class SignupController < ApplicationController

  def step1
    @user = user.new
  end

  def save_step1
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:fast_name] = user_params[:fast_name]
    session[:last_name] = user_params[:last_name]
    session[:fast_name_kana] = user_params[:fast_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      fast_name: session[:fast_name],
      last_name: session[:last_name],
      fast_name_kana: session[:fast_name_kana],
      kana_last_name: session[:kana_last_name],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day]
    )

    if @user.valid?
      unless verify_recaptcha
        render 'signup/step1'
      end
    else
      render 'signup/step1'
    end
  end

  def step2
    @user = User.new
  end

  def save_step2
    session[:phone_number] = user_params[:phone_number]
  end

  def step3
    @user = User.new(
      fast_name: session[:fast_name],
      last_name: session[:last_name],
      fast_name_kana: session[:fast_name_kana],
      kana_last_name: session[:kana_last_name]   
    )
    @user.build_residence
  end

  def save_step3
    session[:fast_name] = user_params[:fast_name]
    session[:last_name] = user_params[:last_name]
    session[:fast_name_kana] = user_params[:fast_name_kana]
    session[:kana_last_name] = user_params[:kana_last_name]
    session[:postal_code] = user_params[:postal_code]    
    session[:prefectures] = user_params[:prefectures]
    session[:city] = user_params[:city]
    session[:adderess] = user_params[:adderess]
    session[:building_name] = user_params[:building_name]


    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      fast_name: session[:fast_name],
      last_name: session[:last_name],
      fast_name_kana: session[:fast_name_kana],
      kana_last_name: session[:kana_last_name],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      adderess: session[:adderess]
      building_name: session[:building_name]
      phone_number: session[:phone_number]      
    )

    render 'signup/step3' unless @user.valid?
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      fast_name: session[:fast_name],
      last_name: session[:last_name],
      fast_name_kana: session[:kana_family_name],
      kana_last_name: session[:kana_last_name],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      adderess: session[:adderess],
      building_name: session[:building_name],
      phone_number: session[:phone_number]
    )
    if @user.save
    # ログインするための情報を保管
     session[:id] = @user.id
     redirect_to done_signup_index_path
    else
     render '/signup/registration'
    end
  end

  def complete_signup
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :fast_name,
      :last_name,
      :fast_name_kana,
      :kana_last_name,
      :birth_year,
      :birth_month,
      :birth_day,
      :postal_code,
      :prefectures,
      :city,
      :adderess,
      :building_name,
      :phone_number,
    )
  end
end