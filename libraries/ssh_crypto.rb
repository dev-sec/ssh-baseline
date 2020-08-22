# Copyright 2015, Dominik Richter
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

class SshCrypto < Inspec.resource(1) # rubocop:disable Metrics/ClassLength
  name 'ssh_crypto'

  def ssh_version
    inspec.command('ssh -V 2>&1 | cut -f1 -d" " | cut -f2 -d"_"').stdout.to_f
  end

  def valid_ciphers # rubocop:disable Metrics/CyclomaticComplexity
    # define a set of default ciphers
    ciphers53 = 'aes256-ctr,aes192-ctr,aes128-ctr'
    ciphers66 = 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'
    ciphers = ciphers53

    # adjust ciphers based on OS + release
    case inspec.os[:name]
    when 'ubuntu'
      ciphers = ciphers66 if inspec.os[:release][0, 2] > '12'
    when 'debian'
      case inspec.os[:release]
      when /^6\./, /^7\./
        ciphers = ciphers53
      when /^8\./, /^9\./, /^10\./
        ciphers = ciphers66
      end
    when 'redhat', 'centos', 'oracle'
      case inspec.os[:release]
      when /^6\./
        ciphers = ciphers53
      when /^7\./, /^8\./
        ciphers = ciphers66
      end
    when 'amazon', 'fedora', 'alpine', 'arch'
      ciphers = ciphers66
    when 'opensuse'
      case inspec.os[:release]
      when /^13\.2/
        ciphers = ciphers66
      when /^42\./
        ciphers = ciphers66
      end
    when 'mac_os_x'
      case inspec.os[:release]
      when /^10.9\./
        ciphers = ciphers53
      when /^10.10\./, /^10.11\./, /^10.12\./
        ciphers = ciphers66
      end
    end

    ciphers
  end

  def valid_kexs # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
    # define a set of default KEXs
    kex80 = 'sntrup4591761x25519-sha512@tinyssh.org,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256'
    kex66 = 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256'
    kex59 = 'diffie-hellman-group-exchange-sha256'
    kex = kex59

    # adjust KEXs based on OS + release
    case inspec.os[:name]
    # https://packages.ubuntu.com/search?keywords=openssh-server
    when 'ubuntu'
      kex = inspec.os[:release][0, 2] >= '19' ? kex80 : kex66
    # https://packages.debian.org/search?keywords=openssh-server
    when 'debian'
      case inspec.os[:release]
      when /^6\./
        kex = nil
      when /^7\./
        kex = kex59
      when /^8\./, /^9\./, /^10\./
        kex = kex66
      when /^11\./
        kex = kex80
      end
    when 'redhat', 'centos', 'oracle'
      case inspec.os[:release]
      when /^6\./
        kex = nil
      when /^7\./
        kex = kex66
      when /^8\./
        kex = kex80
      end
    # https://pkgs.alpinelinux.org/packages?name=openssh
    when 'arch'
      kex = kex80
    when 'alpine'
      kex = inspec.os[:release].split('.')[1] >= '10' ? kex80 : kex66
    when 'amazon'
      kex = kex66
    # https://src.fedoraproject.org/rpms/openssh
    when 'fedora'
      kex = inspec.os[:release] >= '30' ? kex80 : kex66
    # https://software.opensuse.org/package/openssh
    when 'opensuse'
      kex = inspec.os[:release] >= '15.2' ? kex80 : kex66
    when 'mac_os_x'
      case inspec.os[:release]
      when /^10.9\./
        kex = kex59
      when /^10.10\./, /^10.11\./, /^10.12\./
        kex = kex66
      when /^10.15\./
        kex = kex80
      end
    end

    kex
  end

  def valid_macs # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
    # define a set of default MACs
    macs66 = 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256'
    macs59 = 'hmac-sha2-512,hmac-sha2-256,hmac-ripemd160'
    macs53 = 'hmac-ripemd160,hmac-sha1'
    macs53_el65 = 'hmac-sha2-512,hmac-sha2-256'
    macs = macs59

    # adjust MACs based on OS + release
    case inspec.os[:name]
    when 'ubuntu'
      macs = macs66 if inspec.os[:release][0, 2] > '12'
    when 'debian'
      case inspec.os[:release]
      when /^6\./
        macs = macs53
      when /^7\./
        macs = macs59
      when /^8\./, /^9\./, /^10\./
        macs = macs66
      end
    when 'redhat', 'centos', 'oracle'
      case inspec.os[:release]
      when /^6\./
        # RedHat Enterprise Linux (and family) backported SHA2 support to their fork of OpenSSH 5.3 in RHEL 6.5.
        # See BZ#969565 at:
        # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html-single/6.5_technical_notes/index#openssh
        # Because extended support (EUS) updates for 6.x minor releases is no longer available,
        # only the settings available for the supported (latest) 6.x release are recommended.
        macs = macs53_el65
      when /^7\./, /^8\./
        macs = macs66
      end
    when 'amazon', 'fedora', 'alpine', 'arch'
      macs = macs66
    when 'opensuse'
      case inspec.os[:release]
      when /^13\.2/
        macs = macs66
      when /^42\./
        macs = macs66
      end
    when 'mac_os_x'
      case inspec.os[:release]
      when /^10.9\./
        macs = macs59
      when /^10.10\./, /^10.11\./, /^10.12\./
        macs = macs66
      end
    end

    macs
  end

  def valid_privseparation # rubocop:disable Metrics/CyclomaticComplexity
    # define privilege separation set
    ps53 = 'yes'
    ps59 = 'sandbox'
    ps75 = nil
    ps = ps59

    # debian 7.x and newer has ssh 5.9+
    # ubuntu 12.04 and newer has ssh 5.9+

    case inspec.os[:name]
    when 'debian'
      case inspec.os[:release]
      when /^6\./
        ps = ps53
      when /^10\./
        ps = ps75
      end
    when 'redhat', 'centos', 'oracle'
      case inspec.os[:release]
      # redhat/centos/oracle 6.x has ssh 5.3
      when /^6\./
        ps = ps53
      when /^7\./
        ps = ps59
      when /^8\./
        ps = ps75
      end
    when 'ubuntu'
      case inspec.os[:release]
      when /^18\./, /^20\./
        ps = ps75
      end
    when 'fedora', 'alpine', 'arch'
      ps = ps75
    end

    ps
  end

  # return a list of valid algoriths for a current platform
  def valid_algorithms # rubocop:disable Metrics/CyclomaticComplexity
    alg53 = %w[rsa]
    alg60 = %w[rsa ecdsa]
    alg66 = %w[rsa ecdsa ed25519]
    alg = alg66 # probably its a best suitable set for everything unknown

    case inspec.os[:name]
    when 'ubuntu'
      alg = alg53 if inspec.os[:release][0, 2] < '14'
    when 'debian'
      case inspec.os[:release]
      when /^7\./
        alg = alg60
      when /^8\./, /^9\./
        alg = alg66
      end
    when 'redhat', 'centos', 'oracle'
      case inspec.os[:release]
      when /^6\./
        alg = alg53
      when /^7\./
        alg = alg66
      end
    when 'amazon', 'fedora', 'alpine', 'arch'
      alg = alg66
    when 'opensuse'
      case inspec.os[:release]
      when /^13\.2/
        alg = alg66
      when /^42\./
        alg = alg66
      end
    when 'mac_os_x'
      case inspec.os[:release]
      when /^10.9\./
        alg53
      when /^10.10\./, /^10.11\./, /^10.12\./
        alg66
      end
    end

    alg
  end
end
