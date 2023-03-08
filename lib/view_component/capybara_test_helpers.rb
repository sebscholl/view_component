require 'axe/api/run'
require 'axe/core'

module ViewComponent
  module CapybaraTestHelpers
    include Capybara::DSL

    def visit_preview(name, from: preview_class, params: {})
      Capybara.current_driver = :selenium_chrome

      # From what I can tell, it's not possible to overwrite all request parameters
      # at once, so we set them individually here.
      # params.each do |k, v|
      #   previews_controller.request.params[k] = v
      # end

      # previews_controller.request.params[:path] = "#{from.preview_name}/#{name}"
      # previews_controller.set_response!(ActionDispatch::Response.new)
      # result = previews_controller.previews
      #
      visit(ViewComponent::Base.preview_route + "/#{name}")

      # visit via Capybara
      run = Axe::API::Run.new
      check = Axe::Core.new(page).call(run)

      violations = check.results.violations

      if !violations.empty?
        descriptions = violations.map do |violation|
          "[#{violation.id}] - " + violation.description
        end

        flunk "Expected no AXE violations, got #{violations.length} violation(s)\n\n" + descriptions.join("\n")
      end

      Nokogiri::HTML.fragment(@rendered_content)
    end
  end
end
