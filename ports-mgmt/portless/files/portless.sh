#! @BASH@ --
# (X)Emacs: -*- mode: Shell-Script; coding: iso8859-1; -*-
# @(#)portless.sh,v 1.11 2006/08/13 10:23:14 martin Exp
# Show "pkg-descr" file of matching port(s).
#
# Copyright (c) 2006 Martin Kammerhofer <mkamm@gmx.net>
# All rights reserved.
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

Script=`basename $0` # name of this script

# set defaults
for opt in d f I i M m p w; do
    eval opt_$opt=""
done
PORTSDIR=${PORTSDIR:-/usr/ports}
PAGER=${PAGER:-less -e}
PKGDESCR="pkg-descr"
filelist=""
rc=0

# print usage message to stderr and exit
usage()
{
    while [ $# != 0 ]; do
	echo >&2 "$Script: $1"
	shift
    done
    echo >&2 "usage: $Script [-dfIiMmpw] [-P pager] 'portglob'..."
    exit 64	# EX_USAGE
}

fatal() { echo >&2 "$Script: $*"; exit 70; }	# EX_SOFTWARE

# Add file $2 corresponding to option $1 to $filelist.
# Do not add any file twice.
addopt()
{
    eval "[ -n \"\$opt_$1\" ] && return; opt_$1='$1' || fatal 'addopt $*'"
    filelist="$filelist $2"
}

# process options
while getopts "D:dfIiMmpP:wx" option
  do
  case "$option" in
      (D) PORTSDIR="$OPTARG";;		# undocumented
      (d) addopt d "$PKGDESCR";;
      (f) opt_f="f";;
      (I) shopt -s nocaseglob ||
      usage "Option -I needs bash!"
      opt_I="I";;
      (i) addopt i "distinfo";;
      (M) addopt M "Makefile";;
      (m) addopt m "pkg-message";;
      (p) addopt p "pkg-plist";;
      (P) PAGER="$OPTARG";;
      (w) opt_w="w";;
      (x) set -x;;			# undocumented
      (*) usage;;
  esac
done
shift $(($OPTIND - 1))
[ -d "$PORTSDIR" ] || fatal "No such directory '$PORTSDIR'"
if [ -n "$opt_w" ]; then
    [ -n "$filelist" ] && usage "option -w not compatible with other options"
    PAGER="/bin/ls -1d"			# just echo directory name(s)
    filelist="."
elif [ -n "$opt_f" -a -n "$opt_I" ]; then
    usage "only one of options -f and -I is useful"
else
    [ -n "$filelist" ] || filelist="$PKGDESCR"
fi

# there must be at least one argument
if [ $# = 0 ]; then
    usage
fi

# View $PORTSDIR$1$2/{$filelist} with $PAGER.
# Always glob $1 but do not glob $2 when option -f was given.
# (Slightly complicated because /bin/sh may not understand
# csh-like {file1,file2} glob patterns.)
page() {
    [ $# = 2 ] || fatal "page $*"
    dirglob=$1
    portglob=$2
    shift 2
    set +f
    for f in $filelist; do
	if [ -n "$opt_f" ]; then
	    set -- "$@" "$PORTSDIR"$dirglob"$portglob/$f"
	else
	    set -- "$@" "$PORTSDIR"$dirglob$portglob/"$f"
	fi
    done
    $PAGER "$@" || { rc=$?; return $rc; }	# remember last error code
}

# main
for p in "$@"; do
    set -f
    set -- $p
    [ $# != 1 ] && usage "portglob '$p' contains whitespace!"
    case "$p" in
	(*/*/*)
	usage "portglob '$p' contains more than one slash!";;

	(*/*)
	page "/" "$p";;

	(*)
	page "/[a-z]*/" "$p";;
    esac
done

exit $rc

#EOF#
