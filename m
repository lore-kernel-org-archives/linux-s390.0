Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBF472F81
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814483; cv=none; b=JFoMeTCsEZIgwVaHkQXNmGV1wsSRXZ2wNuUEV6Sof+7mcvlhp70AfGYWCorCN7wBnLieRRZqKPti49tO+UI8v3eSxAhLvS+TraLKw3NE4Fn2gOf0hezR2aaKPvWonEQZEdxepfXyEX6c06K9sRwOKVnnwdFNAPX8Rkxl1+b83GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814483; c=relaxed/simple;
	bh=oPQfpZzJE+iYFb26StAUMaPp9xqyxBxckQiW1JM4yAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obPQYktlSKVj8tdPA89jYKUSg0dTsT178s0rq/IqAZ4tbg2XvcjsJQ4A67hyutvesYPGmArKxTaKzV53ldfilsn2eoTEP+yQ0vBD5yW2ycxqtf5WZ7YwJIqU0akLrrVG0ADHaCgMZfA0bVUojDJ4YcShfxfNxazOR8fi1QWYbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqtXQUrd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqtXQUrd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBmP03089951
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8FJeqR6NWx60B8ir/
	DxzYfX8VcDK5uedcdhj+jU7DGI=; b=DqtXQUrdNTjag/yC6YU1W/KyNZBVUu893
	2eFxldvpSKR3K7PK3xn2GNXkGcDPH59SzKItYyQLuWINxIH2IWcy4pvpzonMSIro
	339srHsxg6MIIaGBdgOXZKMz2m5iPwqblj/KLSbY8Jrcqg5xOjqp1/AnNamX6ZoH
	d18J7Fnh2o+8Syr4XDMgf+rHYYIxQT6g0hD8ASeIeu+yD5gPSZ3F1GlFyV2cPTLD
	ini11m25tWkrwGpJDraWgyXlzwgYgpaqk4qbqC6PE5qbAVoBBVlja5v/gDxRDcL5
	vpHhQUslmVoxAc+7uRwOCbaW9LKcBJMXKKueUsabnFekJC/Wi8LkQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abquq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYaRW021334
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcc34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDllGt11010350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE81320040;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0632004D;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 02/13] s390/dasd: Add infrastructure for ESE full-track write
Date: Thu, 23 Jul 2026 15:47:32 +0200
Message-ID: <20260723134743.672413-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXy+xFCPGozwG2
 TayLqfgE9KdeVBoDoCBJz0dZhgkJr1OqsLA1pFIDvB2yVt8MbAt80apSntcftiaHHDjEq6w3sAy
 o+OALt0d6vnZMDLSBlXb8aPNWo4T1xpVRMNZJ8usikRL79OpYtkUZ9vOE2IX23ESYrMw+HBdvFb
 r6wp91D6BMkM6Rp4azecMs/ScYk7uGT1UQRh7BEz9CZsid/ZriB3+TILSFkHdIilyv+P46FGJ5G
 pxjBEpixovaap+HaNbTOs2etEgY+A3G5SUz/rAmLSIXa/mYkB2B3X0ZVQafEBlJjoB5gcxwdCbA
 mfAfcPUS2BgVf+VitwOrHAKZTLQ3cLVUqjuWRE+kvEAgdgS+IGwPEBi1IHXAO37MhhyDt7bVRhJ
 F/gFmf84bI4037hubwUmT2lCyayFM8Bmj8vjiw22Amnunxzi0iq1tmNbH7DYA4U5+tZP9G1nX0V
 bx26QMesRm76RhQTS/A==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dcWMGS4g1NbR-JThP0oA:9
X-Proofpoint-ORIG-GUID: tT__-5VcsgHcGDC4gshFQjGOqneVMGQe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX2WBq1ELOwOc4
 uDKfXnhYW3ZRhEF8Tm/0Hn56r5HxmtYwR7TqSQ0eK4owF2rekCID0uWO4xRXoDXhvlba9HJfrU6
 GXb5XHIWiUaaNxBVaVo7pzC33WS26AE=
X-Proofpoint-GUID: tT__-5VcsgHcGDC4gshFQjGOqneVMGQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Add the driver internals to build WRITE_FULL_TRACK FCX channel programs
in response to unformated tracks on ESE devices.

struct dasd_ccw_req: filldata/fill_chunks for the per-track metadata
buffer (R0 + count records) the CCW program TIDAWs into, and
format/start_trk/end_trk/collision linking a request to its format-track
guard entry.

