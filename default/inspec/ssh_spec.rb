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

def valid_ciphers
  ciphers53 = 'aes256-ctr,aes192-ctr,aes128-ctr'
  return ciphers53
end


control '01' do
  impact 1.0
  title 'Check ssh ciphers'
  desc 'Check ssh ciphers'
  ciphers53 = 'aes256-ctr,aes192-ctr,aes128-ctr'
  ciphers66 = 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'
  #puts chiphers53
  #puts valid_ciphers
  case os[:family]
    when 'ubuntu'
      case os[:release]
      when '12.04'
        describe sshd_config do
          #its('Ciphers') { should eq chiphers66 }
          its('Ciphers') { should eq('aes256-ctr,aes192-ctr,aes128-ctr') }
        end
      when '14.04'
      end
    when 'debian'
      case os[:release]
      when /6\./, /7\./
        ciphers = ciphers53
      when /8\./
        ciphers = ciphers66
      end
    when 'redhat'
      case os[:release]
      when '6.4', '6.5'
        ciphers = ciphers53
      end
  end
end

control '04' do
  impact 1.0
  title 'Check ssh owner, group and permissions'
  desc 'ssh owner, group and permissions'

  describe file('/etc/ssh') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_executable }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    its('mode') { should eq 00755 }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_executable }
    it { should be_readable.by('owner') }
    it { should_not be_readable.by('group') }
    it { should_not be_readable.by('other') }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
  end

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

control '05' do
  impact 1.0
  title 'PermitRoot Login without-password or no'
  desc 'PermitRoot Login without-password or no'
  describe sshd_config do
    its('PermitRootLogin') { should eq 'no' }
  end
end

control '06' do
  impact 1.0
  title 'Specify ssh Port'
  desc 'Specify ssh Port'
  describe sshd_config do
    its('Port') { should eq '22' }
  end
end

control '07' do
  impact 1.0
  title 'Specify AddressFamily'
  desc 'Specify AddressFamily'
  describe sshd_config do
    its('AddressFamily') { should eq 'inet' }
  end
end

control '08' do
  impact 1.0
  title 'Specify ListenAddress'
  desc 'Specify ListenAddress'
  describe sshd_config do
    its('ListenAddress') { should eq '0.0.0.0' }
  end
end

control '09' do
  impact 1.0
  title 'Specify Protocol'
  desc 'Specify Protocol'
  describe sshd_config do
    its('Protocol') { should eq '2' }
  end
end

control '10' do
  impact 1.0
  title 'Specify StrictModes'
  desc 'Specify StrictModes'
  describe sshd_config do
    its('StrictModes') { should eq 'yes' }
  end
end

control '11' do
  impact 1.0
  title 'Specify SyslogFacility'
  desc 'Specify SyslogFacility'
  describe sshd_config do
    its('SyslogFacility') { should eq 'AUTH' }
  end
end

control '12' do
  impact 1.0
  title 'Specify LogLevel'
  desc 'Specify LogLevel'
  describe sshd_config do
    its('LogLevel') { should eq 'VERBOSE' }
  end
end

control '13' do
  impact 1.0
  title 'Specify HostKey'
  desc 'Specify HostKey'
  describe sshd_config do
    its('HostKey') { should eq [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_dsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
      ] }
  end
end

control '14' do
  impact 1.0
  title 'Specify UseLogin'
  desc 'Specify UseLogin'
  describe sshd_config do
    its('UseLogin') { should eq 'no' }
  end
end

control '15' do
  impact 1.0
  title 'Specify UsePrivilegeSeparation'
  desc 'Specify UsePrivilegeSeparation'
    case os[:family]
    when 'ubuntu'
      describe sshd_config do
        its('UsePrivilegeSeparation') { should eq 'sandbox' }
      end
    when 'debian'
      case os[:release]
      when /6\./
        describe sshd_config do
          its('UsePrivilegeSeparation') { should eq 'yes' }
        end
      when /7\./
        describe sshd_config do
          its('UsePrivilegeSeparation') { should eq 'sandbox' }
        end
      end
    when 'redhat'
      case os[:release]
      when '6.4', '6.5'
        describe sshd_config do
          its('UsePrivilegeSeparation') { should eq 'yes' }
        end
      end
    end
end

control '16' do
  impact 1.0
  title 'Specify PermitUserEnvironment'
  desc 'Specify PermitUserEnvironment'
  describe sshd_config do
    its('PermitUserEnvironment') { should eq 'no' }
  end
end

control '17' do
  impact 1.0
  title 'Specify LoginGraceTime'
  desc 'Specify LoginGraceTime'
  describe sshd_config do
    its('LoginGraceTime') { should eq '30s' }
  end
end

control '18' do
  impact 1.0
  title 'Specify MaxAuthTries'
  desc 'Specify MaxAuthTries'
  describe sshd_config do
    its('MaxAuthTries') { should eq '2' }
  end
end

control '19' do
  impact 1.0
  title 'Specify MaxSessions'
  desc 'Specify MaxSessions'
  describe sshd_config do
    its('MaxSessions') { should eq '10' }
  end
end

control '20' do
  impact 1.0
  title 'Specify MaxStartups'
  desc 'Specify MaxStartups'
  describe sshd_config do
    its('MaxStartups') { should eq '10:30:100' }
  end
end

