# Stenoremote

This is a little hack for [Google Stenographer](https://github.com/google/stenographer) to do [currently unsupported](https://github.com/google/stenographer/blob/master/DESIGN.md#serving-data) remote requests. In order for this to work you'll need to open Stenographer to the outside. On the server you're running Stenographer on, modify `/etc/stenographer/config` to use `"Host": "0.0.0.0"`.

Run `./install_rhel7.sh` to install stenoread with everything needed for it to work. The only thing you will have to do manually is move your `client_cert.pem` and `client_key.pem` to `/etc/stenographer/config`. Here's a one-liner to do that you could do from your host, `scp user@serverip:"/etc/stenographer/certs/client_cert.pem /etc/stenographer/certs/client_key.pem" /etc/stenographer/certs/`.

Once you've run the install script you should now be able to do `stenoread 'host 1.2.3.4' -w out.pcap` or similar to grab pcap from Stenographer from your remote host. Currently, only got this working on RHEL/CentOS 7. I'm working on an OS X solution.

## 10minutepcap

Wrote a little script that will continuously, automatically grab the last ten minutes of packet capture, and serve them out on a webserver. This is a quick solution for sharing out pcap to a team, probably will need some adjustment later. I'd recommend throwing stenoremote into a folder so the pcap collects in it's own area, so `mkdir ~/10minutepcap & mv stenoremote/ ~/10minutepcap`. Shouldn't need to adjust anything, just `chmod +x ~/10minutepcap/stenoremote/10minutepcap.py` and then  `~/10minutepcap/stenoremote/./10minutepcap.py &`. Then from another host on your internal network surf to `http://youripaddress`, and grab some pcap!

**Note:** Gotta work on the webserver bit (probably needs multithreading), for now you can just `cd ~/10minutepcap && python -m SimpleHTTPServer 80 &` and you'll spin up a webserver.

## OS X issue
Update on OS X... Pushed a test install script, you'll need to go in and manually change the curl path at the bottom of Stenocurl to where brew installs curl. The error I get from the stenocurl on OSX:
```
curl: (35) error:14094410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure
```
And the error on the Stenographer side:
```
TLS handshake error from <ip>:<port>: tls: client's certificate's extended key usage doesn't permit it to be used for client authentication
```
Looks like this is a [known issue](https://github.com/golang/go/issues/7423), but very low priority.
