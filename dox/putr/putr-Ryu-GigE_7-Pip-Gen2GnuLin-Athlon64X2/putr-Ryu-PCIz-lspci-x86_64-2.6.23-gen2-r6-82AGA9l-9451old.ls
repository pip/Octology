Ryu-lspci-x86_64-2.6.23-gen2-r6-82AGA9l-9451old.ls
`lspci -t -vv`
-[0000:00]-+-00.0  nVidia Corporation CK804 Memory Controller
           +-01.0  nVidia Corporation CK804 ISA Bridge
           +-01.1  nVidia Corporation CK804 SMBus
           +-02.0  nVidia Corporation CK804 USB Controller
           +-02.1  nVidia Corporation CK804 USB Controller
           +-06.0  nVidia Corporation CK804 IDE
           +-07.0  nVidia Corporation CK804 Serial ATA Controller
           +-08.0  nVidia Corporation CK804 Serial ATA Controller
           +-09.0-[0000:01]--+-07.0  Creative Labs SB Audigy
           |                 +-07.1  Creative Labs SB Audigy Game Port
           |                 +-07.2  Creative Labs SB Audigy FireWire Port
           |                 \-0a.0  Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller
           +-0a.0  nVidia Corporation CK804 Ethernet Controller
           +-0b.0-[0000:02]--
           +-0c.0-[0000:03]--
           +-0d.0-[0000:04]----00.0  nVidia Corporation G71 [GeForce 7900 GS]
           +-0e.0-[0000:05]--
           +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
           +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
           +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
           \-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
`lspci -k`
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
  Kernel modules: i2c-nforce2
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
  Kernel driver in use: ohci_hcd
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
  Kernel driver in use: ehci_hcd
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
  Kernel driver in use: AMD_IDE
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
  Kernel driver in use: sata_nv
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
  Kernel driver in use: sata_nv
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
  Kernel driver in use: forcedeth
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
  Kernel driver in use: pcieport-driver
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
  Kernel driver in use: pcieport-driver
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
  Kernel driver in use: pcieport-driver
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
  Kernel driver in use: pcieport-driver
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
  Kernel driver in use: k8temp
01:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
  Kernel driver in use: EMU10K1_Audigy
  Kernel modules: snd-emu10k1
01:07.1 Input device controller: Creative Labs SB Audigy Game Port (rev 04)
  Kernel driver in use: Emu10k1_gameport
01:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
  Kernel driver in use: ohci1394
01:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
04:00.0 VGA compatible controller: nVidia Corporation G71 [GeForce 7900 GS] (rev a1)
  Kernel modules: nvidia
`lspci -nn -qq -vv`
00:00.0 Memory controller [0580]: nVidia Corporation CK804 Memory Controller [10de:005e] (rev a3)
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0
  Capabilities: [44] HyperTransport: Slave or Primary Interface
    Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
    Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
    Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
    Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
    Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
    Revision ID: 1.03
    Link Frequency 0: 1.0GHz
    Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
    Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
    Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
    Link Frequency 1: 200MHz
    Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
    Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
    Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
    Prefetchable memory behind bridge Upper: 00-00
    Bus Number: 00
  Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-
    Mapping Address Base: 00000000fee00000

00:01.0 ISA bridge [0601]: nVidia Corporation CK804 ISA Bridge [10de:0050] (rev a3)
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0

00:01.1 SMBus [0c05]: nVidia Corporation CK804 SMBus [10de:0052] (rev a2)
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Interrupt: pin A routed to IRQ 10
  Region 0: I/O ports at fc00 [size=32]
  Region 4: I/O ports at 1c00 [size=64]
  Region 5: I/O ports at 1c40 [size=64]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel modules: i2c-nforce2

00:02.0 USB Controller [0c03]: nVidia Corporation CK804 USB Controller [10de:005a] (rev a2) (prog-if 10 [OHCI])
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (750ns min, 250ns max)
  Interrupt: pin A routed to IRQ 23
  Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: ohci_hcd

00:02.1 USB Controller [0c03]: nVidia Corporation CK804 USB Controller [10de:005b] (rev a3) (prog-if 20 [EHCI])
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (750ns min, 250ns max)
  Interrupt: pin B routed to IRQ 20
  Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
  Capabilities: [44] Debug port: BAR=1 offset=0098
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: ehci_hcd

00:06.0 IDE interface [0101]: nVidia Corporation CK804 IDE [10de:0053] (rev a2) (prog-if 8a [Master SecP PriP])
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (750ns min, 250ns max)
  Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
  Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
  Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
  Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
  Region 4: I/O ports at e800 [size=16]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: AMD_IDE

00:07.0 IDE interface [0101]: nVidia Corporation CK804 Serial ATA Controller [10de:0054] (rev a3) (prog-if 85 [Master SecO PriO])
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (750ns min, 250ns max)
  Interrupt: pin A routed to IRQ 22
  Region 0: I/O ports at 09f0 [size=8]
  Region 1: I/O ports at 0bf0 [size=4]
  Region 2: I/O ports at 0970 [size=8]
  Region 3: I/O ports at 0b70 [size=4]
  Region 4: I/O ports at d400 [size=16]
  Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: sata_nv

