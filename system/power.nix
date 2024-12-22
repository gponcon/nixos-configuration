{
  #hardware.cpu.intel.updateMicrocode = true;
  #hardware.enableAllFirmware = true;
  #boot.kernelModules = [ "coretemp" ];
  #powerManagement.cpuFreqGovernor = "performance";
  #powerManagement.powertop.enable = true;

  hardware.fancontrol.config = ''
    # Configuration file generated by pwmconfig
    INTERVAL=10
    DEVPATH=hwmon3=devices/platform/dell_smm_hwmon
    DEVNAME=hwmon3=dell_smm
    FCTEMPS=hwmon3/pwm1=hwmon3/temp1_input
    FCFANS=hwmon3/pwm1=
    MINTEMP=hwmon3/pwm1=35
    MAXTEMP=hwmon3/pwm1=65
    MINSTART=hwmon3/pwm1=150
    MINSTOP=hwmon3/pwm1=100
  '';

  # uncomment to lower CPU frequeuncy (0 - lowest, 100 - highest)
  # if it spins even on lowest frequency, then this can be hardware problem

  # system.activationScripts.cpu-frequency-set = {
  #     text = ''
  #         echo 75 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
  #         # check freq with    "sudo cpupower frequency-info"
  #     '';
  #     deps = [];
  # };

  # services.thermald.enable = true;
  # environment.etc."sysconfig/lm_sensors".text = ''
  #   # Generated by sensors-detect on Tue Aug  7 10:54:09 2018
  #   # This file is sourced by /etc/init.d/lm_sensors and defines the modules to
  #   # be loaded/unloaded.
  #   #
  #   # The format of this file is a shell script that simply defines variables:
  #   # HWMON_MODULES for hardware monitoring driver modules, and optionally
  #   # BUS_MODULES for any required bus driver module (for example for I2C or SPI).

  #   HWMON_MODULES="coretemp"
  # '';
}