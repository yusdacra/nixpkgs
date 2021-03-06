{ stdenv, fetchurl, lib, pkg-config, alsa-lib, libogg, libpulseaudio ? null, libjack2 ? null }:

stdenv.mkDerivation rec {
  pname = "alsa-plugins";
  version = "1.2.2";

  src = fetchurl {
    url = "mirror://alsa/plugins/${pname}-${version}.tar.bz2";
    sha256 = "0z9k3ssbfk2ky2w13avgyf202j1drsz9sv3834bp33cj1i2hc3qw";
  };

  nativeBuildInputs = [ pkg-config ];

  # ToDo: a52, etc.?
  buildInputs =
    [ alsa-lib libogg ]
    ++ lib.optional (libpulseaudio != null) libpulseaudio
    ++ lib.optional (libjack2 != null) libjack2;

  meta = with lib; {
    description = "Various plugins for ALSA";
    homepage = "http://alsa-project.org/";
    license = licenses.lgpl21;
    maintainers = [ maintainers.marcweber ];
    platforms = platforms.linux;
  };
}
