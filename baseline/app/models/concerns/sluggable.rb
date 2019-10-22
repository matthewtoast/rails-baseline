module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_source, use: :slugged
    include InstanceMethods
  end

  module InstanceMethods
    def normalize_friendly_id(value)
      value.to_url
    end
  end
end
