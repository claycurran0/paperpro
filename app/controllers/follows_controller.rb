class FollowsController < ApplicationController
  def new
    
    f = Follow.new
    f.follower_id = current_user.id
    f.leader_id = params.fetch("leader_id")

    identical_follows = Follow.where({ :follower_id => f.follower_id }).where({ :leader_id => f.leader_id })

    if identical_follows.count == 0
      f.save
      redirect_back( fallback_location: root_path )
    else 
      redirect_back( fallback_location: root_path )
    end

  end

  def destroy
    
    follower_id = current_user
    leader_id = params.fetch("leader_id")

    identical_follows = Follow.where({ :follower_id => follower_id }).where({ :leader_id => leader_id })

    if identical_follows.count == 0
      redirect_to("/view_profile/#{leader_id}", { :alert => "You are not following this user." })
    else 
      identical_follows.first.destroy

      redirect_to("/view_profile/#{leader_id}", { :notice => "You unfollowed this user." })
    end
  end
end