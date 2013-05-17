#!/bin/sh

# Create an alias so I can load my own user default in nodes that set their own
SUD=src/sud.erl
echo "%%% GENERATED MODULE, DON'T EDIT" > $SUD
sed -e 's/module(user_default)/module(sud)/' < src/user_default.erl >> $SUD

# Compile
cd src
erl -make