struct dasd_device: fill_mem/fill_chunks pool for those buffers and a
zeroed nulldata page used as the data source for pad records.

struct dasd_block: ese_staging/ese_lock, a hardirq-safe staging list for
ESE format CQRs spliced into ccw_queue from dasd_block_tasklet (enqueuing
directly from the IRQ handler would invert queue_lock / ccwdev_lock).

Add CQR states DASD_CQR_ABORT/ABORTED to retire the origin CQR of a
replaced write without completing it to the block layer, and struct
eckd_r0 for the track header record.

The CCW and ESE format pools are enlarged (a full-track ITCW is roughly
twice a plain track-mode one) to keep two maximum-size requests in
flight. Since dasd_alloc_device() runs in process context (device
set_online), these pool allocations now use GFP_KERNEL rather than
GFP_ATOMIC, which is more reliable for the larger, order-2 DMA
allocations.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 105 +++++++++++++++++++++++++++------
 drivers/s390/block/dasd_eckd.c |  11 ++++
 drivers/s390/block/dasd_eckd.h |   5 ++
 drivers/s390/block/dasd_int.h  |  19 ++++++
 4 files changed, 122 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dc1c6d5ab3be..a8dea7503dce 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -87,35 +87,57 @@ struct dasd_device *dasd_alloc_device(void)
 {
 	struct dasd_device *device;
 
-	device = kzalloc_obj(struct dasd_device, GFP_ATOMIC);
+	device = kzalloc_obj(struct dasd_device, GFP_KERNEL);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
 
-	/* Get two pages for normal block device operations. */
-	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	/*
+	 * Four pages: a full-track ITCW is roughly twice the size of a plain
+	 * track-mode one, so this keeps two maximum-size requests in flight.
+	 */
+	device->ccw_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 2);
 	if (!device->ccw_mem) {
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
+	/* per-request track-filler buffers (R0 + count records) */
+	device->fill_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
+	if (!device->fill_mem) {
+		free_pages((unsigned long)device->ccw_mem, 2);
+		kfree(device);
+		return ERR_PTR(-ENOMEM);
+	}
 	/* Get one page for error recovery. */
-	device->erp_mem = (void *) get_zeroed_page(GFP_ATOMIC | GFP_DMA);
+	device->erp_mem = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!device->erp_mem) {
-		free_pages((unsigned long) device->ccw_mem, 1);
+		free_pages((unsigned long)device->fill_mem, 1);
+		free_pages((unsigned long)device->ccw_mem, 2);
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
-	/* Get two pages for ese format. */
-	device->ese_mem = (void *)__get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	/* sized like ccw_chunks: two max-size NRF format requests in flight */
+	device->ese_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 2);
 	if (!device->ese_mem) {
-		free_page((unsigned long) device->erp_mem);
-		free_pages((unsigned long) device->ccw_mem, 1);
+		free_page((unsigned long)device->erp_mem);
+		free_pages((unsigned long)device->fill_mem, 1);
+		free_pages((unsigned long)device->ccw_mem, 2);
+		kfree(device);
+		return ERR_PTR(-ENOMEM);
+	}
+	device->nulldata = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!device->nulldata) {
+		free_page((unsigned long)device->erp_mem);
+		free_pages((unsigned long)device->fill_mem, 1);
+		free_pages((unsigned long)device->ccw_mem, 2);
+		free_pages((unsigned long)device->ese_mem, 2);
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE*2);
+	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE * 4);
+	dasd_init_chunklist(&device->fill_chunks, device->fill_mem, PAGE_SIZE * 2);
 	dasd_init_chunklist(&device->erp_chunks, device->erp_mem, PAGE_SIZE);
