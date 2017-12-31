#
# Cookbook:: cb_chrome
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'cb_chrome::default' do
  platforms = {
    'centos' => {
      'versions' => ['7.4.1708']
    }
  }
  platforms.keys.each do |platform|
    platforms[platform]['versions'].each do |version|
      context 'When all attributes are default, on an unspecified platform' do
        let(:chef_run) do
          # for a complete list of available platforms and versions see:
          # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
          runner = ChefSpec::ServerRunner.new(platform: platform, version: version)
          runner.converge(described_recipe)
        end

        it 'creates installs gpg key' do
          # soething stub
        end
        it 'creates alex repo with proper info' do
          expect(chef_run).to create_yum_repository('google-chrome').with(baseurl: 'http://dl.google.com/linux/chrome/rpm/stable/x86_64')
          expect(chef_run).to create_yum_repository('google-chrome').with(gpgcheck: true)
          expect(chef_run).to create_yum_repository('google-chrome').with(enabled: true)
        end

        it 'installs chrome package' do
          expect(chef_run).to install_package('google-chrome-stable')
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
      end
    end
  end
end
