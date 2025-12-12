{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit applications

    extraPackages = with pkgs; [
      # AMD GPU drivers (RADV Vulkan driver included by default)
      mesa

      # OpenCL support for AMD (RustICL)
      mesa.opencl # Mesa's RustICL OpenCL implementation
    ];

    # 32-bit OpenCL support
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa.opencl
    ];
  };

  # AMD GPU kernel module
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.variables = {
    # Use AMD Vulkan driver
    AMD_VULKAN_ICD = "RADV";

    # ROCm device selection (for OpenCL)
    ROC_ENABLE_PRE_VEGA = "1";

    # Enable Rusticl (Gallium Rust OpenCL)
    RUSTICL_ENABLE = "radeonsi";

    # Force discrete GPU
    DRI_PRIME = "1";

    # Use XCB platform for Qt
    QT_QPA_PLATFORM = "xcb";

    # Help OpenCL find the ICD loader
    OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors";
  };
}
