# frozen_string_literal: true

module ApplicationHelper
  IMAGE_RELPATHS = Dir.entries(
    Rails.root.join('app', 'assets', 'images'),
  ).select do |relpath|
    !File.directory?(relpath) && relpath[0] != '.'
  end

  def application_title
    ENV['APPLICATION_TITLE']
  end

  def application_description
    ENV['APPLICATION_DESCRIPTION']
  end

  def react_main
    react_component(
      'Main.Main',
      {},
      class: 'main',
    )
  end

  def asset_dictionary(out = {})
    IMAGE_RELPATHS.each do |relpath|
      out[relpath] = asset_path(relpath)
    end
    out
  end
end
