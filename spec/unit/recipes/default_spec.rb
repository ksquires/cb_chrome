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

        before(:each) do
          stub_command('rpm -qi gpg-pubkey-7fac5991-*').and_return(false)
        end

        context 'when key is not installed' do
          it 'executes a script' do
            #   stub_command('rpm -qi gpg-pubkey-7fac5991-*').and_return(false)
            expect(chef_run).to run_execute('rpm --import https://dl.google.com/linux/linux_signing_key.pub')
          end
        end

        it 'creates alex repo with proper info' do
          expect(chef_run).to create_yum_repository('google-chrome').with(baseurl: 'http://dl.google.com/linux/chrome/rpm/stable/x86_64')
          expect(chef_run).to create_yum_repository('google-chrome').with(gpgcheck: true)
          expect(chef_run).to create_yum_repository('google-chrome').with(enabled: true)
        end

        it 'upgrades chrome package' do
          expect(chef_run).to upgrade_package('google-chrome-stable')
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
      end
    end
  end
end
