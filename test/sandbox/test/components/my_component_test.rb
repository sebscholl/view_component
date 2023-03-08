# frozen_string_literal: true

require "test_helper"
require 'view_component/capybara_test_helpers'

class MyComponentTest < ViewComponent::TestCase
  include ::ViewComponent::CapybaraTestHelpers


  def setup
    ViewComponent::Preview.load_previews
  end

  def test_render_preview
    render_preview(:default)

    assert_selector("div", text: "hello,world!")
  end

  def test_render_preview_with_args
    visit_preview(:display_inline_component)
  end
end
