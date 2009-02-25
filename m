Return-Path: <linux-kernel-owner+w=401wt.eu-S1762761AbZBYPPH@vger.kernel.org>
Message-Id: <20090225150835.266333259@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 29/46] cio: ensure single load of irq handler pointer
Content-Disposition: inline; filename=128-cio-airq-barrier.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add barrier to prevent compiler from reloading pointer to irq handler.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/airq.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/drivers/s390/cio/airq.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/airq.c
+++ quilt-2.6/drivers/s390/cio/airq.c
@@ -133,6 +133,8 @@ void do_adapter_IO(u8 isc)
 		while (word) {
 			if (word & INDICATOR_MASK) {
 				airq = airqs[isc][i];
+				/* Make sure gcc reads from airqs only once. */
+				barrier();
 				if (likely(airq))
 					airq->handler(&indicators[isc].byte[i],
 						      airq->drv_data);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
