Return-Path: <linux-kernel-owner+w=401wt.eu-S1762244AbZBYPNt@vger.kernel.org>
Message-Id: <20090225150832.347579350@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 19/46] Fix appldata build break with !NET
Content-Disposition: inline; filename=118-appldata-build.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sachin Sant <sachinp@in.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sachin Sant <sachinp@in.ibm.com>

With CONFIG_NET not set appldata build breaks on s390.

arch/s390/appldata/built-in.o: In function appldata_get_net_sum_data:
appldata_net_sum.c:(.text+0x2684): undefined reference to dev_get_stats
appldata_net_sum.c:(.text+0x2688): undefined reference to init_net
appldata_net_sum.c:(.text+0x268c): undefined reference to init_net
appldata_net_sum.c:(.text+0x2694): undefined reference to dev_base_lock

The following patch fixes the issue for me.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -521,7 +521,7 @@ config APPLDATA_OS
 
 config APPLDATA_NET_SUM
 	tristate "Monitor overall network statistics"
-	depends on APPLDATA_BASE
+	depends on APPLDATA_BASE && NET
 	help
 	  This provides network related data to the Linux - VM Monitor Stream,
 	  currently there is only a total sum of network I/O statistics, no

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
