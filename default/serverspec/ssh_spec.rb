# encoding: utf-8

require 'spec_helper'

RSpec.configure do |c|
  c.filter_run_excluding skipOn: backend(Serverspec::Commands::Base).check_os[:family]
end

RSpec::Matchers.define :valid_cipher do
  match do |actual|

    # define a set of default ciphers
    ciphers53 = 'aes256-ctr,aes192-ctr,aes128-ctr'
    ciphers66 = 'chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'
    ciphers = ciphers53

    # adjust ciphers based on OS + release
    case os[:family]
    when 'Ubuntu'
      case os[:release]
      when '12.04'
        ciphers = ciphers53
      when '14.04'
        ciphers = ciphers66
      end
    when 'Debian'
      case os[:release]
      when /6\./, /7\./
        ciphers = ciphers53
      end
    when 'RedHat'
      case os[:release]
      when '6.4', '6.5'
        ciphers = ciphers53
      end
    end

    expect(actual).to match_regex(/^Ciphers #{ciphers}$/)
  end
end

RSpec::Matchers.define :valid_kex do
  match do |actual|

    # define a set of default KEXs
    kex66 = 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1'
    kex59 = 'diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1'
    kex = kex59

    # adjust KEXs based on OS + release
    case os[:family]
    when 'Ubuntu'
      case os[:release]
      when '12.04'
        kex = kex59
      when '14.04'
        kex = kex66
      end
    when 'Debian'
      case os[:release]
      when /6\./
        kex = nil
      when /7\./
        kex = kex59
      end
    when 'RedHat'
      case os[:release]
      when '6.4', '6.5'
        kex = nil
      end
    end

    if kex.nil?
      expect(actual).to should_not match_regex(/^KexAlgorithms/)
    else
      expect(actual).to match_regex(/^KexAlgorithms #{kex}$/)
    end
  end
end

RSpec::Matchers.define :valid_mac do
  match do |actual|

    # define a set of default MACs
    macs66 = 'hmac-sha2-512-etm@openssh.com,hmac-sha2-512,hmac-sha2-256-etm@openssh.com,hmac-sha2-256,umac-128-etm@openssh.com,hmac-ripemd160-etm@openssh.com,hmac-ripemd160'
    macs59 = 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
    macs53 = 'hmac-ripemd160,hmac-sha1'
    macs = macs59

    # adjust MACs based on OS + release
    case os[:family]
    when 'Ubuntu'
      case os[:release]
      when '12.04'
        macs = macs59
      when '14.04'
        macs = macs66
      end
    when 'Debian'
      case os[:release]
      when /6\./
        macs = macs53
      when /7\./
        macs = macs59
      end
    when 'RedHat'
      case os[:release]
      when '6.4', '6.5'
        macs = macs53
      end
    end

    expect(actual).to match_regex(/^MACs #{macs}$/)
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

  # GIS: Req 3.04-13
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitRootLogin no$|^PermitRootLogin without-password$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^Port [0-9]?/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AddressFamily inet|any$/) }
  end

  # GIS: Req 3.04-3
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ListenAddress .*/) }
  end

   # GIS: Req 3.04-1
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^Protocol 2$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^StrictModes yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^SyslogFacility AUTH$/) }
  end

  # GIS: Req 3.04-12
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^LogLevel VERBOSE$/) }
  end

  # GIS: Req 3.04-2
  describe file('/etc/ssh/sshd_config') do
    its(:content) do
      should valid_cipher
    end
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) do
      should valid_mac
    end
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) do
      should valid_kex
    end
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^KeyRegenerationInterval 1h$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^ServerKeyBits 2048$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^UseLogin no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^UsePrivilegeSeparation yes$/) }
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

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^RSAAuthentication yes$/) }
  end

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PubkeyAuthentication yes$/) }
  end

  # GIS: Req 3.04-17
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreRhosts yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreUserKnownHosts yes$/) }
  end

  # GIS: Req 3.04-17
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^RhostsRSAAuthentication no$/) }
  end

  # GIS: Req 3.04-17
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^HostbasedAuthentication no$/) }
  end

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PasswordAuthentication no$/) }
  end

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitEmptyPasswords no$/) }
  end

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
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

  # GIS: Req 3.04-10
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PermitTunnel no$/) }
  end

  # GIS: Req 3.04-6
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AllowTcpForwarding no$/) }
  end

  # GIS: Req 3.04-9
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^AllowAgentForwarding no$/) }
  end

  # GIS: Req 3.04-7
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^GatewayPorts no$/) }
  end

  # GIS: Req 3.04-8
  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^X11Forwarding no$/) }
  end

  # GIS: Req 3.04-8
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

  # GIS: Req 3.04-19
  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^StrictHostKeyChecking ask$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) do
      should valid_cipher
    end
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) do
      should valid_mac
    end
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) do
      should valid_kex
    end
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

  # GIS: Req 3.04-13 ; GIS: Req 3.04-14
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
