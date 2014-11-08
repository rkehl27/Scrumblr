require 'spec_helper'
require 'rails_helper'

describe Story do
  describe 'Creating a new Story' do
    before :each do
      load Rails.root + 'db/seeds.rb'
      @fake_task = Task.new Hash[:title=>'title', :points=>1, :status=>'backlog', :needs_discussion=>false, :description=>'text' ]
      @fake_story = Story.new Hash[:story_name => 'fake', :story_points => 3, :story_description => 'fake', :story_status => 'fake']
    end

    it 'Should be able to add a task' do
      @fake_story.add_task(@fake_task)
      expect (@fake_story.tasks).to include(@fake_task)
    end

  end
end