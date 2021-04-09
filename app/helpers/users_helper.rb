module UsersHelper
  def accept_or_pending_btn(obj)
    return unless current_user.id != obj.id

    out = ''
    if current_user.friend?(obj)
      out << link_to('Unfriend', unfriend_path(user_id: obj.id), class: 'btn btn-secondary', method: :delete)
    elsif current_user.pending_friends.include?(obj)
      out << link_to('pending friendship', '#', class: 'profile-link f-link')
      out << ' | '
      out << link_to('cancel', unfriend_path(user_id: obj.id), class: 'btn btn-secondary', method: :delete)
    elsif current_user.friend_requests.include?(obj)
      out << link_to('Accept', invite_path(user_id: obj.id), class: 'btn btn-primary', method: :put)
      out << ' | '
      out << link_to('Reject', reject_path(user_id: obj.id), class: 'btn btn-secondary', method: :delete)
    else
      out << link_to('Add Friend', invite_path(user_id: obj.id), class: 'btn btn-primary', method: :post)
    end

    out.html_safe
  end
end
