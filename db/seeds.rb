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
    
#Create unique post
new_post = Post.find_or_create_by!(title: 'My name') do |post|
    post.body = "My name is Andrew Wiggins"
end

#Create unique comment
Comment.find_or_create_by(post: new_post, body: "This is a unique comment")
    
puts "Seed finished"
puts "#{Post.count} posts created!"
puts "#{Comment.count} comments created!"
