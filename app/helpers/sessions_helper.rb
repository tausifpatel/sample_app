module SessionsHelper

    # Logs in the given user 
    def log_in(user)    
        session[:user_id] = user.id
    end

    # Returns the current logged in user if any - required to persist current user when we change pages. 
    def current_user 
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end 

    # Check if usr is logged in. We are inserting this in a header menu to display certain menus if user is logged in. 
    # Returns true if user is logged in, otherwise false.
    def logged_in?
        !current_user.nil?
    end 

    # log out
    def log_out 
        reset_session
        @current_user = nil
    end 
end
