NULL =

icons_16 = \
	16x16/gnome-gnometris.png \
	$(NULL)

icons_22 = \
	22x22/gnome-gnometris.png \
	$(NULL)

icons_24 = \
	24x24/gnome-gnometris.png \
	$(NULL)

icons_32 = \
	32x32/gnome-gnometris.png \
	$(NULL)

icons_48 = \
	48x48/gnome-gnometris.png \
	$(NULL)

icons_svg = \
	scalable/gnome-gnometris.svg \
	$(NULL)

icon16dir = $(datadir)/icons/hicolor/16x16/apps
icon22dir = $(datadir)/icons/hicolor/22x22/apps
icon24dir = $(datadir)/icons/hicolor/24x24/apps
icon32dir = $(datadir)/icons/hicolor/32x32/apps
icon48dir = $(datadir)/icons/hicolor/48x48/apps
iconscalabledir = $(datadir)/icons/hicolor/scalable/apps

icon16_DATA = $(icons_16)
icon22_DATA = $(icons_22)
icon24_DATA = $(icons_24)
icon32_DATA = $(icons_32)
icon48_DATA = $(icons_48)
iconscalable_DATA = $(icons_svg)

EXTRA_DIST = \
	$(icons_16)	\
	$(icons_22)	\
	$(icons_24)	\
	$(icons_26)	\
	$(icons_32)	\
	$(icons_34)	\
	$(icons_40)	\
	$(icons_48)	\
	$(icons_50)	\
	$(icons_64_54)	\
	$(icons_svg)	\
	$(NULL)

gtk_update_icon_cache = gtk-update-icon-cache -f -t $(datadir)/icons/hicolor

install-data-hook: update-icon-cache
uninstall-hook: update-icon-cache
update-icon-cache:
	@-if test -z "$(DESTDIR)"; then \
		echo "Updating Gtk icon cache."; \
		$(gtk_update_icon_cache); \
	else \
		echo "*** Icon cache not updated.  After (un)install, run this:"; \
		echo "***   $(gtk_update_icon_cache)"; \
	fi
