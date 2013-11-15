#!/usr/bin/env python3
"""This script creates random groups from a roster of students. This is useful
for creating groups for a group project. You must give the script two
parameters on the command line.

First, you must specify an integer number that corresponds to the size of the
desired groups. For example, giving the script a 3 would split the roster into
groups of no more than three members.

Second, you must specify the roster by giving the path to a CSV file. The format
of the CSV file will be automatically determined. The file should have no
header. Also, the rows should be last name followed by first name. For example:

    Doe,John
    Smith,Jane

The roster will be shuffled prior to being assigned to a group. The resulting
groups will be printed to stdout. I always put the groups into an HTML list, so
the output is uses <li>-tags.
"""
import csv, os, random, sys

def chunks(l, n):
    """ Yields successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i+n]

#Generic usage message
help = 'usage: {}  GROUPSIZE CSV-ROSTER-FILE'.format(sys.argv[0])

#Make sure the parameters were specified, 
#and that the roster is actually a file
if len(sys.argv) < 2:
    sys.exit(help)
elif len(sys.argv) < 3:
    sys.exit('You must specify the roster file.\n'+help)
elif not os.path.isfile(sys.argv[2]):
    sys.exit('You must specify a CSV file containing the roster.\n'+help)

#Convert the group size to an integer    
try:
    group_size = int(sys.argv[1])
except:
    sys.exit('Group size must be an integer.\n'+help)
    

#This will hold the list of names
names = []

#Open the roster as a csv file.
with open(sys.argv[2], 'r') as file:
    #Deduce the csv format
    dialect = csv.Sniffer().sniff(file.read(1024))
    
    #Reset to the start of the file
    file.seek(0)
    
    #The roster has last then first, reverse this
    for name in csv.reader(file, dialect=dialect):
        names.append("{} {}".format(name[1], name[0]))
        
#Randomize the roster
random.shuffle(names)

#Print out the list of groups
for n in chunks(names, group_size):
    print('<li>{}</li>'.format(', '.join(n)))

