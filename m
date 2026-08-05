Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E964334AF;
	Wed,  5 Aug 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928597; cv=none; b=nS9Sr1KNBNcnkLsnG7lBSwNx5pUXKF1fPi/RVTmJjzjsOkVm5XlFugjGZTjBHk/qjCTovFr0YRia0E/lUQWB3e0vA1m6bzDzWhJP6+7zc8DkJI01J3KhJ1BOXsVfKATrpKKLXYhU+K5DtscHsqAqpedgSbG24QW0fmc4jcNQzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928597; c=relaxed/simple;
	bh=ytg1Ixuo74TxmEdfZnf1x03FYxmzoYlHyvpAXf808Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxWHBIUhxfuAeTXDVpsC6FRBThyY7v9XUImRv0CYt7ucqHmbm6nJYiiJKBJ7Imo5/N8Y1Xd+EverIp7KmKcnr7E6+wKvkPXBPveDA7o0oVaz9qW0Wui4WMD3XZvHaHOpE/5LKstrNMpuH5NJFbwNVsCJgsV3U4hhVMe9Bk92t8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZC9PQYP2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZC9PQYP2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758mF9f3438840;
	Wed, 5 Aug 2026 11:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nxxp3H
	QtLAclengv3tM1mcqx/jBmbsZq/ADz7a4jvP8=; b=ZC9PQYP2uVc/tkF3C0m4Pa
	rqKW4JJ6yZY3Z05m7v/65Ddoha+KSSwgpRI46xIgldMjzPcBnUIJAfCeVM0Sybza
	8H3vSng5qLWkGmkNs1q+rlFkIGZkfmfGuI2bswfNZddYpty7Bj1OmKHXJGF2lQE0
	B7sfTOiulFdKEiwPtiSwlbBSXC1ljldnB7m3hv82L9bEr/6A158glpSyUPAtptQW
	UPRiquCvXqTUddFSjyemNYsqDBnEZU0MZZB34QHmx75JTyf19dY9uhiZWqSXXPSt
	VyPhxxLwbpaecDMzYYaLTkmhAa91zZnIXFMBgHdGpHHLbiZA8hr7BxDDeyPmR0uA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut64k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBE22012703;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp0v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGH9545941124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5BA420043;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D962004B;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 08/19] s390/dasd: Add infrastructure for ESE full-track write
Date: Wed,  5 Aug 2026 13:16:01 +0200
Message-ID: <20260805111612.1285190-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TPZUI1zg6ryaMlp5j_ce8r3a7LqcyRwH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4GmtXiuaJff4
 ATRLTbyCVtSLyo1H7YeU8gVxkvMy/X3ynZ4yvu1jQwa1BM4mlrTzmX0vrcJKFAXRKllHj0KoYmm
 W9XnyTR4re7GiUtxAHvxH6tRVGQK3Lo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXyODVZgbMa7G3
 Nkd5O/fMoG7vSr7uWyCaz47NEOdwcRZp8vd7GnQBfRVTSArR3mMpKNojPIWQtBGsPNXN33SDY0F
 noUOiSuCWwCON8AkzQOjWMaE0pmTQhEbI2yIHv/fGGS868qMQ0g16CCV5xF+26cintgkB+0QPk+
 /Nk9e6ZNG7185dhp01Bt5ulXfWBZ8Tx+23DtRycZBLvDax2GJwpTSY3jCE5EuRLrt+Ig8DvyuPQ
 kceLNVLovNimqk7xWMWtL7LdxeZ5gwzBAPedY1YLm0ReDBPtmCYm6TXocejlaMY/qPC5O5edJWj
 G4q0hG64MU7gN+MmuGTkmv7Lo4WFMSxXg2bWzQlSm2A2102C+RVGtZo/OtkF1gwW8IIkK0o7aCI
 NXqXK9L3Okxa9Q+UEhlnKDL7vs15V4Eve/4gYo7FNLsTDnLC+gGlKfDiiGl5+kbFI8AhwtP+3hD
 Xpj8AZsrgcmXAIC/FXw==
X-Proofpoint-GUID: TPZUI1zg6ryaMlp5j_ce8r3a7LqcyRwH
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=81764gqnT93cxZW2DpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

Add the driver internals to build WRITE_FULL_TRACK FCX channel programs
in response to unformatted tracks on ESE devices.

struct dasd_ccw_req: filldata, a pointer to the per-track metadata (an R0
record and the count records) that the WRITE_FULL_TRACK TIDAWs point at,
and format/start_trk/end_trk/collision that link a request to its
format-track guard entry so an overlapping format request can be detected.

struct dasd_device: fill_mem/fill_chunks pool for those buffers and a
zeroed nulldata page used as the data source for pad records.

