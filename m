Return-Path: <linux-kernel-owner+w=401wt.eu-S1756504AbYGaMmZ@vger.kernel.org>
Message-Id: <20080731123933.096225651@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] cio: Include linux/string.h in schid.h.
Content-Disposition: inline; filename=103-cio-string.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

schid.h needs string.h for memset and memcmp.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/schid.h |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/include/asm-s390/schid.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/schid.h
+++ quilt-2.6/include/asm-s390/schid.h
@@ -11,6 +11,7 @@ struct subchannel_id {
 } __attribute__ ((packed, aligned(4)));
 
 #ifdef __KERNEL__
+#include <linux/string.h>
 
 /* Helper function for sane state of pre-allocated subchannel_id. */
 static inline void

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
