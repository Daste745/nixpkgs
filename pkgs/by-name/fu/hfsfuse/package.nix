{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
  fuse,
  libarchive,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hfsfuse";
  version = "0.416";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "0x09";
    repo = "hfsfuse";
    tag = finalAttrs.version;
    hash = "sha256-O0T4VnghNPDYQ8NeMPxCLVl2jdnF4W2miEhQ/t6Dwxs=";
  };

  buildInputs = [
    fuse
    libarchive
  ];

  # TODO: Install outputs from the `install-lib` target
  # installTargets = "install install-lib";

  installPhase = ''
    mkdir -pm755 $out/bin
    install -m755 hfsdump hfsfuse hfstar $out/bin
  '';

  # TODO: Maybe use installFlags? And set DESTDIR to $out

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "FUSE driver for HFS+ filesystems";
    homepage = "https://github.com/0x09/hfsfuse";
    changelog = "https://github.com/0x09/hfsfuse/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "hfsfuse";
    platforms = lib.platforms.all;
  };
})
