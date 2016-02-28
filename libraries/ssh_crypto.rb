# encoding: utf-8
#
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

class SshCrypto
  attr_reader :os
  def initialize(os)
    @os = os
  end

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
    when 'redhat', 'centos'
      case os[:release]
      when '6.4', '6.5', /7\./
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
    when 'redhat', 'centos'
      case os[:release]
      when '6.4', '6.5', /7\./
        macs = macs53
      end
    end

    macs
  end

  def valid_privseparation
    # define privilege separation set
    ps53 = 'yes'
    ps59 = 'sandbox'
    ps = ps59

    # debian 7.x and newer has ssh 5.9+
    # ubuntu 12.04 and newer has ssh 5.9+

    case os[:family]
    when 'debian'
      case os[:release]
      when /6\./
        ps = ps53
      end
    when 'redhat', 'centos'
      case os[:release]
      # redhat/centos/oracle 6.x has ssh 5.3
      when /6\./, /7\./
        ps = ps53
      end
    end

    ps
  end

end
