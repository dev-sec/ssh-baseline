require 'spec_helper'

RSpec.configure do |c|
  c.filter_run_excluding skipOn: backend(Serverspec::Commands::Base).check_os[:family]
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
    its(:content) { should match(/^HostKey*/) }
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

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^LogLevel VERBOSE$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) do

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
      when 'RedHat'
        case os[:release]
        when '6.4', '6.5'
          ciphers = ciphers53
        end
      end

      should match(/^Ciphers #{ciphers}$/)
    end
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) do

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
      when 'RedHat'
        case os[:release]
        when '6.4', '6.5'
          macs = macs53
        end
      end

      should match(/^MACs #{macs}$/)
    end
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) do

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
      when 'RedHat'
        case os[:release]
        when '6.4', '6.5'
          should_not match(/^KexAlgorithms/)
          kex = nil
        end
      end

      should match(/^KexAlgorithms #{kex}$/) unless kex.nil?
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

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^RSAAuthentication yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^PubkeyAuthentication yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreRhosts yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^IgnoreUserKnownHosts yes$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^RhostsRSAAuthentication no$/) }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match(/^HostbasedAuthentication no$/) }
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

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^StrictHostKeyChecking ask$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^Ciphers (aes128-ctr,aes256-ctr,aes192-ctr)|(aes128-ctr,aes256-ctr,aes192-ctr,aes128-cbc,aes256-cbc,aes192-cbc)$/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^MACs (hmac-sha2-256,hmac-sha2-512,hmac-ripemd160)|(hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-sha1)|(hmac-ripemd160$)/) }
  end

  describe file('/etc/ssh/ssh_config') do
    its(:content) { should match(/^KexAlgorithms (ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256)|(ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1)$/) }
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
