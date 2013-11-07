def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_admin_user(user=nil)
  session[:user_id] = (user || Fabricate(:user, admin: true)).id
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def click_on_a_homepage_video(video)
  find("a[href='/videos/#{video.id}']").click
end