Return-Path: <linux-kernel-owner+w=401wt.eu-S937145AbXLTPnt@vger.kernel.org>
Message-Id: <20071220152105.992479981@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/47] qdio: Remove double checked value.
Content-Disposition: inline; filename=113-qdio-doublecheck.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@de.ibm.com>

Signed-off-by: Sebastian Ott <sebott@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -1408,8 +1408,7 @@ __tiqdio_inbound_processing(struct qdio_
 	if (q->hydra_gives_outbound_pcis) {
 		if (!q->siga_sync_done_on_thinints) {
 			SYNC_MEMORY_ALL;
-		} else if ((!q->siga_sync_done_on_outb_tis)&&
-			 (q->hydra_gives_outbound_pcis)) {
+		} else if (!q->siga_sync_done_on_outb_tis) {
 			SYNC_MEMORY_ALL_OUTB;
 		}
 	} else {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
