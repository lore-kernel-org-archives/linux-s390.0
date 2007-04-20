Return-Path: <linux-kernel-owner+w=401wt.eu-S2993005AbXDTLc6@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:33:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3/8] Kconfig: unwanted config options for s390.
Message-ID: <20070420113310.GD3738@skybase>
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

Disable all configuration options in the common Kconfig files that
are of no interest to a s390 machine.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/Kconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2007-04-19 15:49:51.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2007-04-19 15:50:50.000000000 +0200
@@ -6,6 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal" if EMBEDDED
+	depends on !S390
 	select INPUT
 	default y if !VIOCONS
 	---help---
@@ -81,6 +82,7 @@ config VT_HW_CONSOLE_BINDING
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on !S390
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -774,7 +776,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH
+	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -822,7 +824,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -878,6 +880,7 @@ config DTLK
 
 config R3964
 	tristate "Siemens R3964 line discipline"
+	depends on !S390
 	---help---
 	  This driver allows synchronous communication with devices using the
 	  Siemens R3964 packet protocol. Unless you are dealing with special
@@ -1053,7 +1056,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64
+	depends on X86 || IA64 || PPC64 || S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
