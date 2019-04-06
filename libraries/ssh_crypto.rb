# Copyright 2015, Dominik Richter
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# author: Christoph Hartmann
# author: Dominik Richter
# author: Patrick Muench

class SshCrypto < Inspec.resource(1)
  name 'ssh_crypto'

  CRYPTO ||= {
    macs: {
      6.6 => 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256',
      5.9 => 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160',
      5.3 => 'hmac-ripemd160,hmac-sha1',
    },
    ciphers: {
      5.3 => 'aes256-ctr,aes192-ctr,aes128-ctr',
      6.6 => 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr',
    },
    kex: {
      6.6 => 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256',
      5.9 => 'diffie-hellman-group-exchange-sha256',
    }
  }.freeze

  PRIVILEGE_SEPARATION ||= {
    5.3 => 'yes',
    5.9 => 'sandbox',
  }.freeze

  HOSTKEY_ALGORITHMS ||= {
    5.3 => %w[rsa],
    6.0 => %w[rsa ecdsa],
    6.6 => %w[rsa ecdsa ed25519],
  }.freeze

  FALLBACK_SSH_VERSION ||= 5.9

  def real_ssh_version 
    inspec.command('ssh -V 2>&1 | cut -f1 -d" " | cut -f2 -d"_" | cut -f1 -d ","').stdout.to_f
  end

  def ssh_version(versions)
    identified_version = inspec.command('ssh -V 2>&1 | cut -f1 -d" " | cut -f2 -d"_" | cut -f1 -d ","').stdout.to_f
    found_ssh_version = nil 

    versions.each do |version, corresponding_content|
      next unless version.is_a?(Float)
      found_ssh_version = version if identified_version >= version
    end

    return found_ssh_version
  rescue NoMethodError
    guess_ssh_version
  end

  def valid_privseparation
    PRIVILEGE_SEPARATION[ssh_version(PRIVILEGE_SEPARATION)]
  end

  def valid_algorithms
    HOSTKEY_ALGORITHMS[ssh_version(HOSTKEY_ALGORITHMS)]
  end

  def valid_ciphers
    CRYPTO[:ciphers][ssh_version(CRYPTO[:ciphers])]
  end

  def valid_macs
    CRYPTO[:macs][ssh_version(CRYPTO[:macs])]
  end

  def valid_kexs
    puts ssh_version(CRYPTO[:kex])
    CRYPTO[:kex][ssh_version(CRYPTO[:kex])]
  end

 def valid_hostkeys
  hostkeys = HOSTKEY_ALGORITHMS[ssh_version(HOSTKEY_ALGORITHMS)].map { |alg| "/etc/ssh/ssh_host_#{alg}_key" }
  # its('HostKey') provides a string for a single-element value.
  # we have to return a string if we have a single-element
  # https://github.com/chef/inspec/issues/1434
  return hostkeys[0] if hostkeys.length == 1
  hostkeys
end

  def guess_ssh_version
    family = inspec.os[:family]
    platform = inspec.os[:name]
    case family
    when 'debian'
      case name
      when 'ubuntu'
        return 6.6 if version >= 14.04
      when 'debian'
        return 6.6 if version >= 8
        return 6.0 if version >= 7
        return 5.3 if version <= 6
      end
    when 'rhel'
      return 6.6 if version >= 7
      return 5.3 if version >= 6
    when 'fedora'
      return 7.3 if version >= 25
      return 7.2 if version >= 24
    when 'suse'
      case platform
      when 'opensuse'
        return 6.6 if version >= 13.2
      when 'opensuseleap'
        return 7.2 if version >= 42.1
      end
  when 'amazon' 
    case platform
    when 'amazon'
      return 6.6
    end
  when 'alpine'
    case platform
    when 'alpine'
      return 6.6
    end  
  end
    return FALLBACK_SSH_VERSION
  end
end
