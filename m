Return-Path: <linux-kernel-owner+w=401wt.eu-S1759884AbYBSOt5@vger.kernel.org>
Message-Id: <20080219144506.067881522@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:41:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/13] qdio: FCP/SCSI write I/O stagnates on LPAR
Content-Disposition: inline; filename=013-qdio-stalls.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

If running on LPAR, qdio might overlook an incoming buffer in certain
scenarios. The patch makes sure that incoming buffers are detected
immediately in all situations.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    3 ---
 1 file changed, 3 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -1215,9 +1215,6 @@ tiqdio_is_inbound_q_done(struct qdio_q *
 
 	if (!no_used)
 		return 1;
-	if (!q->siga_sync && !irq->is_qebsm)
-		/* we'll check for more primed buffers in qeth_stop_polling */
-		return 0;
 	if (irq->is_qebsm) {
 		count = 1;
 		start_buf = q->first_to_check;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
