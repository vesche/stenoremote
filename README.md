## Stenoremote

This is a little hack for [Google Stenographer](https://github.com/google/stenographer) to do [currently unsupported](https://github.com/google/stenographer/blob/master/DESIGN.md#serving-data) remote requests. In order for this to work you'll need to open Stenographer to the outside. On the server you're running Stenographer on, modify `/etc/stenographer/config` to use `"Host": "0.0.0.0"`.

Run `./install.sh` to install stenoread with everything needed for it to work. The only thing you will have to do manually is move your `client_cert.pem` and `client_key.pem` to `/etc/stenographer/config` on your local machine. Currently, only got this working on RHEL/CentOS 7. I'm working on an OS X solution.
