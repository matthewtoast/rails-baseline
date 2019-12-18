class Analytics
  def initialize
    @client = Segment::Analytics.new(
      write_key: ENV['SEGMENT_WRITE_KEY'],
    )
  end

  def identify(*args)
    @client.identify(*args)
  end

  def track(*args)
    @client.track(*args)
  end
end
