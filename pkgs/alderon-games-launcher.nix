{ pkgs }:
let
  pname = "alderon-games-launcher";
  version = "1.3.57";
  src = pkgs.fetchurl {
    url = "https://launcher-cdn.alderongames.com/AlderonGamesLauncher-${version}.AppImage";
    sha256 = "sha256-5XlpXdfE6WLFcOZfFBqhrtBGnTVssPuzJo0hkjJJ/Wk=";
  };
in
pkgs.stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = [ pkgs.makeWrapper pkgs.squashfsTools ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/${pname} \
      --add-flags "${src}"
    APPIMAGE_CONTENTS=${pkgs.appimageTools.extract { inherit pname version src; }}
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp -L "$APPIMAGE_CONTENTS/usr/share/icons/hicolor/256x256/apps/alderon-games-launcher.png" \
          "$out/share/icons/hicolor/256x256/apps/${pname}.png"
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Alderon Games Launcher
Exec=$out/bin/${pname}
Icon=${pname}
StartupWMClass=alderon-games-launcher
Categories=Game;
Terminal=false
EOF
  '';
}
