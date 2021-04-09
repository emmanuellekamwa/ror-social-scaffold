module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def friends_and_own_posts(current_user)
    myfriends = current_user.friends
    our_posts = []
    myfriends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end
    current_user.posts.each do |p|
      our_posts << p
    end
    our_posts.reverse
  end
end
