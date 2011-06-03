module VestalVersions
  module Observing

    def self.included(klass)
      klass.class_eval do
        include InstanceMethods

        after_update :notify_observers_of_created_version, :if => :version_conditions_met?
      end

    end

    module InstanceMethods
      private
      def notify_observers_of_created_version
        self.class.notify_observers(:version_created, self)
      end
    end

  end
end
