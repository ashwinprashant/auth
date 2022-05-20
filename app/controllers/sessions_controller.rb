class SessionsController < ApplicationController

    def new 
    end


    def create
    #Step 1: check to see if there's a user with email that was provided 
    @user = User.find_by({ "email" => params["email"] })
    if @user 
        #Step 1a: If yes, check the password (go to step 2). 
        #Step 2: Check the password to see if it matches the user's password
        if BCrypt::Password.create(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
            flash["notice"] = "You're in!"
        #Step 2a: If yes, go to companies page.
            redirect_to "/companies"
        else
    #Step 2b: If no, go back to the loging page. 
            flash["notice"] = "Incorrect credentials"
            redirect_to "/sessions/new"
        end
    else
    #Step 1b: If no, go back to the login page
        flash["notice"] = "Incorrect credentials"
        redirect_to "/sessions/new"
    end
end
end