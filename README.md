docker-ssh-tunnel
=================

Docker image for SSH tunnels.

[![](https://images.microbadger.com/badges/image/phlak/ssh-tunnel.svg)](http://microbadger.com/#/images/phlak/ssh-tunnel "Get your own image badge on microbadger.com")

#### Like this project?

[![Join the community on Spectrum](https://img.shields.io/badge/Join_the_community-PHLAKNET-7a15fe.svg)](https://spectrum.chat/phlaknet)
[![Become a Patron](https://img.shields.io/badge/Become_a-Patron-f96854.svg)](https://patreon.com/PHLAK)
[![One-time Donation](https://img.shields.io/badge/Make_a-Donation-006bb6.svg)](https://paypal.me/ChrisKankiewicz)

Running the Container
---------------------

In order to persist configuration data when upgrading your container you should create some
named data volumes. This is not required but is _highly_ recommended.

    docker volume create --name ssh-tunnel-config
    docker volume create --name ssh-tunnel-data

Next, before running the container, we must generate the server's host key files.

    docker run --rm -v ssh-tunnel-config:/etc/ssh phlak/ssh-tunnel ssh-keygen -A

After the data volume has been created run the daemon container with the named data volume:

    docker run -d -v ssh-tunnel-config:/etc/ssh -v ssh-tunnel-data:/.ssh -p 22:22 --name ssh-tunnel phlak/ssh-tunnel

Lastly, in order to authenticate to the SSH server your SSH public key must be added to the
server's `authorized_keys` file.

    docker exec -it ssh-tunnel authorize-key

#### Optional run arguments

`-e TZ=America/Phoenix` - Set the timezone for your server. You can find your timezone in this
                          [list of timezones](https://goo.gl/uy1J6q). Use the (case sensitive)
                          value from the `TZ` column. If left unset, timezone will be UTC.

`--restart unless-stopped` - Always restart the container regardless of the exit status, but do not
                             start it on daemon startup if the container has been put to a stopped
                             state before. See the Docker [restart policies](https://goo.gl/Y0dlDH)
                             for additional details.

Troubleshooting
---------------

For general help and support join our [Spectrum community](https://spectrum.chat/phlaknet).

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-ssh-tunnel/issues).

Copyright
---------

This project is licensed under the [MIT License](https://github.com/PHLAK/docker-ssh-tunnel/blob/master/LICENSE).
