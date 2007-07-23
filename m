Return-Path: <linux-kernel-owner+w=401wt.eu-S1764736AbXGWIzx@vger.kernel.org>
Message-Id: <20070723085656.011043552@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/9] sclp: kill unused SCLP config option.
Content-Disposition: inline; filename=005-sclp-kconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

sclp is always compiled in.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/Kconfig |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/char/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Kconfig
+++ quilt-2.6/drivers/s390/char/Kconfig
@@ -44,15 +44,9 @@ config CCW_CONSOLE
 	depends on TN3215_CONSOLE || TN3270_CONSOLE
 	default y
 
-config SCLP
-	bool "Support for SCLP"
-	depends on S390
-	help
-	  Include support for the SCLP interface to the service element.
-
 config SCLP_TTY
 	bool "Support for SCLP line mode terminal"
-	depends on SCLP
+	depends on S390
 	help
 	  Include support for IBM SCLP line-mode terminals.
 
@@ -65,7 +59,7 @@ config SCLP_CONSOLE
 
 config SCLP_VT220_TTY
 	bool "Support for SCLP VT220-compatible terminal"
-	depends on SCLP
+	depends on S390
 	help
 	  Include support for an IBM SCLP VT220-compatible terminal.
 
@@ -78,7 +72,7 @@ config SCLP_VT220_CONSOLE
 
 config SCLP_CPI
 	tristate "Control-Program Identification"
-	depends on SCLP
+	depends on S390
 	help
 	  This option enables the hardware console interface for system
 	  identification. This is commonly used for workload management and

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
