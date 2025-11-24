{ pkgs, ... }:

# DaVinci Resolve with additional Python packages for scripting and OpenCL support
#
# This wrapper provides:
# 1. Extra python packages accessible for scripting 
# 2. OpenCL libraries explicitly injected into the FHS environment
#
# Note: The base davinci-resolve package already includes ocl-icd in targetPkgs,
# but mesa.opencl (RustICL) needs to be explicitly provided via LD_LIBRARY_PATH
# because the FHS environment doesn't automatically find it in the nix store.

let
  pythonWithPackages = pkgs.python3.withPackages (ps: with ps; [
    pyqt5
    tkinter
  ]);
in
pkgs.symlinkJoin {
  name = "davinci-resolve-wrapped";
  paths = [ pkgs.davinci-resolve ];
  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    # Wrap the FHS launcher to inject Python and OpenCL libraries
    wrapProgram $out/bin/davinci-resolve \
      --prefix PYTHONPATH : "${pythonWithPackages}/${pythonWithPackages.sitePackages}" \
      --prefix LD_LIBRARY_PATH : "${pkgs.mesa.opencl}/lib" \
      --set OCL_ICD_VENDORS "${pkgs.mesa.opencl}/etc/OpenCL/vendors"
  '';
}