00:08.0 IDE interface [0101]: nVidia Corporation CK804 Serial ATA Controller [10de:0055] (rev a3) (prog-if 85 [Master SecO PriO])
  Subsystem: nVidia Corporation Device [10de:cb84]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (750ns min, 250ns max)
  Interrupt: pin A routed to IRQ 21
  Region 0: I/O ports at 09e0 [size=8]
  Region 1: I/O ports at 0be0 [size=4]
  Region 2: I/O ports at 0960 [size=8]
  Region 3: I/O ports at 0b60 [size=4]
  Region 4: I/O ports at c000 [size=16]
  Region 5: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: sata_nv

00:09.0 PCI bridge [0604]: nVidia Corporation CK804 PCI Bridge [10de:005c] (rev a2) (prog-if 01 [Subtractive decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0
  Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
  I/O behind bridge: 0000a000-0000afff
  Memory behind bridge: fde00000-fdefffff
  Prefetchable memory behind bridge: fdf00000-fdffffff
  Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-

00:0a.0 Bridge [0680]: nVidia Corporation CK804 Ethernet Controller [10de:0057] (rev a3)
  Subsystem: nVidia Corporation NF4 Lanparty [10de:cb84]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0 (250ns min, 5000ns max)
  Interrupt: pin A routed to IRQ 23
  Region 0: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
  Region 1: I/O ports at bc00 [size=8]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
  Kernel driver in use: forcedeth

00:0b.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005d] (rev a3) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
  I/O behind bridge: 00009000-00009fff
  Memory behind bridge: fdd00000-fddfffff
  Prefetchable memory behind bridge: 00000000fdc00000-00000000fdcfffff
  Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
  Capabilities: [40] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Count=1/2 Enable+
    Address: 00000000fee0300c  Data: 4149
  Capabilities: [58] HyperTransport: MSI Mapping Enable- Fixed-
    Mapping Address Base: 00000000fee00000
  Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
    DevCap:  MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <4us
      ExtTag- RBE- FLReset-
    DevCtl:  Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
      MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta:  CorrErr- UncorrErr- FatalErr+ UnsuppReq- AuxPwr- TransPend-
    LnkCap:  Port #3, Speed 2.5GT/s, Width x0, ASPM L0s, Latency L0 <512ns, L1 <4us
      ClockPM- Suprise- LLActRep- BwNot-
    LnkCtl:  ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta:  Speed 2.5GT/s, Width x4, TrErr+ Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
      Slot #  8, PowerLimit 25.000000; Interlock- NoCompl-
    SltCtl:  Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
      Control: AttnInd Off, PwrInd On, Power- Interlock-
    SltSta:  Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
      Changed: MRL- PresDet- LinkState-
    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
    RootCap: CRSVisible-
    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
  Capabilities: [100] Virtual Channel <?>
  Kernel driver in use: pcieport-driver

00:0c.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005d] (rev a3) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
  I/O behind bridge: 00008000-00008fff
  Memory behind bridge: fdb00000-fdbfffff
  Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
  Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
  Capabilities: [40] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Count=1/2 Enable+
    Address: 00000000fee0300c  Data: 4151
  Capabilities: [58] HyperTransport: MSI Mapping Enable- Fixed-
    Mapping Address Base: 00000000fee00000
  Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
    DevCap:  MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <4us
      ExtTag- RBE- FLReset-
    DevCtl:  Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
      MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta:  CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    LnkCap:  Port #2, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <512ns, L1 <4us
      ClockPM- Suprise- LLActRep- BwNot-
    LnkCtl:  ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta:  Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
      Slot #  4, PowerLimit 25.000000; Interlock- NoCompl-
    SltCtl:  Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
      Control: AttnInd Off, PwrInd On, Power- Interlock-
    SltSta:  Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
      Changed: MRL- PresDet- LinkState-
    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
    RootCap: CRSVisible-
    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
  Capabilities: [100] Virtual Channel <?>
  Kernel driver in use: pcieport-driver

00:0d.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005d] (rev a3) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
  I/O behind bridge: 00007000-00007fff
  Memory behind bridge: fa000000-fcffffff
  Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
  Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
  BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
  Capabilities: [40] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Count=1/2 Enable+
    Address: 00000000fee0300c  Data: 4159
  Capabilities: [58] HyperTransport: MSI Mapping Enable- Fixed-
    Mapping Address Base: 00000000fee00000
  Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
    DevCap:  MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <4us
      ExtTag- RBE- FLReset-
    DevCtl:  Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
      MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta:  CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    LnkCap:  Port #1, Speed 2.5GT/s, Width x8, ASPM L0s, Latency L0 <512ns, L1 <4us
      ClockPM- Suprise- LLActRep- BwNot-
    LnkCtl:  ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta:  Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
      Slot #  2, PowerLimit 25.000000; Interlock- NoCompl-
    SltCtl:  Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
      Control: AttnInd Off, PwrInd On, Power- Interlock-
    SltSta:  Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
      Changed: MRL- PresDet- LinkState-
    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
    RootCap: CRSVisible-
    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
  Capabilities: [100] Virtual Channel <?>
  Kernel driver in use: pcieport-driver

