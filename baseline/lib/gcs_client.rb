require 'google/cloud/storage'

class GcsClient
  HOST = 'storage.cloud.google.com'.freeze
  BUCKET = ENV['GCS_BUCKET']
  PROJECT_ID = ENV['GCS_PROJECT_ID']
  CREDENTIALS = ENV['GCS_CREDS'].present? ? GcsClient.decode_creds(ENV['GCS_CREDS']) : {}
  DEFAULT_ACL = 'public-read'.freeze
  MAX_FILE_SIZE_MB = 2

  def initialize
    @bucket = Google::Cloud::Storage.new(
      project_id: PROJECT_ID,
      credentials: CREDENTIALS,
    ).bucket(BUCKET)
  end

  def read(key)
    file = @bucket.file(key)
    downloaded = file.download
    downloaded.rewind
    downloaded.read
  end

  def signed_upload_url(key, mime_type, origin, expires_seconds = 30)
    file = @bucket.file(
      key,
      skip_lookup: true, # Object may not exist yet
    )

    headers = {
      'x-goog-resumable': 'start',
      'x-goog-acl': DEFAULT_ACL,
      'Origin': origin, # Required, else CORS errors
    }

    puts "GCS signing #{key} #{mime_type} #{headers}"

    signed_post_url = file.signed_url(
      method: 'POST',
      expires: expires_seconds,
      content_type: mime_type,
      headers: headers,
      version: :v4,
    )

    post_uri = URI.parse(signed_post_url)
    post_conn = Net::HTTP.new(post_uri.host, post_uri.port)
    post_conn.use_ssl = true
    post_request = Net::HTTP::Post.new(post_uri.request_uri, headers)
    post_request.content_type = mime_type
    post_response = post_conn.request(post_request)

    resumable_upload_url = post_response['location']

    puts "GCS signed #{resumable_upload_url}"

    {
      key: key,
      bucket: BUCKET,
      url: resumable_upload_url,
      method: 'PUT',
      expires: expires_seconds,
      content_type: mime_type,
      headers: headers,
    }
  end

  class << self
    def key_to_url(key)
      "https://#{HOST}/#{BUCKET}/#{key}"
    end

    def encode_creds(creds = {})
      Base64.strict_encode64(creds.to_json)
    end

    def decode_creds(creds)
      JSON.parse(Base64.strict_decode64(creds))
    end

    def create_signed_upload_url_payload(user_slug, name, size, request_origin)
      filename = name.downcase
      extname = File.extname(filename)
      basename = File.basename(filename, extname).parameterize

      if extname.blank? || basename.blank?
        return StandardError.new('Please try a different file name.')
      end

      extension = extname[1..-1]

      if Mime::EXTENSION_LOOKUP[extension].blank?
        return StandardError.new('Only valid files are allowed.')
      end

      if (size.to_f / 1024 / 1024) > MAX_FILE_SIZE_MB
        return StandardError.new("Image file size must be less than #{MAX_FILE_SIZE_MB}MB.")
      end

      mime_type = Mime::EXTENSION_LOOKUP[extension].to_s

      key = [
        'uploads',
        user_slug,
        mime_type,
        "#{basename}-#{Timestamp.migration}-#{SecureRandom.hex(2)}.#{extension}",
      ].join('/')

      payload = GcsClient.new.signed_upload_url(
        key,
        mime_type,
        request_origin,
      )

      payload
    end
  end
end

# HACK: Monkeypatch to fix v4's method error due to mixed string/symbol keys
module Google
  module Cloud
    module Storage
      class File
        class SignerV4
          def canonical_and_signed_headers(headers)
            canonical_headers = headers || {}
            headers_arr = canonical_headers.map do |k, v|
              [k.downcase, v.strip.gsub(/[^\S\t]+/, ' ').gsub(/\t+/, "\t")]
            end
            canonical_headers = Hash[headers_arr]

            # HACK: This is the specific monkeypatch referred to above:
            canonical_headers[:host] = 'storage.googleapis.com'
            # This is the line of code that previously caused the exception:
            # canonical_headers['host'] = "storage.googleapis.com"

            canonical_headers = canonical_headers.sort_by do |k, _|
              k.downcase
            end.to_h
            canonical_headers_str = ''
            canonical_headers.each do |k, v|
              canonical_headers_str += "#{k}:#{v}\n"
            end
            signed_headers_str = ''
            canonical_headers.each_key { |k| signed_headers_str += "#{k};" }
            signed_headers_str = signed_headers_str.chomp ';'
            [canonical_headers_str, signed_headers_str]
          end
        end
      end
    end
  end
end
