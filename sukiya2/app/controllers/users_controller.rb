require 'rubyXL/convenience_methods'
require 'holiday_japan'
require 'date'

class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :new, :create, :edit, :update, :logout, :destroy_form, :destroy, :shift_form, :shift, :form_create, :change_pwd_form, :change_pwd]}
  before_action :forbid_login_user, {only: [:login_form, :login]}
  before_action :ensure_chief_user, {only: [:index, :new, :create, :destroy_form, :destroy, :form_create]}
  before_action :ensure_correct_user, {only: [:show, :edit, :update, :change_pwd_form, :change_pwd]}

  def index
    @users = User.all
    if params[:full_date]
      @full_date = params[:full_date]
    end
    if params[:full_each_date]
      @thatdate = Thatdate.find_by(full_date: params[:full_each_date].to_date)
      @crewshifts = Crewshift.where(full_date: @thatdate.full_date)
      name_num = 0
      mon_num = 1
      tue_num = 2
      wed_num = 3
      thu_num = 4
      fri_num = 5
      sat_num = 6
      sun_num = 7

      workbook = RubyXL::Parser.parse('/home/vagrant/work/rails/sukiya2/app/assets/shift_template.xlsx')
      workbook.calc_pr.full_calc_on_load = true
      workbook.calc_pr.calc_completed = true
      workbook.calc_pr.calc_on_save = true
      workbook.calc_pr.force_full_calc = true

      worksheet = workbook[0]
      worksheet1 = workbook[2]
      @crewshifts.each do |crewshift|
        i = 1
        set_num = 0
        while i<50 do
          if worksheet[i][name_num].value == crewshift.user.name
            set_num = i
            break
          else
            i += 1
          end
        end

        # if set_num == 0
        #   break
        # end

        mon = ""
        monds = [crewshift.mon914,
               crewshift.mon10515,
               crewshift.mon1115,
               crewshift.mon115155,
               crewshift.mon1217,
               crewshift.mon1722,
               crewshift.mon1822,
               crewshift.mon228,
               crewshift.mon229]

        monds.each do |mond|
          if mond != nil
            mon = mon + "#{mond} "
          end
        end

        tue = ""
        tueds = [crewshift.tue914,
               crewshift.tue10515,
               crewshift.tue1115,
               crewshift.tue115155,
               crewshift.tue1217,
               crewshift.tue1722,
               crewshift.tue1822,
               crewshift.tue228,
               crewshift.tue229]

         tueds.each do |tued|
           if tued != nil
             tue = tue + "#{tued} "
           end
         end

        wed = ""
        wedds = [crewshift.wed914,
               crewshift.wed10515,
               crewshift.wed1115,
               crewshift.wed115155,
               crewshift.wed1217,
               crewshift.wed1722,
               crewshift.wed1822,
               crewshift.wed228,
               crewshift.wed229]

         wedds.each do |wedd|
           if wedd != nil
             wed = wed + "#{wedd} "
           end
         end

        thu = ""
        thuds = [crewshift.thu914,
               crewshift.thu10515,
               crewshift.thu1115,
               crewshift.thu115155,
               crewshift.thu1217,
               crewshift.thu1722,
               crewshift.thu1822,
               crewshift.thu228,
               crewshift.thu229]

         thuds.each do |thud|
           if thud != nil
             thu = thu + "#{thud} "
           end
         end

        fri = ""
        frids = [crewshift.fri914,
               crewshift.fri10515,
               crewshift.fri1115,
               crewshift.fri115155,
               crewshift.fri1217,
               crewshift.fri1722,
               crewshift.fri1822,
               crewshift.fri19522,
               crewshift.fri229]

         frids.each do |frid|
           if frid != nil
             fri = fri + "#{frid} "
           end
         end

        sat = ""
        satds = [crewshift.sat914,
               crewshift.sat1115,
               crewshift.sat115155,
               crewshift.sat1217,
               crewshift.sat1722,
               crewshift.sat1822,
               crewshift.sat229]

         satds.each do |satd|
           if satd != nil
             sat = sat + "#{satd} "
           end
         end

        sun = ""
        sunds = [crewshift.sun914,
               crewshift.sun1115,
               crewshift.sun115155,
               crewshift.sun1217,
               crewshift.sun1722,
               crewshift.sun1822,
               crewshift.sun228,
               crewshift.sun229]

         sunds.each do |sund|
           if sund != nil
             sun = sun + "#{sund} "
           end
         end

        worksheet[i][mon_num].change_contents(mon)
        worksheet[i][tue_num].change_contents(tue)
        worksheet[i][wed_num].change_contents(wed)
        worksheet[i][thu_num].change_contents(thu)
        worksheet[i][fri_num].change_contents(fri)
        worksheet[i][sat_num].change_contents(sat)
        worksheet[i][sun_num].change_contents(sun)

      end

      worksheet1[19][13].change_contents("#{@thatdate.full_date.year}/#{@thatdate.full_date.month}/#{@thatdate.full_date.day}")

      respond_to do |format|
        format.html
        format.xlsx do
         send_data workbook.stream.read,
           filename: ERB::Util.url_encode("京田辺興戸店シフト希望表 #{@thatdate.full_date.month}#{@thatdate.full_date.day}-#{@thatdate.full_date.end_of_week.month}#{@thatdate.full_date.end_of_week.day}.xlsx")
        end
      end
      # ensure
        workbook.stream.close
      # end
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @thatdates = Thatdate.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(partcord: params[:partcord],
                     name: params[:name],
                     password: params[:password],
                     chief: params[:chief])
    if params[:password] != params[:confirm_password]
      @confirm_password = params[:consirm_password]
      @error_message = "確認用のパスワードが違います"
      render("users/new")
    elsif @user.save
      flash[:notice] = "ユーザーを登録しました"
      redirect_to("/users/#{@current_user.id}")
    else
      @confirm_password = params[:confirm_password]
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @current_user.chief == 1 && @current_user.id != @user.id
      @user.partcord = params[:partcord]
      @user.name = params[:name]
      @user.chief = params[:chief]
    end
    if @current_user.chief == 1 && @current_user.id == @user.id
      @user.partcord = params[:partcord]
      @user.name = params[:name]
      @user.chief = params[:chief].to_i
    end
    if @current_user.chief != 1

    end

    if @user.save
      flash[:notice] = "クルーの情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def change_pwd_form
    @user = User.find_by(id: params[:id])
  end

  def change_pwd
    @user = User.find_by(id: params[:id])
    if @user.authenticate(params[:password])
      if params[:new_password] == params[:confirm_password]
        @user.password = params[:new_password]
        @user.save
        flash[:notice] = "クルーの情報を編集しました"
        redirect_to("/users/#{@user.id}")
      else
        @new_password = params[:new_password]
        @confirm_password = params[:confirm_password]
        @error_message = "確認用のパスワードが間違っています"
        render("users/change_pwd_form")
      end
    else
      @new_password = params[:new_password]
      @confirm_password = params[:confirm_password]
      @error_message = "パスワードが間違っています"
      render("users/change_pwd_form")
    end
  end

  def destroy_form
    @user = User.find_by(id: params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "クルーを削除しました"
    redirect_to("/users/#{@current_user.id}")
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(partcord: params[:partcord])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @error_message = "パートコードまたはパスワードが間違っています"
      @partcord = params[:partcord]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def form_create
    date = params[:date]
    expire = params[:expire].to_date
    if Thatdate.find_by(full_date: date) || expire <= Date.tomorrow
      flash[:notice] = "不正なフォームです"
      redirect_to("/users/#{@current_user.id}")
    else
      @thatdate = Thatdate.create(full_date: date.to_date,
                               expire: expire.to_date)
      # @thatdate.full_date = Time.zone.local(params[:created_at]["date(1i)"],
      #                                       params[:created_at]["date(2i)"],
      #                                       params[:created_at]["date(3i)"])
      @thatdate.date = @thatdate.full_date.day.to_i
      @thatdate.save
      @users = User.all
      @users.each do |user|
        Crewshift.create(user_id: user.id,
                         full_date: date.to_date,
                         already: 0)
      end
      redirect_to("/users/#{@current_user.id}")
    end
  end

  def form_delete
    @crewshifts = Crewshift.where(full_date: params[:date].to_date)
    @crewshifts.each do |crewshift|
      crewshift.destroy
    end
    @thatdate = Thatdate.find_by(full_date: params[:date].to_date)
    @thatdate.destroy
    redirect_to("/users/#{@current_user.id}")
  end

  def excel
    if params[:template]
      template = params[:template]
      File.binwrite("/home/vagrant/work/rails/sukiya2/app/assets/shift_template.xlsx", template.read)
    else
      flash[:notice] = "送信し直してください"
      render("users/#{@current_user.id}")
    end
  end

  def shift_form
    @user = User.find_by(id: params[:id])
    @thatdate = Thatdate.find_by(full_date: params[:date].to_date)
    @crewshift = Crewshift.find_by(user_id: @user.id,
                                   full_date: params[:date].to_date)
  end

  def shift
    @user = User.find_by(id: params[:id])
    @thatdate = Thatdate.find_by(full_date: params[:date].to_date)
    @crewshift = Crewshift.find_by(user_id: @user.id,
                                   full_date: params[:date].to_date)

    @crewshift.mon914 = params[:mon914]
    @crewshift.mon10515 = params[:mon10515]
    @crewshift.mon1115 = params[:mon1115]
    @crewshift.mon115155 = params[:mon115155]
    @crewshift.mon1217 = params[:mon1217]
    @crewshift.mon1722 = params[:mon1722]
    @crewshift.mon1822 = params[:mon1822]
    @crewshift.mon228 = params[:mon228]
    @crewshift.mon229 = params[:mon229]

    @crewshift.tue914 = params[:tue914]
    @crewshift.tue10515 = params[:tue10515]
    @crewshift.tue1115 = params[:tue1115]
    @crewshift.tue115155 = params[:tue115155]
    @crewshift.tue1217 = params[:tue1217]
    @crewshift.tue1722 = params[:tue1722]
    @crewshift.tue1822 = params[:tue1822]
    @crewshift.tue228 = params[:tue228]
    @crewshift.tue229 = params[:tue229]

    @crewshift.wed914 = params[:wed914]
    @crewshift.wed10515 = params[:wed10515]
    @crewshift.wed1115 = params[:wed1115]
    @crewshift.wed115155 = params[:wed115155]
    @crewshift.wed1217 = params[:wed1217]
    @crewshift.wed1722 = params[:wed1722]
    @crewshift.wed1822 = params[:wed1822]
    @crewshift.wed228 = params[:wed228]
    @crewshift.wed229 = params[:wed229]

    @crewshift.thu914 = params[:thu914]
    @crewshift.thu10515 = params[:thu10515]
    @crewshift.thu1115 = params[:thu1115]
    @crewshift.thu115155 = params[:thu115155]
    @crewshift.thu1217 = params[:thu1217]
    @crewshift.thu1722 = params[:thu1722]
    @crewshift.thu1822 = params[:thu1822]
    @crewshift.thu228 = params[:thu228]
    @crewshift.thu229 = params[:thu229]

    @crewshift.fri914 = params[:fri914]
    @crewshift.fri10515 = params[:fri10515]
    @crewshift.fri1115 = params[:fri1115]
    @crewshift.fri115155 = params[:fri115155]
    @crewshift.fri1217 = params[:fri1217]
    @crewshift.fri1722 = params[:fri1722]
    @crewshift.fri1822 = params[:fri1822]
    @crewshift.fri19522 = params[:fri19522]
    @crewshift.fri229 = params[:fri229]

    @crewshift.sat914 = params[:sat914]
    @crewshift.sat1115 = params[:sat1115]
    @crewshift.sat115155 = params[:sat115155]
    @crewshift.sat1217 = params[:sat1217]
    @crewshift.sat1722 = params[:sat1722]
    @crewshift.sat1822 = params[:sat1822]
    @crewshift.sat229 = params[:sat229]

    @crewshift.sun914 = params[:sun914]
    @crewshift.sun1115 = params[:sun1115]
    @crewshift.sun115155 = params[:sun115155]
    @crewshift.sun1217 = params[:sun1217]
    @crewshift.sun1722 = params[:sun1722]
    @crewshift.sun1822 = params[:sun1822]
    @crewshift.sun228 = params[:sun228]
    @crewshift.sun229 = params[:sun229]

    @crewshift.already = 1
    @crewshift.save
    redirect_to("/users/#{@current_user.id}")

  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i && @current_user.chief != 1
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  def ensure_chief_user
    if @current_user.chief != 1
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
