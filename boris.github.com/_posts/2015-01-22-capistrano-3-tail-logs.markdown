---
layout: post
title: Tailing logs with Capistrano 3
date: 2015-01-22 00:00:00.000000000 -03:00
---
_**Discalimer**: I'm writing  in english as some people told me I've to practice_

One of the most popular deployment tools nowadays among DevOps community is Capistrano. It works great to deploy NodeJS (?) and Ruby on Rails applications but it is also a good DevOps tool. As it is written in Ruby, adding tasks, such upload files to all of our servers, it is quite easy.

On my `devops` branch, I have a lot of devops-custom-made code that helps me to perform some tasks, and one of those tasks is tailing logs. This is the code I wrote today to tail logs:

```
namespace :tail do
  desc "Tail Logs - cap <stage> tail:some_role log_file=<name>"
  task :some_name do
    on roles(:some_role) do
      execute_interactively "tail -n 10 -f #{shared_path}/log/#{ENV['log_file']}.log"
    end
  end
end
```

So now, if I want to tail for example my `production.log` I've to run `bundle exec cap production tail:some_role log_file=production`.

## execute_interactively

Few lines above the code for tailing logs, I've a helper called `execute_interactively` which basically open an SSH connection to the server:

```ruby
def execute_interactively(cmd)
  user = fetch(:user)
  info "Connection to #{host} as #{user}"
  exec "ssh -l #{user} #{host} -t 'cd #{deploy_to}/current && #{cmd}'"
end
```

