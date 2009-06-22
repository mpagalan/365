namespace :i365 do
  desc "clean up 365 files"
  task :clean_attachments => :environment do
    sh "rm -fr #{RAILS_ROOT}/public/#{RAILS_ENV}/pages/"
  end
end
