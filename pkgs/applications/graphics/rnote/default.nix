{ lib
, stdenv
, fetchFromGitHub
, alsa-lib
, appstream-glib
, desktop-file-utils
, gio-sharp
, glib
, gstreamer
, gtk4
, libadwaita
, libxml2
, meson
, ninja
, pkg-config
, poppler
, python3
, rustPlatform
, shared-mime-info
, wrapGAppsHook4
}:

stdenv.mkDerivation rec {
  pname = "rnote";
  version = "0.5.0-hotfix-2";

  src = fetchFromGitHub {
    owner = "flxzt";
    repo = "rnote";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-8sv7GQopUbKv8JS1/UXRFeK++UZKk3CJBOzUMx9vZDU=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-N0qsph68FAkwOpyr9QUw0bDQKn7t22Hbz9BYYOs4pCM=";
  };

  nativeBuildInputs = [
    appstream-glib # For appstream-util
    desktop-file-utils # For update-desktop-database
    meson
    ninja
    pkg-config
    python3 # For the postinstall script
    rustPlatform.cargoSetupHook
    rustPlatform.rust.cargo
    rustPlatform.rust.rustc
    shared-mime-info # For update-mime-database
    wrapGAppsHook4
  ];

  buildInputs = [
    alsa-lib
    gio-sharp
    glib
    gstreamer
    gtk4
    libadwaita
    libxml2
    poppler
  ];

  postPatch = ''
    pushd build-aux
    chmod +x meson_post_install.py
    patchShebangs meson_post_install.py
    substituteInPlace meson_post_install.py --replace "gtk-update-icon-cache" "gtk4-update-icon-cache"
    popd
  '';

  meta = with lib; {
    homepage = "https://github.com/flxzt/rnote";
    description = "Simple drawing application to create handwritten notes";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ dotlambda yrd ];
    platforms = platforms.linux;
  };
}