00:0e.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005d] (rev a3) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
  I/O behind bridge: 00006000-00006fff
  Memory behind bridge: fd900000-fd9fffff
  Prefetchable memory behind bridge: 00000000fd800000-00000000fd8fffff
  Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
  Capabilities: [40] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Count=1/2 Enable+
    Address: 00000000fee0300c  Data: 4161
  Capabilities: [58] HyperTransport: MSI Mapping Enable- Fixed-
    Mapping Address Base: 00000000fee00000
  Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
    DevCap:  MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <4us
      ExtTag- RBE- FLReset-
    DevCtl:  Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
      MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta:  CorrErr- UncorrErr- FatalErr+ UnsuppReq- AuxPwr- TransPend-
    LnkCap:  Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency L0 <512ns, L1 <4us
      ClockPM- Suprise- LLActRep- BwNot-
    LnkCtl:  ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta:  Speed 2.5GT/s, Width x16, TrErr+ Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
      Slot #  1, PowerLimit 25.000000; Interlock- NoCompl-
    SltCtl:  Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
      Control: AttnInd Off, PwrInd On, Power- Interlock-
    SltSta:  Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
      Changed: MRL- PresDet- LinkState-
    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
    RootCap: CRSVisible-
    RootSta: PME ReqID 0000, PMEStatus- PMEPending-
  Capabilities: [100] Virtual Channel <?>
  Kernel driver in use: pcieport-driver

00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Capabilities: [80] HyperTransport: Host or Secondary Interface
    !!! Possibly incomplete decoding
    Command: WarmRst+ DblEnd-
    Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
    Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
    Revision ID: 1.02

00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]
  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Kernel driver in use: k8temp

01:07.0 Multimedia audio controller [0401]: Creative Labs SB Audigy [1102:0004] (rev 04)
  Subsystem: Creative Labs SB Audigy 2 ZS (SB0350) [1102:2002]
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 32 (500ns min, 5000ns max)
  Interrupt: pin A routed to IRQ 19
  Region 0: I/O ports at ac00 [size=64]
  Capabilities: [dc] Power Management version 2
    Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: EMU10K1_Audigy
  Kernel modules: snd-emu10k1

01:07.1 Input device controller [0980]: Creative Labs SB Audigy Game Port [1102:7003] (rev 04)
  Subsystem: Creative Labs SB Audigy MIDI/Game Port [1102:0040]
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 32
  Region 0: I/O ports at a800 [size=8]
  Capabilities: [dc] Power Management version 2
    Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Kernel driver in use: Emu10k1_gameport

01:07.2 FireWire (IEEE 1394) [0c00]: Creative Labs SB Audigy FireWire Port [1102:4001] (rev 04) (prog-if 10 [OHCI])
  Subsystem: Creative Labs SB Audigy FireWire Port [1102:0010]
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
  Interrupt: pin B routed to IRQ 16
  Region 0: Memory at fdeff000 (32-bit, non-prefetchable) [size=2K]
  Region 1: Memory at fdef8000 (32-bit, non-prefetchable) [size=16K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME+
  Kernel driver in use: ohci1394

01:0a.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller [11ab:4320] (rev 13)
  Subsystem: DFI Inc Device [15bd:100a]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 32 bytes
  Interrupt: pin A routed to IRQ 5
  Region 0: Memory at fdef4000 (32-bit, non-prefetchable) [size=16K]
  Region 1: I/O ports at a400 [size=256]
  [virtual] Expansion ROM at fdf00000 [disabled] [size=128K]
  Capabilities: [48] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=7 DScale=1 PME-
  Capabilities: [50] Vital Product Data <?>

04:00.0 VGA compatible controller [0300]: nVidia Corporation G71 [GeForce 7900 GS] [10de:0292] (rev a1) (prog-if 00 [VGA controller])
  Subsystem: eVga.com. Corp. Device [3842:c624]
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Interrupt: pin A routed to IRQ 3
  Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
  Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
  Region 3: Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
  Region 5: I/O ports at 7c00 [size=128]
  [virtual] Expansion ROM at fc000000 [disabled] [size=128K]
  Capabilities: [60] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Count=1/1 Enable-
    Address: 0000000000000000  Data: 0000
  Capabilities: [78] Express (v1) Endpoint, MSI 00
    DevCap:  MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <4us
      ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
    DevCtl:  Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
      MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta:  CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
    LnkCap:  Port #1, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <1us, L1 <4us
      ClockPM- Suprise- LLActRep- BwNot-
    LnkCtl:  ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta:  Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
  Capabilities: [100] Virtual Channel <?>
  Capabilities: [128] Power Budgeting <?>
  Kernel modules: nvidia
