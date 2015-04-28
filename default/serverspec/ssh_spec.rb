# encoding: utf-8
#
# Copyright 2014, Deutsche Telekom AG
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

require 'spec_helper'

def valid_ciphers
  # define a set of default ciphers
  ciphers53 = 'aes256-ctr,aes192-ctr,aes128-ctr'
  ciphers66 = 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'
  ciphers = ciphers53

  # adjust ciphers based on OS + release
  case os[:family]
  when 'ubuntu'
    case os[:release]
    when '12.04'
      ciphers = ciphers53
    when '14.04'
      ciphers = ciphers66
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

  ciphers
end

def valid_kexs
  # define a set of default KEXs
  kex66 = 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256'
  kex59 = 'diffie-hellman-group-exchange-sha256'
  kex = kex59

  # adjust KEXs based on OS + release
  case os[:family]
  when 'ubuntu'
    case os[:release]
    when '12.04'
      kex = kex59
    when '14.04'
      kex = kex66
    end
  when 'debian'
    case os[:release]
    when /6\./
      kex = nil
    when /7\./
      kex = kex59
    when /8\./
      kex = kex66
    end
  when 'redhat'
    case os[:release]
    when '6.4', '6.5'
      kex = nil
    end
  end

  kex
end

def valid_macs
  # define a set of default MACs
  macs66 = 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
  macs59 = 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
  macs53 = 'hmac-ripemd160,hmac-sha1'
  macs = macs59

  # adjust MACs based on OS + release
  case os[:family]
  when 'ubuntu'
    case os[:release]
    when '12.04'
      macs = macs59
    when '14.04'
      macs = macs66
    end
  when 'debian'
    case os[:release]
    when /6\./
      macs = macs53
    when /7\./
      macs = macs59
    when /8\./
      macs = macs66
    end
  when 'redhat'
    case os[:release]
    when '6.4', '6.5'
      macs = macs53
    end
  end

  macs
end

def use_privilege_separation
  ps59 = 'sandbox'
  ps53 = 'yes'
  ps = ps59

  # adjust UsePrivilegeSeparation based on OS + release
  case os[:family]
  when 'ubuntu'
    ps = ps59
  when 'debian'
    case os[:release]
    when /6\./
      ps = ps53
    when /7\./
      ps = ps59
    end
  when 'redhat'
    case os[:release]
    when '6.4', '6.5'
      ps = ps53
    end
  end

  ps
end

def it_should_define(field, values)
  its(:content) do
    if values.nil?
      should_not match(/^#{field} .*$/)
    else
      should match(/^#{field} #{values}$/)
    end
  end
end

describe 'SSH owner, group and permissions' do

  describe file('/etc/ssh') do
    it { should be_directory }
  end

  describe file('/etc/ssh') do
    it { should be_owned_by 'root' }
  end

  describe file('/etc/ssh') do
    it { should be_mode 755 }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_owned_by 'root' }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_mode 600 }
  end

  describe file('/etc/ssh/ssh_config') do
    it { should be_mode 644 }
  end

end

describe 'check sshd_config' do

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitRootLogin no$|^PermitRootLogin without-password$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^Port [0-9]?/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AddressFamily inet|any$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ListenAddress .*/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^Protocol 2$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^StrictModes yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^SyslogFacility AUTH$/) }
  end

  2
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^LogLevel VERBOSE$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    it_should_define('Ciphers', valid_ciphers)
  end

  describe file('/etc/ssh/sshd_config') do
    it_should_define('MACs', valid_macs)
  end

  describe file('/etc/ssh/sshd_config') do
    it_should_define('KexAlgorithms', valid_kexs)
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^UseLogin no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    it_should_define('UsePrivilegeSeparation', use_privilege_separation)
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitUserEnvironment no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^LoginGraceTime 30s$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^MaxAuthTries 2$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^MaxSessions 10$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^MaxStartups 10:30:100$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PubkeyAuthentication yes$/) }
  end

  7
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreRhosts yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreUserKnownHosts yes$/) }
  end

  7
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^HostbasedAuthentication no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^UsePAM no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PasswordAuthentication no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitEmptyPasswords no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ChallengeResponseAuthentication no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^KerberosAuthentication no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^KerberosOrLocalPasswd no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^KerberosTicketCleanup yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^GSSAPIAuthentication no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^GSSAPICleanupCredentials yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^TCPKeepAlive no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ClientAliveInterval 600$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ClientAliveCountMax 3$/) }
  end

  0
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitTunnel no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AllowTcpForwarding no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AllowAgentForwarding no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^GatewayPorts no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^X11Forwarding no$/) }
  end

  
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^X11UseLocalhost yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PrintMotd no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PrintLastLog no$/) }
  end

end

describe 'check ssh_config' do

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^AddressFamily inet|any$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Host/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Port [0-9]?/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Protocol 2$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^BatchMode no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^CheckHostIP yes$/) }
  end

  9
  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^StrictHostKeyChecking ask$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    it_should_define('Ciphers', valid_ciphers)
  end

  describe file('/etc/ssh/ssh_config') do
    it_should_define('MACs', valid_macs)
  end

  describe file('/etc/ssh/ssh_config') do
    it_should_define('KexAlgorithms', valid_kexs)
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^ForwardAgent no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^ForwardX11 no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^HostbasedAuthentication no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^RhostsRSAAuthentication no$/) }
  end

  
  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^RSAAuthentication yes$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^PasswordAuthentication no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^GSSAPIAuthentication no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^GSSAPIDelegateCredentials no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Tunnel no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^PermitLocalCommand no$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Compression yes$/) }
  end

end
