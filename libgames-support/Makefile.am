NULL =

commondatadir = $(datadir)/gnome-games-common

slotdir = $(pkgdatadir)/pixmaps
slot_DATA = slot.svg

EXTRA_DIST = \
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

stamp_files = \
	stamp-games-marshal.c \
	stamp-games-marshal.h \
	$(NULL)

CLEANFILES = \
	$(BUILT_SOURCES) \
	$(stamp_files) \
	$(NULL)

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
