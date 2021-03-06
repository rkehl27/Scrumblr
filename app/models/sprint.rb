class Sprint < ActiveRecord::Base
	attr_accessible :sprint_id, :sprint_start_date, :sprint_end_date
	
	has_and_belongs_to_many :stories
	belongs_to :project
	
	validates :sprint_start_date, :presence => true
	validates :sprint_end_date, :presence => true
	validate :start_date_before_end_date
	
	def self.create_sprint(info_hash)	
		new_sprint = Sprint.create!(info_hash)
	end
	
	def add_story(story)
		stories << story
	end
	
	def calculate_velocity
		velocity = 0	
			
		stories.each do |story|
			velocity = velocity + story.calculate_points
		end
		
		return velocity
	end	
	
	def count_discussions
	  discussions = 0
	  
	  stories.each do |story|
	    discussions += story.count_discussions
	  end
	  
	  return discussions
	end
	
	def count_tasks
	  total = 0
	  
	  stories.each do |story|
	    total += story.tasks.count
	  end
	  
	  return total
	end
	
	def count_completed_stories
	  completed = 0
	  
	  stories.each do |story|
	    if story.completed?
	      completed += 1
	    end
	  end
	  
	  return completed
	end
	
	def count_completed_tasks
	  completed = 0
	  
	  stories.each do |story|
	    completed += story.count_completed_tasks
	  end
	  
	  return completed
	end
	
	def start_date_before_end_date
	  if self.sprint_start_date >= self.sprint_end_date
	    errors.add(:sprint_start_date, 'must be at an earlier date than end date')
	  end
	end
end

