final: prev: {
  xwayland-satellite = prev.xwayland-satellite.overrideAttrs (_: rec {
    version = "git-2026-05-18";
    src = final.fetchFromGitHub {
      owner = "Supreeeme";
      repo = "xwayland-satellite";
      rev = "a879e5e0896a326adc79c474bf457b8b99011027";
      hash = "sha256-wToKwH7IgWdGLMSIWksEDs4eumR6UbbsuPQ42r0oTXQ=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-jbEihJYcOwFeDiMYlOtaS8GlunvSze80iWahDj1qDrs=";
    };
  });
}
