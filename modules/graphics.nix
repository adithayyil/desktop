{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit applications

    extraPackages = with pkgs; [
      # AMD GPU drivers (RADV Vulkan driver included by default)
      mesa

      # OpenCL support for AMD
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  # AMD GPU kernel module
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Environment variables for AMD GPU
  environment.variables = {
    # Use AMD Vulkan driver
    AMD_VULKAN_ICD = "RADV";

    # ROCm device selection (for OpenCL)
    ROC_ENABLE_PRE_VEGA = "1";

    # Enable Rusticl (Gallium Rust OpenCL) for better DaVinci Resolve support
    RUSTICL_ENABLE = "amdgpu,amdgpu-pro,radv,radeon";

    # Force discrete GPU for DaVinci Resolve
    DRI_PRIME = "1";

    # Use XCB platform for Qt (better stability with DaVinci Resolve)
    QT_QPA_PLATFORM = "xcb";
  };
}
