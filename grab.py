#!/usr/bin/env python

print "Content-type: text/html\n\n"
print "Grabbing your packets... Wait for this page to finish loading!<br>"
print "When your packets finish downloading they'll be <a href=\"../pcap\">here</a>."

import cgi, subprocess

form = cgi.FieldStorage()
query = str(form.getvalue('query'))
fname = str(form.getvalue('fname'))

subprocess.Popen(["/usr/bin/stenoread", query, "-w", '/var/www/html/pcap/'+fname])
