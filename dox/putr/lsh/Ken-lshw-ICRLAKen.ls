ken
    description: Desktop Computer
    width: 64 bits
    capabilities: smbios-2.2 dmi-2.2 smp vsyscall32
    configuration: boot=normal chassis=desktop
  *-core
       description: Motherboard
       product: LP NF4 Series
       vendor: DFI Corp,LTD
       physical id: 0
       version: 1.0
     *-firmware
          description: BIOS
          vendor: Phoenix Technologies, LTD
          physical id: 0
          version: 6.00 PG
          date: 04/06/2006
          size: 128KiB
          capacity: 448KiB
          capabilities: isa pci pnp apm upgrade shadowing cdboot bootselect socketedrom edd int13floppy360 int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb ls120boot zipboot virtualmachine
     *-cpu:0
          description: CPU
          product: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
          vendor: Advanced Micro Devices [AMD]
          physical id: 4
          bus info: cpu@0
          version: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
          slot: Socket 939
          size: 2134MHz
          capacity: 3GHz
          width: 64 bits
          clock: 194MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt x86-64 3dnowext 3dnow rep_good nopl cpuid pni lahf_lm cmp_legacy 3dnowprefetch vmmcall
        *-cache:0
             description: L1 cache
             physical id: b
             slot: Internal Cache
             size: 128KiB
             capacity: 128KiB
             capabilities: synchronous internal write-back
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: d
             slot: External Cache
             size: 512KiB
             capacity: 512KiB
             capabilities: synchronous internal write-back
             configuration: level=2
     *-cpu:1
          description: CPU
          product: Athlon 64
          vendor: AMD
          physical id: 5
          bus info: cpu@1
          version: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
          slot: Socket 939
          size: 2134MHz
          capacity: 3GHz
          clock: 194MHz
        *-cache:0
             description: L1 cache
             physical id: c
             slot: Internal Cache
             size: 128KiB
             capacity: 128KiB
             capabilities: synchronous internal write-back
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: e
             slot: External Cache
             size: 512KiB
             capacity: 512KiB
             capabilities: synchronous internal write-back
             configuration: level=2
     *-memory:0
          description: System Memory
          physical id: 1e
          slot: System board or motherboard
          size: 3GiB
        *-bank:0
             description: DIMM
             physical id: 0
             slot: A0
             size: 512MiB
             width: 64 bits
        *-bank:1
             description: DIMM
             physical id: 1
             slot: A1
             size: 512MiB
             width: 64 bits
        *-bank:2
             description: DIMM
             physical id: 2
             slot: A2
             size: 1GiB
             width: 64 bits
        *-bank:3
             description: DIMM
             physical id: 3
             slot: A3
             size: 1GiB
             width: 64 bits
     *-memory:1 UNCLAIMED
          description: Memory controller
          product: CK804 Memory Controller
          vendor: NVIDIA Corporation
          physical id: 3
          bus info: pci@0000:00:00.0
          version: a3
          width: 32 bits
          clock: 66MHz (15.2ns)
          capabilities: ht bus_master cap_list
          configuration: latency=0
     *-isa
          description: ISA bridge
          product: CK804 ISA Bridge
          vendor: NVIDIA Corporation
          physical id: 1
          bus info: pci@0000:00:01.0
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: isa bus_master
          configuration: latency=0
     *-serial
          description: SMBus
          product: CK804 SMBus
          vendor: NVIDIA Corporation
          physical id: 1.1
          bus info: pci@0000:00:01.1
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: pm cap_list
          configuration: driver=nForce2_smbus latency=0 maxlatency=1 mingnt=3
          resources: irq:10 ioport:fc00(size=32) ioport:400(size=64) ioport:440(size=64)
     *-usb:0
          description: USB controller
          product: CK804 USB Controller
          vendor: NVIDIA Corporation
          physical id: 2
          bus info: pci@0000:00:02.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: pm ohci bus_master cap_list
          configuration: driver=ohci-pci latency=0 maxlatency=1 mingnt=3
          resources: irq:23 memory:fe02f000-fe02ffff
        *-usbhost
             product: OHCI PCI host controller
             vendor: Linux 4.15.0-43-generic ohci_hcd
             physical id: 1
             bus info: usb@2
             logical name: usb2
             version: 4.15
             capabilities: usb-1.10
             configuration: driver=hub slots=10 speed=12Mbit/s
           *-usb:0
                description: Mouse
                product: Kensington Slimblade Trackball
                vendor: Kensington
                physical id: 1
                bus info: usb@2:1
                version: 1.09
                capabilities: usb-1.10
                configuration: driver=usbhid maxpower=100mA speed=2Mbit/s
           *-usb:1
                description: USB hub
                product: Generic USB Hub
                vendor: Chicony
                physical id: 2
                bus info: usb@2:2
                version: 1.00
                capabilities: usb-1.10
                configuration: driver=hub maxpower=90mA slots=3 speed=12Mbit/s
              *-usb
                   description: Keyboard
                   product: PFU-65 USB Keyboard
                   vendor: Chicony
                   physical id: 1
                   bus info: usb@2:2.1
                   version: 1.00
                   capabilities: usb-1.10
                   configuration: driver=usbhid speed=12Mbit/s
     *-usb:1
          description: USB controller
          product: CK804 USB Controller
          vendor: NVIDIA Corporation
          physical id: 2.1
          bus info: pci@0000:00:02.1
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: debug pm ehci bus_master cap_list
          configuration: driver=ehci-pci latency=0 maxlatency=1 mingnt=3
          resources: irq:22 memory:feb00000-feb000ff
        *-usbhost
             product: EHCI Host Controller
             vendor: Linux 4.15.0-43-generic ehci_hcd
             physical id: 1
             bus info: usb@1
             logical name: usb1
             version: 4.15
             capabilities: usb-2.00
             configuration: driver=hub slots=10 speed=480Mbit/s
     *-ide:0
          description: IDE interface
          product: CK804 IDE
          vendor: NVIDIA Corporation
          physical id: 6
          bus info: pci@0000:00:06.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: ide pm bus_master cap_list
          configuration: driver=pata_amd latency=0 maxlatency=1 mingnt=3
          resources: irq:0 ioport:1f0(size=8) ioport:3f6 ioport:170(size=8) ioport:376 ioport:f000(size=16)
     *-ide:1
          description: IDE interface
          product: CK804 Serial ATA Controller
          vendor: NVIDIA Corporation
          physical id: 7
          bus info: pci@0000:00:07.0
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: ide pm bus_master cap_list
          configuration: driver=sata_nv latency=0 maxlatency=1 mingnt=3
          resources: irq:21 ioport:9f0(size=8) ioport:bf0(size=4) ioport:970(size=8) ioport:b70(size=4) ioport:dc00(size=16) memory:fe02d000-fe02dfff
     *-ide:2
          description: IDE interface
          product: CK804 Serial ATA Controller
          vendor: NVIDIA Corporation
          physical id: 8
          bus info: pci@0000:00:08.0
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: ide pm bus_master cap_list
          configuration: driver=sata_nv latency=0 maxlatency=1 mingnt=3
          resources: irq:20 ioport:9e0(size=8) ioport:be0(size=4) ioport:960(size=8) ioport:b60(size=4) ioport:c800(size=16) memory:fe02c000-fe02cfff
     *-pci:0
          description: PCI bridge
          product: CK804 PCI Bridge
          vendor: NVIDIA Corporation
          physical id: 9
          bus info: pci@0000:00:09.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: pci subtractive_decode bus_master
          resources: ioport:9000(size=12288) memory:fde00000-fdefffff memory:fdf00000-fdffffff
        *-multimedia
             description: Multimedia audio controller
             product: EMU10k1 [Sound Blaster Live! Series]
             vendor: Creative Labs
             physical id: 7
             bus info: pci@0000:01:07.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=snd_emu10k1 latency=32 maxlatency=20 mingnt=2
             resources: irq:19 ioport:bc00(size=32)
        *-input
             description: Input device controller
             product: SB Live! Game Port
             vendor: Creative Labs
             physical id: 7.1
             bus info: pci@0000:01:07.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=Emu10k1_gameport latency=32
             resources: irq:0 ioport:b800(size=8)
        *-storage
             description: RAID bus controller
             product: SiI 3114 [SATALink/SATARaid] Serial ATA Controller
             vendor: Silicon Image, Inc.
             physical id: 8
             bus info: pci@0000:01:08.0
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: storage pm bus_master cap_list rom
             configuration: driver=sata_sil latency=32
             resources: irq:16 ioport:b400(size=8) ioport:b000(size=4) ioport:ac00(size=8) ioport:a800(size=4) ioport:a400(size=16) memory:fdeff000-fdeff3ff memory:fdf00000-fdf7ffff
        *-firewire
             description: FireWire (IEEE 1394)
             product: VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller
             vendor: VIA Technologies, Inc.
             physical id: 9
             bus info: pci@0000:01:09.0
             version: 80
             width: 32 bits
             clock: 33MHz
             capabilities: pm ohci bus_master cap_list
             configuration: driver=firewire_ohci latency=32 maxlatency=32
             resources: irq:17 memory:fdefe000-fdefe7ff ioport:a000(size=128)
        *-network
             description: Ethernet interface
             product: 88E8001 Gigabit Ethernet Controller
             vendor: Marvell Technology Group Ltd.
             physical id: a
             bus info: pci@0000:01:0a.0
             logical name: eth2
             version: 13
             serial: 00:01:29:f5:61:c2
             capacity: 1Gbit/s
             width: 32 bits
             clock: 66MHz
             capabilities: pm vpd bus_master cap_list rom ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=skge driverversion=1.14 latency=32 link=no maxlatency=31 mingnt=23 multicast=yes port=twisted pair
             resources: irq:18 memory:fdef8000-fdefbfff ioport:9c00(size=256) memory:fdf80000-fdf9ffff
     *-bridge
          description: Ethernet interface
          product: CK804 Ethernet Controller
          vendor: NVIDIA Corporation
          physical id: a
          bus info: pci@0000:00:0a.0
          logical name: eth3
          version: a3
          serial: 00:01:29:f5:aa:ce
          size: 1000000000
          capacity: 1000000000
          width: 32 bits
          clock: 66MHz
          capabilities: bridge pm bus_master cap_list ethernet physical mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
          configuration: autonegotiation=on broadcast=yes driver=forcedeth driverversion=0.64 duplex=full ip=192.168.8.3 latency=0 link=yes maxlatency=20 mingnt=1 multicast=yes port=MII speed=1Gbit/s
          resources: irq:23 memory:fe02b000-fe02bfff ioport:c400(size=8)
     *-pci:1
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: NVIDIA Corporation
          physical id: b
          bus info: pci@0000:00:0b.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci pm msi ht pciexpress normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:0 ioport:8000(size=4096) memory:fdd00000-fddfffff ioport:fdc00000(size=1048576)
     *-pci:2
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: NVIDIA Corporation
          physical id: c
          bus info: pci@0000:00:0c.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci pm msi ht pciexpress normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:0 ioport:7000(size=4096) memory:fdb00000-fdbfffff ioport:fda00000(size=1048576)
     *-pci:3
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: NVIDIA Corporation
          physical id: d
          bus info: pci@0000:00:0d.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci pm msi ht pciexpress normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:0 ioport:6000(size=4096) memory:fd900000-fd9fffff ioport:fd800000(size=1048576)
     *-pci:4
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: NVIDIA Corporation
          physical id: e
          bus info: pci@0000:00:0e.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci pm msi ht pciexpress normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:0 ioport:5000(size=4096) memory:fa000000-fcffffff ioport:d0000000(size=268435456)
        *-display
             description: VGA compatible controller
             product: G71 [GeForce 7900 GS]
             vendor: NVIDIA Corporation
             physical id: 0
             bus info: pci@0000:05:00.0
             version: a1
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress vga_controller bus_master cap_list rom
             configuration: driver=nvidia latency=0
             resources: irq:18 memory:fa000000-faffffff memory:d0000000-dfffffff memory:fb000000-fbffffff ioport:5c00(size=128) memory:c0000-dffff
     *-pci:5
          description: Host bridge
          product: K8 [Athlon64/Opteron] HyperTransport Technology Configuration
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 100
          bus info: pci@0000:00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:6
          description: Host bridge
          product: K8 [Athlon64/Opteron] Address Map
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 101
          bus info: pci@0000:00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:7
          description: Host bridge
          product: K8 [Athlon64/Opteron] DRAM Controller
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 102
          bus info: pci@0000:00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:8
          description: Host bridge
          product: K8 [Athlon64/Opteron] Miscellaneous Control
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 103
          bus info: pci@0000:00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz
          configuration: driver=k8temp
          resources: irq:0
     *-scsi:0
          physical id: f
          logical name: scsi0
          capabilities: emulated
        *-cdrom:0
             description: DVD writer
             product: DVD-RW  DVR-109
             vendor: PIONEER
             physical id: 0.0.0
             bus info: scsi@0:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/cdrw
             logical name: /dev/dvdrw
             logical name: /dev/sr0
             version: 1.50
             capabilities: removable audio cd-r cd-rw dvd dvd-r
             configuration: ansiversion=5 status=nodisc
        *-cdrom:1
             description: DVD reader
             product: DVD-ROM DDU1615
             vendor: SONY
             physical id: 0.1.0
             bus info: scsi@0:0.1.0
             logical name: /dev/dvd
             logical name: /dev/sr1
             version: FYS2
             capabilities: removable audio dvd
             configuration: ansiversion=5 status=nodisc
     *-scsi:1
          physical id: 10
          logical name: scsi7
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: ST2000DX001-1CM1
             vendor: Seagate
             physical id: 0.0.0
             bus info: scsi@7:0.0.0
             logical name: /dev/sda
             version: CC43
             serial: Z1E5KD52
             size: 1863GiB (2TB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=5 logicalsectorsize=512 sectorsize=4096 signature=000e7b70
           *-volume:0
                description: Linux filesystem partition
                vendor: Linux
                physical id: 1
                bus info: scsi@7:0.0.0,1
                logical name: /dev/sda1
                logical name: /boot
                version: 1.0
                serial: f4299886-5b40-4a14-adbc-02cefc2de2ec
                size: 243MiB
                capacity: 243MiB
                capabilities: primary bootable extended_attributes ext2 initialized
                configuration: filesystem=ext2 lastmountpoint=/boot modified=2018-12-26 13:21:36 mount.fstype=ext2 mount.options=rw,relatime,block_validity,barrier,user_xattr,acl,stripe=4 mounted=2018-12-26 13:21:36 state=mounted
           *-volume:1
                description: Extended partition
                physical id: 2
                bus info: scsi@7:0.0.0,2
                logical name: /dev/sda2
                size: 1862GiB
                capacity: 1862GiB
                capabilities: primary extended partitioned partitioned:extended
              *-logicalvolume
                   description: Linux LVM Physical Volume partition
                   physical id: 5
                   logical name: /dev/sda5
                   serial: Efo0Bc-5aPw-3Xxf-7NTS-Sge0-BscG-ykkot7
                   size: 1862GiB
                   capacity: 1862GiB
                   capabilities: multi lvm2