struct dasd_block: ese_staging/ese_lock, a hardirq-safe staging list. An
ESE format CQR is created in the interrupt handler but has to be enqueued
on ccw_queue under queue_lock; taking queue_lock while the ccwdev_lock is
held there would invert the lock order, so the CQR is staged under ese_lock
and dasd_block_tasklet splices it onto ccw_queue. Existing locking is
unchanged.

Add CQR states DASD_CQR_ABORT/ABORTED to retire the origin CQR of a
replaced write without completing it to the block layer, and struct
eckd_r0 for the track header record.

The CCW and ESE format pools are enlarged (a full-track ITCW is roughly
twice a plain track-mode one) to keep two maximum-size requests in flight.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 100 ++++++++++++++++++++++++++++-----
 drivers/s390/block/dasd_eckd.c |  11 ++++
 drivers/s390/block/dasd_eckd.h |   5 ++
 drivers/s390/block/dasd_int.h  |  19 +++++++
 4 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 12fa04537fb0..761d559101a9 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -91,31 +91,53 @@ struct dasd_device *dasd_alloc_device(void)
 	if (!device)
 		return ERR_PTR(-ENOMEM);
 
-	/* Get two pages for normal block device operations. */
-	device->ccw_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
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
 	device->erp_mem = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!device->erp_mem) {
-		free_pages((unsigned long) device->ccw_mem, 1);
+		free_pages((unsigned long)device->fill_mem, 1);
+		free_pages((unsigned long)device->ccw_mem, 2);
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
-	/* Get two pages for ese format. */
-	device->ese_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
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
@@ -1885,6 +1925,17 @@ static void __dasd_process_cqr(struct dasd_device *device,
 	case DASD_CQR_CLEARED:
 		cqr->status = DASD_CQR_TERMINATED;
 		break;
+	case DASD_CQR_ABORT:
+		cqr->status = DASD_CQR_ABORTED;
+		/*
+		 * ABORT is only set on the block-layer origin write that a
+		 * full-track format replaces. Clear the callback so the request
+		 * is not completed here - the replacement completes it. Internal
+		 * requests never take this path, so no sleep_on waiter is left
+		 * without its wakeup.
+		 */
+		cqr->callback = NULL;
+		break;
 	default:
 		dev_err(&device->cdev->dev,
 			"Unexpected CQR status %02x", cqr->status);
@@ -2212,6 +2263,7 @@ EXPORT_SYMBOL(dasd_add_request_tail);
 void dasd_wakeup_cb(struct dasd_ccw_req *cqr, void *data)
 {
 	spin_lock_irq(get_ccwdev_lock(cqr->startdev->cdev));
+	cqr->endclk = get_tod_clock();
 	cqr->callback_data = DASD_SLEEPON_END_TAG;
 	spin_unlock_irq(get_ccwdev_lock(cqr->startdev->cdev));
 	wake_up(&generic_waitq);
@@ -2779,7 +2831,8 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 		if (cqr->status != DASD_CQR_DONE &&
 		    cqr->status != DASD_CQR_FAILED &&
 		    cqr->status != DASD_CQR_NEED_ERP &&
-		    cqr->status != DASD_CQR_TERMINATED)
+		    cqr->status != DASD_CQR_TERMINATED &&
+		    cqr->status != DASD_CQR_ABORTED)
 			continue;
 
 		if (cqr->status == DASD_CQR_TERMINATED) {
@@ -2890,6 +2943,14 @@ static void dasd_block_tasklet(unsigned long data)
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
@@ -2949,6 +3010,15 @@ static int _dasd_requests_to_flushqueue(struct dasd_block *block,
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
index 52d008b59561..8a1eac8aa63e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -205,6 +205,17 @@ static void set_ch_t(struct ch_t *geo, __u32 cyl, __u8 head)
 	geo->head |= head;
 }
 
+static __maybe_unused void set_chr_t(void *addr, __u32 cyl, __u8 head, __u8 record)
+{
+	struct chr_t *geo = addr;
+
+	geo->cyl = (__u16)cyl;
+	geo->head = cyl >> DASD_EAV_CYL_HI_SHIFT;
+	geo->head <<= DASD_EAV_HEAD_HI_SHIFT;
+	geo->head |= head;
+	geo->record = record;
+}
+
 /*
  * calculate failing track from sense data depending if
  * it is an EAV device or not
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index bad7ba666370..0fdb92fdddc8 100644
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
 /*
  * Extended Address Volume track address: the head field carries the actual
  * head in its low-order 4 bits; the cylinder bits that do not fit the 16-bit
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 81cfb5c89681..cab16907ea5a 100644
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

