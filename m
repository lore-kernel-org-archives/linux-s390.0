Return-Path: <linux-kernel-owner+w=401wt.eu-S1764750AbXGJJdE@vger.kernel.org>
Message-Id: <20070710093122.774342855@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/16] cio: Remove prototype for non-existing function cmf_reset().
Content-Disposition: inline; filename=014-cio-rmfn.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/cmb.h |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/include/asm-s390/cmb.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cmb.h
+++ quilt-2.6/include/asm-s390/cmb.h
@@ -88,7 +88,6 @@ extern u64 cmf_read(struct ccw_device *c
  *    any
  **/
 extern int cmf_readall(struct ccw_device *cdev, struct cmbdata*data);
-extern void cmf_reset(struct ccw_device *cdev);
 
 #endif /* __KERNEL__ */
 #endif /* S390_CMB_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
