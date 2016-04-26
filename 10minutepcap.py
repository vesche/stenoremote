#!/usr/bin/env python

# author: vesche, Austin Jackson
# contact: austinjackson892 [at] gmail [dot] com

from time import sleep
from subprocess import Popen
from SimpleHTTPServer import SimpleHTTPRequestHandler
from SocketServer import TCPServer
from datetime import datetime, timedelta

ten_minutes = 600
Running = True

def start_webserver(port):
    httpd = TCPServer(('', port), SimpleHTTPRequestHandler)
    httpd.serve_forever()

def grab_pcap():
    time_now = datetime.now()
    time_now_minus_ten = time_now - timedelta(minutes=10)
    time_str_now = str(time_now).split()[1][:5].replace(':', '')
    time_str_past = str(time_now_minus_ten).split()[1][:5].replace(':', '')
    file_name = time_str_past + '-' + time_str_now + '.pcap'
    Popen(["stenoread", "after 10m ago", "-w", file_name])
    print "Grabbed", file_name + "!"

if __name__ == "__main__":
    #start_webserver(80)
    while Running:
        grab_pcap()
        sleep(ten_minutes)
