Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfJaMmc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCeCl3000686
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:31 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyy9fhcp3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:30 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:28 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/8] s390/qdio: implement IQD Multi-Write
Date: Thu, 31 Oct 2019 13:42:14 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This allows IQD drivers to send out multiple SBALs with a single SIGA
instruction.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/s390/cio/qdio.h      |  1 +
 drivers/s390/cio/qdio_main.c | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index a58b45df95d7..2a34a2ab9bf7 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -82,6 +82,7 @@ enum qdio_irq_states {
 #define QDIO_SIGA_WRITE		0x00
 #define QDIO_SIGA_READ		0x01
 #define QDIO_SIGA_SYNC		0x02
+#define QDIO_SIGA_WRITEM	0x03
 #define QDIO_SIGA_WRITEQ	0x04
 #define QDIO_SIGA_QEBSM_FLAG	0x80
 
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 5b63c505a2f7..7368407030b0 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -310,18 +310,19 @@ static inline int qdio_siga_sync_q(struct qdio_q *q)
 		return qdio_siga_sync(q, q->mask, 0);
 }
 
-static int qdio_siga_output(struct qdio_q *q, unsigned int *busy_bit,
-	unsigned long aob)
+static int qdio_siga_output(struct qdio_q *q, unsigned int count,
+			    unsigned int *busy_bit, unsigned long aob)
 {
 	unsigned long schid = *((u32 *) &q->irq_ptr->schid);
 	unsigned int fc = QDIO_SIGA_WRITE;
 	u64 start_time = 0;
 	int retries = 0, cc;
-	unsigned long laob = 0;
 
-	if (aob) {
-		fc = QDIO_SIGA_WRITEQ;
-		laob = aob;
+	if (queue_type(q) == QDIO_IQDIO_QFMT && !multicast_outbound(q)) {
+		if (count > 1)
+			fc = QDIO_SIGA_WRITEM;
+		else if (aob)
+			fc = QDIO_SIGA_WRITEQ;
 	}
 
 	if (is_qebsm(q)) {
@@ -329,7 +330,7 @@ static int qdio_siga_output(struct qdio_q *q, unsigned int *busy_bit,
 		fc |= QDIO_SIGA_QEBSM_FLAG;
 	}
 again:
-	cc = do_siga_output(schid, q->mask, busy_bit, fc, laob);
+	cc = do_siga_output(schid, q->mask, busy_bit, fc, aob);
 
 	/* hipersocket busy condition */
 	if (unlikely(*busy_bit)) {
@@ -781,7 +782,8 @@ static inline int qdio_outbound_q_moved(struct qdio_q *q, unsigned int start)
 	return count;
 }
 
-static int qdio_kick_outbound_q(struct qdio_q *q, unsigned long aob)
+static int qdio_kick_outbound_q(struct qdio_q *q, unsigned int count,
+				unsigned long aob)
 {
 	int retries = 0, cc;
 	unsigned int busy_bit;
@@ -793,7 +795,7 @@ static int qdio_kick_outbound_q(struct qdio_q *q, unsigned long aob)
 retry:
 	qperf_inc(q, siga_write);
 
-	cc = qdio_siga_output(q, &busy_bit, aob);
+	cc = qdio_siga_output(q, count, &busy_bit, aob);
 	switch (cc) {
 	case 0:
 		break;
@@ -1526,7 +1528,7 @@ static int handle_inbound(struct qdio_q *q, unsigned int callflags,
  * @count: how many buffers are filled
  */
 static int handle_outbound(struct qdio_q *q, unsigned int callflags,
-			   int bufnr, int count)
+			   unsigned int bufnr, unsigned int count)
 {
 	const unsigned int scan_threshold = q->irq_ptr->scan_threshold;
 	unsigned char state = 0;
@@ -1549,13 +1551,10 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 	if (queue_type(q) == QDIO_IQDIO_QFMT) {
 		unsigned long phys_aob = 0;
 
-		/* One SIGA-W per buffer required for unicast HSI */
-		WARN_ON_ONCE(count > 1 && !multicast_outbound(q));
-
-		if (q->u.out.use_cq)
+		if (q->u.out.use_cq && count == 1)
 			phys_aob = qdio_aob_for_buffer(&q->u.out, bufnr);
 
-		rc = qdio_kick_outbound_q(q, phys_aob);
+		rc = qdio_kick_outbound_q(q, count, phys_aob);
 	} else if (need_siga_sync(q)) {
 		rc = qdio_siga_sync_q(q);
 	} else if (count < QDIO_MAX_BUFFERS_PER_Q &&
@@ -1564,7 +1563,7 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 		/* The previous buffer is not processed yet, tack on. */
 		qperf_inc(q, fast_requeue);
 	} else {
-		rc = qdio_kick_outbound_q(q, 0);
+		rc = qdio_kick_outbound_q(q, count, 0);
 	}
 
 	/* Let drivers implement their own completion scanning: */
-- 
2.17.1
