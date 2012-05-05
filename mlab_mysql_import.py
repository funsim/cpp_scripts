#!/usr/bin/python
import sys
import re
from optparse import OptionParser
from datetime import datetime
import dateutil.parser as dparser
import MySQLdb

# PLEASE UPDATE THESE SETTINGS
db_host = "localhost" # your host, usually localhost
db_user = "root" # your username
db_passwd = "rootpassword" # your password
db_name = "cpp" # name of the database
db_table = "mlab" # name of the table

# Read command line options
def usage():
  print "Usage: mlab_mysql_import.py mlab_file.csv"
  print "Recursive import can be realised by running:"
  print "find . -iname '*.tgz.csv' -exec ./mlab_mysql_import.py {} \;"
  sys.exit(1)

parser = OptionParser()
parser.add_option("-q", "--quiet", action="store_false", dest="verbose", default=False, help="don't print status messages to stdout")
(options, args) = parser.parse_args()
if len(args) == 0:
  usage()

filename = args[0]
try:
     f = open(filename, 'r')
except IOError as e:
     print 'Could not open file ', filename

def extract_destination(filename):
  ''' This routine extracts the destination server of the mlab file. 
      It assumes that the filename has the form like 20100210T000000Z-mlab3-dfw01-ndt-0000.tgz.csv '''
  # Split the filename and perform some tests if it conforms to our standard
  f_split = filename.split('-')
  if len(f_split) < 3:
    print "The specified filename (", filename, ") should contain at least two '-' characters that delimit the data, destination and the suffix."
    sys.exit(1)
  if '.tgz.csv' not in f_split[-1]:
    print "The specified filename (", filename, ") should end with '.tgz.csv'."

  return '.'.join(filename.split('-')[1:-1])

def extract_datetime(string):
  ''' Returns the datetime contained in string '''
  # Extract the date
  date_match = re.search(r'\d{4}/\d{2}/\d{2}', string)
  if not date_match:
    print 'Error im import: line "', string, '" does not contain a valid date.'
    sys.exit(1)
  # Extract the time
  time_match = re.search(r'\d{2}:\d{2}:\d{2}', string)
  if not time_match:
    print 'Error im import: line "', string, '" does not contain a valid time.'
    sys.exit(1)

  try:
    return dparser.parse(date_match.group(0) + ' ' + time_match.group(0), fuzzy=True) 
  except ValueError:
    raise ValueError, 'Error im import: line "' + string + '" does not contain a valid date and time.'

def extract_ip(string):
  ''' Returns the first valid ip address contained in string '''
  # Extract the date
  match = re.search(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}', string)
  if not match:
    print 'Error im import: line "', string, '" does not contain a valid ip address.'
    sys.exit(1)
  return match.group(0)

# Connect to the mysql database
db = MySQLdb.connect(host = db_host, 
                     user = db_user, 
                     passwd = db_passwd, 
                     db = db_name) 
cur = db.cursor() 

# Read the data line by line and import it
destination = extract_destination(filename)
print 'Found destination: ', destination
for line in f:
  line = line.strip()
  source_ip = extract_ip(line)
  test_datetime = extract_datetime(line)
  print 'Found test performed on the', test_datetime, 'from ' + destination + ' -> ' + source_ip + '.' 
  columns = 'date, destination, source'
  values = '"' + '", "'.join([test_datetime.isoformat(), destination, source_ip]) + '"'
  cur.execute("INSERT INTO  " + db_table + " (" + columns + ") VALUES(" + values + ") ") 


