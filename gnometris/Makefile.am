if WITH_GAMEPLAYDOC
SUBDIRS = help
endif

bin_PROGRAMS=gnometris

gnometris_SOURCES = \
	main.cpp \
	blocks.cpp \
	blocks.h \
	highscores.cpp \
	highscores.h \
	scoreframe.cpp \
	scoreframe.h \
	tetris.cpp \
	tetris.h

gnometris_SOURCES += \
	field-noclutter.cpp \
	field-noclutter.h \
	preview-noclutter.cpp \
	preview-noclutter.h \
	blockops-noclutter.cpp \
	blockops-noclutter.h \
	renderer-noclutter.cpp \
	renderer-noclutter.h

gnometris_CPPFLAGS = \
	-I$(top_srcdir) \
	$(AM_CPPFLAGS)

gnometris_CXXFLAGS = \
	$(GTK_CFLAGS) \
	$(AM_CXXFLAGS)

gnometris_LDADD = \
	$(top_builddir)/libgames-support/libgames-support.la \
	$(GTK_LIBS) \
	$(INTLLIBS)

if OS_WIN32
gnometris_LDFLAGS = -mwindows
endif

pixmapdir = $(pkgdatadir)/gnometris/pixmaps
pixmap_DATA = gnometris.svg

Gamesdir = $(datadir)/applications
Games_in_files = gnometris.desktop.in.in
Games_DATA = $(Games_in_files:.desktop.in.in=.desktop)
@INTLTOOL_DESKTOP_RULE@

EXTRA_DIST = AUTHORS \
	$(pixmap_DATA)

install-data-local:
	-$(mkinstalldirs) $(DESTDIR)$(scoredir)
	-touch $(DESTDIR)$(scoredir)/gnometris.scores
	-chown $(scores_user):$(scores_group) $(DESTDIR)$(scoredir)/gnometris.scores
	-chmod 664 $(DESTDIR)$(scoredir)/gnometris.scores
	-if test "x$(setgid)" = "xtrue"; then chgrp $(scores_group) $(DESTDIR)$(bindir)/gnometris && chmod 2555 $(DESTDIR)$(bindir)/gnometris ; fi

DISTCLEANFILES = $(Games_DATA)
