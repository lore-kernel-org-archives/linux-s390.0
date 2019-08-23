Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394133AbfHWJtD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 05:49:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9kiIg100380
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujbwgvgkx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:02 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 23 Aug 2019 10:49:00 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/7] s390/qdio: enable drivers to poll for Output completions
Date: Fri, 23 Aug 2019 11:48:47 +0200
In-Reply-To: <20190823094853.63814-1-jwi@linux.ibm.com>
References: <20190823094853.63814-1-jwi@linux.ibm.com>
Message-Id: <20190823094853.63814-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

While commit d36deae75011 ("qdio: extend API to allow polling") enhanced
the qdio layer so that drivers can poll their Input Queues, we don't
have the corresponding infrastructure for Output Queues yet.

Factor out a helper that scans a single QDIO Queue, so that qeth can
implement TX NAPI on top of it.
While doing so, remove the duplicated tracking of the next-to-scan index
(q->first_to_check vs q->first_to_kick) in this code path.

qdio_handle_aobs() needs to move slightly upwards in the code hierarchy,
so that it's still called from the polling path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/qdio.h |  3 ++
 drivers/s390/cio/qdio_main.c | 64 ++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index f647d565bd6d..79b4a3e9dc5d 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -416,6 +416,9 @@ extern int do_QDIO(struct ccw_device *, unsigned int, int, unsigned int,
 extern int qdio_start_irq(struct ccw_device *, int);
 extern int qdio_stop_irq(struct ccw_device *, int);
 extern int qdio_get_next_buffers(struct ccw_device *, int, int *, int *);
+extern int qdio_inspect_queue(struct ccw_device *cdev, unsigned int nr,
+			      bool is_input, unsigned int *bufnr,
+			      unsigned int *error);
 extern int qdio_shutdown(struct ccw_device *, int);
 extern int qdio_free(struct ccw_device *);
 extern int qdio_get_ssqd_desc(struct ccw_device *, struct qdio_ssqd_desc *);
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 4142c85e77d8..5efba0d29190 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -647,8 +647,6 @@ static void qdio_kick_handler(struct qdio_q *q, unsigned int count)
 		qperf_inc(q, outbound_handler);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "koh: s:%02x c:%02x",
 			      start, count);
-		if (q->u.out.use_cq)
-			qdio_handle_aobs(q, start, count);
 	}
 
 	q->handler(q->irq_ptr->cdev, q->qdio_error, q->nr, start, count,
@@ -774,8 +772,11 @@ static inline int qdio_outbound_q_moved(struct qdio_q *q, unsigned int start)
 
 	count = get_outbound_buffer_frontier(q, start);
 
-	if (count)
+	if (count) {
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "out moved:%1d", q->nr);
+		if (q->u.out.use_cq)
+			qdio_handle_aobs(q, start, count);
+	}
 
 	return count;
 }
@@ -1655,6 +1656,44 @@ int qdio_start_irq(struct ccw_device *cdev, int nr)
 }
 EXPORT_SYMBOL(qdio_start_irq);
 
+static int __qdio_inspect_queue(struct qdio_q *q, unsigned int *bufnr,
+				unsigned int *error)
+{
+	unsigned int start = q->first_to_check;
+	int count;
+
+	count = q->is_input_q ? qdio_inbound_q_moved(q, start) :
+				qdio_outbound_q_moved(q, start);
+	if (count == 0)
+		return 0;
+
+	*bufnr = start;
+	*error = q->qdio_error;
+
+	/* for the next time */
+	q->first_to_check = add_buf(start, count);
+	q->qdio_error = 0;
+
+	return count;
+}
+
+int qdio_inspect_queue(struct ccw_device *cdev, unsigned int nr, bool is_input,
+		       unsigned int *bufnr, unsigned int *error)
+{
+	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
+	struct qdio_q *q;
+
+	if (!irq_ptr)
+		return -ENODEV;
+	q = is_input ? irq_ptr->input_qs[nr] : irq_ptr->output_qs[nr];
+
+	if (need_siga_sync(q))
+		qdio_siga_sync_q(q);
+
+	return __qdio_inspect_queue(q, bufnr, error);
+}
+EXPORT_SYMBOL_GPL(qdio_inspect_queue);
+
 /**
  * qdio_get_next_buffers - process input buffers
  * @cdev: associated ccw_device for the qdio subchannel
@@ -1672,13 +1711,10 @@ int qdio_get_next_buffers(struct ccw_device *cdev, int nr, int *bufnr,
 {
 	struct qdio_q *q;
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
-	unsigned int start;
-	int count;
 
 	if (!irq_ptr)
 		return -ENODEV;
 	q = irq_ptr->input_qs[nr];
-	start = q->first_to_check;
 
 	/*
 	 * Cannot rely on automatic sync after interrupt since queues may
@@ -1689,25 +1725,11 @@ int qdio_get_next_buffers(struct ccw_device *cdev, int nr, int *bufnr,
 
 	qdio_check_outbound_pci_queues(irq_ptr);
 
-	count = qdio_inbound_q_moved(q, start);
-	if (count == 0)
-		return 0;
-
-	start = add_buf(start, count);
-	q->first_to_check = start;
-
 	/* Note: upper-layer MUST stop processing immediately here ... */
 	if (unlikely(q->irq_ptr->state != QDIO_IRQ_STATE_ACTIVE))
 		return -EIO;
 
-	*bufnr = q->first_to_kick;
-	*error = q->qdio_error;
-
-	/* for the next time */
-	q->first_to_kick = add_buf(q->first_to_kick, count);
-	q->qdio_error = 0;
-
-	return count;
+	return __qdio_inspect_queue(q, bufnr, error);
 }
 EXPORT_SYMBOL(qdio_get_next_buffers);
 
-- 
2.17.1
