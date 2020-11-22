chun
    description: Notebook
    product: LifeBook T1010
    vendor: FUJITSU
    serial: R8Y03029
    width: 64 bits
    capabilities: smbios-2.4 dmi-2.4 smp vsyscall32
    configuration: administrator_password=enabled boot=normal chassis=notebook keyboard_password=disabled power-on_password=disabled uuid=8104CE47-B12F-11DD-8B14-001742F63765
  *-core
       description: Motherboard
       product: FJNB1EB
       vendor: FUJITSU
       physical id: 0
       slot: y1BL-nnv2c32r
     *-firmware
          description: BIOS
          vendor: FUJITSU // Phoenix Technologies Ltd.
          physical id: 0
          version: Version 1.06
          date: 10/10/2008
          size: 128KiB
          capacity: 1984KiB
          capabilities: pci pcmcia pnp upgrade shadowing cdboot bootselect edd int13floppy720 int5printscreen int9keyboard int14serial int17printer int10video acpi usb biosbootspecification netboot
     *-cpu
          description: CPU
          product: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
          slot: Onboard
          size: 2245MHz
          capacity: 2267MHz
          width: 64 bits
          clock: 266MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx x86-64 constant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm pti tpr_shadow vnmi flexpriority dtherm cpufreq
        *-cache:0
             description: L1 cache
             physical id: 8
             slot: L1 Cache
             size: 128KiB
             capacity: 128KiB
             capabilities: internal write-back
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: 9
             slot: L2 Cache
             size: 3MiB
             capacity: 3MiB
             capabilities: pipeline-burst synchronous internal write-back unified
             configuration: level=2
     *-memory
          description: System Memory
          physical id: 10
          slot: System board or motherboard
          size: 2GiB
        *-bank:0
             description: SODIMM Synchronous 533 MHz (1.9 ns)
             physical id: 0
             slot: DDRIII 1
             size: 1GiB
             width: 64 bits
             clock: 533MHz (1.9ns)
        *-bank:1
             description: SODIMM Synchronous 533 MHz (1.9 ns)
             physical id: 1
             slot: DDRIII 2
             size: 1GiB
             width: 64 bits
             clock: 533MHz (1.9ns)
     *-pci
          description: Host bridge
          product: Mobile 4 Series Chipset Memory Controller Hub
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
        *-display:0
             description: VGA compatible controller
             product: Mobile 4 Series Chipset Integrated Graphics Controller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm vga_controller bus_master cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:16 memory:f2000000-f23fffff memory:d0000000-dfffffff ioport:1800(size=8) memory:c0000-dffff
        *-display:1 UNCLAIMED
             description: Display controller
             product: Mobile 4 Series Chipset Integrated Graphics Controller
             vendor: Intel Corporation
             physical id: 2.1
             bus info: pci@0000:00:02.1
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: latency=0
             resources: memory:f2400000-f24fffff
        *-usb:0
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #4
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:16 ioport:1820(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
        *-usb:1
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #5
             vendor: Intel Corporation
             physical id: 1a.1
             bus info: pci@0000:00:1a.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:17 ioport:1840(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
        *-usb:2
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #6
             vendor: Intel Corporation
             physical id: 1a.2
             bus info: pci@0000:00:1a.2
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:18 ioport:1860(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@5
                logical name: usb5
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
        *-usb:3
             description: USB controller
             product: 82801I (ICH9 Family) USB2 EHCI Controller #2
             vendor: Intel Corporation
             physical id: 1a.7
             bus info: pci@0000:00:1a.7
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:18 memory:f2a04800-f2a04bff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.15.0-43-generic ehci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 4.15
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480Mbit/s
        *-multimedia
             description: Audio device
             product: 82801I (ICH9 Family) HD Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 03
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:27 memory:f2a00000-f2a03fff
        *-pci:0
             description: PCI bridge
             product: 82801I (ICH9 Family) PCI Express Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:17 ioport:2000(size=4096) memory:f2500000-f25fffff ioport:80000000(size=2097152)
           *-network
                description: Ethernet interface
                product: 88E8055 PCI-E Gigabit Ethernet Controller
                vendor: Marvell Technology Group Ltd.
                physical id: 0
                bus info: pci@0000:08:00.0
                logical name: eth0
                version: 14
                serial: 00:17:42:f6:37:65
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm vpd msi pciexpress bus_master cap_list rom ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=sky2 driverversion=1.30 latency=0 link=no multicast=yes port=twisted pair
                resources: irq:24 memory:f2500000-f2503fff ioport:2000(size=256) memory:f2520000-f253ffff
        *-pci:1
             description: PCI bridge
             product: 82801I (ICH9 Family) PCI Express Port 2
             vendor: Intel Corporation
             physical id: 1c.1
             bus info: pci@0000:00:1c.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 ioport:3000(size=4096) memory:f0000000-f1ffffff ioport:80200000(size=2097152)
        *-pci:2
             description: PCI bridge
             product: 82801I (ICH9 Family) PCI Express Port 3
             vendor: Intel Corporation
             physical id: 1c.2
             bus info: pci@0000:00:1c.2
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:18 ioport:4000(size=4096) memory:f2600000-f26fffff ioport:80400000(size=2097152)
           *-network
                description: Wireless interface
                product: WiFi Link 5100
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:18:00.0
                logical name: wlan0
                version: 00
                serial: 00:16:ea:69:47:b0
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list ethernet physical wireless
                configuration: broadcast=yes driver=iwlwifi driverversion=4.15.0-43-generic firmware=8.83.5.1 build 33692 ip=192.168.8.32 latency=0 link=yes multicast=yes wireless=IEEE 802.11
                resources: irq:26 memory:f2600000-f2601fff
        *-usb:4
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:23 ioport:1880(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@6
                logical name: usb6
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
              *-usb:0
                   description: Mouse
                   product: USB Touch Panel
                   vendor: Fujitsu Component
                   physical id: 1
                   bus info: usb@6:1
                   version: 50.01
                   capabilities: usb-1.10
                   configuration: driver=usbhid maxpower=20mA speed=2Mbit/s
              *-usb:1
                   description: Bluetooth wireless interface
                   vendor: Taiyo Yuden
                   physical id: 2
                   bus info: usb@6:2
                   version: 48.39
                   capabilities: bluetooth usb-2.00
                   configuration: driver=btusb speed=12Mbit/s
        *-usb:5
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #2
             vendor: Intel Corporation
             physical id: 1d.1
             bus info: pci@0000:00:1d.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:19 ioport:18a0(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@7
                logical name: usb7
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
        *-usb:6
             description: USB controller
             product: 82801I (ICH9 Family) USB UHCI Controller #3
             vendor: Intel Corporation
             physical id: 1d.2
             bus info: pci@0000:00:1d.2
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master cap_list
             configuration: driver=uhci_hcd latency=0
             resources: irq:18 ioport:18c0(size=32)
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 4.15.0-43-generic uhci_hcd
                physical id: 1
                bus info: usb@8
                logical name: usb8
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
        *-usb:7
             description: USB controller
             product: 82801I (ICH9 Family) USB2 EHCI Controller #1
             vendor: Intel Corporation
             physical id: 1d.7
             bus info: pci@0000:00:1d.7
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:23 memory:f2a04c00-f2a04fff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.15.0-43-generic ehci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 4.15
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480Mbit/s
              *-usb
                   description: Video
                   product: Sirius USB2.0 Camera
                   vendor: Namtai Corp.
                   physical id: 4
                   bus info: usb@2:4
                   version: 10.23
                   capabilities: usb-2.00
                   configuration: driver=uvcvideo maxpower=320mA speed=480Mbit/s
        *-pci:3
             description: PCI bridge
             product: 82801 Mobile PCI Bridge
             vendor: Intel Corporation
             physical id: 1e
             bus info: pci@0000:00:1e.0
             version: 93
             width: 32 bits
             clock: 33MHz
             capabilities: pci subtractive_decode bus_master cap_list
             resources: ioport:5000(size=4096) memory:f2700000-f27fffff
           *-pcmcia:0
                description: CardBus bridge
                product: OZ711SP1 Memory CardBus Controller
                vendor: O2 Micro, Inc.
                physical id: 3
                bus info: pci@0000:38:03.0
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: pcmcia bus_master cap_list
                configuration: driver=yenta_cardbus latency=176 maxlatency=5 mingnt=192
                resources: irq:17 memory:84000000-84000fff ioport:5000(size=256) ioport:5400(size=256) memory:88000000-8bffffff memory:8c000000-8fffffff
           *-pcmcia:1
                description: CardBus bridge
                product: OZ711SP1 Memory CardBus Controller
                vendor: O2 Micro, Inc.
                physical id: 3.1
                bus info: pci@0000:38:03.1
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: pcmcia bus_master cap_list
                configuration: driver=yenta_cardbus latency=176 maxlatency=5 mingnt=192
                resources: irq:17 memory:90000000-90000fff ioport:5800(size=256) ioport:5c00(size=256) memory:94000000-97ffffff memory:98000000-9bffffff
           *-generic
                description: SD Host controller
                product: Integrated MMC/SD Controller
                vendor: O2 Micro, Inc.
                physical id: 3.2
                bus info: pci@0000:38:03.2
                version: 02
                width: 32 bits
                clock: 33MHz
                capabilities: pm bus_master cap_list
                configuration: driver=sdhci-pci latency=32
                resources: irq:17 memory:f2700000-f27000ff
           *-storage UNCLAIMED
                description: Mass storage controller
                product: Integrated MS/xD Controller
                vendor: O2 Micro, Inc.
                physical id: 3.3
                bus info: pci@0000:38:03.3
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: storage pm cap_list
                configuration: latency=32
                resources: memory:f2701000-f2701fff
        *-isa
             description: ISA bridge
             product: ICH9M LPC Interface Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: driver=lpc_ich latency=0
             resources: irq:0
        *-storage
             description: SATA controller
             product: 82801IBM/IEM (ICH9M/ICH9M-E) 4 port SATA Controller [AHCI mode]
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 03
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:25 ioport:1818(size=8) ioport:180c(size=4) ioport:1810(size=8) ioport:1808(size=4) ioport:18e0(size=32) memory:f2a04000-f2a047ff
        *-serial
             description: SMBus
             product: 82801I (ICH9 Family) SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 03
             width: 64 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0
             resources: irq:19 memory:80600000-806000ff ioport:1c00(size=32)
     *-scsi:0
          physical id: 1
          logical name: scsi0
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: FUJITSU MHZ2250B
             vendor: Fujitsu
             physical id: 0.0.0
             bus info: scsi@0:0.0.0
             logical name: /dev/sda
             version: 0009
             serial: K622T8A27PH1
             size: 232GiB (250GB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=5 logicalsectorsize=512 sectorsize=512 signature=0000fc30
           *-volume:0
                description: EXT4 volume
                vendor: Linux
                physical id: 1
                bus info: scsi@0:0.0.0,1
                logical name: /dev/sda1
                logical name: /
                version: 1.0
                serial: 18020300-4a3f-4ae2-8110-631ffdefc302
                size: 230GiB
                capacity: 230GiB
                capabilities: primary bootable journaled extended_attributes large_files huge_files dir_nlink recover extents ext4 ext2 initialized
                configuration: created=2012-12-23 18:19:10 filesystem=ext4 lastmountpoint=/ modified=2018-12-27 10:02:53 mount.fstype=ext4 mount.options=rw,relatime,errors=remount-ro,data=ordered mounted=2018-12-27 10:03:02 state=mounted
           *-volume:1
                description: Extended partition
                physical id: 2
                bus info: scsi@0:0.0.0,2
                logical name: /dev/sda2
                size: 2001MiB
                capacity: 2001MiB
                capabilities: primary extended partitioned partitioned:extended
              *-logicalvolume
                   description: Linux swap volume
                   physical id: 5
                   logical name: /dev/sda5
                   version: 1
                   serial: d4a8cce5-fcee-4840-9469-ab97ec9503cf
                   size: 2001MiB
                   capacity: 2001MiB
                   capabilities: nofs swap initialized
                   configuration: filesystem=swap pagesize=4096
     *-scsi:1
          physical id: 2
          logical name: scsi1
          capabilities: emulated
        *-cdrom
             description: DVD-RAM writer
             product: DVDRAM_GSA-T50N
             vendor: HL-DT-ST
             physical id: 0.0.0
             bus info: scsi@1:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/cdrw
             logical name: /dev/dvd
             logical name: /dev/dvdrw
             logical name: /dev/sr0
             version: RF07
             capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
             configuration: ansiversion=5 status=nodisc
  *-battery
       description: Lithium Ion Battery
       product: CP345705
       vendor: FUJITSU
       physical id: 1
       serial: 01
       slot: Internal Battery
       capacity: 56160mWh
       configuration: voltage=10.8V
