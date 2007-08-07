Return-Path: <linux-kernel-owner+w=401wt.eu-S1763788AbXHGLRI@vger.kernel.org>
Message-Id: <20070807111845.647123600@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/18] remove DEFAULT_MIGRATION_COST
Content-Disposition: inline; filename=004-migration.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

0437e109e1841607f2988891eaa36c531c6aa6ac removes the migration
cost init code. Remove the s390 leftovers as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    4 ----
 1 file changed, 4 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -109,10 +109,6 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
-config DEFAULT_MIGRATION_COST
-	int
-	default "1000000"
-
 config MATHEMU
 	bool "IEEE FPU emulation"
 	depends on MARCH_G5

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
