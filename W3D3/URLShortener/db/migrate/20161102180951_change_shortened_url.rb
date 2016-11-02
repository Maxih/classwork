class ChangeShortenedUrl < ActiveRecord::Migration
  def self.up
    rename_column :shortened_urls, :log_url, :long_url
  end

  def self.down
    rename_column :shortened_urls, :long_url, :log_url
  end
end
