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

title 'SSH server config'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'libraries'))
require 'ssh_crypto'

ssh_crypto = SshCrypto.new(os)

control 'sshd-01' do
  impact 1.0
  title 'Server: Check for secure ssh ciphers'
  desc 'Configure a list of ciphers to the best secure ciphers (avoid older and weaker ciphers)'
  describe sshd_config do
    its('Ciphers') { should eq(ssh_crypto.valid_ciphers) }
  end
end

control 'sshd-02' do
  impact 1.0
  title 'Server: Check for secure ssh Key-Exchange Algorithm'
  desc 'Configure a list of Key-Exchange Algorithms (Kexs) to the best secure Kexs (avoid older and weaker Key-Exchange Algorithm)'
  describe sshd_config do
    its('KexAlgorithms') { should eq(ssh_crypto.valid_kexs) }
  end
end

control 'sshd-03' do
  impact 1.0
  title 'Server: Check for secure ssh Message Authentication Codes'
  desc 'Configure a list of Message Authentication Codes (MACs) to the best secure MACs (avoid older and weaker Message Authentication Codes)'
  describe sshd_config do
    its('MACs') { should eq(ssh_crypto.valid_macs) }
  end
end

control 'sshd-04' do
  impact 1.0
  title 'Server: Check SSH folder owner, group and permissions.'
  desc 'The SSH folder should owned by root, only be writable by owner and readable by others.'
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
  end
end

control 'sshd-05' do
  impact 1.0
  title 'Server: Check sshd_config owner, group and permissions.'
  desc 'The sshd_config should owned by root, only be writable/readable by owner and not be executable.'

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
end

control 'sshd-06' do
  impact 1.0
  title 'Server: Do not permit root-based login or do not allow password and keyboard-interactive authentication'
  desc 'Reduce the potential risk to gain full privileges access of the system because of weak password and keyboard-interactive authentication, do not allow logging in as the root user or with password authentication.'
  describe sshd_config do
    its('PermitRootLogin') { should match(/no|without-password/) }
  end
end

control 'sshd-07' do
  impact 1.0
  title 'Server: Specify the listen ssh Port'
  desc 'Always specify which port the SSH server should listen to. Prevent unexpected settings.'
  describe sshd_config do
    its('Port') { should eq('22') }
  end
end

control 'sshd-08' do
  impact 1.0
  title 'Server: Specify the AddressFamily to your need'
  desc 'OpenSSH should be configured to the network family. Set it to inet if you use IPv4 only. For IPv6 only set it to inet6.'
  describe sshd_config do
    its('AddressFamily') { should match(/inet|inet6|any/) }
  end
end

control 'sshd-09' do
  impact 1.0
  title 'Server: Specify ListenAddress'
  desc "Limit the SSH server to listen to a specific address. Don't let it listen on all interfaces to avoid logins from unexpected sources."
  describe sshd_config do
    its('ListenAddress') { should eq('0.0.0.0') }
  end
end

control 'sshd-10' do
  impact 1.0
  title 'Server: Specify protocol version 2'
  desc "Only SSH protocol version 2 connections should be permitted. Version 1 of the protocol contains security vulnerabilities. Don't use legacy insecure SSHv1 connections anymore."
  describe sshd_config do
    its('Protocol') { should eq('2') }
  end
end

control 'sshd-11' do
  impact 1.0
  title 'Server: Enable StrictModes'
  desc 'Prevent the use of insecure home directory and key file permissions.'
  describe sshd_config do
    its('StrictModes') { should eq('yes') }
  end
end

control 'sshd-12' do
  impact 1.0
  title 'Server: Specify SyslogFacility to AUTH'
  desc 'Logging should be set to go to the /var/log/auth.log facility by using the SysLog AUTH parameter. This will ensure that any problems around invalid logins or the like are forwarded to a central security file for auditing purposes'
  describe sshd_config do
    its('SyslogFacility') { should eq('AUTH') }
  end
end

control 'sshd-13' do
  impact 1.0
  title 'Server: Specify LogLevel to VERBOSE'
  desc 'Be verbose in logging, to allow analysis in case of unexpected behavior.'
  describe sshd_config do
    its('LogLevel') { should eq('VERBOSE') }
  end
end

control 'sshd-14' do
  impact 1.0
  title 'Server: Specify SSH HostKeys'
  desc 'Specify HostKey for protection against Man-In-The-Middle Attacks'
  describe sshd_config do
    its('HostKey') { should eq [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_dsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
      ] }
  end
end

