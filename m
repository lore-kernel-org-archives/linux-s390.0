Return-Path: <linux-kernel-owner+w=401wt.eu-S2993036AbXDTLdV@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:33:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4/8] Kconfig: use common Kconfig for s390.
Message-ID: <20070420113330.GE3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Disband drivers/s390/Kconfig, use the common Kconfig files. The s390
specific config options from drivers/s390/Kconfig are moved to the
respective common Kconfig files.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig          |   49 +++------
 drivers/block/Kconfig      |    4 
 drivers/char/Kconfig       |    2 
 drivers/crypto/Kconfig     |   22 ++++
 drivers/s390/Kconfig       |  239 ---------------------------------------------
 drivers/s390/block/Kconfig |   11 --
 drivers/s390/char/Kconfig  |  166 +++++++++++++++++++++++++++++++
 drivers/s390/net/Kconfig   |    8 -
 include/asm-s390/param.h   |    2 
 9 files changed, 217 insertions(+), 286 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2007-04-19 15:24:32.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -4,27 +4,23 @@
 #
 
 config MMU
-	bool
-	default y
+	def_bool y
 
 config ZONE_DMA
 	def_bool y
 	depends on 64BIT
 
 config LOCKDEP_SUPPORT
-	bool
-	default y
+	def_bool y
 
 config STACKTRACE_SUPPORT
-	bool
-	default y
+	def_bool y
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
+	def_bool y
 
 config ARCH_HAS_ILOG2_U32
 	bool
@@ -35,8 +31,7 @@ config ARCH_HAS_ILOG2_U64
 	default n
 
 config GENERIC_HWEIGHT
-	bool
-	default y
+	def_bool y
 
 config GENERIC_TIME
 	def_bool y
@@ -55,8 +50,7 @@ config NO_DMA
 mainmenu "Linux Kernel Configuration"
 
 config S390
-	bool
-	default y
+	def_bool y
 
 source "init/Kconfig"
 
@@ -280,6 +274,10 @@ config WARN_STACK_SIZE
 config ARCH_POPULATES_NODE_MAP
 	def_bool y
 
+comment "Kernel preemption"
+
+source "kernel/Kconfig.preempt"
+
 source "mm/Kconfig"
 
 config HOLES_IN_ZONE
@@ -320,17 +318,6 @@ config QDIO_DEBUG
 
 comment "Misc"
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
-
-	  Say N if you are unsure.
-
 config IPL
 	bool "Builtin IPL record support"
 	help
@@ -488,6 +475,8 @@ config APPLDATA_NET_SUM
 	  This can also be compiled as a module, which will be called
 	  appldata_net_sum.o.
 
+source kernel/Kconfig.hz
+
 config NO_IDLE_HZ
 	bool "No HZ timer ticks in idle"
 	help
@@ -535,18 +524,12 @@ endmenu
 source "net/Kconfig"
 
 config PCMCIA
-	bool
-	default n
-
-source "drivers/base/Kconfig"
+	def_bool n
 
-source "drivers/connector/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/s390/Kconfig"
+config CCW
+	def_bool y
 
-source "drivers/net/Kconfig"
+source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
diff -urpN linux-2.6/drivers/block/Kconfig linux-2.6-patched/drivers/block/Kconfig
--- linux-2.6/drivers/block/Kconfig	2007-04-19 15:23:55.000000000 +0200
+++ linux-2.6-patched/drivers/block/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -444,8 +444,6 @@ config CDROM_PKTCDVD_WCACHE
 	  this option is dangerous unless the CD-RW media is known good, as we
 	  don't do deferred write error handling yet.
 
-source "drivers/s390/block/Kconfig"
-
 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
 	depends on NET
@@ -453,6 +451,8 @@ config ATA_OVER_ETH
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+source "drivers/s390/block/Kconfig"
+
 endmenu
 
 endif
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2007-04-19 15:51:34.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -1091,5 +1091,7 @@ config DEVPORT
 	depends on ISA || PCI
 	default y
 
+source "drivers/s390/char/Kconfig"
+
 endmenu
 
diff -urpN linux-2.6/drivers/crypto/Kconfig linux-2.6-patched/drivers/crypto/Kconfig
--- linux-2.6/drivers/crypto/Kconfig	2007-04-19 15:23:57.000000000 +0200
+++ linux-2.6-patched/drivers/crypto/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -66,4 +66,26 @@ config CRYPTO_DEV_GEODE
 	  To compile this driver as a module, choose M here: the module
 	  will be called geode-aes.
 
