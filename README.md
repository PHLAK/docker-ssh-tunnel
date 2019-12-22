docker-ssh-tunnel
=================

<p align="center">
    <a href="https://microbadger.com/images/phlak/ssh-tunnel" alt="Microbadger"><img src="https://images.microbadger.com/badges/image/phlak/ssh-tunnel.svg"></a>
    <a href="https://ln.phlak.net/join-slack"><img src="https://img.shields.io/badge/Join_our-Slack-611f69.svg" alt="Join our"></a>
    <a href="https://github.com/users/PHLAK/sponsorship"><img src="https://img.shields.io/badge/Become_a-Sponsor-cc4195.svg" alt="Become a Sponsor"></a>
    <a href="https://patreon.com/PHLAK"><img src="https://img.shields.io/badge/Become_a-Patron-e7513b.svg" alt="Become a Patron"></a>
    <a href="https://paypal.me/ChrisKankiewicz"><img src="https://img.shields.io/badge/Make_a-Donation-006bb6.svg" alt="One-time Donation"></a>
</p>

<p align="center">
    Docker image for <a href="https://www.openssh.com">SSH</a> tunnels.
</p>

---

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

For general help and support join our [Slack Workspace](https://ln.phlak.net/join-slack).

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-ssh-tunnel/issues).

Copyright
---------

This project is licensed under the [MIT License](https://github.com/PHLAK/docker-ssh-tunnel/blob/master/LICENSE).
