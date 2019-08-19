#!/usr/bin/env python
# Copyright 2019 nomennescio

import glob, os, re, sys

passed, failed, verbose, quiet = 0, 0, 0, 0

def run (factorfile):
    #return os.popen ("bash -c 'FACTOR_ROOTS=$(cd `pwd`/..;pwd -P) factor " + factorfile + "'").readlines ()
    return os.popen ("bash -c 'FACTOR_ROOTS=`pwd`/.. factor " + factorfile + "'").readlines ()

def timeless (lines):
    return [re.sub(r'\d+', '0', l) if "<COMPLETEDIN::>" in l else l for l in lines]

def test (filename):
    global passed, failed
    actual = run (filename)
    expected = open (os.path.splitext (filename)[0] + ".expected").readlines ()
    if (timeless (actual) == timeless (expected)):
        if verbose:
            print ("Pass: " + filename)
        passed += 1
    else:
        if (not quiet):
            print ("Fail: {0}\n==8<--".format (filename, ""))
        sys.stdout.write (''.join (actual))
        if (not quiet):
            print ("\n==8<--")
        failed += 1

# change to script directory
prevdir = os.getcwd ()
os.chdir (os.path.dirname (os.path.abspath (__file__)))

# parse flags
args=sys.argv[1:]
if (len (args) and args[0]=="-v"):
    verbose=1
    args.pop (0)
if (len (args) and args[0]=="-q"):
    quiet=1
    args.pop (0)

# test named files, or all Factor files in directory
files = args if len (args) else glob.glob ("*.factor")
for f in files:
    test (f)

# show totals
if (verbose):
    if (failed==0):
        print ("All {0} tests were successful".format (passed))
    else:
        print ("{0} out of {1} tests failed".format (failed, failed+passed))

# restore directory
os.chdir (prevdir)

if failed > 0 or passed == 0:
    sys.exit(1)
