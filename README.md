#  🍏 Hackintosh setup for Dell Inspiron 15 3543
This setup is based on OpenCore, if you are not using it then I heavily recommend you to give it a try. This will not cover Clover. Working on MacOS Catalina.

## Hardware Configuration
My specific hardware configuration. Make sure you match most of these.    

The dGPU is disabled to save power since we would not be able to use it anyways. And as for the wireless card, the one that comes with the laptop is not supported. You can replace it with another compatible card (mini format).

|   Type   |   Name   |   Status   |
|----------|:--------:|:----------:|
|Processor |Intel Core i5-5200U|✓  
|RAM       |1x 8GB|✓ 
|iGPU      |Intel HD Graphics 5500|✓
|dGPU      |NVIDIA GeForce 820M|✗
|Ethernet  |Realtek PCIe FE Family Controller|✓ 
|WiFi      |Dell Wireless 1704 802.11b/g/n (2.4)|✗

## Configuration
The OpenCore configuration file, along with all the kext, acpi and driver directories is in the `raw` directory.
##### Kexts
The kernel extensions used for this build. Loaded in the same order as in the table (top => bottom).
|   Name   |  Purpose |
|----------|--------|
| Lilu.kext | Patching platform, required by other kexts.
| VirtualSMC.kext | Emulates the SMC. 
| AppleALC.kext | Makes the audio work.
| RealtekRTL8100.kext | Driver for the Ethernet card.
| USBInjectAll.kext | Haven't made a USB map for this yet, so in the meantime - inject all ports.
| VoodooPS2Controller.kext (+all plugins)| Provides support for the keyboard and touchpad.
| WhateverGreen.kext | Patches for the integrated GPU. 
| SMCSuperIO.kext | VirtualSMC plugin for fan speed monitoring.
| SMCProcessor.kext | VirtualSMC plugin for CPU temp. monitoring.
| SMCBatteryManager.kext | VirtualSMC plugin for battery management.

##### SSDTs 
The SSDTs used for this build.
|   Name   |  Purpose |
|----------|--------|
| SSDT-dGPU-Off.dsl | Disables the discrete GPU to save power.
| SDT-GPI0.dsl | Enables our GPI0.
| SSDT-HPET.dsl | Fixes IRQ conflicts. 
| SSDT-PLUG.dsl | Fixes power management. 
| SSDT-PNLF.dsl | Fixes backlight.
| SSDT-EC.dsl | Fixes embedded controller. 

##### Drivers 
The OpenCore drivers used for this build. **Use the copies of the drivers that come with your OpenCore version!**
|   Name   |  Purpose |
|----------|--------|
| HfsPlus.efi | HFS+ driver for OpenCore.
| OpenRuntime.efi | Runtime driver for OpenCore. 
| OpenCanopy.efi | Makes the OpenCore UI not ugly.

## Changing DVMT settings 
With this laptop, you cannot easily change your DVMT - but its doable.
At this time I don't have time to make a guide about doing it so you can follow this one [here](https://github.com/jevinruv/Hackintosh-Dell-Inspiron-3543#1-change-dvmt-settings). You can download the utility mentioned in the guide from [here](https://ami.com/en/products/firmware-tools-and-utilities/bios-uefi-utilities/). Its either Aptio 4 or Aptio V. 

Without having this done you will encounter kernel panics due to graphical issues. 

## Building 
To create a usable EFI folder, you have to run the `build.ps1` script that I have included (run from the root directory!).
In order for it to work you must have `iasl.exe` downloaded and placed inside the `Tools` directory. 

I have included my `DSDT.dsl` and `refs.txt` files but you can use your own if you so desire. 

After running the script you will have the finished product inside the `out` folder. Simply copy the files in there and paste them into your EFI folder. 

Have fun! 










