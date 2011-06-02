require 'spec_helper'

describe VestalVersions::Observing do
  let(:name) { 'Adam' }

  let(:user) { User.new :name => name }

  subject { User }

  context "with :initial_version option" do
    before do
      User.prepare_versioned_options(:initial_version => true) 
    end

    it "should notify the obsevers that a version is created" do
      subject.should_receive(:notify_observers).with(:initial_version_created, user)
      user.save!
    end

    it "should not notify that a general version was created" do
      subject.should_not_receive(:notify_observers).with(:version_created, user)
      user.save!
    end
  end

  context "without the :initial_verion option" do
    before do
      User.prepare_versioned_options(:initial_version => false) 
    end

    it "should notify the obsevers that a version is created" do
      subject.should_not_receive(:notify_observers).with(:initial_version_created, user)
      user.save!
    end
  end

  context "when a new version is created" do
    let(:user) { User.create! :name => name }

    it "should notify the observers that a version is created" do
      subject.should_receive(:notify_observers).with(:version_created, user)
      user.update_attributes!(:first_name => 'Markus', :last_name => 'Schulz')
    end
  end

  context "when nothing is changed" do
    it "should not notify the observers" do
      subject.should_not_receive(:notify_observers).with(:version_created, user)
      user.update_attributes! :name => name
    end
  end

  context "when a record is deleted" do
    subject { DeletedUser }
    let(:user) { DeletedUser.create!(:first_name => 'Adam', :last_name => 'Hawkins') }

    it "should notify the observer that a deletion version was created" do
      subject.should_receive(:notify_observers).with(:deleted_version_created, user)
      user.destroy
    end

    it "should not notify the obsever about a regular version" do
      subject.should_not_receive(:notify_observers).with(:version_created, user)
      user.destroy
    end
  end
end
