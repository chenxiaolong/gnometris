AC_PREREQ([2.53])
AC_INIT([Gnometris], [2.26.3],
  [https://github.com/chenxiaolong/gnometris/issues],
  [gnometris], [https://github.com/chenxiaolong/gnometris])
AM_INIT_AUTOMAKE([1.9 no-dist-gzip dist-xz foreign])
AM_SILENT_RULES([yes])
AM_MAINTAINER_MODE

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])

# Feature matrix

want_gstreamer=yes

# Locate various programs

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CXX

AC_PROG_LIBTOOL

GNOME_DEBUG_CHECK
GNOME_COMPILE_WARNINGS([maximum])
GNOME_CXX_WARNINGS([yes])

dnl ###########################################################################
dnl Documentation
dnl ###########################################################################

YELP_HELP_INIT

dnl ###########################################################################
dnl Dependencies
dnl ###########################################################################

# Sound

if test "$want_gstreamer" = "yes"; then
  AC_MSG_CHECKING([whether to enable sound support])
  AC_ARG_ENABLE([sound],
    [AS_HELP_STRING([--enable-sound],[Enable sound with GStreamer or SDL_Mixer.])],
    [],[enable_sound=yes])
  AC_MSG_RESULT([$enable_sound])
else
  enable_sound=no
fi

# Check which sound library to use

AC_MSG_CHECKING([for which sound library to use])
AC_ARG_WITH([sound],
  [AS_HELP_STRING([--with-sound=gstreamer|sdl_mixer (default: sdl_mixer)])],
  [with_sound="$withval"],
  [with_sound=sdl_mixer])
AC_MSG_RESULT([$with_sound])

# Gameplay documentation

AC_MSG_CHECKING([whether to build gameplay documentation])
AC_ARG_ENABLE([gameplaydoc],
  [AS_HELP_STRING([--enable-gameplaydoc],[whether to build gameplay documentation (default: enabled)])],
  [],[enable_gameplaydoc=yes])
AC_MSG_RESULT([$enable_gameplaydoc])


dnl ###########################################################################
dnl Checks for libraries
dnl ###########################################################################

GTK_REQUIRED=2.14.0

CAIRO_REQUIRED=1.0
GSTREAMER_REQUIRED=0.10.11

# Check for common modules

PKG_CHECK_MODULES([GTK],[gtk+-2.0 >= $GTK_REQUIRED])
AC_SUBST([GTK_CFLAGS])
AC_SUBST([GTK_LIBS])

# Gameplay documentation

if test "$enable_gameplaydoc" = "yes"; then
  AC_DEFINE([WITH_GAMEPLAYDOC],[1],[Define if gameplay docs should be built])
fi

AM_CONDITIONAL([WITH_GAMEPLAYDOC],[test "$enable_gameplaydoc" = "yes"])

# Sound support: GStreamer and SDL_mixer
have_gstreamer=no
if test "$enable_sound" = "yes" -a "$with_sound" = "sdl_mixer"; then
  # Check for SDL_Mixer sound support, sets SDL_MIXER_CFLAGS, SDL_MIXER_LIBS, AUDIO_SDL
  GAMES_CHECK_SOUND()

  if test "$SDL_mixer" = "no"; then
    with_sound=gstreamer
    echo "SDL_Mixer not found, fallback to GStreamer."
  fi

fi

if test "$enable_sound" = "yes" -a "$with_sound" = "gstreamer"; then
  # Check for GStreamer 
  PKG_CHECK_MODULES([GSTREAMER],
    [gstreamer-0.10 >= $GSTREAMER_REQUIRED],
    [have_gstreamer=yes],[have_gstreamer=no])
    # SDL_mixer is default, while GStreamer is a required dependency if SDL_mixer isn't found.
    if test "$enable_sound" = "yes" -a "$have_gstreamer" = "no" -a "$SDL_mixer" = "no"; then
      AC_MSG_ERROR([Sound enabled but GStreamer or SDL_Mixer not found])
    fi
fi

if test "$have_gstreamer" = "yes"; then
  AC_SUBST([GSTREAMER_CFLAGS])
  AC_SUBST([GSTREAMER_LIBS])

  AC_DEFINE([HAVE_GSTREAMER],[1],[Define if GStreamer is available])
fi

if test "x$SDL_mixer" = "xyes"; then
  AC_SUBST(SDL_MIXER_CFLAGS)
  AC_SUBST(SDL_MIXER_LIBS)

  AC_DEFINE([HAVE_SDL_MIXER],[1],[Define if SDL_Mixer is available])
fi

AM_CONDITIONAL([HAVE_GSTREAMER],[test "$have_gstreamer" = "yes"])
AM_CONDITIONAL([HAVE_SDL_MIXER],[test "x$SDL_mixer" = "xyes"])
AM_CONDITIONAL([ENABLE_SOUND],[test "$enable_sound" = "yes"])

dnl ###########################################################################
dnl glib-genmarshal
dnl ###########################################################################

AC_PATH_PROG([GLIB_GENMARSHAL],[glib-genmarshal])

GLIB_GENMARSHAL_INTERNAL="--internal"
AC_SUBST([GLIB_GENMARSHAL_INTERNAL])

dnl ###########################################################################
dnl i18n
dnl ###########################################################################

GETTEXT_PACKAGE=gnometris
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE", [Name of default gettext domain])
AM_GLIB_GNU_GETTEXT

IT_PROG_INTLTOOL([0.35.0])

dnl ###########################################################################
dnl Check for header files and library functions
dnl ###########################################################################

AC_CHECK_HEADERS(fcntl.h)
AC_CHECK_HEADERS(time.h)
AC_CHECK_HEADERS(unistd.h)
AC_CHECK_FUNCS(strchr fork getpwuid close)
AC_HEADER_STDC

dnl ###########################################################################
dnl setgid checks
dnl ###########################################################################

AC_ARG_ENABLE([setgid],
  [AS_HELP_STRING([--disable-setgid],
    [Disable the use of setgid binaries])],
  [case "${enableval}" in
    yes) setgid=true ;;
    no)  setgid=false ;;
    *) AC_MSG_ERROR([bad value ${enableval} for --disable-setgid]) ;;
   esac],[setgid=true])
