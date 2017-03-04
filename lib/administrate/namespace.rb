module Administrate
  class Namespace
    def initialize(namespace)
      @namespace = namespace
    end

    def resources
      namespace_controller_paths.uniq.map do |controller|
        controller.gsub(regex, "").to_sym
      end
    end

    private

    attr_reader :namespace

    def namespace_controller_paths
      all_controller_paths.select do |controller|
        controller.match(regex)
      end
    end

    def all_controller_paths
      Rails.application.routes.routes.map do |route|
        route.defaults[:controller].to_s
      end
    end

    def regex
      %r{^#{namespace}/}
    end
  end
end