control 'sshd-15' do
  impact 1.0
  title 'Server: Speciy UseLogin to NO'
  desc 'Disable legacy login mechanism and do not use login for interactive login sessions.'
  describe sshd_config do
    its('UseLogin') { should eq('no') }
  end
end

control 'sshd-16' do
  impact 1.0
  title 'Server: Use privilege separation'
  desc 'UsePrivilegeSeparation is an option, when enabled will allow the OpenSSH server to run a small (necessary) amount of code as root and the of the code in a chroot jail environment. This enables ssh to deal incoming network traffic in an unprivileged child process to avoid privilege escalation by an attacker.'
  describe sshd_config do
    its('UsePrivilegeSeparation') { should eq(ssh_crypto.valid_privseparation) }
  end
end

control 'sshd-17' do
  impact 1.0
  title 'Server: Disable PermitUserEnvironment'
  desc 'Enabling environment processing may enable users to bypass access restrictions in some configurations using mechanisms such as LD_PRELOAD.'
  describe sshd_config do
    its('PermitUserEnvironment') { should eq('no') }
  end
end

control 'sshd-18' do
  impact 1.0
  title 'Server: Specify LoginGraceTime'
  desc 'The LoginGraceTime gives the user 30 seconds to accomplish a login. This could be used to conduct a Denial of Service (DoS) against a running SSH daemon.'
  describe sshd_config do
    its('LoginGraceTime') { should eq('30s') }
  end
end

control 'sshd-19' do
  impact 1.0
  title 'Server: Specify Limit for maximum authentication retries'
  desc 'MaxAuthTries limits the user to three wrong attempts before the login attempt is denied. This avoid resource starvation attacks.'
  describe sshd_config do
    its('MaxAuthTries') { should eq('2') }
  end
end

control 'sshd-20' do
  impact 1.0
  title 'Server: Specify maximum sessions'
  desc 'Specifies the maximum number of open sessions permitted per network connection. This could be used to conduct a Denial of Service (DoS) against a running SSH daemon.'
  describe sshd_config do
    its('MaxSessions') { should eq('10') }
  end
end

control 'sshd-21' do
  impact 1.0
  title 'Server: Specify maximum startups'
  desc 'Limit the number of concurrent unauthenticated sessions to prevent Denial of Service (DoS) against a running SSH daemon.'
  describe sshd_config do
    its('MaxStartups') { should eq('10:30:100') }
  end
end

control 'sshd-22' do
  impact 1.0
  title 'Server: Enable PubkeyAuthentication'
  desc 'Prefer public key authentication mechanisms, because other methods are weaker (e.g. passwords).'
  describe sshd_config do
    its('PubkeyAuthentication') { should eq('yes') }
  end
end

control 'sshd-23' do
  impact 1.0
  title 'Server: Disable IgnoreRhosts'
  desc 'Ignore legacy .rhosts configuration, because rhosts are a weak way to authenticate systems and provide attacker more ways to enter the system.'
  describe sshd_config do
    its('IgnoreRhosts') { should eq('yes') }
  end
end

control 'sshd-24' do
  impact 1.0
  title 'Server: Enable IgnoreUserKnownHosts'
  desc 'This option is a weak way for authentication and provide attacker more ways to enter the system.'
  describe sshd_config do
    its('IgnoreUserKnownHosts') { should eq('yes') }
  end
end

control 'sshd-25' do
  impact 1.0
  title 'Server: Disable HostbasedAuthentication'
  desc 'This option is a weak way for authentication and provide attacker more ways to enter the system.'
  describe sshd_config do
    its('HostbasedAuthentication') { should eq('no') }
  end
end

control 'sshd-26' do
  impact 1.0
  title 'Server: Disable PAM'
  desc 'Avoid challenge-response and password-based authentications.'
  describe sshd_config do
    its('UsePAM') { should eq('no') }
  end
end

control 'sshd-27' do
  impact 1.0
  title 'Server: Disable password-based authentication'
  desc 'Avoid password-based authentications.'
  describe sshd_config do
    its('PasswordAuthentication') { should eq('no') }
  end
end

control 'sshd-28' do
  impact 1.0
  title 'Server: Disable PermitEmptyPasswords'
  desc 'Accounts should be protected and users should be accountable. For this reason the usage of empty passwords should never be allowed.'
  describe sshd_config do
    its('PermitEmptyPasswords') { should eq('no') }
  end
end

control 'sshd-29' do
  impact 1.0
  title 'Server: Disable ChallengeResponseAuthentication'
  desc 'Avoid challenge-response and password-based authentications.'
  describe sshd_config do
    its('ChallengeResponseAuthentication') { should eq('no') }
  end
end

