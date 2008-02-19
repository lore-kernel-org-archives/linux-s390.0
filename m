Return-Path: <linux-kernel-owner+w=401wt.eu-S1759035AbYBSOqR@vger.kernel.org>
Message-Id: <20080219144503.431421445@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/13] Let NR_CPUS default to 32/64 on s390/s390x.
Content-Disposition: inline; filename=003-nrcpus.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -100,7 +100,8 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
 	depends on SMP
-	default "32"
+	default "32" if !64BIT
+	default "64" if 64BIT
 	help
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  The maximum supported value is 64 and the

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
