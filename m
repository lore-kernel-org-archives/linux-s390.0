Return-Path: <linux-kernel-owner+w=401wt.eu-S933367AbXGWI5U@vger.kernel.org>
Message-Id: <20070723085714.929460242@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 8/9] add types.h include to s390_ext.h
Content-Disposition: inline; filename=008-s390-ext.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The header file for external interrupts uses the _u16 type. Make sure
that _u16 is defined by including linux/types.h. This prevents compile
failures, if asm/s390_ext.h is the first include file. 

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/s390_ext.h |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/include/asm-s390/s390_ext.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/s390_ext.h
+++ quilt-2.6/include/asm-s390/s390_ext.h
@@ -10,6 +10,8 @@
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
+#include <linux/types.h>
+
 typedef void (*ext_int_handler_t)(__u16 code);
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
