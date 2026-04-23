{ pkgs }:
let
  pname = "helium-browser";
  version = "0.11.2.1";
  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    sha256 = "sha256-tGOgJSCGrGfkG2aE0VcGm2GH8ttiBQ602GftlWEHRHA=";
  };
in
pkgs.stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = [ pkgs.makeWrapper pkgs.squashfsTools pkgs.gnused ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/${pname} \
      --add-flags "${src}"
    APPIMAGE_CONTENTS=${pkgs.appimageTools.extract { inherit pname version src; }}
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp -L "$APPIMAGE_CONTENTS/helium.png" \
          "$out/share/icons/hicolor/256x256/apps/${pname}.png"
    mkdir -p $out/share/applications
    sed "s|Exec=.*|Exec=$out/bin/${pname}|" \
      "$APPIMAGE_CONTENTS/helium.desktop" \
      > "$out/share/applications/${pname}.desktop"
  '';
}
