#! /bin/sh
# Copyright 2018 nomennescio
# Released to the public domain

FILE=factor-linux-x86-64-0.98.tar.gz
[ -f $FILE ] || wget -nd http://downloads.factorcode.org/releases/0.98/$FILE
[ -d factor ] || tar -zxf $FILE
