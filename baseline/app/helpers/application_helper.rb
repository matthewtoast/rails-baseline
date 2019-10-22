# frozen_string_literal: true

module ApplicationHelper
  def application_title
    ENV['APPLICATION_TITLE']
  end

  def react_main
    react_component(
      'Main.Main',
      {},
      class: 'main',
    )
  end
end
