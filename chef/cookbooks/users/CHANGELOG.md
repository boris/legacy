# users Cookbook CHANGELOG

This file is used to list changes made in each version of the users cookbook.

## 5.1.0 (2017-05-30)

- Keep ssh keys out of the chef logs
- Improve docs and examples
- Remove class_eval and require Chef 12.7+ as class_eval causes issues with later Chef 12 releases

## 5.0.0 (2017-04-17)

### Breaking changes

- The users_manage LWRP has been converted to a custom resource, which requires Chef 12.5 or later
- The sysadmins recipe contains no resources now and will do nothing

### Other changes

- Added integration tests with Inspec
- Fixed all deprecation warnings
- Fixed group creation on macOS when the group already exists
- Added suse platforms as supported in the metadata
- Switched to a SPDX apache-2.0 license string
- Moved all templates out of the default directory as we don't support Chef 11 anymore

## 4.0.3 (2016-11-23)

- Update manage provider to return true/false in guard block which avoids warnings during run on Chef 12.14+

## 4.0.2 (2016-11-18)

- Deprecate the sysadmins recipe

## 4.0.1 (2016-09-15)

- Fix creation of user home directory

## 4.0.0 (2016-09-15)

- Add chef_version to the metadata
- Require Chef 12.1+
- Testing updates
- Fixed compatibility with Chef 12.14
- Properly define the Chefspec matcher
- Add a warning if someone includes users::default since that does nothing

## v3.0.0

- @onlyhavecans - Fix FreeBSD support
- @stem - Fix user creation on Mac OS X on 10.7 and 10.8
- Remove old style chef solo code to clean up rubocop issues, move to using cookstyle
- Adding zlinux support

## v2.0.3

- @nkadel-skyhook - create .ssh directory only if keys are configured.
- @signe - allow force parameter to be specified for users configured to be removed.
- @FlorentFlament - adding the ability to manage groups for existing users.

## v2.0.2 (2016-1-25)

- @375gnu- validate uid/gid for strings versus numeric
- fix rubocop errors based on <https://github.com/bbatsov/rubocop/issues/2608>
- fix kitchen configurations for testing

## v2.0.1 (2016-1-8)

- Fixed provider to work on Mac OS X
- funzoneq - add correct default shell for FreeBSD if not provided
- Added kitchen.dokken to speed up platform testing

## v2.0.0 (2015-12-11)

- Removed Chef 10 compatibility code
- Removed the nodes fqdn from the authorized_keys file
- Removed a trailing comma in a readme example
- Added chef standard .gitignore and chefignore files
- Added chef standard .rubocop.yml file and resolved warnings
- Resolved foodcritic warnings

## v1.8.2 (2015-03-18)

- No changes, just republishing 1.8.1

## v1.8.1 (2015-03-12)

- Add `source_url` and `issues_url` to the metadata.rb so Supermarket can display appropriate links

## v1.8.0 (2015-03-09)

- Expose LWRP state attributes
- [COOK-4401] - Add unit tests with ChefSpec
- [COOK-4404] - Determine file system and add manage_nfs_home_dirs attribute to disable managing NFS mounted home directories
- Remove `converge_by` when creating home directory, the directory resource already handles this
- Do not manage home directory if the path does not exist
- Add integration with TravisCI
- "Opscode" to "Chef" replacements
- Retire unsupported Ruby 1.9.3 and add Ruby 2.2 to the Travis integration tests
- Updates for RSpec 3

## v1.7.0 (2014-02-14)

- [COOK-4139] - users_manage resource always notifies
- [COOK-4078] - users cookbook fails in why-run mode for .ssh directory
- [COOK-3959] - Add support for Mac OS X to users cookbook

## v1.6.0

### Bug

- **[COOK-3744](https://tickets.opscode.com/browse/COOK-3744)** - Allow passing an action option via the `data_bag` to the user resource

## v1.5.2

### Bug

- **[COOK-3215](https://tickets.opscode.com/browse/COOK-3215)** - Make `group_id` optional

## v1.5.0

- [COOK-2427] - Mistakenly released instead of sudo :-).

## v1.4.0

- [COOK-2479] - Permit users cookbook to work with chef-solo if edelight/chef-solo-search is installed
- [COOK-2486] - specify precedence when setting node attribute

## v1.3.0

- [COOK-1842] - allow specifying private SSH keys
- [COOK-2021] - Empty default recipe for including users LWRPs

## v1.2.0

- [COOK-1398] - Provider manage.rb ignores username attribute
- [COOK-1582] - ssh_keys should take an array in addition to a string separated by new lines

## v1.1.4

- [COOK-1396] - removed users get recreated
- [COOK-1433] - resolve foodcritic warnings
- [COOK-1583] - set passwords for users

## v1.1.2

- [COOK-1076] - authorized_keys template not found in another cookbook

## v1.1.0

- [COOK-623] - LWRP conversion
