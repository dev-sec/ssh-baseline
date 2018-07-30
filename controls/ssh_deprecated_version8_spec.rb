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
# author: Frederik Bosch
#
# Since OpenSSH Version 8 the following directives are deprecated.
#
# - KeyRegenerationInterval
# - RSAAuthentication
# - RhostsRSAAuthentication
# - ServerKeyBits
#
# https://salsa.debian.org/ssh-team/openssh/commit/fb87db8aa47d3508be8e5bb1d21897fa1f2eca90

title 'SSH deprecated client config (version < 8)'

only_if { command('ssh -V').stdout match(/^OpenSSH_[0-7]/) }

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
