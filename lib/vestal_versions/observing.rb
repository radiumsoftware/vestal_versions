module VestalVersions
  module Observing

    def self.included(klass)
      klass.class_eval do
        include InstanceMethods

        after_update :notify_observers_of_created_version, :if => :version_conditions_met?, :unless => :initial_version?
      end

    end

    module InstanceMethods
      private
      def notify_observers_of_created_version
        self.class.changed
        self.class.notify_observers(:version_created, self)
      end

      def initial_version?
        version == 1
      end
    end

  end
end
