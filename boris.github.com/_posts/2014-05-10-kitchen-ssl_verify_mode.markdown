---
layout: post
title: 'KitchenCI: ssl_verify_mode'
date: 2014-05-10 00:00:00.000000000 -04:00
---
Hoy mientras preparaba un cookbook, obviamente utilizando [Kitchen CI](http://kitchen.ci) me encontré con el siguiente mensaje de **warning**:

```bash
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
SSL validation of HTTPS requests is disabled. HTTPS connections are still
encrypted, but chef is not able to detect forged replies or man in the middle
attacks.

To fix this issue add an entry like this to your configuration file:

   ```
# Verify all HTTPS connections (recommended)
   ssl_verify_mode :verify_peer

# OR, Verify only connections to chef-server
   verify_api_cert true
   ```

   To check your SSL configuration, or troubleshoot errors, you can use the
   `knife ssl check` command like so:

   ```
   knife ssl check -c /tmp/kitchen/solo.rb
   ```

   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

   Starting Chef Client, version 11.12.4
   [2014-05-11T01:01:44+00:00] INFO: *** Chef 11.12.4 ***
```

## Solución

Es bastante simple. Tal como nos indica el mensaje de error, debemos agregar la linea `ssl_virify_mode :verify_peer` a nuestro archivo `.kitchen.yml`, de la siguiente forma:

```ruby
provisioner:
  name: chef_solo
  solo_rb:
      ssl_verify_mode: verify_peer
```

Ojo con la identación, que en YML es muy importante... 
