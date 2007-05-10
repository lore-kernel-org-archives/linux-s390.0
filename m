Return-Path: <linux-kernel-owner+w=401wt.eu-S1762486AbXEJN6m@vger.kernel.org>
Message-Id: <20070510135644.393485092@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/15] qdio: re-add lost perf_stats.tl_runs change in qdio_handle_pci
Content-Disposition: inline; filename=007-qdio-stats.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Statement has been inadvertently lost with commit
00c0c6466c66bdf05f2a3dcf59e6895179ea8b76.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -1983,6 +1983,7 @@ qdio_handle_pci(struct qdio_irq *irq_ptr
 		if (q->is_input_q&QDIO_FLAG_NO_INPUT_INTERRUPT_CONTEXT)
 			qdio_mark_q(q);
 		else {
+			qdio_perf_stat_dec(&perf_stats.tl_runs);
 			__qdio_inbound_processing(q);
 		}
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
