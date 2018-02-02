#
# Cookbook:: cb_chrome
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chrome::default'

package 'google-chrome-stable' do
  action :upgrade
end
