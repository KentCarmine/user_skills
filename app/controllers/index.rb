get '/' do
  # render home page
  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  @skills = Skill.all
  erb :edit_user
end

post '/users/:id/edit' do
  @user = User.find(params[:id])

  skill_name = params[:skill_name]
  years_exp = params[:years_experience].to_i

  if params[:formally_educated].nil?
    formally_educated = false
  else
    formally_educated = true
  end

  @skill = Skill.where("name =?", skill_name).first

  us = UsersSkill.create(:years_experience => years_exp, :formally_educated => formally_educated)

  @user.users_skills << us
  @user.save

  @skill.users_skills << us
  @skill.save

  redirect to '/'
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end