+config ZCRYPT
+	tristate "Support for PCI-attached cryptographic adapters"
+	depends on S390
+	select ZCRYPT_MONOLITHIC if ZCRYPT="y"
+	default "m"
+	help
+	  Select this option if you want to use a PCI-attached cryptographic
+	  adapter like:
+	  + PCI Cryptographic Accelerator (PCICA)
+	  + PCI Cryptographic Coprocessor (PCICC)
+	  + PCI-X Cryptographic Coprocessor (PCIXCC)
+	  + Crypto Express2 Coprocessor (CEX2C)
+	  + Crypto Express2 Accelerator (CEX2A)
+
+config ZCRYPT_MONOLITHIC
+	bool "Monolithic zcrypt module"
+	depends on ZCRYPT="m"
+	help
+	  Select this option if you want to have a single module z90crypt.ko
+	  that contains all parts of the crypto device driver (ap bus,
+	  request router and all the card drivers).
+
 endmenu
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -1,11 +1,9 @@
-if S390 && BLOCK
-
 comment "S/390 block device drivers"
-	depends on S390
+	depends on S390 && BLOCK
 
 config BLK_DEV_XPRAM
 	tristate "XPRAM disk support"
-	depends on S390
+	depends on S390 && BLOCK
 	help
 	  Select this option if you want to use your expanded storage on S/390
 	  or zSeries as a disk.  This is useful as a _fast_ swap device if you
@@ -15,12 +13,13 @@ config BLK_DEV_XPRAM
 
 config DCSSBLK
 	tristate "DCSSBLK support"
+	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
 config DASD
 	tristate "Support for DASD devices"
-	depends on CCW
+	depends on CCW && BLOCK
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
@@ -62,5 +61,3 @@ config DASD_EER
 	  This driver provides a character device interface to the
 	  DASD extended error reporting. This is only needed if you want to
 	  use applications written for the EER facility.
