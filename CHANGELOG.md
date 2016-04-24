# Change Log

## [1.2.0](https://github.com/dev-sec/tests-ssh-hardening/tree/1.2.0) (2016-04-24)
[Full Changelog](https://github.com/dev-sec/tests-ssh-hardening/compare/1.0.0...1.2.0)

**Closed issues:**

- No easy way to install Ansible on all OS's [\#47](https://github.com/dev-sec/tests-ssh-hardening/issues/47)
- undefined method `backend' for main:Object [\#32](https://github.com/dev-sec/tests-ssh-hardening/issues/32)

**Merged pull requests:**

- Symlinks real suite names to "default" [\#55](https://github.com/dev-sec/tests-ssh-hardening/pull/55) ([conorsch](https://github.com/conorsch))
- complet inspec tests [\#52](https://github.com/dev-sec/tests-ssh-hardening/pull/52) ([atomic111](https://github.com/atomic111))
- Improve Ansible tests [\#51](https://github.com/dev-sec/tests-ssh-hardening/pull/51) ([rndmh3ro](https://github.com/rndmh3ro))
- Fix typos [\#50](https://github.com/dev-sec/tests-ssh-hardening/pull/50) ([rndmh3ro](https://github.com/rndmh3ro))
- update urls [\#49](https://github.com/dev-sec/tests-ssh-hardening/pull/49) ([chris-rock](https://github.com/chris-rock))
- feature: debian 8 support [\#48](https://github.com/dev-sec/tests-ssh-hardening/pull/48) ([arlimus](https://github.com/arlimus))
- Add Ansible support [\#46](https://github.com/dev-sec/tests-ssh-hardening/pull/46) ([rndmh3ro](https://github.com/rndmh3ro))
- feature: UsePrivilegeSeparation = sandbox for ssh \>= 5.9 [\#44](https://github.com/dev-sec/tests-ssh-hardening/pull/44) ([arlimus](https://github.com/arlimus))
- remove sha1-based key-exchange mechanisms [\#43](https://github.com/dev-sec/tests-ssh-hardening/pull/43) ([arlimus](https://github.com/arlimus))
- add json format option [\#42](https://github.com/dev-sec/tests-ssh-hardening/pull/42) ([atomic111](https://github.com/atomic111))
- reprioritize etm macs [\#41](https://github.com/dev-sec/tests-ssh-hardening/pull/41) ([arlimus](https://github.com/arlimus))
- feature: add back gcm [\#40](https://github.com/dev-sec/tests-ssh-hardening/pull/40) ([arlimus](https://github.com/arlimus))
- Descriptive spec [\#39](https://github.com/dev-sec/tests-ssh-hardening/pull/39) ([arlimus](https://github.com/arlimus))
- Update common [\#38](https://github.com/dev-sec/tests-ssh-hardening/pull/38) ([arlimus](https://github.com/arlimus))
- remove options that only apply to SSH protocol version 1 [\#37](https://github.com/dev-sec/tests-ssh-hardening/pull/37) ([arlimus](https://github.com/arlimus))
- Update common [\#36](https://github.com/dev-sec/tests-ssh-hardening/pull/36) ([arlimus](https://github.com/arlimus))
- Update common [\#34](https://github.com/dev-sec/tests-ssh-hardening/pull/34) ([arlimus](https://github.com/arlimus))
- support serverspec-2.0 [\#31](https://github.com/dev-sec/tests-ssh-hardening/pull/31) ([bkw](https://github.com/bkw))
- changed GIS to DTAG SEC [\#30](https://github.com/dev-sec/tests-ssh-hardening/pull/30) ([atomic111](https://github.com/atomic111))
- bugfix: lint error [\#29](https://github.com/dev-sec/tests-ssh-hardening/pull/29) ([chris-rock](https://github.com/chris-rock))

## [1.0.0](https://github.com/dev-sec/tests-ssh-hardening/tree/1.0.0) (2014-08-13)
**Closed issues:**

- HostKeys and OSes [\#13](https://github.com/dev-sec/tests-ssh-hardening/issues/13)
- Comment-tests causing false-positives [\#5](https://github.com/dev-sec/tests-ssh-hardening/issues/5)
- Unify required crypto for ssh server and client [\#4](https://github.com/dev-sec/tests-ssh-hardening/issues/4)
- Add testing of ssh client config [\#3](https://github.com/dev-sec/tests-ssh-hardening/issues/3)

**Merged pull requests:**

- bugfix: unlock user accounts during chef runs [\#28](https://github.com/dev-sec/tests-ssh-hardening/pull/28) ([arlimus](https://github.com/arlimus))
- test for UsePAM disabled [\#27](https://github.com/dev-sec/tests-ssh-hardening/pull/27) ([arlimus](https://github.com/arlimus))
- bugfix sed command location [\#26](https://github.com/dev-sec/tests-ssh-hardening/pull/26) ([arlimus](https://github.com/arlimus))
- Fix puppet user unlock [\#25](https://github.com/dev-sec/tests-ssh-hardening/pull/25) ([arlimus](https://github.com/arlimus))
- bugfix: unlock user accounts on test systems [\#24](https://github.com/dev-sec/tests-ssh-hardening/pull/24) ([arlimus](https://github.com/arlimus))
- Fix matches [\#23](https://github.com/dev-sec/tests-ssh-hardening/pull/23) ([arlimus](https://github.com/arlimus))
- update and fix rubocop [\#22](https://github.com/dev-sec/tests-ssh-hardening/pull/22) ([ehaselwanter](https://github.com/ehaselwanter))
- common validator for client and server config [\#21](https://github.com/dev-sec/tests-ssh-hardening/pull/21) ([chris-rock](https://github.com/chris-rock))
- add robocop rake task [\#20](https://github.com/dev-sec/tests-ssh-hardening/pull/20) ([chris-rock](https://github.com/chris-rock))
- add ruby gem source [\#19](https://github.com/dev-sec/tests-ssh-hardening/pull/19) ([chris-rock](https://github.com/chris-rock))
- added Telekom Security Requirement numbers to the corresponding kitchen test [\#18](https://github.com/dev-sec/tests-ssh-hardening/pull/18) ([atomic111](https://github.com/atomic111))
- add tests for debian 6 and 7 [\#17](https://github.com/dev-sec/tests-ssh-hardening/pull/17) ([arlimus](https://github.com/arlimus))
- add format html option [\#16](https://github.com/dev-sec/tests-ssh-hardening/pull/16) ([ehaselwanter](https://github.com/ehaselwanter))
- remove host keys from checks [\#15](https://github.com/dev-sec/tests-ssh-hardening/pull/15) ([arlimus](https://github.com/arlimus))
- make the integration tests even more useful with standalone invocation [\#14](https://github.com/dev-sec/tests-ssh-hardening/pull/14) ([ehaselwanter](https://github.com/ehaselwanter))
- Tests update [\#12](https://github.com/dev-sec/tests-ssh-hardening/pull/12) ([arlimus](https://github.com/arlimus))
- relax permissions on /etc/ssh and files [\#11](https://github.com/dev-sec/tests-ssh-hardening/pull/11) ([arlimus](https://github.com/arlimus))
- Tests update: remove comments + add conditional ciphers [\#10](https://github.com/dev-sec/tests-ssh-hardening/pull/10) ([arlimus](https://github.com/arlimus))
- add lockfiles and delete them from tree [\#9](https://github.com/dev-sec/tests-ssh-hardening/pull/9) ([ehaselwanter](https://github.com/ehaselwanter))
- streamline rubocop, fix issue which comes with this change [\#8](https://github.com/dev-sec/tests-ssh-hardening/pull/8) ([ehaselwanter](https://github.com/ehaselwanter))
- rubocop fixes [\#7](https://github.com/dev-sec/tests-ssh-hardening/pull/7) ([ehaselwanter](https://github.com/ehaselwanter))
- use a per suite manifest [\#6](https://github.com/dev-sec/tests-ssh-hardening/pull/6) ([ehaselwanter](https://github.com/ehaselwanter))
- changed AllowTcpForwarding and AllowAgentForwarding from yes to no [\#2](https://github.com/dev-sec/tests-ssh-hardening/pull/2) ([atomic111](https://github.com/atomic111))
- move the ssh tests to this new central location [\#1](https://github.com/dev-sec/tests-ssh-hardening/pull/1) ([ehaselwanter](https://github.com/ehaselwanter))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*