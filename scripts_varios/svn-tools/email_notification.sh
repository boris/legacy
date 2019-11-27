#!/bin/bash

REPOS="$1"
REV="$2"

/usr/bin/svnnotify \
   --repos-path   "$REPOS" \
   --revision     "$REV" \
   --subject-prefix [svn-commit] \
   --subject-cx   \
   --with-diff \
   --handler      HTML::ColorDiff \
   --to           somebody@example.com \
   --from         svn@example.com

