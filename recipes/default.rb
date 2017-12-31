#
# Cookbook:: cb_chrome
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'gpg-key' do
  command 'rpm --import https://dl.google.com/linux/linux_signing_key.pub'
  not_if 'rpm -qi gpg-pubkey-7fac5991-*'
end

yum_repository 'google-chrome' do
  baseurl 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
  gpgcheck true
  enabled true
  description 'repo for google chrome'
end

package 'google-chrome-stable'
