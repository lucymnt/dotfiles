final: prev: {
  kdePackages = prev.kdePackages.overrideScope (kfinal: kprev: {
    dolphin = prev.symlinkJoin {
      name = "dolphin-wrapped";
      paths = [ kprev.dolphin ];
      nativeBuildInputs = [ prev.makeWrapper ];
      postBuild = ''
        rm $out/bin/dolphin
        makeWrapper ${kprev.dolphin}/bin/dolphin $out/bin/dolphin \
          --prefix XDG_DATA_DIRS : "/run/current-system/sw/share:/etc/profiles/per-user/$USER/share" \
          --run "${kprev.kservice}/bin/kbuildsycoca6 --noincremental"
      '';
    };
  });
}
