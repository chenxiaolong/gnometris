#!/bin/bash

# This is meant for use on Arch Linux. Make sure the following packages from
# the AUR are installed:
# - mingw-w64-gtk2
# - mingw-w64-sdl_mixer

set -ex

# Change to x86_64-w64-mingw32 for a 64-bit build
_host=i686-w64-mingw32
_build=x86_64-unknown-linux-gnu
_prefix=/usr/${_host}
_bindir=${_prefix}/bin

NOCONFIGURE=1 ./autogen.sh

./configure \
  --prefix="${_prefix}" \
  --build=${_build} \
  --host=${_host} \
  --disable-setgid \
  --disable-gameplaydoc

make

rm -rf TEMP
make install DESTDIR="$(pwd)/TEMP"

tempdir=$(mktemp -d)
mkdir "${tempdir}/gnometris/"
mv ./TEMP/"${_prefix}"/* "${tempdir}"/gnometris/
rm -r TEMP
rm -r "${tempdir}"/gnometris/share/applications/

pushd "${tempdir}/gnometris/bin/"
cp ${_bindir}/libatk-1.0-0.dll .
cp ${_bindir}/libbz2-1.dll .
cp ${_bindir}/libcairo-2.dll .
cp ${_bindir}/libexpat-1.dll .
cp ${_bindir}/libffi-6.dll .
cp ${_bindir}/libfontconfig-1.dll .
cp ${_bindir}/libfreetype-6.dll .
cp ${_bindir}/libgcc_s_sjlj-1.dll .
cp ${_bindir}/libgdk_pixbuf-2.0-0.dll .
cp ${_bindir}/libgdk-win32-2.0-0.dll .
cp ${_bindir}/libgio-2.0-0.dll .
cp ${_bindir}/libglib-2.0-0.dll .
cp ${_bindir}/libgmodule-2.0-0.dll .
cp ${_bindir}/libgobject-2.0-0.dll .
cp ${_bindir}/libgtk-win32-2.0-0.dll .
cp ${_bindir}/libharfbuzz-0.dll .
cp ${_bindir}/libiconv-2.dll .
cp ${_bindir}/libintl-8.dll .
cp ${_bindir}/libpango-1.0-0.dll .
cp ${_bindir}/libpangocairo-1.0-0.dll .
cp ${_bindir}/libpangoft2-1.0-0.dll .
cp ${_bindir}/libpangowin32-1.0-0.dll .
cp ${_bindir}/libpixman-1-0.dll .
cp ${_bindir}/libpng16-16.dll .
cp ${_bindir}/libstdc++-6.dll .
cp ${_bindir}/libwinpthread-1.dll .
cp ${_bindir}/SDL.dll .
cp ${_bindir}/SDL_mixer.dll .
cp ${_bindir}/zlib1.dll .
popd

pushd "${tempdir}/gnometris/share/icons/hicolor/"
cp /usr/share/icons/hicolor/index.theme .
gtk-update-icon-cache .
popd

sizes=($(find icons -type d -name '*x*' | sort -r | xargs basename -a | xargs))
icons=()

for size in "${sizes[@]}"; do
  convert -resize ${size} icons/${size}/gnome-gnometris.png \
    "${tempdir}/output-${size}.ico"
  icons+=("${tempdir}/output-${size}.ico")
done

# Preserve descending order
convert "${icons[@]}" "${tempdir}/combined.ico"
rm "${icons[@]}"

cat > "${tempdir}/res.rc" << EOF
1 ICON "${tempdir}/combined.ico"
EOF

${_host}-windres "${tempdir}"/res.{rc,o}

${_host}-g++ \
  -static \
  -Wl,-subsystem,windows \
  win32-launcher.cpp \
  "${tempdir}/res.o" \
  -lshlwapi \
  -DLANG=\"zh_CN.UTF-8\" \
  -o "${tempdir}/gnometris/Gnome 方块.exe"

rm "${tempdir}/res.rc"
rm "${tempdir}/res.o"
rm "${tempdir}/combined.ico"

${_host}-strip "${tempdir}/gnometris/Gnome 方块.exe"
${_host}-strip "${tempdir}"/gnometris/bin/*
if which upx >/dev/null; then
  upx -9 "${tempdir}/gnometris/Gnome 方块.exe"
  upx -9 "${tempdir}"/gnometris/bin/*
fi

pushd "${tempdir}"
zip -r gnometris.zip gnometris/
popd

mv "${tempdir}/gnometris.zip" .
rm -r "${tempdir}"
