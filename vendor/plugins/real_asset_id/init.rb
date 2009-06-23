require 'real_asset_id'
ActionView::Helpers::AssetTagHelper.send(:include, RealAssetId::AssetTagHelper)
