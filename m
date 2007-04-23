Return-Path: <linux-kernel-owner+w=401wt.eu-S1754059AbXDWOMz@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:13:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4/9] Kconfig: common config options for s390.
Message-ID: <20070423141309.GE21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Disable some configuration options in the common Kconfig files that
are of no interest to a s390 machine. Enable hangcheck timer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2007-04-23 15:53:01.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2007-04-23 15:53:09.000000000 +0200
@@ -6,6 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal" if EMBEDDED
+	depends on !S390
 	select INPUT
 	default y if !VIOCONS
 	---help---
@@ -775,7 +776,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH
+	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -823,7 +824,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -1054,7 +1055,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64
+	depends on X86 || IA64 || PPC64 || S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
