require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "valid credentials" do
      it "sets user"
      it "sets session[:user_id]"
      it "redirects to home path"
      it "sets notice"
    end
    context "invalid credentials" do
      it "shows error"
      it "redirects to sign in path"
    end
  end
  describe "POST destroy" do
    it "nils session[:user_id]"
    it "redirects to root path"
    it "sets notice"
  end
end