AC_SUBST(setgid)

AC_ARG_WITH(scores-group,
  AC_HELP_STRING([--with-scores-group=group],
    [Group for the high score tables and binaries]),
  scores_group="$withval",scores_group="games")
AC_SUBST(scores_group)
AC_ARG_WITH(scores-user,
  AC_HELP_STRING([--with-scores-user=user],
    [User for the high score tables]),
  scores_user="$withval",scores_user="games")
AC_SUBST(scores_user)

scoredir='${localstatedir}/games'
AC_SUBST(scoredir)

dnl ###########################################################################
dnl Flags
dnl ###########################################################################

AC_SUBST([AM_CPPFLAGS])
AC_SUBST([AM_CFLAGS])
AC_SUBST([AM_CXXFLAGS])
AC_SUBST([AM_LDFLAGS])

dnl ###########################################################################
dnl Files to generate
dnl ###########################################################################

AC_CONFIG_FILES([
Makefile
po/Makefile.in
icons/Makefile
sounds/Makefile
libgames-support/Makefile
gnometris/Makefile
gnometris/pix/Makefile
gnometris/help/Makefile
gnometris/gnometris.desktop.in
])
AC_OUTPUT

echo "
Configuration:

    Source code location:  ${srcdir}
    Compiler:              ${CC}

    Sound support:         ${with_sound}
    Enable gameplay docs:  ${enable_gameplaydoc}
    Use setgid binaries:   ${setgid}
    Scores user:           ${scores_user}
    Scores & setgid group: ${scores_group}
"

if grep "$scores_group:" /etc/group > /dev/null; then
:;
else
echo
echo "Warning: The $scores_group group does not exist. Installation will"
echo "         succeed, but high score logging will not work. To specify a"
echo "         different group use the --with-scores-group option."
echo
fi

