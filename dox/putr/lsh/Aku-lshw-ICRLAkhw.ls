aku
    description: Desktop Computer
    product: System Product Name (To Be Filled By O.E.M.)
    vendor: System manufacturer
    version: System Version
    serial: System Serial Number
    width: 64 bits
    capabilities: smbios-2.5 dmi-2.5 smp vsyscall32
    configuration: boot=normal chassis=desktop family=To Be Filled By O.E.M. sku=To Be Filled By O.E.M. uuid=C04E001E-8C00-00D5-D639-485B394ADAD8
  *-core
       description: Motherboard
       product: M4A79T Deluxe
       vendor: ASUSTeK Computer INC.
       physical id: 0
       version: Rev 1.xx
       serial: 104950700000214
       slot: To Be Filled By O.E.M.
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 3205
          date: 06/07/2010
          size: 64KiB
          capacity: 960KiB
          capabilities: isa pci pnp apm upgrade shadowing escd cdboot bootselect socketedrom edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: AMD Phenom(tm) II X4 965 Processor
          vendor: Advanced Micro Devices [AMD]
          physical id: 4
          bus info: cpu@0
          version: AMD Phenom(tm) II X4 965 Processor
          serial: To Be Filled By O.E.M.
          slot: AM3
          size: 3400MHz
          capacity: 3400MHz
          width: 64 bits
          clock: 200MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt hw_pstate vmmcall npt lbrv svm_lock nrip_save
          configuration: cores=4 enabledcores=4
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1-Cache
             size: 512KiB
             capacity: 512KiB
             capabilities: pipeline-burst internal varies
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2-Cache
             size: 2MiB
             capacity: 2MiB
             capabilities: pipeline-burst internal varies
             configuration: level=2
        *-cache:2
             description: L3 cache
             physical id: 7
             slot: L3-Cache
             size: 6MiB
             capacity: 6MiB
             capabilities: pipeline-burst internal varies
             configuration: level=3
     *-memory
          description: System Memory
          physical id: 3d
          slot: System board or motherboard
          size: 8GiB
        *-bank:0
             description: DIMM DDR Synchronous 1333 MHz (0.8 ns)
             product: ModulePartNumber00
             vendor: Manufacturer00
             physical id: 0
             serial: SerNum00
             slot: DIMM0
             size: 2GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
        *-bank:1
             description: DIMM DDR Synchronous 1333 MHz (0.8 ns)
             product: ModulePartNumber01
             vendor: Manufacturer01
             physical id: 1
             serial: SerNum01
             slot: DIMM1
             size: 2GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
        *-bank:2
             description: DIMM DDR Synchronous 1333 MHz (0.8 ns)
             product: ModulePartNumber02
             vendor: Manufacturer02
             physical id: 2
             serial: SerNum02
             slot: DIMM2
             size: 2GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
        *-bank:3
             description: DIMM DDR Synchronous 1333 MHz (0.8 ns)
             product: ModulePartNumber03
             vendor: Manufacturer03
             physical id: 3
             serial: SerNum03
             slot: DIMM3
             size: 2GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
     *-pci:0
          description: Host bridge
          product: RD790 Host Bridge
          vendor: Advanced Micro Devices, Inc. [AMD/ATI]
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 00
          width: 64 bits
          clock: 66MHz
        *-pci:0
             description: PCI bridge
             product: RX780/RD790 PCI to PCI bridge (external gfx0 port A)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:18 ioport:e000(size=4096) memory:fbf00000-fbffffff ioport:d0000000(size=268435456)
           *-display
                description: VGA compatible controller
                product: Curacao XT / Trinidad XT [Radeon R7 370 / R9 270X/370X]
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0
                bus info: pci@0000:05:00.0
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pm pciexpress msi vga_controller bus_master cap_list rom
                configuration: driver=radeon latency=0
                resources: irq:31 memory:d0000000-dfffffff memory:fbf80000-fbfbffff ioport:e000(size=256) memory:c0000-dffff
           *-multimedia
                description: Audio device
                product: Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series]
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0.1
                bus info: pci@0000:05:00.1
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pm pciexpress msi bus_master cap_list
                configuration: driver=snd_hda_intel latency=0
                resources: irq:32 memory:fbffc000-fbffffff
        *-pci:1
             description: PCI bridge
             product: RD790 PCI to PCI bridge (PCI express gpp port C)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 6
             bus info: pci@0000:00:06.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:18 ioport:d000(size=4096) memory:fbe00000-fbefffff
           *-network
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:04:00.0
                logical name: eth0
                version: 01
                serial: 48:5b:39:4a:da:d8
                size: 1Gbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm vpd msi pciexpress bus_master cap_list rom ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=r8169 driverversion=2.3LK-NAPI duplex=full ip=192.168.8.15 latency=0 link=yes multicast=yes port=MII speed=1Gbit/s
                resources: irq:30 ioport:d800(size=256) memory:fbeff000-fbefffff memory:fbec0000-fbedffff
        *-pci:2
             description: PCI bridge
             product: RX780/RD790 PCI to PCI bridge (PCI express gpp port D)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 7
             bus info: pci@0000:00:07.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:19 ioport:c000(size=4096) memory:fbd00000-fbdfffff
           *-firewire
                description: FireWire (IEEE 1394)
                product: VT6315 Series Firewire Controller
                vendor: VIA Technologies, Inc.
                physical id: 0
                bus info: pci@0000:03:00.0
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress ohci bus_master cap_list
                configuration: driver=firewire_ohci latency=0
                resources: irq:19 memory:fbdff800-fbdfffff ioport:c800(size=256)
        *-pci:3
             description: PCI bridge
             product: RD790 PCI to PCI bridge (external gfx1 port A)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: b
             bus info: pci@0000:00:0b.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:19 memory:fbc00000-fbcfffff
           *-usb
                description: USB controller
                product: uPD720202 USB 3.0 Host Controller
                vendor: Renesas Technology Corp.
                physical id: 0
                bus info: pci@0000:02:00.0
                version: 02
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi msix pciexpress xhci bus_master cap_list
                configuration: driver=xhci_hcd latency=0
                resources: irq:19 memory:fbcfe000-fbcfffff
              *-usbhost:0
                   product: xHCI Host Controller
                   vendor: Linux 4.15.0-43-generic xhci-hcd
                   physical id: 0
                   bus info: usb@8
                   logical name: usb8
                   version: 4.15
                   capabilities: usb-2.00
                   configuration: driver=hub slots=2 speed=480Mbit/s
                 *-usb
                      description: USB hub
                      product: Generic USB Hub
                      vendor: Chicony
                      physical id: 1
                      bus info: usb@8:1
                      version: 1.00
                      capabilities: usb-1.10
                      configuration: driver=hub maxpower=90mA slots=1 speed=12Mbit/s
                    *-usb
                         description: Keyboard
                         product: PFU-65 USB Keyboard
                         vendor: Chicony
                         physical id: 1
                         bus info: usb@8:1.1
                         version: 1.00
                         capabilities: usb-1.10
                         configuration: driver=usbhid speed=12Mbit/s
              *-usbhost:1
                   product: xHCI Host Controller
                   vendor: Linux 4.15.0-43-generic xhci-hcd
                   physical id: 1
                   bus info: usb@9
                   logical name: usb9
                   version: 4.15
                   capabilities: usb-3.00
                   configuration: driver=hub slots=2 speed=5000Mbit/s
        *-storage
             description: SATA controller
             product: SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode]
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 11
             bus info: pci@0000:00:11.0
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=64
             resources: irq:29 ioport:b000(size=8) ioport:a000(size=4) ioport:9000(size=8) ioport:8000(size=4) ioport:7000(size=16) memory:fbbfe400-fbbfe7ff
        *-usb:0
             description: USB controller
             product: SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 12
             bus info: pci@0000:00:12.0
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=64
             resources: irq:16 memory:fbbf6000-fbbf6fff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.15.0-43-generic ohci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=3 speed=12Mbit/s
              *-usb
                   description: Mouse
                   product: Kensington Slimblade Trackball
                   vendor: Kensington
                   physical id: 3
                   bus info: usb@3:3
                   version: 1.09
                   capabilities: usb-1.10
                   configuration: driver=usbhid maxpower=100mA speed=2Mbit/s
        *-usb:1
             description: USB controller
             product: SB7x0 USB OHCI1 Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 12.1
             bus info: pci@0000:00:12.1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=64
             resources: irq:16 memory:fbbf7000-fbbf7fff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.15.0-43-generic ohci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=3 speed=12Mbit/s
        *-usb:2
             description: USB controller
             product: SB7x0/SB8x0/SB9x0 USB EHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 12.2
             bus info: pci@0000:00:12.2
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=64
             resources: irq:17 memory:fbbfe800-fbbfe8ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.15.0-43-generic ehci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 4.15
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480Mbit/s
        *-usb:3
             description: USB controller
             product: SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 13
             bus info: pci@0000:00:13.0
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=64
             resources: irq:18 memory:fbbfc000-fbbfcfff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.15.0-43-generic ohci_hcd
                physical id: 1
                bus info: usb@5
                logical name: usb5
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=3 speed=12Mbit/s
        *-usb:4
             description: USB controller
             product: SB7x0 USB OHCI1 Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 13.1
             bus info: pci@0000:00:13.1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=64
             resources: irq:18 memory:fbbfd000-fbbfdfff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.15.0-43-generic ohci_hcd
                physical id: 1
                bus info: usb@6
                logical name: usb6
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=3 speed=12Mbit/s
        *-usb:5
             description: USB controller
             product: SB7x0/SB8x0/SB9x0 USB EHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 13.2
             bus info: pci@0000:00:13.2
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=64
             resources: irq:19 memory:fbbfec00-fbbfecff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.15.0-43-generic ehci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 4.15
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480Mbit/s
        *-serial UNCLAIMED
             description: SMBus
             product: SBx00 SMBus Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 3c
             width: 32 bits
             clock: 66MHz
             capabilities: ht cap_list
             configuration: latency=0
        *-ide
             description: IDE interface
             product: SB7x0/SB8x0/SB9x0 IDE Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14.1
             bus info: pci@0000:00:14.1
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ide msi bus_master cap_list
             configuration: driver=pata_atiixp latency=64
             resources: irq:16 ioport:1f0(size=8) ioport:3f6 ioport:170(size=8) ioport:376 ioport:ff00(size=16)
        *-multimedia
             description: Audio device
             product: SBx00 Azalia (Intel HDA)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 00
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=snd_hda_intel latency=64
             resources: irq:16 memory:fbbf8000-fbbfbfff
        *-isa
             description: ISA bridge
             product: SB7x0/SB8x0/SB9x0 LPC host controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14.3
             bus info: pci@0000:00:14.3
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: isa bus_master
             configuration: latency=0
        *-pci:4
             description: PCI bridge
             product: SBx00 PCI to PCI Bridge
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14.4
             bus info: pci@0000:00:14.4
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: pci subtractive_decode bus_master
        *-usb:6
             description: USB controller
             product: SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 14.5
             bus info: pci@0000:00:14.5
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=64
             resources: irq:18 memory:fbbff000-fbbfffff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.15.0-43-generic ohci_hcd
                physical id: 1
                bus info: usb@7
                logical name: usb7
                version: 4.15
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12Mbit/s
     *-pci:1
          description: Host bridge
          product: Family 10h Processor HyperTransport Configuration
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 101
          bus info: pci@0000:00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:2
          description: Host bridge
          product: Family 10h Processor Address Map
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 102
          bus info: pci@0000:00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:3
          description: Host bridge
          product: Family 10h Processor DRAM Controller
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 103
          bus info: pci@0000:00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:4
          description: Host bridge
          product: Family 10h Processor Miscellaneous Control
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 104
          bus info: pci@0000:00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz
          configuration: driver=k10temp
          resources: irq:0
     *-pci:5
          description: Host bridge
          product: Family 10h Processor Link Control
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 105
          bus info: pci@0000:00:18.4
          version: 00
          width: 32 bits
          clock: 33MHz
     *-scsi:0
          physical id: 1
          logical name: scsi3
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: ST2000DX001-1CM1
             vendor: Seagate
             physical id: 0.0.0
             bus info: scsi@3:0.0.0
             logical name: /dev/sda
             version: CC43
             serial: Z1E5KM4G
             size: 1863GiB (2TB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=5 logicalsectorsize=512 sectorsize=4096
           *-volume:0
                description: Linux filesystem partition
                vendor: Linux
                physical id: 1
                bus info: scsi@3:0.0.0,1
                logical name: /dev/sda1
                logical name: /boot
                version: 1.0
                serial: c744e58a-9a81-4790-a87d-b219a841196c
                size: 243MiB
                capacity: 243MiB
                capabilities: primary bootable ext2 initialized
                configuration: filesystem=ext2 lastmountpoint=/boot modified=2018-12-25 17:45:50 mount.fstype=ext2 mount.options=rw,relatime,block_validity,barrier,user_xattr,acl mounted=2018-12-25 17:45:50 state=mounted
           *-volume:1
                description: Extended partition
                physical id: 2
                bus info: scsi@3:0.0.0,2
                logical name: /dev/sda2
                size: 1862GiB
                capacity: 1862GiB
                capabilities: primary extended partitioned partitioned:extended
              *-logicalvolume
                   description: Linux LVM Physical Volume partition
                   physical id: 5
                   logical name: /dev/sda5
                   serial: ldsAnP-R0df-dTte-hPVJ-D3Bj-me5U-if36vk
                   size: 1862GiB
                   capacity: 1862GiB
                   capabilities: multi lvm2
     *-scsi:1
          physical id: 2
          logical name: scsi5
          capabilities: emulated
        *-cdrom
             description: DVD writer
             product: iHAS124   F
             vendor: ATAPI
             physical id: 0.0.0
             bus info: scsi@5:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/cdrw
             logical name: /dev/dvd
             logical name: /dev/dvdrw
             logical name: /dev/sr0
             version: CL9N
             capabilities: removable audio cd-r cd-rw dvd dvd-r
             configuration: ansiversion=5 status=nodisc
  *-network:0
       description: Ethernet interface
       physical id: 1
       logical name: docker0
       serial: 02:42:78:af:e0:01
       capabilities: ethernet physical
       configuration: broadcast=yes driver=bridge driverversion=2.3 firmware=N/A ip=172.17.0.1 link=no multicast=yes
  *-network:1
       description: Ethernet interface
       physical id: 2
       logical name: lxcbr0
       serial: 00:16:3e:00:00:00
       capabilities: ethernet physical
       configuration: broadcast=yes driver=bridge driverversion=2.3 firmware=N/A ip=10.0.3.1 link=no multicast=yes
