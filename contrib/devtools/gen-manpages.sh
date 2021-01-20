#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CATRAD=${CATRAD:-$BINDIR/catrad}
CATRACLI=${CATRACLI:-$BINDIR/catra-cli}
CATRATX=${CATRATX:-$BINDIR/catra-tx}
CATRAQT=${CATRAQT:-$BINDIR/qt/catra-qt}

[ ! -x $CATRAD ] && echo "$CATRAD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
CTAVER=($($CATRACLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for catrad if --version-string is not set,
# but has different outcomes for catra-qt and catra-cli.
echo "[COPYRIGHT]" > footer.h2m
$CATRAD --version | sed -n '1!p' >> footer.h2m

for cmd in $CATRAD $CATRACLI $CATRATX $CATRAQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CTAVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CTAVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
