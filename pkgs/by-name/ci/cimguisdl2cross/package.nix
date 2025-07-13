{
  lib,
  stdenv,
  fetchgit,
  cmake,
  luajit,
  SDL2,
  xorg,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cimguisdl2cross";
  version = "r2";

  src = fetchgit {
    url = "https://github.com/exelix11/CimguiSDL2Cross.git";
    rev = "refs/tags/${finalAttrs.version}";
    hash = "sha256-76LnXoT82YpZ4NuAxC4HHL0WbNmIM+n2+bG5508EkMo=";
    fetchSubmodules = true;
  };

  postPatch = ''
    chmod +x apply_patches.sh
    ./apply_patches.sh
    cd ./cimgui/generator
    bash ./generator.sh
    cd ..
  '';

  buildInputs = [ SDL2 xorg.libX11 ];
  nativeBuildInputs = [ cmake luajit ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp cimgui.so $out/lib

    runHook postInstall
  '';

  meta = {
    description = "";
    homepage = "";
    changelog = "";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gaykitty ];
  };
})
