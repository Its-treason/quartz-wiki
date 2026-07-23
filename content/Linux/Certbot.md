## Install

### Snap Store

This is the install method advised by LetsEncrypt.

Make sure the certbot is not installed using Apt: `sudo apt remove certbot`.

Ensure the latest Snap version is installed: `sudo snap install core; sudo snap refresh core`.

Install the Certbot, make sure to use the `--classic` flag: `sudo snap install --classic certbot`.

Link the certbot binary to a path thats in the $PATH variabel: `sudo ln -s /snap/bin/certbot /usr/bin/certbot`. Depending on your environment this might not be necessary.

### Apt & Apk

The certbot is also available in the officiall Debian, Ubuntu & Alpine repositories, but the version might be outdated.

- Ubuntu & Debian: `apt install certbot`
- Alpine: `apk install certbot`

## Retrieving a Certificate

To create an Certificate for `example.com`

`sudo certbot certonly --nginx --agree-tos -n -d example.com`

- `--nginx`: Use Local installed nginx for the Authentication-Challange, see Challanges for other ways to authenticate
- `--agree-tos`: Agree to the Terms of Service, the Command will not work without this option
- `-n`: Non-Interactive, do not prompt for anything
- `-d <DOMAIN>`: Domain to create the Certificate for

The Certificate will be saved under:

- `/etc/letsencrypt/live/<DOMAIN>/fullchain.pem` (Certificate)
- `/etc/letsencrypt/live/<DOMAIN>/privkey.pem`: (Private key)

## Renewing Certificates

To renew all Certificates use:

`sudo certbot renew --nginx --agree-tos -n`

- `--nginx`: Use a locally installed nginx for the authentication challange. See [Challenges](https://wiki.its-treason.com/wiki/Certbot#Challenges) for other ways to authenticate
- `--agree-tos`: Agree to the Terms of Service, the Command will not work without this option
- `-n`: Non-Interactive, do not prompt for anything
- `-d <DOMAIN>`: Optional, Domain to renew the Certificate for

Certificates will be updated if it expires in less than 30 days.

`--reuse-key` can be used to keep using the same public key in case some apps verify the public key.

## Challenges

To validate that you own a Domain you must complete a challange using one of the following method:

### Nginx

If a Nginx is running localy and serving for your domain you can simply use the `--nginx` option and certbot will use Nginx for the Challange and should complete it without stopping the Nginx.

### Apache

If a Apache is running localy and serving for your domain you can simply use the `--apache` option and certbot will use Apache for the Challange and should complete it without stopping the Apache server.

### Standalone

Certbot will start a Webserver on Port 80 and will try to serve a file containg a verification code. If the Certbot can find that file, the challange will be completed.

### Webroot

Using the `--webroot <Path>` the Certbot will put files under the given directory und the given directory and try to access them.