require 'random_data'

# Create posts
50.times do 
    Post.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
        )
    end
    posts = Post.all
    
# Create comments
100.times do 
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
        )
    end
    
10.times do
    Advertisement.create!(
        title: RandomData.random_sentence,
        copy: RandomData.random_paragraph,
        price: 99
        )
    end
    
puts "Seed finished"
puts "#{Post.count} posts created!"
puts "#{Comment.count} comments created!"
puts "#{Advertisement.count} advertisements created!"
