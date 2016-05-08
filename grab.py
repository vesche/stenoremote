#!/usr/bin/env python

print "Content-type: text/html\n\n"
print "Grabbing pcap..."

import cgi, os

form = cgi.FieldStorage()
query = form.getvalue('query')
fname = form.getvalue('fname')

os.system("stenoread '{}' -w /tmp/stenoremote/{}".format(query, fname))
