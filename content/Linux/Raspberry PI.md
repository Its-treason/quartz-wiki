### Watchdog setup

The Watchdog will ensure that the Raspberry Pi will restart in case it freezes.

Ensure the watchdog is installed as a Kernel module: `ls -al /dev/watchdog*` should show one or more files.

The watchdog must then be enabled in `systemd`. Edit the `/etc/systemd/system.conf` config file. Under the `[Manager]` section, add the following:

```
RuntimeWatchdogSec=10
ShutdownWatchdogSec=10min
```

Reboot the system to apply all changes. `dmesg` should now log watchdog being started.

```
$ dmesg | grep -i watchdog
[    0.596574] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
[    2.336190] systemd[1]: Using hardware watchdog 'Broadcom BCM2835 Watchdog timer', version 0, device /dev/watchdog
[    2.336229] systemd[1]: Set hardware watchdog to 10s.
```

To test the watchdog, you can start a fork bomb to freeze the system, the watchdog should detect the freeze and automatically reboot. This fork bomb can be executed inside your shell: `:(){ :|:& };:` **This will freeze your system! Make sure nothing important is running in the background. It can take a few minutes before reboot.**

### SSH key authorization

By depositing the public key on the Raspberry Pi, you can connect using SSH without using a password.

Ensure that you already created an SSH key, if not follow these instructions: [Generation a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key). Execute `ssh-copy-id <username>@<host>` this will collect your local SSH key and ask for a password. When the password was correct, the Public key will be copied to `~/.ssh/authorized_keys` and SSH will not ask for a password the next time connecting.