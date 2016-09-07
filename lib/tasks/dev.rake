namespace :dev  do
	
	#task :rebuild => ["db:drop", "db:setup", :fake]
	#task :rebuild => ["db:drop", "db:create", "db:schema:load", "db:seed", :fake]

	task :fake => :environment do 

		puts "Creating fake data"
		

		10.times do |i|
			p = Post.create( :title => Faker::StarWars.character ,:content => Faker::Lorem.paragraph(2, true), :user => User.first)
			PostGroupship.create(:post_id => p.id , :group_id => Group.all.sample.id)
			puts "create post#{p.id}"
				10.times do |j|
					r = p.replies.create( :comment => Faker::Lorem.sentence, :user => User.last)
					puts "create post_replies#{r.comment}"
				end
		end
	end

	task :fake2 => :environment do 

		puts "Creating fake data"
		

		10.times do |i|
			p = Post.create( :title => Faker::StarWars.character ,:content => Faker::Lorem.paragraph(2, true), :user => User.last)
			puts "create post#{p.id}"
				10.times do |j|
					r = p.replies.create( :comment => Faker::Lorem.sentence, :user => User.first)
					puts "create event_attendees#{r.comment}"
				end
		end
	end


end