control 'sshd-30' do
  impact 1.0
  title 'Server: Disable Kerberos or Local Password'
  desc 'Avoid kerberos authentication.'
  describe sshd_config do
    its('KerberosAuthentication') { should eq('no') }
  end
end

control 'sshd-31' do
  impact 1.0
  title 'Server: Disable Kerberos or Local Password'
  desc 'Avoid kerberos authentication because it use password-based authentication as fallback.'
  describe sshd_config do
    its('KerberosOrLocalPasswd') { should eq('no') }
  end
end

control 'sshd-32' do
  impact 1.0
  title 'Server: Enable KerberosTicketCleanup'
  desc "Specifies whether to automatically destroy the user's ticket cache file on logout."
  describe sshd_config do
    its('KerberosTicketCleanup') { should eq('yes') }
  end
end

control 'sshd-33' do
  impact 1.0
  title 'Server: Disable GSSAPIAuthentication'
  desc 'If you do not use GSSAPI authentication then disable it.'
  describe sshd_config do
    its('GSSAPIAuthentication') { should eq('no') }
  end
end

control 'sshd-34' do
  impact 1.0
  title 'Server: Enable GSSAPICleanupCredentials'
  desc "Automatically destroy the user's credentials cache on logout."
  describe sshd_config do
    its('GSSAPICleanupCredentials') { should eq('yes') }
  end
end

control 'sshd-35' do
  impact 1.0
  title 'Server: Disable TCPKeepAlive'
  desc 'Avoid the TCPKeepAlive messages to see if the client is still alive, because they are sent over unencrypted connection and are spoofable.'
  describe sshd_config do
    its('TCPKeepAlive') { should eq('no') }
  end
end

control 'sshd-36' do
  impact 1.0
  title 'Server: Set a client alive interval'
  desc 'ClientAlive messages are sent over encrypted connection and are not spoofable.'
  describe sshd_config do
    its('ClientAliveInterval') { should eq('600') }
  end
end

control 'sshd-37' do
  impact 1.0
  title 'Server: Configure a few client alive counters'
  desc 'This indicates the total number of checkalive message sent by the ssh server without getting any response from the ssh client. ClientAlive messages are sent over encrypted connection and are not spoofable.'
  describe sshd_config do
    its('ClientAliveCountMax') { should eq('3') }
  end
end

control 'sshd-38' do
  impact 1.0
  title 'Server: Disable tunnels'
  desc 'Avoid to use tunnels.'
  describe sshd_config do
    its('PermitTunnel') { should eq('no') }
  end
end

control 'sshd-39' do
  impact 1.0
  title 'Server: Disable TCP forwarding'
  desc 'If you use TCP forwarding in an uncontrolled manner then you can bypass the firewalls'
  describe sshd_config do
    its('AllowTcpForwarding') { should eq('no') }
  end
end

control 'sshd-40' do
  impact 1.0
  title 'Server: Disable Agent forwarding'
  desc "Users with the ability to bypass file permissions on the remote host (for the agent's UNIX-domain socket) can access the local agent through the forwarded connection. An attacker cannot obtain key material from the agent, however they can perform operations on the keys that enable them to authenticate using the identities loaded into the agent."
  describe sshd_config do
    its('AllowAgentForwarding') { should eq('no') }
  end
end

control 'sshd-41' do
  impact 1.0
  title 'Server: Disable gateway ports'
  desc 'Prevent remote hosts from connecting to forwarded ports on the node.'
  describe sshd_config do
    its('GatewayPorts') { should eq('no') }
  end
end

control 'sshd-42' do
  impact 1.0
  title 'Server: Disable X11Forwarding'
  desc 'Prevent X11 forwarding by default, as it can be used in a limited way to enable attacks.'
  describe sshd_config do
    its('X11Forwarding') { should eq('no') }
  end
end

control 'sshd-43' do
  impact 1.0
  title 'Server: Enable X11UseLocalhost'
  desc 'SSH daemon should bind the X11 forwarding server to the loopback address. This prevents remote hosts from connecting to the proxy display and reduce the attack surface'
  describe sshd_config do
    its('X11UseLocalhost') { should eq('yes') }
  end
end

control 'sshd-44' do
  impact 1.0
  title 'Server: Disable PrintMotd'
  desc 'This specifies that the SSH daemon itself should not read and display the message of the day file.'
  describe sshd_config do
    its('PrintMotd') { should eq('no') }
  end
end

control 'sshd-45' do
  impact 1.0
  title 'Server: PrintLastLog'
  desc 'This tells the SSH daemon to print out information about the last time you logged in.'
  describe sshd_config do
    its('PrintLastLog') { should eq('no') }
  end
end
