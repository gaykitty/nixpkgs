{
  lib,
  dotnetCorePackages,
  fetchFromGitHub,
  buildDotnetModule,
  ffmpeg_6,
  SDL2,
  SDL2_image,
  libusb1,
  cimguisdl2cross,
  git,
  gcc,
}:

buildDotnetModule rec {
  pname = "sysdvr";
  version = "6.2.1";

  src = fetchFromGitHub {
    owner = "exelix11";
    repo = "SysDVR";
    tag = "v${version}";
    hash = "sha256-Pta+hL9JwGDBeaSIv1vE9EKI8TBvnvf+jA4DpI+CmhQ=";
    leaveDotGit = true;
  };

  patches = [
    ./01-load-libs-fix.patch
    ./02-ffmpeg-version.patch
    ./03-config-location.patch
  ];

  projectFile = "Client/Client.csproj";

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps.json;

  nativeBuildInputs = [ git gcc ];

  runtimeDeps = [
    ffmpeg_6
    SDL2
    SDL2_image
    libusb1
    cimguisdl2cross
  ];

  executables = [ "SysDVR-Client" ];

  # Needed for performance
  selfContainedBuild = true;

  meta = with lib; {
    homepage = "https://github.com/exelix11/SysDVR/";
    description = "sysdvr screen capture client for switch";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [
      theotheroracle
    ];
  };
}
