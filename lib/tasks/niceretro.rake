namespace :niceretro do
  desc "Create the symbolic link on production"
  task symlink: :environment do
    %x(ln -s /var/lib/nginx/database.yml /var/www/webroot/ROOT/config/database.yml)
    %x(ln -s /var/lib/nginx/secrets.yml /var/www/webroot/ROOT/config/secrets.yml)
  end
end
