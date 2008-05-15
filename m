Return-Path: <linux-kernel-owner+w=401wt.eu-S932693AbYEOPFw@vger.kernel.org>
Message-Id: <20080515150008.584696442@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/11] blacklist.c: removed duplicated include
Content-Disposition: inline; filename=005-cio-include.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Huang Weiyi <weiyi.huang@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huang Weiyi <weiyi.huang@gmail.com>

Removed duplicated include <asm/cio.h>
in drivers/s390/cio/blacklist.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -19,7 +19,6 @@
 
 #include <asm/cio.h>
 #include <asm/uaccess.h>
-#include <asm/cio.h>
 
 #include "blacklist.h"
 #include "cio.h"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
