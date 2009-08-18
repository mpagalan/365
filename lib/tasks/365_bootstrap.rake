# ---------------------------------------
# app boostrap
# this rake file consist of task for jumstarting the app
# eg. users

namespace :i365 do
  namespace :bootstrap do
    def crypt_de(str)
      str.tr("A-Za-z0-9", "N-ZA-Mn-za-m5-90-4")
    end

    desc "this will the initial users on the application"
    task :users => :environment  do
      puts "adding users"
      User.create(:email => "mpagalan@gmail.com", :password => crypt_de("z9ewha516639"), :password_confirmation => crypt_de("z9ewha516639"))
    end

  end
end
