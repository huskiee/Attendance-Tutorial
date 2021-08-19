class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  ##6.3 ログインの仕組みを作ろう(どのコントローラーでもヘルパーに定義したメソッドが使える)
  include SessionsHelper
end
