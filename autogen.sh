#!/bin/sh
# Run this to generate all the initial makefiles, etc.

which gnome-autogen.sh || {
    echo "You need to install gnome-common from GNOME git (or from"
    echo "your OS vendor's package manager)."
    exit 1
}

REQUIRED_AUTOMAKE_VERSION=1.9
REQUIRED_GNOME_DOC_UTILS_VERSION=0.10.0 
REQUIRED_GETTEXT_VERSION=0.12
REQUIRED_INTLTOOL_VERSION=0.40.4

. gnome-autogen.sh
