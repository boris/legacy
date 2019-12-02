# Chef-solo 
This is my chef-solo repo, including cookbooks, roles, data bags and
environments. It uses `berkshelf` to manage cookbooks.

### Berkshelf usage

- Add a cookbook to `Berksfile`:
```
cookbook 'git'
```
- Run `berks vendor cookbooks`
