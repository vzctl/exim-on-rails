module RealAssetId #:nodoc:
  module AssetTagHelper
    ASSETS_DIR = defined?(Rails.public_path) ? Rails.public_path : "public"
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias :old_rails_asset_id :rails_asset_id
        alias :rails_asset_id :real_asset_id
      end
    end
    module InstanceMethods
      private
      def real_asset_id(source)
        md5path = File.join(ASSETS_DIR, source+'.md5')
        if File.exist?(md5path)
          File.open(md5path).read
        else
          path =  File.join(ASSETS_DIR, source)
          if File.exist?(path)
            require 'digest/md5'
            asset_id = Digest::MD5.hexdigest(File.read(path))
            File.new(md5path,'w').write(Digest::MD5.hexdigest(File.read(path)))
            asset_id
          else
            ''
          end
        end
      end
    end
  end
end
