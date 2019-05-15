# Change Log

## [2.4.0](https://github.com/dev-sec/ssh-baseline/tree/2.4.0) (2019-02-25)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.3.2...2.4.0)

**Closed issues:**

- need to account for sshd version when checking UseRoaming in `ssh\_config` [\#121](https://github.com/dev-sec/ssh-baseline/issues/121)
- profile fails inspec check [\#101](https://github.com/dev-sec/ssh-baseline/issues/101)
- Deprecated option [\#95](https://github.com/dev-sec/ssh-baseline/issues/95)

**Merged pull requests:**

- 2.4.0 [\#124](https://github.com/dev-sec/ssh-baseline/pull/124) ([chris-rock](https://github.com/chris-rock))
- Allow prohibit-password as PermitRootLogin value [\#123](https://github.com/dev-sec/ssh-baseline/pull/123) ([jeremy-clerc](https://github.com/jeremy-clerc))
- UseRoaming is deprecated, only check on older versions [\#122](https://github.com/dev-sec/ssh-baseline/pull/122) ([rndmh3ro](https://github.com/rndmh3ro))
- Fix os detection [\#120](https://github.com/dev-sec/ssh-baseline/pull/120) ([IceBear2k](https://github.com/IceBear2k))
- Update issue templates [\#118](https://github.com/dev-sec/ssh-baseline/pull/118) ([rndmh3ro](https://github.com/rndmh3ro))
- Fixup of UsePrivilegeSeparation deprecation for Amazon [\#117](https://github.com/dev-sec/ssh-baseline/pull/117) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Deprecated UsePrivilegeSeparation for Fedora/Amazon [\#116](https://github.com/dev-sec/ssh-baseline/pull/116) ([artem-sidorenko](https://github.com/artem-sidorenko))
- UseLogin is deprecated [\#114](https://github.com/dev-sec/ssh-baseline/pull/114) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Add separate PrivilegeSeparation check for Ubuntu 1804 [\#113](https://github.com/dev-sec/ssh-baseline/pull/113) ([rndmh3ro](https://github.com/rndmh3ro))
- allow some customization of expected values depending on attributes [\#112](https://github.com/dev-sec/ssh-baseline/pull/112) ([juju4](https://github.com/juju4))
- Avoid checking deprecated optinos for OpenSSH \>=7.6 [\#110](https://github.com/dev-sec/ssh-baseline/pull/110) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Avoid failing on EL 6 family and OpenSuse Leap 42 [\#109](https://github.com/dev-sec/ssh-baseline/pull/109) ([artem-sidorenko](https://github.com/artem-sidorenko))
- add debian 9 support [\#106](https://github.com/dev-sec/ssh-baseline/pull/106) ([rndmh3ro](https://github.com/rndmh3ro))
- adding ubuntu bionic support [\#104](https://github.com/dev-sec/ssh-baseline/pull/104) ([attachmentgenie](https://github.com/attachmentgenie))
- Initial support for Alpine Linux [\#102](https://github.com/dev-sec/ssh-baseline/pull/102) ([radhus](https://github.com/radhus))

## [2.3.2](https://github.com/dev-sec/ssh-baseline/tree/2.3.2) (2018-04-20)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.3.1...2.3.2)

**Merged pull requests:**

- Fix bogus success of sshd-47 on non Debian [\#100](https://github.com/dev-sec/ssh-baseline/pull/100) ([eramoto](https://github.com/eramoto))

## [2.3.1](https://github.com/dev-sec/ssh-baseline/tree/2.3.1) (2018-02-13)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.3.0...2.3.1)

**Closed issues:**

- No git tag for 2.3.0 [\#96](https://github.com/dev-sec/ssh-baseline/issues/96)

**Merged pull requests:**

- Modified the client\_alive\_interval default to suggested value [\#98](https://github.com/dev-sec/ssh-baseline/pull/98) ([iennae](https://github.com/iennae))
- Support Amazon Linux [\#97](https://github.com/dev-sec/ssh-baseline/pull/97) ([woneill](https://github.com/woneill))

## [2.3.0](https://github.com/dev-sec/ssh-baseline/tree/2.3.0) (2017-12-01)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.2.0...2.3.0)

**Closed issues:**

- OpenSSH 7.6 deprecated MACs [\#93](https://github.com/dev-sec/ssh-baseline/issues/93)

**Merged pull requests:**

- remove ripemd160 MAC from the macs66 list [\#94](https://github.com/dev-sec/ssh-baseline/pull/94) ([atomic111](https://github.com/atomic111))
- use recommended spdx license identifier [\#90](https://github.com/dev-sec/ssh-baseline/pull/90) ([chris-rock](https://github.com/chris-rock))
- CI: update to ruby 2.4.1 and rubocop 0.49 [\#89](https://github.com/dev-sec/ssh-baseline/pull/89) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Support of OpenSuse Leap 42.2 [\#88](https://github.com/dev-sec/ssh-baseline/pull/88) ([artem-sidorenko](https://github.com/artem-sidorenko))

## [2.2.0](https://github.com/dev-sec/ssh-baseline/tree/2.2.0) (2017-05-08)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.1.1...2.2.0)

**Merged pull requests:**

- update copyright name [\#87](https://github.com/dev-sec/ssh-baseline/pull/87) ([chris-rock](https://github.com/chris-rock))
- update metadata [\#86](https://github.com/dev-sec/ssh-baseline/pull/86) ([chris-rock](https://github.com/chris-rock))
- restrict ruby testing to version 2.3.3 and update gemfile [\#85](https://github.com/dev-sec/ssh-baseline/pull/85) ([atomic111](https://github.com/atomic111))
- Proper tests for Opensuse leap 42.1 [\#84](https://github.com/dev-sec/ssh-baseline/pull/84) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Fix check for os.darwin [\#83](https://github.com/dev-sec/ssh-baseline/pull/83) ([techraf](https://github.com/techraf))
- Add openssh definitions for macos [\#82](https://github.com/dev-sec/ssh-baseline/pull/82) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Add support for oracle [\#80](https://github.com/dev-sec/ssh-baseline/pull/80) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Algorithm/Hostkey tests for different platforms [\#79](https://github.com/dev-sec/ssh-baseline/pull/79) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Test the strong DH primes [\#77](https://github.com/dev-sec/ssh-baseline/pull/77) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Removal of DSA key [\#76](https://github.com/dev-sec/ssh-baseline/pull/76) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Ignore inspec.lock file [\#73](https://github.com/dev-sec/ssh-baseline/pull/73) ([techraf](https://github.com/techraf))
- Remove the PAM deactivation enforcement [\#72](https://github.com/dev-sec/ssh-baseline/pull/72) ([artem-sidorenko](https://github.com/artem-sidorenko))

## [2.1.1](https://github.com/dev-sec/ssh-baseline/tree/2.1.1) (2016-12-22)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.1.0...2.1.1)

**Closed issues:**

- Compare ciphers as array? [\#70](https://github.com/dev-sec/ssh-baseline/issues/70)
- Error performing inspec exec https://github.com/dev-sec/tests-ssh-hardening [\#66](https://github.com/dev-sec/ssh-baseline/issues/66)

**Merged pull requests:**

- update profile metadata & tooling [\#71](https://github.com/dev-sec/ssh-baseline/pull/71) ([chris-rock](https://github.com/chris-rock))
- update Gemfile and remove ruby 1.9.3 support [\#69](https://github.com/dev-sec/ssh-baseline/pull/69) ([arlimus](https://github.com/arlimus))
- Test server config for Banner and DebianBanner [\#67](https://github.com/dev-sec/ssh-baseline/pull/67) ([tsenart](https://github.com/tsenart))
- pin rack version [\#65](https://github.com/dev-sec/ssh-baseline/pull/65) ([chris-rock](https://github.com/chris-rock))
- rename sshd-30 [\#64](https://github.com/dev-sec/ssh-baseline/pull/64) ([attachmentgenie](https://github.com/attachmentgenie))
- Fixing inspec tests for ubuntu hosts [\#63](https://github.com/dev-sec/ssh-baseline/pull/63) ([attachmentgenie](https://github.com/attachmentgenie))

## [2.1.0](https://github.com/dev-sec/ssh-baseline/tree/2.1.0) (2016-07-27)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/2.0.0...2.1.0)

**Closed issues:**

- ListenAddress [\#45](https://github.com/dev-sec/ssh-baseline/issues/45)

**Merged pull requests:**

- Use new ciphers, kex, macs and priv separation sandbox for redhat family 7 [\#62](https://github.com/dev-sec/ssh-baseline/pull/62) ([atomic111](https://github.com/atomic111))
- Fixing typo in sshd\_spec.rb [\#61](https://github.com/dev-sec/ssh-baseline/pull/61) ([brimstone](https://github.com/brimstone))
- Fix: Issue ListenAddress \#45 \(\#45\) and  added check for SSH Client Bug CVE-2016-0777 and CVE-2016-0778  [\#60](https://github.com/dev-sec/ssh-baseline/pull/60) ([atomic111](https://github.com/atomic111))
- changed from hardening-io to dev-sec in README.md and added ubuntu and centos version to ssh\_crypto.rb [\#59](https://github.com/dev-sec/ssh-baseline/pull/59) ([atomic111](https://github.com/atomic111))

## [2.0.0](https://github.com/dev-sec/ssh-baseline/tree/2.0.0) (2016-04-28)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/1.2.0...2.0.0)

**Fixed bugs:**

- bugfix: use new inspec load mechanism [\#58](https://github.com/dev-sec/ssh-baseline/pull/58) ([chris-rock](https://github.com/chris-rock))

**Merged pull requests:**

- migrate to InSpec profile [\#56](https://github.com/dev-sec/ssh-baseline/pull/56) ([chris-rock](https://github.com/chris-rock))

## [1.2.0](https://github.com/dev-sec/ssh-baseline/tree/1.2.0) (2016-04-25)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/1.1.1...1.2.0)

**Closed issues:**

- No easy way to install Ansible on all OS's [\#47](https://github.com/dev-sec/ssh-baseline/issues/47)

**Merged pull requests:**

- 1.2.0 [\#57](https://github.com/dev-sec/ssh-baseline/pull/57) ([chris-rock](https://github.com/chris-rock))
- Symlinks real suite names to "default" [\#55](https://github.com/dev-sec/ssh-baseline/pull/55) ([conorsch](https://github.com/conorsch))
- complet inspec tests [\#52](https://github.com/dev-sec/ssh-baseline/pull/52) ([atomic111](https://github.com/atomic111))
- Improve Ansible tests [\#51](https://github.com/dev-sec/ssh-baseline/pull/51) ([rndmh3ro](https://github.com/rndmh3ro))
- Fix typos [\#50](https://github.com/dev-sec/ssh-baseline/pull/50) ([rndmh3ro](https://github.com/rndmh3ro))
- update urls [\#49](https://github.com/dev-sec/ssh-baseline/pull/49) ([chris-rock](https://github.com/chris-rock))
- feature: debian 8 support [\#48](https://github.com/dev-sec/ssh-baseline/pull/48) ([arlimus](https://github.com/arlimus))
- Add Ansible support [\#46](https://github.com/dev-sec/ssh-baseline/pull/46) ([rndmh3ro](https://github.com/rndmh3ro))
- feature: UsePrivilegeSeparation = sandbox for ssh \>= 5.9 [\#44](https://github.com/dev-sec/ssh-baseline/pull/44) ([arlimus](https://github.com/arlimus))

## [1.1.1](https://github.com/dev-sec/ssh-baseline/tree/1.1.1) (2015-01-14)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/1.1.0...1.1.1)

**Merged pull requests:**

- remove sha1-based key-exchange mechanisms [\#43](https://github.com/dev-sec/ssh-baseline/pull/43) ([arlimus](https://github.com/arlimus))
- add json format option [\#42](https://github.com/dev-sec/ssh-baseline/pull/42) ([atomic111](https://github.com/atomic111))
- reprioritize etm macs [\#41](https://github.com/dev-sec/ssh-baseline/pull/41) ([arlimus](https://github.com/arlimus))

## [1.1.0](https://github.com/dev-sec/ssh-baseline/tree/1.1.0) (2015-01-12)
[Full Changelog](https://github.com/dev-sec/ssh-baseline/compare/1.0.0...1.1.0)

**Closed issues:**

- undefined method `backend' for main:Object [\#32](https://github.com/dev-sec/ssh-baseline/issues/32)

**Merged pull requests:**

- feature: add back gcm [\#40](https://github.com/dev-sec/ssh-baseline/pull/40) ([arlimus](https://github.com/arlimus))
- Descriptive spec [\#39](https://github.com/dev-sec/ssh-baseline/pull/39) ([arlimus](https://github.com/arlimus))
- Update common [\#38](https://github.com/dev-sec/ssh-baseline/pull/38) ([arlimus](https://github.com/arlimus))
- remove options that only apply to SSH protocol version 1 [\#37](https://github.com/dev-sec/ssh-baseline/pull/37) ([arlimus](https://github.com/arlimus))
- Update common [\#36](https://github.com/dev-sec/ssh-baseline/pull/36) ([arlimus](https://github.com/arlimus))
- Update common [\#34](https://github.com/dev-sec/ssh-baseline/pull/34) ([arlimus](https://github.com/arlimus))
- support serverspec-2.0 [\#31](https://github.com/dev-sec/ssh-baseline/pull/31) ([bkw](https://github.com/bkw))
- changed GIS to DTAG SEC [\#30](https://github.com/dev-sec/ssh-baseline/pull/30) ([atomic111](https://github.com/atomic111))
- bugfix: lint error [\#29](https://github.com/dev-sec/ssh-baseline/pull/29) ([chris-rock](https://github.com/chris-rock))

## [1.0.0](https://github.com/dev-sec/ssh-baseline/tree/1.0.0) (2014-08-13)
**Closed issues:**

- HostKeys and OSes [\#13](https://github.com/dev-sec/ssh-baseline/issues/13)
- Comment-tests causing false-positives [\#5](https://github.com/dev-sec/ssh-baseline/issues/5)
- Unify required crypto for ssh server and client [\#4](https://github.com/dev-sec/ssh-baseline/issues/4)
- Add testing of ssh client config [\#3](https://github.com/dev-sec/ssh-baseline/issues/3)

**Merged pull requests:**

- bugfix: unlock user accounts during chef runs [\#28](https://github.com/dev-sec/ssh-baseline/pull/28) ([arlimus](https://github.com/arlimus))
- test for UsePAM disabled [\#27](https://github.com/dev-sec/ssh-baseline/pull/27) ([arlimus](https://github.com/arlimus))
- bugfix sed command location [\#26](https://github.com/dev-sec/ssh-baseline/pull/26) ([arlimus](https://github.com/arlimus))
- Fix puppet user unlock [\#25](https://github.com/dev-sec/ssh-baseline/pull/25) ([arlimus](https://github.com/arlimus))
- bugfix: unlock user accounts on test systems [\#24](https://github.com/dev-sec/ssh-baseline/pull/24) ([arlimus](https://github.com/arlimus))
- Fix matches [\#23](https://github.com/dev-sec/ssh-baseline/pull/23) ([arlimus](https://github.com/arlimus))
- update and fix rubocop [\#22](https://github.com/dev-sec/ssh-baseline/pull/22) ([ehaselwanter](https://github.com/ehaselwanter))
- common validator for client and server config [\#21](https://github.com/dev-sec/ssh-baseline/pull/21) ([chris-rock](https://github.com/chris-rock))
- add robocop rake task [\#20](https://github.com/dev-sec/ssh-baseline/pull/20) ([chris-rock](https://github.com/chris-rock))
- add ruby gem source [\#19](https://github.com/dev-sec/ssh-baseline/pull/19) ([chris-rock](https://github.com/chris-rock))
- added Telekom Security Requirement numbers to the corresponding kitchen test [\#18](https://github.com/dev-sec/ssh-baseline/pull/18) ([atomic111](https://github.com/atomic111))
- add tests for debian 6 and 7 [\#17](https://github.com/dev-sec/ssh-baseline/pull/17) ([arlimus](https://github.com/arlimus))
- add format html option [\#16](https://github.com/dev-sec/ssh-baseline/pull/16) ([ehaselwanter](https://github.com/ehaselwanter))
- remove host keys from checks [\#15](https://github.com/dev-sec/ssh-baseline/pull/15) ([arlimus](https://github.com/arlimus))
- make the integration tests even more useful with standalone invocation [\#14](https://github.com/dev-sec/ssh-baseline/pull/14) ([ehaselwanter](https://github.com/ehaselwanter))
- Tests update [\#12](https://github.com/dev-sec/ssh-baseline/pull/12) ([arlimus](https://github.com/arlimus))
- relax permissions on /etc/ssh and files [\#11](https://github.com/dev-sec/ssh-baseline/pull/11) ([arlimus](https://github.com/arlimus))
- Tests update: remove comments + add conditional ciphers [\#10](https://github.com/dev-sec/ssh-baseline/pull/10) ([arlimus](https://github.com/arlimus))
- add lockfiles and delete them from tree [\#9](https://github.com/dev-sec/ssh-baseline/pull/9) ([ehaselwanter](https://github.com/ehaselwanter))
- streamline rubocop, fix issue which comes with this change [\#8](https://github.com/dev-sec/ssh-baseline/pull/8) ([ehaselwanter](https://github.com/ehaselwanter))
- rubocop fixes [\#7](https://github.com/dev-sec/ssh-baseline/pull/7) ([ehaselwanter](https://github.com/ehaselwanter))
- use a per suite manifest [\#6](https://github.com/dev-sec/ssh-baseline/pull/6) ([ehaselwanter](https://github.com/ehaselwanter))
- changed AllowTcpForwarding and AllowAgentForwarding from yes to no [\#2](https://github.com/dev-sec/ssh-baseline/pull/2) ([atomic111](https://github.com/atomic111))
- move the ssh tests to this new central location [\#1](https://github.com/dev-sec/ssh-baseline/pull/1) ([ehaselwanter](https://github.com/ehaselwanter))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*