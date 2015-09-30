#! /bin/bash

cmus-remote -Q | grep -q 'status playing' && cmus-remote -s || cmus-remote -p