Ruby scripts to perform some common tasks on AWS

## Profiles
In case you manage more than one aws profile (on `~/.aws/credentials`), modify
the `profile.rb`, in particular line 3: `(profile_name: 'my-profile')`

## Usage
```bash
region='<region>' ruby <script>

```

Example:
```
region='ap-southeast-1' ruby sqs-show_queues.rb
```
