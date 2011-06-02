module VestalVersions
  module Observing
    extend ActiveSupport::Concern

    included do
      after_create :notify_observers_of_initial_version, :if => :create_initial_version?
      after_update :notify_observers_of_created_version, :if => :version_conditions_met?
      before_destroy :notify_observers_of_deleted_version, :if => :delete_version?
    end

    module InstanceMethods
      private
      def notify_observers_of_initial_version
        self.class.notify_observers(:initial_version_created, self)
      end

      def notify_observers_of_created_version
        self.class.notify_observers(:version_created, self)
      end

      def notify_observers_of_deleted_version
        self.class.notify_observers(:deleted_version_created, self)
      end
    end

  end
end
