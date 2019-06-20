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
      5.3 => 'hmac-ripemd160,hmac-sha1',
      5.9 => 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160',
      6.6 => 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256'
    },
    ciphers: {
      5.3 => 'aes256-ctr,aes192-ctr,aes128-ctr',
      6.6 => 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr',
    },
    kex: {
      5.9 => 'diffie-hellman-group-exchange-sha256',
      6.6 => 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256',
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

  def get_ssh_version
    inspec.command('ssh -V 2>&1 | cut -f1 -d" " | cut -f2 -d"_" | cut -f1 -d ","').stdout.to_f
  rescue NoMethodError
    guess_ssh_version
  end

  # Find the ssh version, matching to the next small
  # version in versions array
  def find_ssh_version(version, versions)
    found_ssh_version = nil 

    versions.map do |v|
      next unless v.is_a?(Float)
      found_ssh_version = v if version >= v
    end

    # We can't just throw an Error here like in devsec_ssh.rb. This would abort the
    # whole execution of tests, but that is not wanted since there are valid cases where
    # a feature is not supported on the hosts so no ssh version matching can be determined.
    Inspec::Log.warn("No matching ssh version could be found for #{version}") unless found_ssh_version

    return found_ssh_version
  end

  def valid_privseparation
     found_ssh_version = find_ssh_version(get_ssh_version, PRIVILEGE_SEPARATION.keys) 

     PRIVILEGE_SEPARATION[found_ssh_version]
  end

  def valid_algorithms
    found_ssh_version = find_ssh_version(get_ssh_version, HOSTKEY_ALGORITHMS.keys)

    HOSTKEY_ALGORITHMS[found_ssh_version]
  end

  def valid_ciphers
    get_crypto_data(:ciphers)
  end

  def valid_macs
    get_crypto_data(:macs)
  end

  def valid_kexs
    get_crypto_data(:kex)
  end

  def get_crypto_data(crypto_type)
    # In the chef baseline there are two methods to determine the ssh version, here there is one
    # ssh -V should return the version of both client and server reliably.
    found_ssh_version = find_ssh_version(get_ssh_version, CRYPTO[crypto_type.to_sym].keys)

    crypto = CRYPTO[crypto_type][found_ssh_version]

    if crypto.nil?
      Inspec::Log.info("No crypto information available for #{found_ssh_version}")
      return nil
    end

    crypto
  end

 def valid_hostkeys
  found_ssh_version = find_ssh_version(get_ssh_version, HOSTKEY_ALGORITHMS.keys)

  hostkeys = HOSTKEY_ALGORITHMS[found_ssh_version].map { |alg| "/etc/ssh/ssh_host_#{alg}_key" }
  # its('HostKey') provides a string for a single-element value.
  # we have to return a string if we have a single-element
  # https://github.com/chef/inspec/issues/1434
  return hostkeys[0] if hostkeys.length == 1
  hostkeys
end

  # This method gessues the ssh_version based on operating system family and name 
  # It intends to be a fallback in case no ssh version can be determined via means of ssh -V
  def guess_ssh_version
    family = inspec.os[:family]
    platform = inspec.os[:name]
    case family
    when 'debian'
      case platform
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
