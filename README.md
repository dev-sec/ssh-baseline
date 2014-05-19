tests-ssh-hardening
===================

This are the integration tests for the projects

- https://github.com/TelekomLabs/puppet-ssh-hardening
- https://github.com/TelekomLabs/chef-ss-hardening

they start at `integration` level

you can use the gem `kitchen-sharedtests`

- https://github.com/ehaselwanter/kitchen-sharedtests/

to make them available to your project. Use `thor kitchen:fetch-remote-tests` to put the repo into `test/integration`  