-	dasd_init_chunklist(&device->ese_chunks, device->ese_mem, PAGE_SIZE * 2);
+	dasd_init_chunklist(&device->ese_chunks, device->ese_mem, PAGE_SIZE * 4);
 	spin_lock_init(&device->mem_lock);
 	atomic_set(&device->tasklet_scheduled, 0);
 	tasklet_init(&device->tasklet, dasd_device_tasklet,
@@ -138,9 +160,11 @@ struct dasd_device *dasd_alloc_device(void)
 void dasd_free_device(struct dasd_device *device)
 {
 	kfree(device->private);
-	free_pages((unsigned long) device->ese_mem, 1);
-	free_page((unsigned long) device->erp_mem);
-	free_pages((unsigned long) device->ccw_mem, 1);
+	free_pages((unsigned long)device->ese_mem, 2);
+	free_page((unsigned long)device->erp_mem);
+	free_pages((unsigned long)device->fill_mem, 1);
+	free_pages((unsigned long)device->ccw_mem, 2);
+	free_page((unsigned long)device->nulldata);
 	kfree(device);
 }
 
@@ -164,6 +188,8 @@ struct dasd_block *dasd_alloc_block(void)
 	spin_lock_init(&block->queue_lock);
 	INIT_LIST_HEAD(&block->format_list);
 	spin_lock_init(&block->format_lock);
+	INIT_LIST_HEAD(&block->ese_staging);
+	spin_lock_init(&block->ese_lock);
 	timer_setup(&block->timer, dasd_block_timeout, 0);
 	spin_lock_init(&block->profile.lock);
 
@@ -364,7 +390,8 @@ int _wait_for_empty_queues(struct dasd_device *device)
 {
 	if (device->block)
 		return list_empty(&device->ccw_queue) &&
-			list_empty(&device->block->ccw_queue);
+			list_empty(&device->block->ccw_queue) &&
+			list_empty(&device->block->ese_staging);
 	else
 		return list_empty(&device->ccw_queue);
 }
@@ -1224,7 +1251,18 @@ void dasd_sfree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device->mem_lock, flags);
-	dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
+	/*
+	 * Free the request block from the pool it came from: smalloc() sets
+	 * mem_chunk (ccw_chunks), fmalloc() leaves it NULL (ese_chunks). A
+	 * full-track request also frees its track-filler buffer.
+	 */
+	if (cqr->filldata)
+		dasd_free_chunk(&device->fill_chunks, cqr->filldata);
+	if (cqr->mem_chunk)
+		dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
+	else
+		dasd_free_chunk(&device->ese_chunks, cqr);
+
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	dasd_put_device(device);
 }
@@ -1235,6 +1273,8 @@ void dasd_ffree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device->mem_lock, flags);
+	if (cqr->filldata)
+		dasd_free_chunk(&device->fill_chunks, cqr->filldata);
 	dasd_free_chunk(&device->ese_chunks, cqr);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	dasd_put_device(device);
@@ -1883,6 +1923,10 @@ static void __dasd_process_cqr(struct dasd_device *device,
 	case DASD_CQR_CLEARED:
 		cqr->status = DASD_CQR_TERMINATED;
 		break;
+	case DASD_CQR_ABORT:
+		cqr->status = DASD_CQR_ABORTED;
+		cqr->callback = NULL;
+		break;
 	default:
 		dev_err(&device->cdev->dev,
 			"Unexpected CQR status %02x", cqr->status);
@@ -2210,6 +2254,7 @@ EXPORT_SYMBOL(dasd_add_request_tail);
 void dasd_wakeup_cb(struct dasd_ccw_req *cqr, void *data)
 {
 	spin_lock_irq(get_ccwdev_lock(cqr->startdev->cdev));
+	cqr->endclk = get_tod_clock();
 	cqr->callback_data = DASD_SLEEPON_END_TAG;
 	spin_unlock_irq(get_ccwdev_lock(cqr->startdev->cdev));
 	wake_up(&generic_waitq);
@@ -2726,7 +2771,9 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
 			error = BLK_STS_IOERR;
 			break;
 		}
-	}
+	} else if (status == DASD_CQR_ABORTED)
+		/* aborted requests are replaced with a new one so do not complete this */
+		return;
 
 	/*
 	 * We need to take care for ETIMEDOUT errors here since the
@@ -2771,7 +2818,8 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 		if (cqr->status != DASD_CQR_DONE &&
 		    cqr->status != DASD_CQR_FAILED &&
 		    cqr->status != DASD_CQR_NEED_ERP &&
-		    cqr->status != DASD_CQR_TERMINATED)
+		    cqr->status != DASD_CQR_TERMINATED &&
+		    cqr->status != DASD_CQR_ABORTED)
 			continue;
 
 		if (cqr->status == DASD_CQR_TERMINATED) {
@@ -2879,9 +2927,21 @@ static void dasd_block_tasklet(unsigned long data)
 	struct dasd_ccw_req *cqr;
 	struct dasd_queue *dq;
 
+	if (!block) {
+		WARN_ON_ONCE(!block);
+		return;
+	}
 	atomic_set(&block->tasklet_scheduled, 0);
 	INIT_LIST_HEAD(&final_queue);
 	spin_lock_irq(&block->queue_lock);
+	/*
+	 * Splice the hardirq-staged ESE format CQRs onto ccw_queue. Splice to
+	 * the tail so an aborted origin request (already on ccw_queue) is
+	 * retired before its format-CQR replacement completes and requeues it.
+	 */
+	spin_lock(&block->ese_lock);
+	list_splice_tail_init(&block->ese_staging, &block->ccw_queue);
+	spin_unlock(&block->ese_lock);
 	/* Finish off requests on ccw queue */
 	__dasd_process_block_ccw_queue(block, &final_queue);
 	spin_unlock_irq(&block->queue_lock);
