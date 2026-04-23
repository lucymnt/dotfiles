{ pkgs }:
let
  pname = "hayase";
  version = "6.4.58";
  src = pkgs.fetchurl {
    url = "https://api.hayase.watch/files/linux-hayase-${version}-linux.AppImage";
    hash = "sha256-0vx6DU3asJwfgMiWh/qUwb3I7F1ILOE8gRO/W8U6cXU=";
  };
  appimageContents = pkgs.appimageTools.extractType2 {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;
  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/hayase.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/hayase.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    install -Dm444 ${appimageContents}/hayase.png \
      $out/share/icons/hicolor/512x512/apps/hayase.png
  '';
  meta = with pkgs.lib; {
    description = "Stream anime torrents instantly, real-time with no waiting for downloads to finish";
    homepage = "https://hayase.watch";
    license = licenses.bsl11;
    mainProgram = "hayase";
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
