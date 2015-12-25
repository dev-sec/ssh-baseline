# encoding: utf-8
#
# Copyright 2015, Patrick Muench
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# author: Christoph Hartmann
# author: Dominik Richter
# author: Patrick Muench

title 'SSH client config'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'libraries'))
require 'ssh_crypto'

ssh_crypto = SshCrypto.new(os)

control 'ssh-01' do
  impact 1.0
  title 'client: Check ssh_config owner, group and permissions.'
  desc 'The ssh_config should owned by root, only be writable by owner and readable to all.'

  describe file('/etc/ssh/ssh_config') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_executable }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
  end
end

control 'ssh-02' do
  impact 1.0
  title 'Client: Specify the AddressFamily to your need'
  desc 'OpenSSH should be configured to the network family. Set it to inet if you use IPv4 only. For IPv6 only set it to inet6.'
  describe ssh_config do
    its('AddressFamily') { should match(/inet|inet6|any/) }
  end
end

control 'ssh-03' do
  impact 1.0
  title 'Client: Specify expected ssh port'
  desc 'Always specify which port the SSH client should connect. Prevent unexpected settings.'
  describe ssh_config do
    its('Port') { should eq('22') }
  end
end

control 'ssh-04' do
  impact 1.0
  title 'Client: Specify protocol version 2'
  desc "Only SSH protocol version 2 connections should be permitted. Version 1 of the protocol contains security vulnerabilities. Don't use legacy insecure SSHv1 connections anymore."
  describe ssh_config do
    its('Protocol') { should eq('2') }
  end
end

control 'ssh-05' do
  impact 1.0
  title 'Client: Disable batch mode'
  desc 'Avoid batch mode in the default configuration.'
  describe ssh_config do
    its('BatchMode') { should eq('no') }
  end
end

control 'ssh-06' do
  impact 1.0
  title 'Client: Check Host IPs'
  desc 'Make sure that SSH checks the host IP address in the known_hosts file, to avoid DNS spoofing effects.'
  describe ssh_config do
    its('CheckHostIP') { should eq('yes') }
  end
end

control 'ssh-07' do
  impact 1.0
  title 'Client: Ask when checking host keys'
  desc "Don't automatically add new hosts keys to the list of known hosts."
  describe ssh_config do
    its('StrictHostKeyChecking') { should match(/ask|yes/) }
  end
end

control 'ssh-08' do
  impact 1.0
  title 'Client: Check for secure ssh ciphers'
  desc 'Configure a list of ciphers to the best secure ciphers (avoid older and weaker ciphers)'
  describe ssh_config do
    its('Ciphers') { should eq(ssh_crypto.valid_ciphers) }
  end
end

control 'ssh-09' do
  impact 1.0
  title 'Client: Check for secure ssh Key-Exchange Algorithm'
  desc 'Configure a list of Key-Exchange Algorithms (Kexs) to the best secure Kexs (avoid older and weaker Key-Exchange Algorithm)'
  describe ssh_config do
    its('KexAlgorithms') { should eq(ssh_crypto.valid_kexs) }
  end
end

control 'ssh-10' do
  impact 1.0
  title 'Client: Check for secure ssh Message Authentication Codes'
  desc 'Configure a list of Message Authentication Codes (MACs) to the best secure MACs (avoid older and weaker Message Authentication Codes)'
  describe ssh_config do
    its('MACs') { should eq(ssh_crypto.valid_macs) }
  end
end

control 'ssh-11' do
  impact 1.0
  title 'Client: Disable agent forwarding'
  desc 'Prevent agent forwarding by default, as it can be used in a limited way to enable attacks.'
  describe ssh_config do
    its('ForwardAgent') { should eq('no') }
  end
end

control 'ssh-12' do
  impact 1.0
  title 'Client: Disable X11Forwarding'
  desc 'Prevent X11 forwarding by default, as it can be used in a limited way to enable attacks.'
  describe ssh_config do
    its('ForwardX11') { should eq('no') }
  end
end

control 'ssh-13' do
  impact 1.0
  title 'Client: Disable HostbasedAuthentication'
  desc 'This option is a weak way for authentication and provide attacker more ways to enter the system.'
  describe ssh_config do
    its('HostbasedAuthentication') { should eq('no') }
  end
end

control 'ssh-14' do
  impact 1.0
  title 'Client: Disable rhosts-based authentication'
  desc 'Avoid rhosts-based authentication, as it opens more ways for an attacker to enter a system.'
  describe ssh_config do
    its('RhostsRSAAuthentication') { should eq('no') }
  end
end

control 'ssh-15' do
  impact 1.0
  title 'Client: Enable RSA authentication'
  desc 'Make sure RSA authentication is used by default.'
  describe ssh_config do
    its('RSAAuthentication') { should eq('yes') }
  end
end

control 'ssh-16' do
  impact 1.0
  title 'Client: Disable password-based authentication'
  desc 'Avoid password-based authentications.'
  describe ssh_config do
    its('PasswordAuthentication') { should eq('no') }
  end
end

control 'ssh-17' do
  impact 1.0
  title 'Client: Disable GSSAPIAuthentication'
  desc 'If you do not use GSSAPI authentication then disable it.'
  describe ssh_config do
    its('GSSAPIAuthentication') { should eq('no') }
  end
end

control 'ssh-18' do
  impact 1.0
  title 'Client: Disable GSSAPIDelegateCredentials'
  desc 'If you do not use GSSAPI authentication then disable it.'
  describe ssh_config do
    its('GSSAPIDelegateCredentials') { should eq('no') }
  end
end

control 'ssh-19' do
  impact 1.0
  title 'Client: Disable tunnels'
  desc 'Avoid using SSH tunnels.'
  describe ssh_config do
    its('Tunnel') { should eq('no') }
  end
end

control 'ssh-20' do
  impact 1.0
  title 'Client: Do not permit local commands'
  desc 'Do not permit any local command execution.'
  describe ssh_config do
    its('PermitLocalCommand') { should eq('no') }
  end
end
