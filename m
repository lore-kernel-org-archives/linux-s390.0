From: Henrik Austad <henrik@austad.us>
Subject: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Date: Tue,  4 Sep 2018 00:15:23 +0200
Message-ID: <1536012923-16275-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/dri-devel/>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
To: linux-doc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Jan Kandziora <jjj@gmx.de>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Henrik Austad <henrik@austad.us>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Henrik Austad <haustad@cisco.com>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-s390@vger.kernel.org, Ian Kent <raven@themaw.net>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.orgJame
List-ID: <linux-s390.vger.kernel.org>

This is a respin with a wider audience (all that get_maintainer returned)
and I know this spams a *lot* of people. Not sure what would be the correct
way, so my apologies for ruining your inbox.

The 00-INDEX files are supposed to give a summary of all files present
in a directory, but these files are horribly out of date and their
usefulness is brought into question. Often a simple "ls" would reveal
the same information as the filenames are generally quite descriptive as
a short introduction to what the file covers (it should not surprise
anyone what Documentation/sched/sched-design-CFS.txt covers)

A few years back it was mentioned that these files were no longer really
needed, and they have since then grown further out of date, so perhaps
it is time to just throw them out.

A short status yields the following _outdated_ 00-INDEX files, first
counter is files listed in 00-INDEX but missing in the directory, last
is files present but not listed in 00-INDEX.

List of outdated 00-INDEX:
Documentation: (4/10)
Documentation/sysctl: (0/1)
Documentation/timers: (1/0)
Documentation/blockdev: (3/1)
Documentation/w1/slaves: (0/1)
Documentation/locking: (0/1)
Documentation/devicetree: (0/5)
Documentation/power: (1/1)
Documentation/powerpc: (0/5)
Documentation/arm: (1/0)
Documentation/x86: (0/9)
Documentation/x86/x86_64: (1/1)
Documentation/scsi: (4/4)
Documentation/filesystems: (2/9)
Documentation/filesystems/nfs: (0/2)
Documentation/cgroup-v1: (0/2)
Documentation/kbuild: (0/4)
Documentation/spi: (1/0)
Documentation/virtual/kvm: (1/0)
Documentation/scheduler: (0/2)
Documentation/fb: (0/1)
Documentation/block: (0/1)
Documentation/networking: (6/37)
Documentation/vm: (1/3)

Then there are 364 subdirectories in Documentation/ with several files that
are missing 00-INDEX alltogether (and another 120 with a single file and no
00-INDEX).

I don't really have an opinion to whether or not we /should/ have 00-INDEX,
but the above 00-INDEX should either be removed or be kept up to date. If
we should keep the files, I can try to keep them updated, but I rather not
if we just want to delete them anyway.

As a starting point, remove all index-files and references to 00-INDEX and
see where the discussion is going.

Again, sorry for the insanely wide distribution.

