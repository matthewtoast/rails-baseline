class Timestamp
  class << self
    def migration
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def database
      Time.now.utc.strftime('%Y-%m-%d %H:%M:%S.%6N')
    end
  end
end