@@ -2941,6 +3001,15 @@ static int _dasd_requests_to_flushqueue(struct dasd_block *block,
 	int rc, i;
 
 	spin_lock_irqsave(&block->queue_lock, flags);
+	/*
+	 * Splice any hardirq-staged ESE format CQRs onto ccw_queue first so
+	 * they are seen and canceled by the walk below instead of being
+	 * orphaned across this flush / state transition. Mirrors the splice
+	 * in dasd_block_tasklet().
+	 */
+	spin_lock(&block->ese_lock);
+	list_splice_tail_init(&block->ese_staging, &block->ccw_queue);
+	spin_unlock(&block->ese_lock);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 073795ea7cd0..52f3859ef537 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -204,6 +204,17 @@ static void set_ch_t(struct ch_t *geo, __u32 cyl, __u8 head)
 	geo->head |= head;
 }
 
+static void set_chr_t(void *addr, __u32 cyl, __u8 head, __u8 record)
+{
+	struct chr_t *geo = addr;
+
+	geo->cyl = (__u16)cyl;
+	geo->head = cyl >> 16;
+	geo->head <<= 4;
+	geo->head |= head;
+	geo->record = record;
+}
+
 /*
  * calculate failing track from sense data depending if
  * it is an EAV device or not
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 763733bcc4d2..184266102f60 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -146,6 +146,11 @@ struct eckd_count {
 	__u16 dl;
 } __attribute__ ((packed));
 
+struct eckd_r0 {
+	struct eckd_count count;
+	__u8 data[8];
+} __packed;
+
 struct ch_t {
 	__u16 cyl;
 	__u16 head;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 99c253421653..0ca039126ae9 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -159,6 +159,11 @@ struct dasd_ccw_req {
 	void *callback_data;
 	unsigned int proc_bytes;	/* bytes for partial completion */
 	unsigned int trkcount;		/* count formatted tracks */
+	void *filldata;			/* address of filler data */
+	struct dasd_format_entry *format;
+	sector_t start_trk;
+	sector_t end_trk;
+	bool collision;
 };
 
 /*
@@ -170,6 +175,7 @@ struct dasd_ccw_req {
 #define DASD_CQR_IN_ERP 	0x03	/* request is in recovery */
 #define DASD_CQR_FAILED 	0x04	/* request is finally failed */
 #define DASD_CQR_TERMINATED	0x05	/* request was stopped by driver */
+#define DASD_CQR_ABORTED	0x06	/* request was replaced and will be deleted */
 
 #define DASD_CQR_QUEUED 	0x80	/* request is queued to be processed */
 #define DASD_CQR_IN_IO		0x81	/* request is currently in IO */
@@ -177,6 +183,7 @@ struct dasd_ccw_req {
 #define DASD_CQR_CLEAR_PENDING	0x83	/* request is clear pending */
 #define DASD_CQR_CLEARED	0x84	/* request was cleared */
 #define DASD_CQR_SUCCESS	0x85	/* request was successful */
+#define DASD_CQR_ABORT		0x86	/* request was replaced and will not be handled */
 
 /* default expiration time*/
 #define DASD_EXPIRES	  300
@@ -573,9 +580,12 @@ struct dasd_device {
 	struct list_head ccw_queue;
 	spinlock_t mem_lock;
 	void *ccw_mem;
+	void *fill_mem;
 	void *erp_mem;
 	void *ese_mem;
+	void *nulldata;
 	struct list_head ccw_chunks;
+	struct list_head fill_chunks;
 	struct list_head erp_chunks;
 	struct list_head ese_chunks;
 
@@ -640,6 +650,15 @@ struct dasd_block {
 	struct list_head format_list;
 	spinlock_t format_lock;
 	atomic_t trkcount;
+
+	/*
+	 * ESE format CQRs staged from hardirq, spliced into
+	 * ccw_queue in dasd_block_tasklet under queue_lock. Direct enqueue from
+	 * the IRQ handler would invert the queue_lock / ccwdev_lock order.
+	 */
+	struct list_head ese_staging;
+	/* lock for ese_staging */
+	spinlock_t ese_lock;
 };
 
 struct dasd_attention_data {
-- 
2.53.0