Signed-off-by: Henrik Austad <henrik@austad.us>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Henrik Austad <henrik@austad.us>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Jan Kandziora <jjj@gmx.de>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: kvm@vger.kernel.org
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Documentation/00-INDEX                  | 428 --------------------------------
 Documentation/PCI/00-INDEX              |  26 --
 Documentation/RCU/00-INDEX              |  34 ---
 Documentation/RCU/rcu.txt               |   4 -
 Documentation/admin-guide/README.rst    |   3 +-
 Documentation/arm/00-INDEX              |  50 ----
 Documentation/block/00-INDEX            |  34 ---
 Documentation/blockdev/00-INDEX         |  18 --
 Documentation/cdrom/00-INDEX            |  11 -
 Documentation/cgroup-v1/00-INDEX        |  26 --
 Documentation/devicetree/00-INDEX       |  12 -
 Documentation/fb/00-INDEX               |  75 ------
 Documentation/filesystems/00-INDEX      | 153 ------------
 Documentation/filesystems/nfs/00-INDEX  |  26 --
 Documentation/fmc/00-INDEX              |  38 ---
 Documentation/gpio/00-INDEX             |   4 -
 Documentation/ide/00-INDEX              |  14 --
 Documentation/ioctl/00-INDEX            |  12 -
 Documentation/isdn/00-INDEX             |  42 ----
 Documentation/kbuild/00-INDEX           |  14 --
 Documentation/laptops/00-INDEX          |  16 --
 Documentation/leds/00-INDEX             |  32 ---
 Documentation/locking/00-INDEX          |  16 --
 Documentation/m68k/00-INDEX             |   7 -
 Documentation/mips/00-INDEX             |   4 -
 Documentation/mmc/00-INDEX              |  10 -
 Documentation/netlabel/00-INDEX         |  10 -
 Documentation/netlabel/cipso_ipv4.txt   |  11 +-
 Documentation/netlabel/introduction.txt |   2 +-
 Documentation/networking/00-INDEX       | 234 -----------------
 Documentation/parisc/00-INDEX           |   6 -
 Documentation/power/00-INDEX            |  44 ----
 Documentation/powerpc/00-INDEX          |  34 ---
 Documentation/s390/00-INDEX             |  28 ---
 Documentation/scheduler/00-INDEX        |  18 --
 Documentation/scsi/00-INDEX             | 108 --------
 Documentation/serial/00-INDEX           |  16 --
 Documentation/spi/00-INDEX              |  16 --
 Documentation/sysctl/00-INDEX           |  16 --
 Documentation/timers/00-INDEX           |  16 --
 Documentation/virtual/00-INDEX          |  11 -
 Documentation/virtual/kvm/00-INDEX      |  35 ---
 Documentation/vm/00-INDEX               |  50 ----
 Documentation/w1/00-INDEX               |  10 -
 Documentation/w1/masters/00-INDEX       |  12 -
 Documentation/w1/slaves/00-INDEX        |  14 --
 Documentation/x86/00-INDEX              |  20 --
 Documentation/x86/x86_64/00-INDEX       |  16 --
 README                                  |   1 -
 scripts/check_00index.sh                |  67 -----
 50 files changed, 8 insertions(+), 1896 deletions(-)
 delete mode 100644 Documentation/00-INDEX
 delete mode 100644 Documentation/PCI/00-INDEX
 delete mode 100644 Documentation/RCU/00-INDEX
 delete mode 100644 Documentation/arm/00-INDEX
 delete mode 100644 Documentation/block/00-INDEX
 delete mode 100644 Documentation/blockdev/00-INDEX
 delete mode 100644 Documentation/cdrom/00-INDEX
 delete mode 100644 Documentation/cgroup-v1/00-INDEX
 delete mode 100644 Documentation/devicetree/00-INDEX
 delete mode 100644 Documentation/fb/00-INDEX
 delete mode 100644 Documentation/filesystems/00-INDEX
 delete mode 100644 Documentation/filesystems/nfs/00-INDEX
 delete mode 100644 Documentation/fmc/00-INDEX
 delete mode 100644 Documentation/gpio/00-INDEX
 delete mode 100644 Documentation/ide/00-INDEX
 delete mode 100644 Documentation/ioctl/00-INDEX
 delete mode 100644 Documentation/isdn/00-INDEX
 delete mode 100644 Documentation/kbuild/00-INDEX
 delete mode 100644 Documentation/laptops/00-INDEX
 delete mode 100644 Documentation/leds/00-INDEX
 delete mode 100644 Documentation/locking/00-INDEX
 delete mode 100644 Documentation/m68k/00-INDEX
 delete mode 100644 Documentation/mips/00-INDEX
 delete mode 100644 Documentation/mmc/00-INDEX
 delete mode 100644 Documentation/netlabel/00-INDEX
 delete mode 100644 Documentation/networking/00-INDEX
 delete mode 100644 Documentation/parisc/00-INDEX
 delete mode 100644 Documentation/power/00-INDEX
 delete mode 100644 Documentation/powerpc/00-INDEX
 delete mode 100644 Documentation/s390/00-INDEX
 delete mode 100644 Documentation/scheduler/00-INDEX
 delete mode 100644 Documentation/scsi/00-INDEX
 delete mode 100644 Documentation/serial/00-INDEX
 delete mode 100644 Documentation/spi/00-INDEX
 delete mode 100644 Documentation/sysctl/00-INDEX
 delete mode 100644 Documentation/timers/00-INDEX
 delete mode 100644 Documentation/virtual/00-INDEX
 delete mode 100644 Documentation/virtual/kvm/00-INDEX
 delete mode 100644 Documentation/vm/00-INDEX
 delete mode 100644 Documentation/w1/00-INDEX
 delete mode 100644 Documentation/w1/masters/00-INDEX
 delete mode 100644 Documentation/w1/slaves/00-INDEX
 delete mode 100644 Documentation/x86/00-INDEX
 delete mode 100644 Documentation/x86/x86_64/00-INDEX
 delete mode 100755 scripts/check_00index.sh

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
deleted file mode 100644
index 2754fe8..0000000
--- a/Documentation/00-INDEX
+++ /dev/null
@@ -1,428 +0,0 @@
-
-This is a brief list of all the files in ./linux/Documentation and what
-they contain. If you add a documentation file, please list it here in
-alphabetical order as well, or risk being hunted down like a rabid dog.
-Please keep the descriptions small enough to fit on one line.
-							 Thanks -- Paul G.
-
-Following translations are available on the WWW:
-
-   - Japanese, maintained by the JF Project (jf@listserv.linux.or.jp), at
-     http://linuxjf.sourceforge.jp/
-
-00-INDEX
-	- this file.
-ABI/
-	- info on kernel <-> userspace ABI and relative interface stability.
-CodingStyle
-	- nothing here, just a pointer to process/coding-style.rst.
-DMA-API.txt
-	- DMA API, pci_ API & extensions for non-consistent memory machines.
-DMA-API-HOWTO.txt
-	- Dynamic DMA mapping Guide
-DMA-ISA-LPC.txt
-	- How to do DMA with ISA (and LPC) devices.
-DMA-attributes.txt
-	- listing of the various possible attributes a DMA region can have
-EDID/
-	- directory with info on customizing EDID for broken gfx/displays.
-IPMI.txt
-	- info on Linux Intelligent Platform Management Interface (IPMI) Driver.
-IRQ-affinity.txt
-	- how to select which CPU(s) handle which interrupt events on SMP.
-IRQ-domain.txt
-	- info on interrupt numbering and setting up IRQ domains.
-IRQ.txt
-	- description of what an IRQ is.
-Intel-IOMMU.txt
-	- basic info on the Intel IOMMU virtualization support.
-Makefile
-	- It's not of interest for those who aren't touching the build system.
-PCI/
-	- info related to PCI drivers.
-RCU/
-	- directory with info on RCU (read-copy update).
-SAK.txt
-	- info on Secure Attention Keys.
-SM501.txt
-	- Silicon Motion SM501 multimedia companion chip
-SubmittingPatches
-	- nothing here, just a pointer to process/coding-style.rst.
-accounting/
-	- documentation on accounting and taskstats.
-acpi/
-	- info on ACPI-specific hooks in the kernel.
-admin-guide/
-	- info related to Linux users and system admins.
-aoe/
-	- description of AoE (ATA over Ethernet) along with config examples.
-arm/
-	- directory with info about Linux on the ARM architecture.
-arm64/
-	- directory with info about Linux on the 64 bit ARM architecture.
-auxdisplay/
-	- misc. LCD driver documentation (cfag12864b, ks0108).
-backlight/
-	- directory with info on controlling backlights in flat panel displays
-block/
-	- info on the Block I/O (BIO) layer.
-blockdev/
-	- info on block devices & drivers
-bt8xxgpio.txt
-	- info on how to modify a bt8xx video card for GPIO usage.
-btmrvl.txt
-	- info on Marvell Bluetooth driver usage.
-bus-devices/
-	- directory with info on TI GPMC (General Purpose Memory Controller)
-bus-virt-phys-mapping.txt
-	- how to access I/O mapped memory from within device drivers.
-cdrom/
-	- directory with information on the CD-ROM drivers that Linux has.
-cgroup-v1/
-	- cgroups v1 features, including cpusets and memory controller.
-cma/
-	- Continuous Memory Area (CMA) debugfs interface.
-conf.py
-	- It's not of interest for those who aren't touching the build system.
-connector/
-	- docs on the netlink based userspace<->kernel space communication mod.
-console/
-	- documentation on Linux console drivers.
-core-api/
-	- documentation on kernel core components.
-cpu-freq/
-	- info on CPU frequency and voltage scaling.
-cpu-hotplug.txt
-	- document describing CPU hotplug support in the Linux kernel.
-cpu-load.txt
-	- document describing how CPU load statistics are collected.
-cpuidle/
-	- info on CPU_IDLE, CPU idle state management subsystem.
-cputopology.txt
-	- documentation on how CPU topology info is exported via sysfs.
-crc32.txt
-	- brief tutorial on CRC computation
-crypto/
-	- directory with info on the Crypto API.
-dcdbas.txt
-	- information on the Dell Systems Management Base Driver.
-debugging-modules.txt
-	- some notes on debugging modules after Linux 2.6.3.
-debugging-via-ohci1394.txt
-	- how to use firewire like a hardware debugger memory reader.
-dell_rbu.txt
-	- document demonstrating the use of the Dell Remote BIOS Update driver.
-dev-tools/
-	- directory with info on development tools for the kernel.
-device-mapper/
-	- directory with info on Device Mapper.
-dmaengine/
-	- the DMA engine and controller API guides.
-devicetree/
-	- directory with info on device tree files used by OF/PowerPC/ARM
-digsig.txt
-	-info on the Digital Signature Verification API
-dma-buf-sharing.txt
-	- the DMA Buffer Sharing API Guide
-docutils.conf
-	- nothing here. Just a configuration file for docutils.
-dontdiff
-	- file containing a list of files that should never be diff'ed.
-driver-api/
-	- the Linux driver implementer's API guide.
-driver-model/
-	- directory with info about Linux driver model.
-early-userspace/
-	- info about initramfs, klibc, and userspace early during boot.
-efi-stub.txt
-	- How to use the EFI boot stub to bypass GRUB or elilo on EFI systems.
-eisa.txt
-	- info on EISA bus support.
-extcon/
-	- directory with porting guide for Android kernel switch driver.
-isa.txt
-	- info on EISA bus support.
-fault-injection/
-	- dir with docs about the fault injection capabilities infrastructure.
-fb/
-	- directory with info on the frame buffer graphics abstraction layer.
-features/
-	- status of feature implementation on different architectures.
-filesystems/
-	- info on the vfs and the various filesystems that Linux supports.
-firmware_class/
-	- request_firmware() hotplug interface info.
-flexible-arrays.txt
-	- how to make use of flexible sized arrays in linux
-fmc/
-	- information about the FMC bus abstraction
-fpga/
-	- FPGA Manager Core.
-futex-requeue-pi.txt
-	- info on requeueing of tasks from a non-PI futex to a PI futex
-gcc-plugins.txt
-	- GCC plugin infrastructure.
-gpio/
-	- gpio related documentation
-gpu/
-	- directory with information on GPU driver developer's guide.
-hid/
-	- directory with information on human interface devices
-highuid.txt
-	- notes on the change from 16 bit to 32 bit user/group IDs.
-hwspinlock.txt
-	- hardware spinlock provides hardware assistance for synchronization
-timers/
-	- info on the timer related topics
-hw_random.txt
-	- info on Linux support for random number generator in i8xx chipsets.
-hwmon/
-	- directory with docs on various hardware monitoring drivers.
-i2c/
-	- directory with info about the I2C bus/protocol (2 wire, kHz speed).
-x86/i386/
-	- directory with info about Linux on Intel 32 bit architecture.
-ia64/
-	- directory with info about Linux on Intel 64 bit architecture.
-ide/
-	- Information regarding the Enhanced IDE drive.
-iio/
-	- info on industrial IIO configfs support.
-index.rst
-	- main index for the documentation at ReST format.
-infiniband/
-	- directory with documents concerning Linux InfiniBand support.
-input/
-	- info on Linux input device support.
-intel_txt.txt
-	- info on intel Trusted Execution Technology (intel TXT).
-io-mapping.txt
-	- description of io_mapping functions in linux/io-mapping.h
-io_ordering.txt
-	- info on ordering I/O writes to memory-mapped addresses.
-ioctl/
-	- directory with documents describing various IOCTL calls.
-iostats.txt
-	- info on I/O statistics Linux kernel provides.
-irqflags-tracing.txt
-	- how to use the irq-flags tracing feature.
-isapnp.txt
-	- info on Linux ISA Plug & Play support.
-isdn/
-	- directory with info on the Linux ISDN support, and supported cards.
-kbuild/
-	- directory with info about the kernel build process.
-kdump/
-	- directory with mini HowTo on getting the crash dump code to work.
-doc-guide/
-	- how to write and format reStructuredText kernel documentation
-kernel-per-CPU-kthreads.txt
-	- List of all per-CPU kthreads and how they introduce jitter.
-kobject.txt
-	- info of the kobject infrastructure of the Linux kernel.
-kprobes.txt
-	- documents the kernel probes debugging feature.
-kref.txt
-	- docs on adding reference counters (krefs) to kernel objects.
-laptops/
-	- directory with laptop related info and laptop driver documentation.
-ldm.txt
-	- a brief description of LDM (Windows Dynamic Disks).
-leds/
-	- directory with info about LED handling under Linux.
-livepatch/
-	- info on kernel live patching.
-locking/
-	- directory with info about kernel locking primitives
-lockup-watchdogs.txt
-	- info on soft and hard lockup detectors (aka nmi_watchdog).
-logo.gif
-	- full colour GIF image of Linux logo (penguin - Tux).
-logo.txt
-	- info on creator of above logo & site to get additional images from.
-lsm.txt
-	- Linux Security Modules: General Security Hooks for Linux
-lzo.txt
-	- kernel LZO decompressor input formats
-m68k/
-	- directory with info about Linux on Motorola 68k architecture.
-mailbox.txt
-	- How to write drivers for the common mailbox framework (IPC).
-md/
-	- directory with info about Linux Software RAID
-media/
-	- info on media drivers: uAPI, kAPI and driver documentation.
-memory-barriers.txt
-	- info on Linux kernel memory barriers.
-memory-devices/
-	- directory with info on parts like the Texas Instruments EMIF driver
-memory-hotplug.txt
-	- Hotpluggable memory support, how to use and current status.
-men-chameleon-bus.txt
-	- info on MEN chameleon bus.
-mic/
-	- Intel Many Integrated Core (MIC) architecture device driver.
-mips/
-	- directory with info about Linux on MIPS architecture.
-misc-devices/
-	- directory with info about devices using the misc dev subsystem
-mmc/
-	- directory with info about the MMC subsystem
-mtd/
-	- directory with info about memory technology devices (flash)
-namespaces/
-	- directory with various information about namespaces
-netlabel/
-	- directory with information on the NetLabel subsystem.
-networking/
-	- directory with info on various aspects of networking with Linux.
-nfc/
-	- directory relating info about Near Field Communications support.
-nios2/
-	- Linux on the Nios II architecture.
-nommu-mmap.txt
-	- documentation about no-mmu memory mapping support.
-numastat.txt
-	- info on how to read Numa policy hit/miss statistics in sysfs.
-ntb.txt
-	- info on Non-Transparent Bridge (NTB) drivers.
-nvdimm/
-	- info on non-volatile devices.
-nvmem/
-	- info on non volatile memory framework.
-output/
-	- default directory where html/LaTeX/pdf files will be written.
-padata.txt
-	- An introduction to the "padata" parallel execution API
-parisc/
-	- directory with info on using Linux on PA-RISC architecture.
-parport-lowlevel.txt
-	- description and usage of the low level parallel port functions.
-pcmcia/
-	- info on the Linux PCMCIA driver.
-percpu-rw-semaphore.txt
-	- RCU based read-write semaphore optimized for locking for reading
-perf/
-	- info about the APM X-Gene SoC Performance Monitoring Unit (PMU).
-phy/
-	- ino on Samsung USB 2.0 PHY adaptation layer.
-phy.txt
-	- Description of the generic PHY framework.
-pi-futex.txt
-	- documentation on lightweight priority inheritance futexes.
-pinctrl.txt
-	- info on pinctrl subsystem and the PINMUX/PINCONF and drivers
-platform/
-	- List of supported hardware by compal and Dell laptop.
-pnp.txt
-	- Linux Plug and Play documentation.
-power/
-	- directory with info on Linux PCI power management.
-powerpc/
-	- directory with info on using Linux with the PowerPC.
-prctl/
-	- directory with info on the priveledge control subsystem
-preempt-locking.txt
-	- info on locking under a preemptive kernel.
-process/
-	- how to work with the mainline kernel development process.
-pps/
-	- directory with information on the pulse-per-second support
-pti/
-	- directory with info on Intel MID PTI.
-ptp/
-	- directory with info on support for IEEE 1588 PTP clocks in Linux.
-pwm.txt
-	- info on the pulse width modulation driver subsystem
-rapidio/
-	- directory with info on RapidIO packet-based fabric interconnect
-rbtree.txt
-	- info on what red-black trees are and what they are for.
-remoteproc.txt
-	- info on how to handle remote processor (e.g. AMP) offloads/usage.
-rfkill.txt
-	- info on the radio frequency kill switch subsystem/support.
-robust-futex-ABI.txt
-	- documentation of the robust futex ABI.
-robust-futexes.txt
-	- a description of what robust futexes are.
-rpmsg.txt
-	- info on the Remote Processor Messaging (rpmsg) Framework
-rtc.txt
-	- notes on how to use the Real Time Clock (aka CMOS clock) driver.
-s390/
-	- directory with info on using Linux on the IBM S390.
-scheduler/
-	- directory with info on the scheduler.
-scsi/
-	- directory with info on Linux scsi support.
-security/
-	- directory that contains security-related info
-serial/
-	- directory with info on the low level serial API.
-sgi-ioc4.txt
-	- description of the SGI IOC4 PCI (multi function) device.
-sh/
-	- directory with info on porting Linux to a new architecture.
-smsc_ece1099.txt
-	-info on the smsc Keyboard Scan Expansion/GPIO Expansion device.
-sound/
-	- directory with info on sound card support.
-spi/
-	- overview of Linux kernel Serial Peripheral Interface (SPI) support.
-sphinx/
-	- no documentation here, just files required by Sphinx toolchain.
-sphinx-static/
-	- no documentation here, just files required by Sphinx toolchain.
-static-keys.txt
-	- info on how static keys allow debug code in hotpaths via patching
-svga.txt
-	- short guide on selecting video modes at boot via VGA BIOS.
-sync_file.txt
-	- Sync file API guide.
-sysctl/
-	- directory with info on the /proc/sys/* files.
-target/
-	- directory with info on generating TCM v4 fabric .ko modules
-tee.txt
-	- info on the TEE subsystem and drivers
-this_cpu_ops.txt
-	- List rationale behind and the way to use this_cpu operations.
-thermal/
-	- directory with information on managing thermal issues (CPU/temp)
-trace/
-	- directory with info on tracing technologies within linux
-translations/
-	- translations of this document from English to another language
-unaligned-memory-access.txt
-	- info on how to avoid arch breaking unaligned memory access in code.
-unshare.txt
-	- description of the Linux unshare system call.
-usb/
-	- directory with info regarding the Universal Serial Bus.
-vfio.txt
-	- info on Virtual Function I/O used in guest/hypervisor instances.
-video-output.txt
-	- sysfs class driver interface to enable/disable a video output device.
-virtual/
-	- directory with information on the various linux virtualizations.
-vm/
-	- directory with info on the Linux vm code.
-w1/
-	- directory with documents regarding the 1-wire (w1) subsystem.
-watchdog/
-	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
-wimax/
-	- directory with info about Intel Wireless Wimax Connections
-core-api/workqueue.rst
-	- information on the Concurrency Managed Workqueue implementation
-x86/x86_64/
-	- directory with info on Linux support for AMD x86-64 (Hammer) machines.
-xillybus.txt
-	- Overview and basic ui of xillybus driver
-xtensa/
-	- directory with documents relating to arch/xtensa port/implementation
-xz.txt
-	- how to make use of the XZ data compression within linux kernel
-zorro.txt
-	- info on writing drivers for Zorro bus devices found on Amigas.
diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
deleted file mode 100644
index 206b1d5..0000000
--- a/Documentation/PCI/00-INDEX
+++ /dev/null
@@ -1,26 +0,0 @@
-00-INDEX
-	- this file
-acpi-info.txt
-	- info on how PCI host bridges are represented in ACPI
-MSI-HOWTO.txt
-	- the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
-PCIEBUS-HOWTO.txt
-	- a guide describing the PCI Express Port Bus driver
-pci-error-recovery.txt
-	- info on PCI error recovery
-pci-iov-howto.txt
-	- the PCI Express I/O Virtualization HOWTO
-pci.txt
-	- info on the PCI subsystem for device driver authors
-pcieaer-howto.txt
-	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
-endpoint/pci-endpoint.txt
-	- guide to add endpoint controller driver and endpoint function driver.
-endpoint/pci-endpoint-cfs.txt
-	- guide to use configfs to configure the PCI endpoint function.
-endpoint/pci-test-function.txt
-	- specification of *PCI test* function device.
-endpoint/pci-test-howto.txt
-	- userguide for PCI endpoint test function.
-endpoint/function/binding/
-	- binding documentation for PCI endpoint function
diff --git a/Documentation/RCU/00-INDEX b/Documentation/RCU/00-INDEX
deleted file mode 100644
index f46980c..0000000
--- a/Documentation/RCU/00-INDEX
+++ /dev/null
@@ -1,34 +0,0 @@
-00-INDEX
-	- This file
-arrayRCU.txt
-	- Using RCU to Protect Read-Mostly Arrays
-checklist.txt
-	- Review Checklist for RCU Patches
-listRCU.txt
-	- Using RCU to Protect Read-Mostly Linked Lists
-lockdep.txt
-	- RCU and lockdep checking
-lockdep-splat.txt
-	- RCU Lockdep splats explained.
-NMI-RCU.txt
-	- Using RCU to Protect Dynamic NMI Handlers
-rcu_dereference.txt
-	- Proper care and feeding of return values from rcu_dereference()
-rcubarrier.txt
-	- RCU and Unloadable Modules
-rculist_nulls.txt
-	- RCU list primitives for use with SLAB_TYPESAFE_BY_RCU
-rcuref.txt
-	- Reference-count design for elements of lists/arrays protected by RCU
-rcu.txt
-	- RCU Concepts
-RTFP.txt
-	- List of RCU papers (bibliography) going back to 1980.
-stallwarn.txt
-	- RCU CPU stall warnings (module parameter rcu_cpu_stall_suppress)
-torture.txt
-	- RCU Torture Test Operation (CONFIG_RCU_TORTURE_TEST)
-UP.txt
-	- RCU on Uniprocessor Systems
-whatisRCU.txt
-	- What is RCU?
diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.txt
index 7d4ae11..721b3e4 100644
--- a/Documentation/RCU/rcu.txt
+++ b/Documentation/RCU/rcu.txt
@@ -87,7 +87,3 @@ o	Where can I find more information on RCU?
 
 	See the RTFP.txt file in this directory.
 	Or point your browser at http://www.rdrop.com/users/paulmck/RCU/.
-
-o	What are all these files in this directory?
-
-	See 00-INDEX for the list.
diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 15ea785..0797eec 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -51,8 +51,7 @@ Documentation
 
  - There are various README files in the Documentation/ subdirectory:
    these typically contain kernel-specific installation notes for some
-   drivers for example. See Documentation/00-INDEX for a list of what
-   is contained in each file.  Please read the
+   drivers for example. Please read the
    :ref:`Documentation/process/changes.rst <changes>` file, as it
    contains information about the problems, which may result by upgrading
    your kernel.
diff --git a/Documentation/arm/00-INDEX b/Documentation/arm/00-INDEX
deleted file mode 100644
index b6e69fd..0000000
--- a/Documentation/arm/00-INDEX
+++ /dev/null
@@ -1,50 +0,0 @@
-00-INDEX
-	- this file
-Booting
-	- requirements for booting
-CCN.txt
-	- Cache Coherent Network ring-bus and perf PMU driver.
-Interrupts
-	- ARM Interrupt subsystem documentation
-IXP4xx
-	- Intel IXP4xx Network processor.
-Netwinder
-	- Netwinder specific documentation
-Porting
-       - Symbol definitions for porting Linux to a new ARM machine.
-Setup
-       - Kernel initialization parameters on ARM Linux
-README
-	- General ARM documentation
-SA1100/
-	- SA1100 documentation
-Samsung-S3C24XX/
-	- S3C24XX ARM Linux Overview
-SPEAr/
-	- ST SPEAr platform Linux Overview
-VFP/
-	- Release notes for Linux Kernel Vector Floating Point support code
-cluster-pm-race-avoidance.txt
-	- Algorithm for CPU and Cluster setup/teardown
-empeg/
-	- Ltd's Empeg MP3 Car Audio Player
-firmware.txt
-	- Secure firmware registration and calling.
-kernel_mode_neon.txt
-	- How to use NEON instructions in kernel mode
-kernel_user_helpers.txt
-	- Helper functions in kernel space made available for userspace.
-mem_alignment
-	- alignment abort handler documentation
-memory.txt
-	- description of the virtual memory layout
-nwfpe/
-	- NWFPE floating point emulator documentation
-swp_emulation
-	- SWP/SWPB emulation handler/logging description
-tcm.txt
-	- ARM Tightly Coupled Memory
-uefi.txt
-	- [U]EFI configuration and runtime services documentation
-vlocks.txt
-	- Voting locks, low-level mechanism relying on memory system atomic writes.
diff --git a/Documentation/block/00-INDEX b/Documentation/block/00-INDEX
deleted file mode 100644
index 8d55b4b..0000000
--- a/Documentation/block/00-INDEX
+++ /dev/null
@@ -1,34 +0,0 @@
-00-INDEX
-	- This file
-bfq-iosched.txt
-	- BFQ IO scheduler and its tunables
-biodoc.txt
-	- Notes on the Generic Block Layer Rewrite in Linux 2.5
-biovecs.txt
-	- Immutable biovecs and biovec iterators
-capability.txt
-	- Generic Block Device Capability (/sys/block/<device>/capability)
-cfq-iosched.txt
-	- CFQ IO scheduler tunables
-cmdline-partition.txt
-	- how to specify block device partitions on kernel command line
-data-integrity.txt
-	- Block data integrity
-deadline-iosched.txt
-	- Deadline IO scheduler tunables
-ioprio.txt
-	- Block io priorities (in CFQ scheduler)
-pr.txt
-	- Block layer support for Persistent Reservations
-null_blk.txt
-	- Null block for block-layer benchmarking.
-queue-sysfs.txt
-	- Queue's sysfs entries
-request.txt
-	- The members of struct request (in include/linux/blkdev.h)
-stat.txt
-	- Block layer statistics in /sys/block/<device>/stat
-switching-sched.txt
-	- Switching I/O schedulers at runtime
-writeback_cache_control.txt
-	- Control of volatile write back caches
diff --git a/Documentation/blockdev/00-INDEX b/Documentation/blockdev/00-INDEX
deleted file mode 100644
index c08df56..0000000
--- a/Documentation/blockdev/00-INDEX
+++ /dev/null
@@ -1,18 +0,0 @@
-00-INDEX
-	- this file
-README.DAC960
-	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux.
-cciss.txt
-	- info, major/minor #'s for Compaq's SMART Array Controllers.
-cpqarray.txt
-	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
-floppy.txt
-	- notes and driver options for the floppy disk driver.
-mflash.txt
-	- info on mGine m(g)flash driver for linux.
-nbd.txt
-	- info on a TCP implementation of a network block device.
-paride.txt
-	- information about the parallel port IDE subsystem.
-ramdisk.txt
-	- short guide on how to set up and use the RAM disk.
diff --git a/Documentation/cdrom/00-INDEX b/Documentation/cdrom/00-INDEX
deleted file mode 100644
index 433edf2..0000000
--- a/Documentation/cdrom/00-INDEX
+++ /dev/null
@@ -1,11 +0,0 @@
-00-INDEX
-	- this file (info on CD-ROMs and Linux)
-Makefile
-	- only used to generate TeX output from the documentation.
-cdrom-standard.tex
-	- LaTeX document on standardizing the CD-ROM programming interface.
-ide-cd
-	- info on setting up and using ATAPI (aka IDE) CD-ROMs.
-packet-writing.txt
-	- Info on the CDRW packet writing module
-
diff --git a/Documentation/cgroup-v1/00-INDEX b/Documentation/cgroup-v1/00-INDEX
deleted file mode 100644
index 13e0c85..0000000
--- a/Documentation/cgroup-v1/00-INDEX
+++ /dev/null
@@ -1,26 +0,0 @@
-00-INDEX
-	- this file
-blkio-controller.txt
-	- Description for Block IO Controller, implementation and usage details.
-cgroups.txt
-	- Control Groups definition, implementation details, examples and API.
-cpuacct.txt
-	- CPU Accounting Controller; account CPU usage for groups of tasks.
-cpusets.txt
-	- documents the cpusets feature; assign CPUs and Mem to a set of tasks.
-admin-guide/devices.rst
-	- Device Whitelist Controller; description, interface and security.
-freezer-subsystem.txt
-	- checkpointing; rationale to not use signals, interface.
-hugetlb.txt
-	- HugeTLB Controller implementation and usage details.
-memcg_test.txt
-	- Memory Resource Controller; implementation details.
-memory.txt
-	- Memory Resource Controller; design, accounting, interface, testing.
-net_cls.txt
-	- Network classifier cgroups details and usages.
-net_prio.txt
-	- Network priority cgroups details and usages.
-pids.txt
-	- Process number cgroups details and usages.
diff --git a/Documentation/devicetree/00-INDEX b/Documentation/devicetree/00-INDEX
deleted file mode 100644
index 8c4102c..0000000
--- a/Documentation/devicetree/00-INDEX
+++ /dev/null
@@ -1,12 +0,0 @@
-Documentation for device trees, a data structure by which bootloaders pass
-hardware layout to Linux in a device-independent manner, simplifying hardware
-probing.  This subsystem is maintained by Grant Likely
-<grant.likely@secretlab.ca> and has a mailing list at
-https://lists.ozlabs.org/listinfo/devicetree-discuss
-
-00-INDEX
-	- this file
-booting-without-of.txt
-	- Booting Linux without Open Firmware, describes history and format of device trees.
-usage-model.txt
-	- How Linux uses DT and what DT aims to solve.
\ No newline at end of file
diff --git a/Documentation/fb/00-INDEX b/Documentation/fb/00-INDEX
deleted file mode 100644
index fe85e7c..0000000
--- a/Documentation/fb/00-INDEX
+++ /dev/null
@@ -1,75 +0,0 @@
-Index of files in Documentation/fb.  If you think something about frame
-buffer devices needs an entry here, needs correction or you've written one
-please mail me.
-				    Geert Uytterhoeven <geert@linux-m68k.org>
-
-00-INDEX
-	- this file.
-api.txt
-	- The frame buffer API between applications and buffer devices.
-arkfb.txt
-	- info on the fbdev driver for ARK Logic chips.
-aty128fb.txt
-	- info on the ATI Rage128 frame buffer driver.
-cirrusfb.txt
-	- info on the driver for Cirrus Logic chipsets.
-cmap_xfbdev.txt
-	- an introduction to fbdev's cmap structures.
-deferred_io.txt
-	- an introduction to deferred IO.
-efifb.txt
-	- info on the EFI platform driver for Intel based Apple computers.
-ep93xx-fb.txt
-	- info on the driver for EP93xx LCD controller.
-fbcon.txt
-	- intro to and usage guide for the framebuffer console (fbcon).
-framebuffer.txt
-	- introduction to frame buffer devices.
-gxfb.txt
-	- info on the framebuffer driver for AMD Geode GX2 based processors.
-intel810.txt
-	- documentation for the Intel 810/815 framebuffer driver.
-intelfb.txt
-	- docs for Intel 830M/845G/852GM/855GM/865G/915G/945G fb driver.
-internals.txt
-	- quick overview of frame buffer device internals.
-lxfb.txt
-	- info on the framebuffer driver for AMD Geode LX based processors.
-matroxfb.txt
-	- info on the Matrox framebuffer driver for Alpha, Intel and PPC.
-metronomefb.txt
-	- info on the driver for the Metronome display controller.
-modedb.txt
-	- info on the video mode database.
-pvr2fb.txt
-	- info on the PowerVR 2 frame buffer driver.
-pxafb.txt
-	- info on the driver for the PXA25x LCD controller.
-s3fb.txt
-	- info on the fbdev driver for S3 Trio/Virge chips.
-sa1100fb.txt
-	- information about the driver for the SA-1100 LCD controller.
-sh7760fb.txt
-	- info on the SH7760/SH7763 integrated LCDC Framebuffer driver.
-sisfb.txt
-	- info on the framebuffer device driver for various SiS chips.
-sm501.txt
-	- info on the framebuffer device driver for sm501 videoframebuffer.
-sstfb.txt
-	- info on the frame buffer driver for 3dfx' Voodoo Graphics boards.
-tgafb.txt
-	- info on the TGA (DECChip 21030) frame buffer driver.
-tridentfb.txt
-	info on the framebuffer driver for some Trident chip based cards.
-udlfb.txt
-	- Driver for DisplayLink USB 2.0 chips.
-uvesafb.txt
-	- info on the userspace VESA (VBE2+ compliant) frame buffer device.
-vesafb.txt
-	- info on the VESA frame buffer device.
-viafb.modes
-	- list of modes for VIA Integration Graphic Chip.
-viafb.txt
-	- info on the VIA Integration Graphic Chip console framebuffer driver.
-vt8623fb.txt
-	- info on the fb driver for the graphics core in VIA VT8623 chipsets.
diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
deleted file mode 100644
index 0937bad..0000000
--- a/Documentation/filesystems/00-INDEX
+++ /dev/null
@@ -1,153 +0,0 @@
-00-INDEX
-	- this file (info on some of the filesystems supported by linux).
-Locking
-	- info on locking rules as they pertain to Linux VFS.
-9p.txt
-	- 9p (v9fs) is an implementation of the Plan 9 remote fs protocol.
-adfs.txt
-	- info and mount options for the Acorn Advanced Disc Filing System.
-afs.txt
-	- info and examples for the distributed AFS (Andrew File System) fs.
-affs.txt
-	- info and mount options for the Amiga Fast File System.
-autofs-mount-control.txt
-	- info on device control operations for autofs module.
-automount-support.txt
-	- information about filesystem automount support.
-befs.txt
-	- information about the BeOS filesystem for Linux.
-bfs.txt
-	- info for the SCO UnixWare Boot Filesystem (BFS).
-btrfs.txt
-	- info for the BTRFS filesystem.
-caching/
-	- directory containing filesystem cache documentation.
-ceph.txt
-	- info for the Ceph Distributed File System.
-cifs/
-	- directory containing CIFS filesystem documentation and example code.
-coda.txt
-	- description of the CODA filesystem.
-configfs/
-	- directory containing configfs documentation and example code.
-cramfs.txt
-	- info on the cram filesystem for small storage (ROMs etc).
-dax.txt
-	- info on avoiding the page cache for files stored on CPU-addressable
-	  storage devices.
-debugfs.txt
-	- info on the debugfs filesystem.
-devpts.txt
-	- info on the devpts filesystem.
-directory-locking
-	- info about the locking scheme used for directory operations.
-dlmfs.txt
-	- info on the userspace interface to the OCFS2 DLM.
-dnotify.txt
-	- info about directory notification in Linux.
-dnotify_test.c
-	- example program for dnotify.
-ecryptfs.txt
-	- docs on eCryptfs: stacked cryptographic filesystem for Linux.
-efivarfs.txt
-	- info for the efivarfs filesystem.
-exofs.txt
-	- info, usage, mount options, design about EXOFS.
-ext2.txt
-	- info, mount options and specifications for the Ext2 filesystem.
-ext3.txt
-	- info, mount options and specifications for the Ext3 filesystem.
-ext4.txt
-	- info, mount options and specifications for the Ext4 filesystem.
-f2fs.txt
-	- info and mount options for the F2FS filesystem.
-fiemap.txt
-	- info on fiemap ioctl.
-files.txt
-	- info on file management in the Linux kernel.
-fuse.txt
-	- info on the Filesystem in User SpacE including mount options.
-gfs2-glocks.txt
-	- info on the Global File System 2 - Glock internal locking rules.
-gfs2-uevents.txt
-	- info on the Global File System 2 - uevents.
-gfs2.txt
-	- info on the Global File System 2.
-hfs.txt
-	- info on the Macintosh HFS Filesystem for Linux.
-hfsplus.txt
-	- info on the Macintosh HFSPlus Filesystem for Linux.
-hpfs.txt
-	- info and mount options for the OS/2 HPFS.
-inotify.txt
-	- info on the powerful yet simple file change notification system.
-isofs.txt
-	- info and mount options for the ISO 9660 (CDROM) filesystem.
-jfs.txt
-	- info and mount options for the JFS filesystem.
-locks.txt
-	- info on file locking implementations, flock() vs. fcntl(), etc.
-mandatory-locking.txt
-	- info on the Linux implementation of Sys V mandatory file locking.
-nfs/
-	- nfs-related documentation.
-nilfs2.txt
-	- info and mount options for the NILFS2 filesystem.
-ntfs.txt
-	- info and mount options for the NTFS filesystem (Windows NT).
-ocfs2.txt
-	- info and mount options for the OCFS2 clustered filesystem.
-omfs.txt
-	- info on the Optimized MPEG FileSystem.
-path-lookup.txt
-	- info on path walking and name lookup locking.
-pohmelfs/
-	- directory containing pohmelfs filesystem documentation.
-porting
-	- various information on filesystem porting.
-proc.txt
-	- info on Linux's /proc filesystem.
-qnx6.txt
-	- info on the QNX6 filesystem.
-quota.txt
-	- info on Quota subsystem.
-ramfs-rootfs-initramfs.txt
-	- info on the 'in memory' filesystems ramfs, rootfs and initramfs.
-relay.txt
-	- info on relay, for efficient streaming from kernel to user space.
-romfs.txt
-	- description of the ROMFS filesystem.
-seq_file.txt
-	- how to use the seq_file API.
-sharedsubtree.txt
-	- a description of shared subtrees for namespaces.
-spufs.txt
-	- info and mount options for the SPU filesystem used on Cell.
-squashfs.txt
-	- info on the squashfs filesystem.
-sysfs-pci.txt
-	- info on accessing PCI device resources through sysfs.
-sysfs-tagging.txt
-	- info on sysfs tagging to avoid duplicates.
-sysfs.txt
-	- info on sysfs, a ram-based filesystem for exporting kernel objects.
-sysv-fs.txt
-	- info on the SystemV/V7/Xenix/Coherent filesystem.
-tmpfs.txt
-	- info on tmpfs, a filesystem that holds all files in virtual memory.
-ubifs.txt
-	- info on the Unsorted Block Images FileSystem.
-udf.txt
-	- info and mount options for the UDF filesystem.
-ufs.txt
-	- info on the ufs filesystem.
-vfat.txt
-	- info on using the VFAT filesystem used in Windows NT and Windows 95.
-vfs.txt
-	- overview of the Virtual File System.
-xfs-delayed-logging-design.txt
-	- info on the XFS Delayed Logging Design.
-xfs-self-describing-metadata.txt
-	- info on XFS Self Describing Metadata.
-xfs.txt
-	- info and mount options for the XFS filesystem.
diff --git a/Documentation/filesystems/nfs/00-INDEX b/Documentation/filesystems/nfs/00-INDEX
deleted file mode 100644
index 53f3b59..0000000
--- a/Documentation/filesystems/nfs/00-INDEX
+++ /dev/null
@@ -1,26 +0,0 @@
-00-INDEX
-	- this file (nfs-related documentation).
-Exporting
-	- explanation of how to make filesystems exportable.
-fault_injection.txt
-	- information for using fault injection on the server
-knfsd-stats.txt
-	- statistics which the NFS server makes available to user space.
-nfs.txt
-	- nfs client, and DNS resolution for fs_locations.
-nfs41-server.txt
-	- info on the Linux server implementation of NFSv4 minor version 1.
-nfs-rdma.txt
-	- how to install and setup the Linux NFS/RDMA client and server software
-nfsd-admin-interfaces.txt
-	- Administrative interfaces for nfsd.
-nfsroot.txt
-	- short guide on setting up a diskless box with NFS root filesystem.
-pnfs.txt
-	- short explanation of some of the internals of the pnfs client code
-rpc-cache.txt
-	- introduction to the caching mechanisms in the sunrpc layer.
-idmapper.txt
-	- information for configuring request-keys to be used by idmapper
-rpc-server-gss.txt
-	- Information on GSS authentication support in the NFS Server
diff --git a/Documentation/fmc/00-INDEX b/Documentation/fmc/00-INDEX
deleted file mode 100644
index 431c695..0000000
--- a/Documentation/fmc/00-INDEX
+++ /dev/null
@@ -1,38 +0,0 @@
-
-Documentation in this directory comes from sections of the manual we
-wrote for the externally-developed fmc-bus package. The complete
-manual as of today (2013-02) is available in PDF format at
-http://www.ohwr.org/projects/fmc-bus/files
-
-00-INDEX
-	- this file.
-
-FMC-and-SDB.txt
-	- What are FMC and SDB, basic concepts for this framework
-
-API.txt
-	- The functions that are exported by the bus driver
-
-parameters.txt
-	- The module parameters
-
-carrier.txt
-	- writing a carrier (a device)
-
-mezzanine.txt
-	- writing code for your mezzanine (a driver)
-
-identifiers.txt
-	- how identification and matching works
-
-fmc-fakedev.txt
-	- about drivers/fmc/fmc-fakedev.ko
-
-fmc-trivial.txt
-	- about drivers/fmc/fmc-trivial.ko
-
-fmc-write-eeprom.txt
-	- about drivers/fmc/fmc-write-eeprom.ko
-
-fmc-chardev.txt
-	- about drivers/fmc/fmc-chardev.ko
diff --git a/Documentation/gpio/00-INDEX b/Documentation/gpio/00-INDEX
deleted file mode 100644
index 17e19a6..0000000
--- a/Documentation/gpio/00-INDEX
+++ /dev/null
@@ -1,4 +0,0 @@
-00-INDEX
-	- This file
-sysfs.txt
-	- Information about the GPIO sysfs interface
diff --git a/Documentation/ide/00-INDEX b/Documentation/ide/00-INDEX
deleted file mode 100644
index 22f98ca..0000000
--- a/Documentation/ide/00-INDEX
+++ /dev/null
@@ -1,14 +0,0 @@
-00-INDEX
-    	- this file
-ChangeLog.ide-cd.1994-2004
-	- ide-cd changelog
-ChangeLog.ide-floppy.1996-2002
-	- ide-floppy changelog
-ChangeLog.ide-tape.1995-2002
-	- ide-tape changelog
-ide-tape.txt
-	- info on the IDE ATAPI streaming tape driver
-ide.txt
-	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS).
-warm-plug-howto.txt
-	- using sysfs to remove and add IDE devices.
\ No newline at end of file
diff --git a/Documentation/ioctl/00-INDEX b/Documentation/ioctl/00-INDEX
deleted file mode 100644
index c1a9257..0000000
--- a/Documentation/ioctl/00-INDEX
+++ /dev/null
@@ -1,12 +0,0 @@
-00-INDEX
-	- this file
-botching-up-ioctls.txt
-	- how to avoid botching up ioctls
-cdrom.txt
-	- summary of CDROM ioctl calls
-hdio.txt
-	- summary of HDIO_ ioctl calls
-ioctl-decoding.txt
-	- how to decode the bits of an IOCTL code
-ioctl-number.txt
-	- how to implement and register device/driver ioctl calls
diff --git a/Documentation/isdn/00-INDEX b/Documentation/isdn/00-INDEX
deleted file mode 100644
index 2d1889b..0000000
--- a/Documentation/isdn/00-INDEX
+++ /dev/null
@@ -1,42 +0,0 @@
-00-INDEX
-	- this file (info on ISDN implementation for Linux)
-CREDITS
-	- list of the kind folks that brought you this stuff.
-HiSax.cert
-	- information about the ITU approval certification of the HiSax driver.
-INTERFACE
-	- description of isdn4linux Link Level and Hardware Level interfaces.
-INTERFACE.fax
-	- description of the fax subinterface of isdn4linux.
-INTERFACE.CAPI
-	- description of kernel CAPI Link Level to Hardware Level interface.
-README
-	- general info on what you need and what to do for Linux ISDN.
-README.FAQ
-	- general info for FAQ.
-README.HiSax
-	- info on the HiSax driver which replaces the old teles.
-README.audio
-	- info for running audio over ISDN.
-README.avmb1
-	- info on driver for AVM-B1 ISDN card.
-README.concap
-	- info on "CONCAP" encapsulation protocol interface used for X.25.
-README.diversion
-	- info on module for isdn diversion services.
-README.fax
-	- info for using Fax over ISDN.
-README.gigaset
-	- info on the drivers for Siemens Gigaset ISDN adapters
-README.hfc-pci
-	- info on hfc-pci based cards.
-README.hysdn
-        - info on driver for Hypercope active HYSDN cards
-README.mISDN
-	- info on the Modular ISDN subsystem (mISDN)
-README.syncppp
-	- info on running Sync PPP over ISDN.
-README.x25
-	- info for running X.25 over ISDN.
-syncPPP.FAQ
-	- frequently asked questions about running PPP over ISDN.
diff --git a/Documentation/kbuild/00-INDEX b/Documentation/kbuild/00-INDEX
deleted file mode 100644
index 8c5e6aa..0000000
--- a/Documentation/kbuild/00-INDEX
+++ /dev/null
@@ -1,14 +0,0 @@
-00-INDEX
-	- this file: info on the kernel build process
-headers_install.txt
-	- how to export Linux headers for use by userspace
-kbuild.txt
-	- developer information on kbuild
-kconfig.txt
-	- usage help for make *config
-kconfig-language.txt
-	- specification of Config Language, the language in Kconfig files
-makefiles.txt
-	- developer information for linux kernel makefiles
-modules.txt
-	- how to build modules and to install them
diff --git a/Documentation/laptops/00-INDEX b/Documentation/laptops/00-INDEX
deleted file mode 100644
index 86169dc..0000000
--- a/Documentation/laptops/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- This file
-asus-laptop.txt
-	- information on the Asus Laptop Extras driver.
-disk-shock-protection.txt
-	- information on hard disk shock protection.
-laptop-mode.txt
-	- how to conserve battery power using laptop-mode.
-sony-laptop.txt
-	- Sony Notebook Control Driver (SNC) Readme.
-sonypi.txt
-	- info on Linux Sony Programmable I/O Device support.
-thinkpad-acpi.txt
-	- information on the (IBM and Lenovo) ThinkPad ACPI Extras driver.
-toshiba_haps.txt
-	- information on the Toshiba HDD Active Protection Sensor driver.
diff --git a/Documentation/leds/00-INDEX b/Documentation/leds/00-INDEX
deleted file mode 100644
index ae626b2..0000000
--- a/Documentation/leds/00-INDEX
+++ /dev/null
@@ -1,32 +0,0 @@
-00-INDEX
-	- This file
-leds-blinkm.txt
-	- Driver for BlinkM LED-devices.
-leds-class.txt
-	- documents LED handling under Linux.
-leds-class-flash.txt
-	- documents flash LED handling under Linux.
-leds-lm3556.txt
-	- notes on how to use the leds-lm3556 driver.
-leds-lp3944.txt
-	- notes on how to use the leds-lp3944 driver.
-leds-lp5521.txt
-	- notes on how to use the leds-lp5521 driver.
-leds-lp5523.txt
-	- notes on how to use the leds-lp5523 driver.
-leds-lp5562.txt
-	- notes on how to use the leds-lp5562 driver.
-leds-lp55xx.txt
-	- description about lp55xx common driver.
-leds-lm3556.txt
-	- notes on how to use the leds-lm3556 driver.
-leds-mlxcpld.txt
-	- notes on how to use the leds-mlxcpld driver.
-ledtrig-oneshot.txt
-	- One-shot LED trigger for both sporadic and dense events.
-ledtrig-transient.txt
-	- LED Transient Trigger, one shot timer activation.
-ledtrig-usbport.txt
-	- notes on how to use the drivers/usb/core/ledtrig-usbport.c trigger.
-uleds.txt
-	- notes on how to use the uleds driver.
diff --git a/Documentation/locking/00-INDEX b/Documentation/locking/00-INDEX
deleted file mode 100644
index c256c9b..0000000
--- a/Documentation/locking/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- this file.
-lockdep-design.txt
-	- documentation on the runtime locking correctness validator.
-lockstat.txt
-	- info on collecting statistics on locks (and contention).
-mutex-design.txt
-	- info on the generic mutex subsystem.
-rt-mutex-design.txt
-	- description of the RealTime mutex implementation design.
-rt-mutex.txt
-	- desc. of RT-mutex subsystem with PI (Priority Inheritance) support.
-spinlocks.txt
-	- info on using spinlocks to provide exclusive access in kernel.
-ww-mutex-design.txt
-	- Intro to Mutex wait/would deadlock handling.s
diff --git a/Documentation/m68k/00-INDEX b/Documentation/m68k/00-INDEX
deleted file mode 100644
index 2be8c6b..0000000
--- a/Documentation/m68k/00-INDEX
+++ /dev/null
@@ -1,7 +0,0 @@
-00-INDEX
-	- this file
-README.buddha
-	- Amiga Buddha and Catweasel IDE Driver
-kernel-options.txt
-	- command line options for Linux/m68k
-
diff --git a/Documentation/mips/00-INDEX b/Documentation/mips/00-INDEX
deleted file mode 100644
index 8ae9cff..0000000
--- a/Documentation/mips/00-INDEX
+++ /dev/null
@@ -1,4 +0,0 @@
-00-INDEX
-	- this file.
-AU1xxx_IDE.README
-	- README for MIPS AU1XXX IDE driver.
diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
deleted file mode 100644
index 4623bc0..0000000
--- a/Documentation/mmc/00-INDEX
+++ /dev/null
@@ -1,10 +0,0 @@
-00-INDEX
-        - this file
-mmc-dev-attrs.txt
-        - info on SD and MMC device attributes
-mmc-dev-parts.txt
-        - info on SD and MMC device partitions
-mmc-async-req.txt
-        - info on mmc asynchronous requests
-mmc-tools.txt
-	- info on mmc-utils tools
diff --git a/Documentation/netlabel/00-INDEX b/Documentation/netlabel/00-INDEX
deleted file mode 100644
index 837bf35..0000000
--- a/Documentation/netlabel/00-INDEX
+++ /dev/null
@@ -1,10 +0,0 @@
-00-INDEX
-	- this file.
-cipso_ipv4.txt
-	- documentation on the IPv4 CIPSO protocol engine.
-draft-ietf-cipso-ipsecurity-01.txt
-	- IETF draft of the CIPSO protocol, dated 16 July 1992.
-introduction.txt
-	- NetLabel introduction, READ THIS FIRST.
-lsm_interface.txt
-	- documentation on the NetLabel kernel security module API.
diff --git a/Documentation/netlabel/cipso_ipv4.txt b/Documentation/netlabel/cipso_ipv4.txt
index 93dacb1..a607548 100644
--- a/Documentation/netlabel/cipso_ipv4.txt
+++ b/Documentation/netlabel/cipso_ipv4.txt
@@ -6,11 +6,12 @@ May 17, 2006
 
  * Overview
 
-The NetLabel CIPSO/IPv4 protocol engine is based on the IETF Commercial IP
-Security Option (CIPSO) draft from July 16, 1992.  A copy of this draft can be
-found in this directory, consult '00-INDEX' for the filename.  While the IETF
-draft never made it to an RFC standard it has become a de-facto standard for
-labeled networking and is used in many trusted operating systems.
+The NetLabel CIPSO/IPv4 protocol engine is based on the IETF Commercial
+IP Security Option (CIPSO) draft from July 16, 1992.  A copy of this
+draft can be found in this directory
+(draft-ietf-cipso-ipsecurity-01.txt).  While the IETF draft never made
+it to an RFC standard it has become a de-facto standard for labeled
+networking and is used in many trusted operating systems.
 
  * Outbound Packet Processing
 
diff --git a/Documentation/netlabel/introduction.txt b/Documentation/netlabel/introduction.txt
index 5ecd8d1..3caf77b 100644
--- a/Documentation/netlabel/introduction.txt
+++ b/Documentation/netlabel/introduction.txt
@@ -22,7 +22,7 @@ refrain from calling the protocol engines directly, instead they should use
 the NetLabel kernel security module API described below.
 
 Detailed information about each NetLabel protocol engine can be found in this
-directory, consult '00-INDEX' for filenames.
+directory.
 
  * Communication Layer
 
diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
deleted file mode 100644
index 02a323c..0000000
--- a/Documentation/networking/00-INDEX
+++ /dev/null
@@ -1,234 +0,0 @@
-00-INDEX
-	- this file
-3c509.txt
-	- information on the 3Com Etherlink III Series Ethernet cards.
-6pack.txt
-	- info on the 6pack protocol, an alternative to KISS for AX.25
-LICENSE.qla3xxx
-	- GPLv2 for QLogic Linux Networking HBA Driver
-LICENSE.qlge
-	- GPLv2 for QLogic Linux qlge NIC Driver
-LICENSE.qlcnic
-	- GPLv2 for QLogic Linux qlcnic NIC Driver
-PLIP.txt
-	- PLIP: The Parallel Line Internet Protocol device driver
-README.ipw2100
-	- README for the Intel PRO/Wireless 2100 driver.
-README.ipw2200
-	- README for the Intel PRO/Wireless 2915ABG and 2200BG driver.
-README.sb1000
-	- info on General Instrument/NextLevel SURFboard1000 cable modem.
-altera_tse.txt
-	- Altera Triple-Speed Ethernet controller.
-arcnet-hardware.txt
-	- tons of info on ARCnet, hubs, jumper settings for ARCnet cards, etc.
-arcnet.txt
-	- info on the using the ARCnet driver itself.
-atm.txt
-	- info on where to get ATM programs and support for Linux.
-ax25.txt
-	- info on using AX.25 and NET/ROM code for Linux
-baycom.txt
-	- info on the driver for Baycom style amateur radio modems
-bonding.txt
-	- Linux Ethernet Bonding Driver HOWTO: link aggregation in Linux.
-bridge.txt
-	- where to get user space programs for ethernet bridging with Linux.
-cdc_mbim.txt
-	- 3G/LTE USB modem (Mobile Broadband Interface Model)
-checksum-offloads.txt
-	- Explanation of checksum offloads; LCO, RCO
-cops.txt
-	- info on the COPS LocalTalk Linux driver
-cs89x0.txt
-	- the Crystal LAN (CS8900/20-based) Ethernet ISA adapter driver
-cxacru.txt
-	- Conexant AccessRunner USB ADSL Modem
-cxacru-cf.py
-	- Conexant AccessRunner USB ADSL Modem configuration file parser
-cxgb.txt
-	- Release Notes for the Chelsio N210 Linux device driver.
-dccp.txt
-	- the Datagram Congestion Control Protocol (DCCP) (RFC 4340..42).
-dctcp.txt
-	- DataCenter TCP congestion control
-de4x5.txt
-	- the Digital EtherWORKS DE4?? and DE5?? PCI Ethernet driver
-decnet.txt
-	- info on using the DECnet networking layer in Linux.
-dl2k.txt
-	- README for D-Link DL2000-based Gigabit Ethernet Adapters (dl2k.ko).
-dm9000.txt
-	- README for the Simtec DM9000 Network driver.
-dmfe.txt
-	- info on the Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver.
-dns_resolver.txt
-	- The DNS resolver module allows kernel servies to make DNS queries.
-driver.txt
-	- Softnet driver issues.
-ena.txt
-	- info on Amazon's Elastic Network Adapter (ENA)
-e100.txt
-	- info on Intel's EtherExpress PRO/100 line of 10/100 boards
-e1000.txt
-	- info on Intel's E1000 line of gigabit ethernet boards
-e1000e.txt
-	- README for the Intel Gigabit Ethernet Driver (e1000e).
-eql.txt
-	- serial IP load balancing
-fib_trie.txt
-	- Level Compressed Trie (LC-trie) notes: a structure for routing.
-filter.txt
-	- Linux Socket Filtering
-fore200e.txt
-	- FORE Systems PCA-200E/SBA-200E ATM NIC driver info.
-framerelay.txt
-	- info on using Frame Relay/Data Link Connection Identifier (DLCI).
-gen_stats.txt
-	- Generic networking statistics for netlink users.
-generic-hdlc.txt
-	- The generic High Level Data Link Control (HDLC) layer.
-generic_netlink.txt
-	- info on Generic Netlink
-gianfar.txt
-	- Gianfar Ethernet Driver.
-i40e.txt
-	- README for the Intel Ethernet Controller XL710 Driver (i40e).
-i40evf.txt
-	- Short note on the Driver for the Intel(R) XL710 X710 Virtual Function
-ieee802154.txt
-	- Linux IEEE 802.15.4 implementation, API and drivers
-igb.txt
-	- README for the Intel Gigabit Ethernet Driver (igb).
-igbvf.txt
-	- README for the Intel Gigabit Ethernet Driver (igbvf).
-ip-sysctl.txt
-	- /proc/sys/net/ipv4/* variables
-ip_dynaddr.txt
-	- IP dynamic address hack e.g. for auto-dialup links
-ipddp.txt
-	- AppleTalk-IP Decapsulation and AppleTalk-IP Encapsulation
-iphase.txt
-	- Interphase PCI ATM (i)Chip IA Linux driver info.
-ipsec.txt
-	- Note on not compressing IPSec payload and resulting failed policy check.
-ipv6.txt
-	- Options to the ipv6 kernel module.
-ipvs-sysctl.txt
-	- Per-inode explanation of the /proc/sys/net/ipv4/vs interface.
-irda.txt
-	- where to get IrDA (infrared) utilities and info for Linux.
-ixgb.txt
-	- README for the Intel 10 Gigabit Ethernet Driver (ixgb).
-ixgbe.txt
-	- README for the Intel 10 Gigabit Ethernet Driver (ixgbe).
-ixgbevf.txt
-	- README for the Intel Virtual Function (VF) Driver (ixgbevf).
-l2tp.txt
-	- User guide to the L2TP tunnel protocol.
-lapb-module.txt
-	- programming information of the LAPB module.
-ltpc.txt
-	- the Apple or Farallon LocalTalk PC card driver
-mac80211-auth-assoc-deauth.txt
-	- authentication and association / deauth-disassoc with max80211
-mac80211-injection.txt
-	- HOWTO use packet injection with mac80211
-multiqueue.txt
-	- HOWTO for multiqueue network device support.
-netconsole.txt
-	- The network console module netconsole.ko: configuration and notes.
-netdev-features.txt
-	- Network interface features API description.
-netdevices.txt
-	- info on network device driver functions exported to the kernel.
-netif-msg.txt
-	- Design of the network interface message level setting (NETIF_MSG_*).
-netlink_mmap.txt
-	- memory mapped I/O with netlink
-nf_conntrack-sysctl.txt
-	- list of netfilter-sysctl knobs.
-nfc.txt
-	- The Linux Near Field Communication (NFS) subsystem.
-openvswitch.txt
-	- Open vSwitch developer documentation.
-operstates.txt
-	- Overview of network interface operational states.
-packet_mmap.txt
-	- User guide to memory mapped packet socket rings (PACKET_[RT]X_RING).
-phonet.txt
-	- The Phonet packet protocol used in Nokia cellular modems.
-phy.txt
-	- The PHY abstraction layer.
-pktgen.txt
-	- User guide to the kernel packet generator (pktgen.ko).
-policy-routing.txt
-	- IP policy-based routing
-ppp_generic.txt
-	- Information about the generic PPP driver.
-proc_net_tcp.txt
-	- Per inode overview of the /proc/net/tcp and /proc/net/tcp6 interfaces.
-radiotap-headers.txt
-	- Background on radiotap headers.
-ray_cs.txt
-	- Raylink Wireless LAN card driver info.
-rds.txt
-	- Background on the reliable, ordered datagram delivery method RDS.
-regulatory.txt
-	- Overview of the Linux wireless regulatory infrastructure.
-rxrpc.txt
-	- Guide to the RxRPC protocol.
-s2io.txt
-	- Release notes for Neterion Xframe I/II 10GbE driver.
-scaling.txt
-	- Explanation of network scaling techniques: RSS, RPS, RFS, aRFS, XPS.
-sctp.txt
-	- Notes on the Linux kernel implementation of the SCTP protocol.
-secid.txt
-	- Explanation of the secid member in flow structures.
-skfp.txt
-	- SysKonnect FDDI (SK-5xxx, Compaq Netelligent) driver info.
-smc9.txt
-	- the driver for SMC's 9000 series of Ethernet cards
-spider_net.txt
-	- README for the Spidernet Driver (as found in PS3 / Cell BE).
-stmmac.txt
-	- README for the STMicro Synopsys Ethernet driver.
-tc-actions-env-rules.txt
-	- rules for traffic control (tc) actions.
-timestamping.txt
-	- overview of network packet timestamping variants.
-tcp.txt
-	- short blurb on how TCP output takes place.
-tcp-thin.txt
-	- kernel tuning options for low rate 'thin' TCP streams.
-team.txt
-	- pointer to information for ethernet teaming devices.
-tlan.txt
-	- ThunderLAN (Compaq Netelligent 10/100, Olicom OC-2xxx) driver info.
-tproxy.txt
-	- Transparent proxy support user guide.
-tuntap.txt
-	- TUN/TAP device driver, allowing user space Rx/Tx of packets.
-udplite.txt
-	- UDP-Lite protocol (RFC 3828) introduction.
-vortex.txt
-	- info on using 3Com Vortex (3c590, 3c592, 3c595, 3c597) Ethernet cards.
-vxge.txt
-	- README for the Neterion X3100 PCIe Server Adapter.
-vxlan.txt
-	- Virtual extensible LAN overview
-x25.txt
-	- general info on X.25 development.
-x25-iface.txt
-	- description of the X.25 Packet Layer to LAPB device interface.
-xfrm_device.txt
-	- description of XFRM offload API
-xfrm_proc.txt
-	- description of the statistics package for XFRM.
-xfrm_sync.txt
-	- sync patches for XFRM enable migration of an SA between hosts.
-xfrm_sysctl.txt
-	- description of the XFRM configuration options.
-z8530drv.txt
-	- info about Linux driver for Z8530 based HDLC cards for AX.25
diff --git a/Documentation/parisc/00-INDEX b/Documentation/parisc/00-INDEX
deleted file mode 100644
index cbd0609..0000000
--- a/Documentation/parisc/00-INDEX
+++ /dev/null
@@ -1,6 +0,0 @@
-00-INDEX
-	- this file.
-debugging
-	- some debugging hints for real-mode code
-registers
-	- current/planned usage of registers
diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
deleted file mode 100644
index 7f3c2de..0000000
--- a/Documentation/power/00-INDEX
+++ /dev/null
@@ -1,44 +0,0 @@
-00-INDEX
-	- This file
-apm-acpi.txt
-	- basic info about the APM and ACPI support.
-basic-pm-debugging.txt
-	- Debugging suspend and resume
-charger-manager.txt
-	- Battery charger management.
-admin-guide/devices.rst
-	- How drivers interact with system-wide power management
-drivers-testing.txt
-	- Testing suspend and resume support in device drivers
-freezing-of-tasks.txt
-	- How processes and controlled during suspend
-interface.txt
-	- Power management user interface in /sys/power
-opp.txt
-	- Operating Performance Point library
-pci.txt
-	- How the PCI Subsystem Does Power Management
-pm_qos_interface.txt
-	- info on Linux PM Quality of Service interface
-power_supply_class.txt
-	- Tells userspace about battery, UPS, AC or DC power supply properties
-runtime_pm.txt
-	- Power management framework for I/O devices.
-s2ram.txt
-	- How to get suspend to ram working (and debug it when it isn't)
-states.txt
-	- System power management states
-suspend-and-cpuhotplug.txt
-	- Explains the interaction between Suspend-to-RAM (S3) and CPU hotplug
-swsusp-and-swap-files.txt
-	- Using swap files with software suspend (to disk)
-swsusp-dmcrypt.txt
-	- How to use dm-crypt and software suspend (to disk) together
-swsusp.txt
-	- Goals, implementation, and usage of software suspend (ACPI S3)
-tricks.txt
-	- How to trick software suspend (to disk) into working when it isn't
-userland-swsusp.txt
-	- Experimental implementation of software suspend in userspace
-video.txt
-	- Video issues during resume from suspend
diff --git a/Documentation/powerpc/00-INDEX b/Documentation/powerpc/00-INDEX
deleted file mode 100644
index 9dc845c..0000000
--- a/Documentation/powerpc/00-INDEX
+++ /dev/null
@@ -1,34 +0,0 @@
-Index of files in Documentation/powerpc.  If you think something about
-Linux/PPC needs an entry here, needs correction or you've written one
-please mail me.
-                                        Cort Dougan (cort@fsmlabs.com)
-
-00-INDEX
-	- this file
-bootwrapper.txt
-	- Information on how the powerpc kernel is wrapped for boot on various
-	  different platforms.
-cpu_features.txt
-	- info on how we support a variety of CPUs with minimal compile-time
-	options.
-cxl.txt
-	- Overview of the CXL driver.
-eeh-pci-error-recovery.txt
-	- info on PCI Bus EEH Error Recovery
-firmware-assisted-dump.txt
-	- Documentation on the firmware assisted dump mechanism "fadump".
-hvcs.txt
-	- IBM "Hypervisor Virtual Console Server" Installation Guide
-mpc52xx.txt
-	- Linux 2.6.x on MPC52xx family
-pmu-ebb.txt
-	- Description of the API for using the PMU with Event Based Branches.
-qe_firmware.txt
-	- describes the layout of firmware binaries for the Freescale QUICC
-	  Engine and the code that parses and uploads the microcode therein.
-ptrace.txt
-	- Information on the ptrace interfaces for hardware debug registers.
-transactional_memory.txt
-	- Overview of the Power8 transactional memory support.
-dscr.txt
-	- Overview DSCR (Data Stream Control Register) support.
diff --git a/Documentation/s390/00-INDEX b/Documentation/s390/00-INDEX
deleted file mode 100644
index 317f037..0000000
--- a/Documentation/s390/00-INDEX
+++ /dev/null
@@ -1,28 +0,0 @@
-00-INDEX
-	- this file.
-3270.ChangeLog
-	- ChangeLog for the UTS Global 3270-support patch (outdated).
-3270.txt
-	- how to use the IBM 3270 display system support.
-cds.txt
-	- s390 common device support (common I/O layer).
-CommonIO
-	- common I/O layer command line parameters, procfs and debugfs	entries
-config3270.sh
-	- example configuration for 3270 devices.
-DASD
-	- information on the DASD disk device driver.
-Debugging390.txt
-	- hints for debugging on s390 systems.
-driver-model.txt
-	- information on s390 devices and the driver model.
-monreader.txt
-	- information on accessing the z/VM monitor stream from Linux.
-qeth.txt
-	- HiperSockets Bridge Port Support.
-s390dbf.txt
-	- information on using the s390 debug feature.
-vfio-ccw.txt
-	  information on the vfio-ccw I/O subchannel driver.
-zfcpdump.txt
-	- information on the s390 SCSI dump tool.
diff --git a/Documentation/scheduler/00-INDEX b/Documentation/scheduler/00-INDEX
deleted file mode 100644
index eccf7ad..0000000
--- a/Documentation/scheduler/00-INDEX
+++ /dev/null
@@ -1,18 +0,0 @@
-00-INDEX
-	- this file.
-sched-arch.txt
-	- CPU Scheduler implementation hints for architecture specific code.
-sched-bwc.txt
-	- CFS bandwidth control overview.
-sched-design-CFS.txt
-	- goals, design and implementation of the Completely Fair Scheduler.
-sched-domains.txt
-	- information on scheduling domains.
-sched-nice-design.txt
-	- How and why the scheduler's nice levels are implemented.
-sched-rt-group.txt
-	- real-time group scheduling.
-sched-deadline.txt
-	- deadline scheduling.
-sched-stats.txt
-	- information on schedstats (Linux Scheduler Statistics).
diff --git a/Documentation/scsi/00-INDEX b/Documentation/scsi/00-INDEX
deleted file mode 100644
index bb4a76f..0000000
--- a/Documentation/scsi/00-INDEX
+++ /dev/null
@@ -1,108 +0,0 @@
-00-INDEX
-	- this file
-53c700.txt
-	- info on driver for 53c700 based adapters
-BusLogic.txt
-	- info on driver for adapters with BusLogic chips
-ChangeLog.1992-1997
-	- Changes to scsi files, if not listed elsewhere
-ChangeLog.arcmsr
-	- Changes to driver for ARECA's SATA RAID controller cards
-ChangeLog.ips
-	- IBM ServeRAID driver Changelog
-ChangeLog.lpfc
-	- Changes to lpfc driver
-ChangeLog.megaraid
-	- Changes to LSI megaraid controller.
-ChangeLog.megaraid_sas
-	- Changes to serial attached scsi version of LSI megaraid controller.
-ChangeLog.ncr53c8xx
-	- Changes to ncr53c8xx driver
-ChangeLog.sym53c8xx
-	- Changes to sym53c8xx driver
-ChangeLog.sym53c8xx_2
-	- Changes to second generation of sym53c8xx driver
-FlashPoint.txt
-	- info on driver for BusLogic FlashPoint adapters
-LICENSE.FlashPoint
-	- Licence of the Flashpoint driver
-LICENSE.qla2xxx
-	- License for QLogic Linux Fibre Channel HBA Driver firmware.
-LICENSE.qla4xxx
-	- License for QLogic Linux iSCSI HBA Driver.
-Mylex.txt
-	- info on driver for Mylex adapters
-NinjaSCSI.txt
-	- info on WorkBiT NinjaSCSI-32/32Bi driver
-aacraid.txt
-	- Driver supporting Adaptec RAID controllers
-advansys.txt
-	- List of Advansys Host Adapters
-aha152x.txt
-	- info on driver for Adaptec AHA152x based adapters
-aic79xx.txt
-	- Adaptec Ultra320 SCSI host adapters
-aic7xxx.txt
-	- info on driver for Adaptec controllers
-arcmsr_spec.txt
-	- ARECA FIRMWARE SPEC (for IOP331 adapter)
-bfa.txt
-	- Brocade FC/FCOE adapter driver.
-bnx2fc.txt
-	- FCoE hardware offload for Broadcom network interfaces.
-cxgb3i.txt
-	- Chelsio iSCSI Linux Driver
-dc395x.txt
-	- README file for the dc395x SCSI driver
-dpti.txt
-	- info on driver for DPT SmartRAID and Adaptec I2O RAID based adapters
-dtc3x80.txt
-	- info on driver for DTC 2x80 based adapters
-g_NCR5380.txt
-	- info on driver for NCR5380 and NCR53c400 based adapters
-hpsa.txt
-	- HP Smart Array Controller SCSI driver.
-hptiop.txt
-	- HIGHPOINT ROCKETRAID 3xxx RAID DRIVER
-libsas.txt
-	- Serial Attached SCSI management layer.
-link_power_management_policy.txt
-	- Link power management options.
-lpfc.txt
-	- LPFC driver release notes
-megaraid.txt
-	- Common Management Module, shared code handling ioctls for LSI drivers
-ncr53c8xx.txt
-	- info on driver for NCR53c8xx based adapters
-osd.txt
-	Object-Based Storage Device, command set introduction.
-osst.txt
-	- info on driver for OnStream SC-x0 SCSI tape
-ppa.txt
-	- info on driver for IOmega zip drive
-qlogicfas.txt
-	- info on driver for QLogic FASxxx based adapters
-scsi-changer.txt
-	- README for the SCSI media changer driver
-scsi-generic.txt
-	- info on the sg driver for generic (non-disk/CD/tape) SCSI devices.
-scsi-parameters.txt
-	- List of SCSI-parameters to pass to the kernel at module load-time.
-scsi.txt
-	- short blurb on using SCSI support as a module.
-scsi_mid_low_api.txt
-	- info on API between SCSI layer and low level drivers
-scsi_eh.txt
-	- info on SCSI midlayer error handling infrastructure
-scsi_fc_transport.txt
-	- SCSI Fiber Channel Tansport
-st.txt
-	- info on scsi tape driver
-sym53c500_cs.txt
-	- info on PCMCIA driver for Symbios Logic 53c500 based adapters
-sym53c8xx_2.txt
-	- info on second generation driver for sym53c8xx based adapters
-tmscsim.txt
-	- info on driver for AM53c974 based adapters
-ufs.txt
-	- info on Universal Flash Storage(UFS) and UFS host controller driver.
diff --git a/Documentation/serial/00-INDEX b/Documentation/serial/00-INDEX
deleted file mode 100644
index 8021a9f..0000000
--- a/Documentation/serial/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- this file.
-README.cycladesZ
-	- info on Cyclades-Z firmware loading.
-driver
-	- intro to the low level serial driver.
-moxa-smartio
-	- file with info on installing/using Moxa multiport serial driver.
-n_gsm.txt
-	- GSM 0710 tty multiplexer howto.
-rocket.txt
-	- info on the Comtrol RocketPort multiport serial driver.
-serial-rs485.txt
-	- info about RS485 structures and support in the kernel.
-tty.txt
-	- guide to the locking policies of the tty layer.
diff --git a/Documentation/spi/00-INDEX b/Documentation/spi/00-INDEX
deleted file mode 100644
index 8e4bb17..0000000
--- a/Documentation/spi/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- this file.
-butterfly
-	- AVR Butterfly SPI driver overview and pin configuration.
-ep93xx_spi
-	- Basic EP93xx SPI driver configuration.
-pxa2xx
-	- PXA2xx SPI master controller build by spi_message fifo wq
-spidev
-	- Intro to the userspace API for spi devices
-spi-lm70llp
-	- Connecting an LM70-LLP sensor to the kernel via the SPI subsys.
-spi-sc18is602
-	- NXP SC18IS602/603 I2C-bus to SPI bridge
-spi-summary
-	- (Linux) SPI overview. If unsure about SPI or SPI in Linux, start here.
diff --git a/Documentation/sysctl/00-INDEX b/Documentation/sysctl/00-INDEX
deleted file mode 100644
index 8cf5d49..0000000
--- a/Documentation/sysctl/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- this file.
-README
-	- general information about /proc/sys/ sysctl files.
-abi.txt
-	- documentation for /proc/sys/abi/*.
-fs.txt
-	- documentation for /proc/sys/fs/*.
-kernel.txt
-	- documentation for /proc/sys/kernel/*.
-net.txt
-	- documentation for /proc/sys/net/*.
-sunrpc.txt
-	- documentation for /proc/sys/sunrpc/*.
-vm.txt
-	- documentation for /proc/sys/vm/*.
diff --git a/Documentation/timers/00-INDEX b/Documentation/timers/00-INDEX
deleted file mode 100644
index 3be05fe..0000000
--- a/Documentation/timers/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- this file
-highres.txt
-	- High resolution timers and dynamic ticks design notes
-hpet.txt
-	- High Precision Event Timer Driver for Linux
-hrtimers.txt
-	- subsystem for high-resolution kernel timers
-NO_HZ.txt
-	- Summary of the different methods for the scheduler clock-interrupts management.
-timekeeping.txt
-	- Clock sources, clock events, sched_clock() and delay timer notes
-timers-howto.txt
-	- how to insert delays in the kernel the right (tm) way.
-timer_stats.txt
-	- timer usage statistics
diff --git a/Documentation/virtual/00-INDEX b/Documentation/virtual/00-INDEX
deleted file mode 100644
index af0d239..0000000
--- a/Documentation/virtual/00-INDEX
+++ /dev/null
@@ -1,11 +0,0 @@
-Virtualization support in the Linux kernel.
-
-00-INDEX
-	- this file.
-
-paravirt_ops.txt
-	- Describes the Linux kernel pv_ops to support different hypervisors
-kvm/
-	- Kernel Virtual Machine.  See also http://linux-kvm.org
-uml/
-	- User Mode Linux, builds/runs Linux kernel as a userspace program.
diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/kvm/00-INDEX
deleted file mode 100644
index 3492458..0000000
--- a/Documentation/virtual/kvm/00-INDEX
+++ /dev/null
@@ -1,35 +0,0 @@
-00-INDEX
-	- this file.
-amd-memory-encryption.rst
-	- notes on AMD Secure Encrypted Virtualization feature and SEV firmware
-	  command description
-api.txt
-	- KVM userspace API.
-arm
-	- internal ABI between the kernel and HYP (for arm/arm64)
-cpuid.txt
-	- KVM-specific cpuid leaves (x86).
-devices/
-	- KVM_CAP_DEVICE_CTRL userspace API.
-halt-polling.txt
-	- notes on halt-polling
-hypercalls.txt
-	- KVM hypercalls.
-locking.txt
-	- notes on KVM locks.
-mmu.txt
-	- the x86 kvm shadow mmu.
-msr.txt
-	- KVM-specific MSRs (x86).
-nested-vmx.txt
-	- notes on nested virtualization for Intel x86 processors.
-ppc-pv.txt
-	- the paravirtualization interface on PowerPC.
-review-checklist.txt
-	- review checklist for KVM patches.
-s390-diag.txt
-	- Diagnose hypercall description (for IBM S/390)
-timekeeping.txt
-	- timekeeping virtualization for x86-based architectures.
-vcpu-requests.rst
-	- internal VCPU request API
diff --git a/Documentation/vm/00-INDEX b/Documentation/vm/00-INDEX
deleted file mode 100644
index f4a4f3e..0000000
--- a/Documentation/vm/00-INDEX
+++ /dev/null
@@ -1,50 +0,0 @@
-00-INDEX
-	- this file.
-active_mm.rst
-	- An explanation from Linus about tsk->active_mm vs tsk->mm.
-balance.rst
-	- various information on memory balancing.
-cleancache.rst
-	- Intro to cleancache and page-granularity victim cache.
-frontswap.rst
-	- Outline frontswap, part of the transcendent memory frontend.
-highmem.rst
-	- Outline of highmem and common issues.
-hmm.rst
-	- Documentation of heterogeneous memory management
-hugetlbfs_reserv.rst
-	- A brief overview of hugetlbfs reservation design/implementation.
-hwpoison.rst
-	- explains what hwpoison is
-ksm.rst
-	- how to use the Kernel Samepage Merging feature.
-mmu_notifier.rst
-	- a note about clearing pte/pmd and mmu notifications
-numa.rst
-	- information about NUMA specific code in the Linux vm.
-overcommit-accounting.rst
-	- description of the Linux kernels overcommit handling modes.
-page_frags.rst
-	- description of page fragments allocator
-page_migration.rst
-	- description of page migration in NUMA systems.
-page_owner.rst
-	- tracking about who allocated each page
-remap_file_pages.rst
-	- a note about remap_file_pages() system call
-slub.rst
-	- a short users guide for SLUB.
-split_page_table_lock.rst
-	- Separate per-table lock to improve scalability of the old page_table_lock.
-swap_numa.rst
-	- automatic binding of swap device to numa node
-transhuge.rst
-	- Transparent Hugepage Support, alternative way of using hugepages.
-unevictable-lru.rst
-	- Unevictable LRU infrastructure
-z3fold.txt
-	- outline of z3fold allocator for storing compressed pages
-zsmalloc.rst
-	- outline of zsmalloc allocator for storing compressed pages
-zswap.rst
-	- Intro to compressed cache for swap pages
diff --git a/Documentation/w1/00-INDEX b/Documentation/w1/00-INDEX
deleted file mode 100644
index cb49802..0000000
--- a/Documentation/w1/00-INDEX
+++ /dev/null
@@ -1,10 +0,0 @@
-00-INDEX
-	- This file
-slaves/
-	- Drivers that provide support for specific family codes.
-masters/
-	- Individual chips providing 1-wire busses.
-w1.generic
-	- The 1-wire (w1) bus
-w1.netlink
-	- Userspace communication protocol over connector [1].
diff --git a/Documentation/w1/masters/00-INDEX b/Documentation/w1/masters/00-INDEX
deleted file mode 100644
index 8330cf9..0000000
--- a/Documentation/w1/masters/00-INDEX
+++ /dev/null
@@ -1,12 +0,0 @@
-00-INDEX
-	- This file
-ds2482
-	- The Maxim/Dallas Semiconductor DS2482 provides 1-wire busses.
-ds2490
-	- The Maxim/Dallas Semiconductor DS2490 builds USB <-> W1 bridges.
-mxc-w1
-	- W1 master controller driver found on Freescale MX2/MX3 SoCs
-omap-hdq
-	- HDQ/1-wire module of TI OMAP 2430/3430.
-w1-gpio
-	- GPIO 1-wire bus master driver.
diff --git a/Documentation/w1/slaves/00-INDEX b/Documentation/w1/slaves/00-INDEX
deleted file mode 100644
index 68946f8..0000000
--- a/Documentation/w1/slaves/00-INDEX
+++ /dev/null
@@ -1,14 +0,0 @@
-00-INDEX
-	- This file
-w1_therm
-	- The Maxim/Dallas Semiconductor ds18*20 temperature sensor.
-w1_ds2413
-	- The Maxim/Dallas Semiconductor ds2413 dual channel addressable switch.
-w1_ds2423
-	- The Maxim/Dallas Semiconductor ds2423 counter device.
-w1_ds2438
-	- The Maxim/Dallas Semiconductor ds2438 smart battery monitor.
-w1_ds28e04
-	- The Maxim/Dallas Semiconductor ds28e04 eeprom.
-w1_ds28e17
-	- The Maxim/Dallas Semiconductor ds28e17 1-Wire-to-I2C Master Bridge.
diff --git a/Documentation/x86/00-INDEX b/Documentation/x86/00-INDEX
deleted file mode 100644
index 3bb2ee3..0000000
--- a/Documentation/x86/00-INDEX
+++ /dev/null
@@ -1,20 +0,0 @@
-00-INDEX
-	- this file
-boot.txt
-	- List of boot protocol versions
-earlyprintk.txt
-	- Using earlyprintk with a USB2 debug port key.
-entry_64.txt
-	- Describe (some of the) kernel entry points for x86.
-exception-tables.txt
-	- why and how Linux kernel uses exception tables on x86
-microcode.txt
-	- How to load microcode from an initrd-CPIO archive early to fix CPU issues.
-mtrr.txt
-	- how to use x86 Memory Type Range Registers to increase performance
-pat.txt
-	- Page Attribute Table intro and API
-usb-legacy-support.txt
-	- how to fix/avoid quirks when using emulated PS/2 mouse/keyboard.
-zero-page.txt
-	- layout of the first page of memory.
diff --git a/Documentation/x86/x86_64/00-INDEX b/Documentation/x86/x86_64/00-INDEX
deleted file mode 100644
index 92fc20a..0000000
--- a/Documentation/x86/x86_64/00-INDEX
+++ /dev/null
@@ -1,16 +0,0 @@
-00-INDEX
-	- This file
-boot-options.txt
-	- AMD64-specific boot options.
-cpu-hotplug-spec
-	- Firmware support for CPU hotplug under Linux/x86-64
-fake-numa-for-cpusets
-	- Using numa=fake and CPUSets for Resource Management
-kernel-stacks
-	- Context-specific per-processor interrupt stacks.
-machinecheck
-	- Configurable sysfs parameters for the x86-64 machine check code.
-mm.txt
-	- Memory layout of x86-64 (4 level page tables, 46 bits physical).
-uefi.txt
-	- Booting Linux via Unified Extensible Firmware Interface.
diff --git a/README b/README
index 2c927cc..669ac7c 100644
--- a/README
+++ b/README
@@ -12,7 +12,6 @@ In order to build the documentation, use ``make htmldocs`` or
 
 There are various text files in the Documentation/ subdirectory,
 several of them using the Restructured Text markup notation.
-See Documentation/00-INDEX for a list of what is contained in each file.
 
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
diff --git a/scripts/check_00index.sh b/scripts/check_00index.sh
deleted file mode 100755
index aa47f592..0000000
--- a/scripts/check_00index.sh
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-cd Documentation/
-
-# Check entries that should be removed
-
-obsolete=""
-for i in $(tail -n +12 00-INDEX |grep -E '^[a-zA-Z0-9]+'); do
-	if [ ! -e $i ]; then
-		obsolete="$obsolete $i"
-	fi
-done
-
-# Check directory entries that should be added
-search=""
-dir=""
-for i in $(find . -maxdepth 1 -type d); do
-	if [ "$i" != "." ]; then
-		new=$(echo $i|perl -ne 's,./(.*),$1/,; print $_')
-		search="$search $new"
-	fi
-done
-
-for i in $search; do
-	if [ "$(grep -P "^$i" 00-INDEX)" == "" ]; then
-		dir="$dir $i"
-	fi
-done
-
-# Check file entries that should be added
-search=""
-file=""
-for i in $(find . -maxdepth 1 -type f); do
-	if [ "$i" != "./.gitignore" ]; then
-		new=$(echo $i|perl -ne 's,./(.*),$1,; print $_')
-		search="$search $new"
-	fi
-done
-
-for i in $search; do
-	if [ "$(grep -P "^$i\$" 00-INDEX)" == "" ]; then
-		file="$file $i"
-	fi
-done
-
-# Output its findings
-
-echo -e "Documentation/00-INDEX check results:\n"
-
-if [ "$obsolete" != "" ]; then
-	echo -e "- Should remove those entries:\n\t$obsolete\n"
-else
-	echo -e "- No obsolete entries\n"
-fi
-
-if [ "$dir" != "" ]; then
-	echo -e "- Should document those directories:\n\t$dir\n"
-else
-	echo -e "- No new directories to add\n"
-fi
-
-if [ "$file" != "" ]; then
-	echo -e "- Should document those files:\n\t$file"
-else
-	echo "- No new files to add"
-fi
-- 
2.7.4
