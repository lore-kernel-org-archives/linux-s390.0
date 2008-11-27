Return-Path: <linux-kernel-owner+w=401wt.eu-S1755307AbYK0KhE@vger.kernel.org>
Message-Id: <20081127103131.672503551@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/60] qdio: improve error handling for unexpected buffer states
Content-Disposition: inline; filename=113-qdio-error-handling.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

In case of a qdio internal problem regarding the buffer handling
advance the queue and report the problem with WARN_ON instead
of getting stuck.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -476,9 +476,12 @@ check_next:
 		atomic_sub(count, &q->nr_buf_used);
 		break;
 	case SLSB_CU_INPUT_EMPTY:
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in nop");
+		break;
 	case SLSB_P_INPUT_NOT_INIT:
 	case SLSB_P_INPUT_ACK:
-		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in nop");
+		WARN_ON(1);
+		q->first_to_check++;
 		break;
 	default:
 		BUG();
@@ -648,6 +651,9 @@ check_next:
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "out primed:%1d", q->nr);
 		break;
 	case SLSB_P_OUTPUT_NOT_INIT:
+		WARN_ON(1);
+		q->first_to_check++;
+		break;
 	case SLSB_P_OUTPUT_HALTED:
 		break;
 	default:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