-
-endif
diff -urpN linux-2.6/drivers/s390/char/Kconfig linux-2.6-patched/drivers/s390/char/Kconfig
--- linux-2.6/drivers/s390/char/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -0,0 +1,166 @@
+comment "S/390 character device drivers"
+	depends on S390
+
+config TN3270
+	tristate "Support for locally attached 3270 terminals"
+	depends on CCW
+	help
+	  Include support for IBM 3270 terminals.
+
+config TN3270_TTY
+	tristate "Support for tty input/output on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for using an IBM 3270 terminal as a Linux tty.
+
+config TN3270_FS
+	tristate "Support for fullscreen applications on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for fullscreen applications on an IBM 3270 terminal.
+
+config TN3270_CONSOLE
+	bool "Support for console on 3270 terminal"
+	depends on TN3270=y && TN3270_TTY=y
+	help
+	  Include support for using an IBM 3270 terminal as a Linux system
+	  console.  Available only if 3270 support is compiled in statically.
+
+config TN3215
+	bool "Support for 3215 line mode terminal"
+	depends on CCW
+	help
+	  Include support for IBM 3215 line-mode terminals.
+
+config TN3215_CONSOLE
+	bool "Support for console on 3215 line mode terminal"
+	depends on TN3215
+	help
+	  Include support for using an IBM 3215 line-mode terminal as a
+	  Linux system console.
+
+config CCW_CONSOLE
+	bool
+	depends on TN3215_CONSOLE || TN3270_CONSOLE
+	default y
+
+config SCLP
+	bool "Support for SCLP"
+	depends on S390
+	help
+	  Include support for the SCLP interface to the service element.
+
+config SCLP_TTY
+	bool "Support for SCLP line mode terminal"
+	depends on SCLP
+	help
+	  Include support for IBM SCLP line-mode terminals.
+
+config SCLP_CONSOLE
+	bool "Support for console on SCLP line mode terminal"
+	depends on SCLP_TTY
+	help
+	  Include support for using an IBM HWC line-mode terminal as the Linux
+	  system console.
+
+config SCLP_VT220_TTY
+	bool "Support for SCLP VT220-compatible terminal"
+	depends on SCLP
+	help
+	  Include support for an IBM SCLP VT220-compatible terminal.
+
+config SCLP_VT220_CONSOLE
+	bool "Support for console on SCLP VT220-compatible terminal"
+	depends on SCLP_VT220_TTY
+	help
+	  Include support for using an IBM SCLP VT220-compatible terminal as a
+	  Linux system console.
+
+config SCLP_CPI
+	tristate "Control-Program Identification"
+	depends on SCLP
+	help
+	  This option enables the hardware console interface for system
+	  identification. This is commonly used for workload management and
+	  gives you a nice name for the system on the service element.
+	  Please select this option as a module since built-in operation is
+	  completely untested.
+	  You should only select this option if you know what you are doing,
+	  need this feature and intend to run your kernel in LPAR.
+
+config S390_TAPE
+	tristate "S/390 tape device support"
+	depends on CCW
+	help
+	  Select this option if you want to access channel-attached tape
+	  devices on IBM S/390 or zSeries.
+	  If you select this option you will also want to select at
+	  least one of the tape interface options and one of the tape
+	  hardware options in order to access a tape device.
+	  This option is also available as a module. The module will be
+	  called tape390 and include all selected interfaces and
+	  hardware drivers.
+
+comment "S/390 tape interface support"
+	depends on S390_TAPE
+
+config S390_TAPE_BLOCK
+	bool "Support for tape block devices"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access your channel-attached tape
+	  devices using the block device interface.  This interface is similar
+	  to CD-ROM devices on other platforms.  The tapes can only be
+	  accessed read-only when using this interface.  Have a look at
+	  <file:Documentation/s390/TAPE> for further information about creating
+	  volumes for and using this interface.  It is safe to say "Y" here.
+
+comment "S/390 tape hardware support"
+	depends on S390_TAPE
+
+config S390_TAPE_34XX
+	tristate "Support for 3480/3490 tape hardware"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access IBM 3480/3490 magnetic
+	  tape subsystems and 100% compatibles.
+	  It is safe to say "Y" here.
+
+config S390_TAPE_3590
+	tristate "Support for 3590 tape hardware"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access IBM 3590 magnetic
+	  tape subsystems and 100% compatibles.
+	  It is safe to say "Y" here.
+
+config VMLOGRDR
+	tristate "Support for the z/VM recording system services (VM only)"
+	depends on IUCV
+	help
+	  Select this option if you want to be able to receive records collected
+	  by the z/VM recording system services, eg. from *LOGREC, *ACCOUNT or
+	  *SYMPTOM.
+	  This driver depends on the IUCV support driver.
+
+config VMCP
+	tristate "Support for the z/VM CP interface (VM only)"
+	depends on S390
+	help
+	  Select this option if you want to be able to interact with the control
+	  program on z/VM
+
+
+config MONREADER
+	tristate "API for reading z/VM monitor service records"
+	depends on IUCV
+	help
+	  Character device driver for reading z/VM monitor service records
+
+config MONWRITER
+	tristate "API for writing z/VM monitor service records"
+	depends on S390
+	default "m"
+	help
+	  Character device driver for writing z/VM monitor service records
+
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2007-04-19 15:24:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	1970-01-01 01:00:00.000000000 +0100
@@ -1,239 +0,0 @@
-config CCW
-	bool
-	default y
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-
-menu "Character device drivers"
-
-config UNIX98_PTYS
-	bool "Unix98 PTY support"
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx for
-	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
-	  has a number of problems. The GNU C library glibc 2.1 and later,
-	  however, supports the Unix98 naming standard: in order to acquire a
-	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
-	  terminal is then made available to the process and the pseudo
-	  terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
-
-	  The entries in /dev/pts/ are created on the fly by a virtual
-	  file system; therefore, if you say Y here you should say Y to
-	  "/dev/pts file system for Unix98 PTYs" as well.
-
-	  If you want to say Y here, you need to have the C library glibc 2.1
-	  or later (equal to libc-6.1, check with "ls -l /lib/libc.so.*").
-	  Read the instructions in <file:Documentation/Changes> pertaining to
-	  pseudo terminals. It's safe to say N.
-
-config UNIX98_PTY_COUNT
-	int "Maximum number of Unix98 PTYs in use (0-2048)"
-	depends on UNIX98_PTYS
-	default "256"
-	help
-	  The maximum number of Unix98 PTYs that can be used at any one time.
-	  The default is 256, and should be enough for desktop systems. Server
-	  machines which support incoming telnet/rlogin/ssh connections and/or
-	  serve several X terminals may want to increase this: every incoming
-	  connection and every xterm uses up one PTY.
-
-	  When not in use, each additional set of 256 PTYs occupy
-	  approximately 8 KB of kernel memory on 32-bit architectures.
-
-config HANGCHECK_TIMER
-	tristate "Hangcheck timer"
-	help
-	  The hangcheck-timer module detects when the system has gone
-	  out to lunch past a certain margin.  It can reboot the system
-	  or merely print a warning.
-
-source "drivers/char/watchdog/Kconfig"
-
-comment "S/390 character device drivers"
-
-config TN3270
-	tristate "Support for locally attached 3270 terminals"
-	help
-	  Include support for IBM 3270 terminals.
-
-config TN3270_TTY
-	tristate "Support for tty input/output on 3270 terminals"
-	depends on TN3270
-	help
-	  Include support for using an IBM 3270 terminal as a Linux tty.
-
-config TN3270_FS
-	tristate "Support for fullscreen applications on 3270 terminals"
-	depends on TN3270
-	help
-	  Include support for fullscreen applications on an IBM 3270 terminal.
-
-config TN3270_CONSOLE
-	bool "Support for console on 3270 terminal"
-	depends on TN3270=y && TN3270_TTY=y
-	help
-	  Include support for using an IBM 3270 terminal as a Linux system
-	  console.  Available only if 3270 support is compiled in statically.
-
-config TN3215
-	bool "Support for 3215 line mode terminal"
-	help
-	  Include support for IBM 3215 line-mode terminals.
-
-config TN3215_CONSOLE
-	bool "Support for console on 3215 line mode terminal"
-	depends on TN3215
-	help
-	  Include support for using an IBM 3215 line-mode terminal as a
-	  Linux system console.
-
-config CCW_CONSOLE
- 	bool
- 	depends on TN3215_CONSOLE || TN3270_CONSOLE
- 	default y
- 
-config SCLP_TTY
-	bool "Support for SCLP line mode terminal"
-	help
-	  Include support for IBM SCLP line-mode terminals.
-
-config SCLP_CONSOLE
-	bool "Support for console on SCLP line mode terminal"
-	depends on SCLP_TTY
-	help
-	  Include support for using an IBM HWC line-mode terminal as the Linux
-	  system console.
-
-config SCLP_VT220_TTY
-	bool "Support for SCLP VT220-compatible terminal"
-	help
-	  Include support for an IBM SCLP VT220-compatible terminal.
-
-config SCLP_VT220_CONSOLE
-	bool "Support for console on SCLP VT220-compatible terminal"
-	depends on SCLP_VT220_TTY
-	help
-	  Include support for using an IBM SCLP VT220-compatible terminal as a
-	  Linux system console.
-
-config SCLP_CPI
-	tristate "Control-Program Identification"
-	help
-	  This option enables the hardware console interface for system
-	  identification. This is commonly used for workload management and
-	  gives you a nice name for the system on the service element.
-	  Please select this option as a module since built-in operation is
-	  completely untested.
-	  You should only select this option if you know what you are doing,
-	  need this feature and intend to run your kernel in LPAR.
-
-config S390_TAPE
-	tristate "S/390 tape device support"
-	help
-	  Select this option if you want to access channel-attached tape
-	  devices on IBM S/390 or zSeries.
-	  If you select this option you will also want to select at
-	  least one of the tape interface options and one of the tape
-	  hardware options in order to access a tape device.
-	  This option is also available as a module. The module will be
-	  called tape390 and include all selected interfaces and
-	  hardware drivers.
-
-comment "S/390 tape interface support"
-	depends on S390_TAPE
-
-config S390_TAPE_BLOCK
-	bool "Support for tape block devices"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access your channel-attached tape
-	  devices using the block device interface.  This interface is similar
-	  to CD-ROM devices on other platforms.  The tapes can only be
-	  accessed read-only when using this interface.  Have a look at
-	  <file:Documentation/s390/TAPE> for further information about creating
-	  volumes for and using this interface.  It is safe to say "Y" here.
-
-comment "S/390 tape hardware support"
-	depends on S390_TAPE
-
-config S390_TAPE_34XX
-	tristate "Support for 3480/3490 tape hardware"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access IBM 3480/3490 magnetic
-	  tape subsystems and 100% compatibles.
-	  It is safe to say "Y" here.
-
-config S390_TAPE_3590
-	tristate "Support for 3590 tape hardware"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access IBM 3590 magnetic
-	  tape subsystems and 100% compatibles.
-	  It is safe to say "Y" here.
-
-config VMLOGRDR
-	tristate "Support for the z/VM recording system services (VM only)"
-	depends on IUCV
-	help
-	  Select this option if you want to be able to receive records collected
-	  by the z/VM recording system services, eg. from *LOGREC, *ACCOUNT or
-	  *SYMPTOM.
-	  This driver depends on the IUCV support driver.
-
-config VMCP
-	tristate "Support for the z/VM CP interface (VM only)"
-	help
-	  Select this option if you want to be able to interact with the control
-	  program on z/VM
-
-
-config MONREADER
-	tristate "API for reading z/VM monitor service records"
-	depends on IUCV
-	help
-	  Character device driver for reading z/VM monitor service records
-
-config MONWRITER
-	tristate "API for writing z/VM monitor service records"
-	default "m"
-	help
-	  Character device driver for writing z/VM monitor service records
-
-endmenu
-
-menu "Cryptographic devices"
-
-config ZCRYPT
-	tristate "Support for PCI-attached cryptographic adapters"
-	select ZCRYPT_MONOLITHIC if ZCRYPT="y"
-	default "m"
-	help
-	  Select this option if you want to use a PCI-attached cryptographic
-	  adapter like:
-	  + PCI Cryptographic Accelerator (PCICA)
-	  + PCI Cryptographic Coprocessor (PCICC)
-	  + PCI-X Cryptographic Coprocessor (PCIXCC)
-	  + Crypto Express2 Coprocessor (CEX2C)
-	  + Crypto Express2 Accelerator (CEX2A)
-
-config ZCRYPT_MONOLITHIC
-	bool "Monolithic zcrypt module"
-	depends on ZCRYPT="m"
-	help
-	  Select this option if you want to have a single module z90crypt.ko
-	  that contains all parts of the crypto device driver (ap bus,
-	  request router and all the card drivers).
-
-endmenu
diff -urpN linux-2.6/drivers/s390/net/Kconfig linux-2.6-patched/drivers/s390/net/Kconfig
--- linux-2.6/drivers/s390/net/Kconfig	2007-04-19 15:24:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/Kconfig	2007-04-19 15:51:46.000000000 +0200
@@ -3,7 +3,7 @@ menu "S/390 network device drivers"
 
 config LCS
 	tristate "Lan Channel Station Interface"
