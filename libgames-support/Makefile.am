NULL =

commondatadir = $(datadir)/gnome-games-common

slotdir = $(pkgdatadir)/pixmaps
slot_DATA = slot.svg

EXTRA_DIST = \
	$(schema_in_files)	\
	$(slot_DATA)		\
	games-marshal.list	\
	$(NULL)

noinst_LTLIBRARIES = libgames-support.la

BUILT_SOURCES = \
	games-marshal.c			\
	games-marshal.h			\
	$(NULL)

libgames_support_la_SOURCES =		\
	$(BUILT_SOURCES)		\
	games-conf.c			\
	games-conf.h			\
	games-debug.c			\
	games-debug.h			\
	games-files.c			\
	games-files.h			\
	games-profile.c			\
	games-profile.h			\
	games-runtime.c			\
	games-runtime.h			\
	games-sound.c			\
	games-sound.h			\
	games-stock.c			\
	games-stock.h			\
	$(NULL)

libgames_support_la_SOURCES +=		\
	games-atk-utils.c		\
	games-atk-utils.h		\
	games-frame.c			\
	games-frame.h			\
	games-help.c			\
	games-help.h			\
	games-score.h			\
	games-score.c			\
	games-scores.c			\
	games-scores.h			\
	games-scores-dialog.c		\
	games-scores-dialog.h		\
	games-scores-dialog-private.h	\
	games-controls.c		\
	games-controls.h		\
	games-setgid-io.c		\
	games-setgid-io.h		\
	games-scores-backend.c		\
	games-scores-backend.h		\
	$(NULL)

if HAVE_CLUTTER
libgames_support_la_SOURCES += \
	games-clutter-embed.c		\
	games-clutter-embed.h		\
	$(NULL)
endif

libgames_support_la_CPPFLAGS = \
	-DPKGDATADIR="\"$(pkgdatadir)\""			\
	-DDATADIR="\"$(datadir)\""				\
	-DCOMMON_DATADIR="\"$(datadir)/gnome-games-common\""	\
	-DSCORESDIR="\"$(scoredir)\""				\
	$(NULL)

libgames_support_la_CFLAGS = 	\
	$(GTK_CFLAGS)		\
	$(AM_CFLAGS)

libgames_support_la_LIBADD = 	\
	$(GTK_LIBS)

if WITH_SMCLIENT
libgames_support_la_SOURCES += \
	eggdesktopfile.c \
	eggdesktopfile.h \
	eggsmclient.c \
	eggsmclient.h \
	eggsmclient-private.h \
	$(NULL)
libgames_support_la_CFLAGS += $(SMCLIENT_CFLAGS)
libgames_support_la_LIBADD += $(SMCLIENT_LIBS)

if WITH_SMCLIENT_XSMP
libgames_support_la_SOURCES += eggsmclient-xsmp.c
libgames_support_la_CPPFLAGS += -DEGG_SM_CLIENT_BACKEND_XSMP
endif
endif

if HAVE_GNOME
libgames_support_la_CFLAGS += $(GNOME_CFLAGS)
libgames_support_la_LIBADD += $(GNOME_LIBS)
endif

if HAVE_CLUTTER
libgames_support_la_CFLAGS += $(CLUTTER_CFLAGS)
libgames_support_la_LIBADD += $(CLUTTER_LIBS)
endif

if HAVE_GSTREAMER
libgames_support_la_CFLAGS += $(GSTREAMER_CFLAGS)
libgames_support_la_LIBADD += $(GSTREAMER_LIBS)
endif

if HAVE_SDL_MIXER
libgames_support_la_CFLAGS += $(SDL_MIXER_CFLAGS)
libgames_support_la_LIBADD += $(SDL_MIXER_LIBS)
endif

install-data-local:
if GCONF_SCHEMAS_INSTALL
	if test -z "$(DESTDIR)" ; then \
		for p in $^ ; do \
			GCONF_CONFIG_SOURCE=$(GCONF_SCHEMA_CONFIG_SOURCE) $(GCONFTOOL) --makefile-install-rule $$p 2>&1 > /dev/null; \
		done \
	fi
endif

stamp_files = \
	stamp-games-marshal.c \
	stamp-games-marshal.h \
	$(NULL)

CLEANFILES = \
	$(BUILT_SOURCES) \
	$(stamp_files) \
	$(NULL)

DISTCLEANFILES = $(schema_DATA)

games-marshal.c: stamp-games-marshal.c
	@true
stamp-games-marshal.c: games-marshal.list Makefile
	$(GLIB_GENMARSHAL) --prefix=games_marshal $< --header --body $(GLIB_GENMARSHAL_INTERNAL) > games-marshal.c \
	&& echo timestamp > $(@F)

games-marshal.h: stamp-games-marshal.h
	@true
stamp-games-marshal.h: games-marshal.list Makefile
	$(GLIB_GENMARSHAL) --prefix=games_marshal $< --header $(GLIB_GENMARSHAL_INTERNAL) > games-marshal.h \
	&& echo timestamp > $(@F)
