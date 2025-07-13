{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "sysdvr-udev";
  version = "6.2";

  src = fetchFromGitHub {
    owner = "exelix11";
    repo = "SysDVR";
    tag = "v${version}";
    hash = "sha256-3t87KWltTdK/4Cd68lwjxOFaqylaG6ZCwHQ54MLzBGc=";
  };

  installPhase = ''
    install -Dpm644 $src/Client/Platform/Linux/sysdvr.rules $out/lib/udev/rules.d/50-sysdvr.rules
  '';

  meta = with lib; {
    homepage = "https://github.com/exelix11/SysDVR/";
    description = "udev rules that give NixOS permission to communicate with sysdvr on switch";
    platforms = platforms.linux;
    license = licenses.gpl2Only;
    maintainers = with maintainers; [
      theotheroracle
    ];
  };
}