-	depends on NETDEVICES && (NET_ETHERNET || TR || FDDI)
+	depends on CCW && NETDEVICES && (NET_ETHERNET || TR || FDDI)
 	help
 	   Select this option if you want to use LCS networking  on IBM S/390
   	   or zSeries. This device driver supports Token Ring (IEEE 802.5),
@@ -13,7 +13,7 @@ config LCS
 
 config CTC
 	tristate "CTC device support"
-	depends on NETDEVICES
+	depends on CCW && NETDEVICES
 	help
 	  Select this option if you want to use channel-to-channel networking
 	  on IBM S/390 or zSeries. This device driver supports real CTC
@@ -42,7 +42,7 @@ config SMSGIUCV
 
 config CLAW
 	tristate "CLAW device support"
-	depends on NETDEVICES
+	depends on CCW && NETDEVICES
 	help
 	  This driver supports channel attached CLAW devices.
 	  CLAW is Common Link Access for Workstation.  Common devices
@@ -52,7 +52,7 @@ config CLAW
 
 config QETH
 	tristate "Gigabit Ethernet device support"
-	depends on NETDEVICES && IP_MULTICAST && QDIO
+	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO
 	help
 	  This driver supports the IBM S/390 and zSeries OSA Express adapters
 	  in QDIO mode (all media types), HiperSockets interfaces and VM GuestLAN
diff -urpN linux-2.6/include/asm-s390/param.h linux-2.6-patched/include/asm-s390/param.h
--- linux-2.6/include/asm-s390/param.h	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/param.h	2007-04-19 15:51:46.000000000 +0200
@@ -10,7 +10,7 @@
 #define _ASMS390_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		100		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
