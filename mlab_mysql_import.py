#!/usr/bin/python
from optparse import OptionParser

# Read command line options
parser = OptionParser()
parser.add_option("-f", "--file", dest="filename", help="specifies the mlab csv file to be imported", metavar="FILE")
parser.add_option("-q", "--quiet",
                      action="store_false", dest="verbose", default=False, help="don't print status messages to stdout")

(options, args) = parser.parse_args()


print options, args 
