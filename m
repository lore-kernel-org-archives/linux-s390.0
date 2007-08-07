Return-Path: <linux-kernel-owner+w=401wt.eu-S1760965AbXHGLQL@vger.kernel.org>
Message-Id: <20070807111844.909113621@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/18] cio: avoid memory leak on error in css_alloc_subchannel().
Content-Disposition: inline; filename=001-cio-leak.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

sch->lock has been allocated in cio_validate_subchannel(), it must be
freed if cio_modify() fails.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -79,6 +79,7 @@ css_alloc_subchannel(struct subchannel_i
 	sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
 	ret = cio_modify(sch);
 	if (ret) {
+		kfree(sch->lock);
 		kfree(sch);
 		return ERR_PTR(ret);
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
