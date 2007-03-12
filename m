Return-Path: <linux-kernel-owner+w=401wt.eu-S965848AbXCLNsf@vger.kernel.org>
Date: Mon, 12 Mar 2007 14:48:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] cio: qdio slsb setup
Message-ID: <20070312134839.GA10204@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: braunu@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

[S390] cio: qdio slsb setup

Make sure set_slsb problems are handled correctly in
qdio_do_qdio_fill_input() and qdio_do_qdio_fill_output.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2007-03-12 13:52:36.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2007-03-12 13:52:56.000000000 +0100
@@ -210,9 +210,11 @@ again:
 		goto again;
 	}
 	if (rc < 0) {
-                QDIO_DBF_TEXT3(1,trace,"sqberr");
-                sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt,*cnt,ccq,q_no);
-                QDIO_DBF_TEXT3(1,trace,dbf_text);
+		QDIO_DBF_TEXT3(1,trace,"sqberr");
+		sprintf(dbf_text,"%2x,%2x",tmp_cnt,*cnt);
+		QDIO_DBF_TEXT3(1,trace,dbf_text);
+		sprintf(dbf_text,"%d,%d",ccq,q_no);
+		QDIO_DBF_TEXT3(1,trace,dbf_text);
 		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
 				QDIO_STATUS_LOOK_FOR_ERROR,
 				0, 0, 0, -1, -1, q->int_parm);
@@ -1250,7 +1252,6 @@ qdio_is_inbound_q_done(struct qdio_q *q)
 	if (!no_used) {
 		QDIO_DBF_TEXT4(0,trace,"inqisdnA");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-		QDIO_DBF_TEXT4(0,trace,dbf_text);
 		return 1;
 	}
 	if (irq->is_qebsm) {
@@ -3371,10 +3372,15 @@ qdio_do_qdio_fill_input(struct qdio_q *q
 			unsigned int count, struct qdio_buffer *buffers)
 {
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+	int tmp = 0;
+
 	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
 	if (irq->is_qebsm) {
-		while (count)
-			set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
+		while (count) {
+			tmp = set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
+			if (!tmp)
+				return;
+		}
 		return;
 	}
 	for (;;) {
@@ -3390,11 +3396,15 @@ qdio_do_qdio_fill_output(struct qdio_q *
 			 unsigned int count, struct qdio_buffer *buffers)
 {
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+	int tmp = 0;
 
 	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
 	if (irq->is_qebsm) {
-		while (count)
-			set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
+		while (count) {
+			tmp = set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
+			if (!tmp)
+				return;
+		}
 		return;
 	}
 
