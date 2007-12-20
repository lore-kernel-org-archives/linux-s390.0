Return-Path: <linux-kernel-owner+w=401wt.eu-S965943AbXLTPj2@vger.kernel.org>
Message-Id: <20071220152109.145602064@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 28/47] Remove appldata include from sysctl_check.c
Content-Disposition: inline; filename=127-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Forgot to remove this when removing the appldata binary sysctls.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 kernel/sysctl_check.c |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/kernel/sysctl_check.c
===================================================================
--- quilt-2.6.orig/kernel/sysctl_check.c
+++ quilt-2.6/kernel/sysctl_check.c
@@ -1,6 +1,5 @@
 #include <linux/stat.h>
 #include <linux/sysctl.h>
-#include "../arch/s390/appldata/appldata.h"
 #include "../fs/xfs/linux-2.6/xfs_sysctl.h"
 #include <linux/sunrpc/debug.h>
 #include <linux/string.h>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