control '21' do
  impact 1.0
  title 'Specify PubkeyAuthentication'
  desc 'Specify PubkeyAuthentication'
  describe sshd_config do
    its('PubkeyAuthentication') { should eq 'yes' }
  end
end

control '22' do
  impact 1.0
  title 'Specify IgnoreRhosts'
  desc 'Specify IgnoreRhosts'
  describe sshd_config do
    its('IgnoreRhosts') { should eq 'yes' }
  end
end

control '23' do
  impact 1.0
  title 'Specify IgnoreUserKnownHosts'
  desc 'Specify IgnoreUserKnownHosts'
  describe sshd_config do
    its('IgnoreUserKnownHosts') { should eq 'yes' }
  end
end

control '24' do
  impact 1.0
  title 'Specify HostbasedAuthentication'
  desc 'Specify HostbasedAuthentication'
  describe sshd_config do
    its('HostbasedAuthentication') { should eq 'no' }
  end
end

control '25' do
  impact 1.0
  title 'Specify UsePAM'
  desc 'Specify UsePAM'
  describe sshd_config do
    its('UsePAM') { should eq 'no' }
  end
end

control '26' do
  impact 1.0
  title 'Specify PasswordAuthentication'
  desc 'Specify PasswordAuthentication'
  describe sshd_config do
    its('PasswordAuthentication') { should eq 'no' }
  end
end

control '27' do
  impact 1.0
  title 'Specify PermitEmptyPasswords'
  desc 'Specify PermitEmptyPasswords'
  describe sshd_config do
    its('PermitEmptyPasswords') { should eq 'no' }
  end
end

control '28' do
  impact 1.0
  title 'Specify ChallengeResponseAuthentication'
  desc 'Specify ChallengeResponseAuthentication'
  describe sshd_config do
    its('ChallengeResponseAuthentication') { should eq 'no' }
  end
end

control '29' do
  impact 1.0
  title 'Specify KerberosAuthentication'
  desc 'Specify KerberosAuthentication'
  describe sshd_config do
    its('KerberosAuthentication') { should eq 'no' }
  end
end

control '30' do
  impact 1.0
  title 'Specify KerberosOrLocalPasswd'
  desc 'Specify KerberosOrLocalPasswd'
  describe sshd_config do
    its('KerberosOrLocalPasswd') { should eq 'no' }
  end
end

control '31' do
  impact 1.0
  title 'Specify KerberosTicketCleanup'
  desc 'Specify KerberosTicketCleanup'
  describe sshd_config do
    its('KerberosTicketCleanup') { should eq 'yes' }
  end
end

control '32' do
  impact 1.0
  title 'Specify GSSAPIAuthentication'
  desc 'Specify GSSAPIAuthentication'
  describe sshd_config do
    its('GSSAPIAuthentication') { should eq 'no' }
  end
end

control '33' do
  impact 1.0
  title 'Specify GSSAPICleanupCredentials'
  desc 'Specify GSSAPICleanupCredentials'
  describe sshd_config do
    its('GSSAPICleanupCredentials') { should eq 'yes' }
  end
end

control '34' do
  impact 1.0
  title 'Specify TCPKeepAlive'
  desc 'Specify TCPKeepAlive'
  describe sshd_config do
    its('TCPKeepAlive') { should eq 'no' }
  end
end

control '35' do
  impact 1.0
  title 'Specify ClientAliveInterval'
  desc 'Specify ClientAliveInterval'
  describe sshd_config do
    its('ClientAliveInterval') { should eq '600' }
  end
end

control '36' do
  impact 1.0
  title 'Specify ClientAliveCountMax'
  desc 'Specify ClientAliveCountMax'
  describe sshd_config do
    its('ClientAliveCountMax') { should eq '3' }
  end
end

control '37' do
  impact 1.0
  title 'Specify PermitTunnel'
  desc 'Specify PermitTunnel'
  describe sshd_config do
    its('PermitTunnel') { should eq 'no' }
  end
end

control '38' do
  impact 1.0
  title 'Specify AllowTcpForwarding'
  desc 'Specify AllowTcpForwarding'
  describe sshd_config do
    its('AllowTcpForwarding') { should eq 'no' }
  end
end

control '39' do
  impact 1.0
  title 'Specify AllowAgentForwarding'
  desc 'Specify AllowAgentForwarding'
  describe sshd_config do
    its('AllowAgentForwarding') { should eq 'no' }
  end
end

control '40' do
  impact 1.0
  title 'Specify GatewayPorts'
  desc 'Specify GatewayPorts'
  describe sshd_config do
    its('GatewayPorts') { should eq 'no' }
  end
end

control '41' do
  impact 1.0
  title 'Specify X11Forwarding'
  desc 'Specify X11Forwarding'
  describe sshd_config do
    its('X11Forwarding') { should eq 'no' }
  end
end

control '42' do
  impact 1.0
  title 'Specify X11UseLocalhost'
  desc 'Specify X11UseLocalhost'
  describe sshd_config do
    its('X11UseLocalhost') { should eq 'yes' }
  end
end

control '43' do
  impact 1.0
  title 'Specify PrintMotd'
  desc 'Specify PrintMotd'
  describe sshd_config do
    its('PrintMotd') { should eq 'no' }
  end
end

control '44' do
  impact 1.0
  title 'Specify PrintLastLog'
  desc 'Specify PrintLastLog'
  describe sshd_config do
    its('PrintLastLog') { should eq 'no' }
  end
end
