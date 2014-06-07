ACLOCAL_AMFLAGS = -I m4

SUBDIRS= \
	po \
	icons \
	libgames-support \
	gnometris

if ENABLE_SOUND
SUBDIRS += sounds
endif

DIST_SUBDIRS = po icons sounds libgames-support gnometris

EXTRA_DIST = \
	autogen.sh \
	COPYING-DOCS

# Ignore score files, these *should* be left behind.
distuninstallcheck_listfiles = find . -type f -print | grep -v '.scores'
