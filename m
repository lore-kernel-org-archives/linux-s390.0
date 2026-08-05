Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B2435AB5;
	Wed,  5 Aug 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928598; cv=none; b=X66eRbPyYMyu93ewlhUJM9sG4yaHwLS9gUajbWKZyXt5bV9HCQCJGPN5qdvvZHoA+k44YBsXh77MWUyt8rjpw7NGPgrJ9xsPikkC1p2AGlD/DK+SzPfAI9dRW1goGPlDS628OWqdBER96a5DqjWDqnpHpBrIXKu104YArHBLYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928598; c=relaxed/simple;
	bh=06fFdNY+uKruDYUpJcGozy0EQHI5HowPD/TefFdaKKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esl5ieBlA765ohFHoAK8kAkSclCAG4sAnSOvpqH8yLrvytPs84gwqEFpB9/2RdoK0lRu8J6L4z7FvJW8VD7hhWs0I1HLJ9OZEZxbDYHJ1PdxF7BnheSn7RDSFg1jdG9Uzhmeksy8x7uaZjOeKPM8AAq/SOI0UanrPVY2KQ6znwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tKncb8Jv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tKncb8Jv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lZgu3354428;
	Wed, 5 Aug 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UyXxbx
	GBTZ7lhHXZC19z581Xze3SelsrFgQ3Gm8mTP4=; b=tKncb8JvIOM0ET6J7WTptc
	zOfiq6xdlK2A0RIkW//Ol/txUC/nZQpy/HNea2hXbQDrTXyfnJ43vs7gM4zSXzuR
	bg7Kb45GLYzFKJmoxQPxMlctENT91s8xr4SEzBs5fkJWoAbVZuJnYbKH1xJI4LaS
	IUlo7Lm2Kf/LQW4on4Byovgt7khgizESzBuxasZndcplpo+EWSLIkXaf7YrU/Oa+
	b/trsQlXsSVKYQU9dMy9YtR7iO9Udon90ErabsP6nAS6Ec2orxwJa71SOoQm6fJ1
	wPBPJItgKogLXiLmZbjNzAUnGNFgvr+OiLGMCcjurtwNhjwzvh7mkbvdhP1Unhig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfmEH006377;
	Wed, 5 Aug 2026 11:16:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGIGd32375242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A13720043;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA142004B;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
Date: Wed,  5 Aug 2026 13:16:05 +0200
Message-ID: <20260805111612.1285190-13-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b8a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=XmTE6GNeP6Qga7PDqrwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4pBk7NEOZlBOXoLMUED2wk4HltQDDiGl
X-Proofpoint-GUID: 4pBk7NEOZlBOXoLMUED2wk4HltQDDiGl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX+sdfXzo9r+3+
 oL52AFh5uKXK973b58JlBOJBTbnvM9Ker9kv9GB2WtKPBf1Jt3BjQFUTznia4kpP1l9A15/fvbC
 u13nU5JtB8bpdx3dn+iEOSAeZIA2ZLw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX7TIA1OnxGK0j
 sWKwJc1NhQwh6jMNJtQQcOHyClZOvg7w6NBfjz/Az/Ue28hwxkqzYLVIAKVjUdZ6m7w5/okS9sI
 5cMJFBb6rgo+KoVsAvlxKRqSd6zdPIoLDZy9RQvhzLS9FhA3rXga00UtKml3End9nw5GL/eWLMO
 sJ9qGc1vipOVnfle3BeBj6Dg0y2kvzc/60An5d94lHTcQVn+9hUwJH/uSaMhknRmub8HUGOIgSo
 fA+yCS4c6cVGqnZ+inB9nCtxs+k6sVfuOjCySp8Pq5sVy0d62knQmcNBNGP4FfI+UqqIcZGlolU
 7MjD/PwFUpHyg0nZqMcn+pdyxqQnKOlN9Q7j7lL4CBv8XIlkDVX59B20467TOh2r1pQbbsMPmlW
 fWazwOs/lv4XFkjoYDgewRrtyyzSDB+vpe325rKPFGMgUDM7yZP8KZwsfn4Zo36K6Vo9R3nfeJG
 WDa6aax8Y1xrik3tVYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

Wire dasd_eckd_build_cp_tpm_writefulltrack() into the ESE unformated
track handler.

dasd_eckd_ese_format() now returns void (matching the revised discipline
hook): it computes the failing track/record range, trims a partially
covered last track when several tracks are involved (the block layer
re-issues the remainder), claims the range with
test_and_set_format_track(), builds a writefulltrack CQR, copies
callback_data/proc_bytes from the origin, and stages it on
block->ese_staging. The origin CQR is set to DASD_CQR_ABORT so
__dasd_process_cqr() retires it without the normal completion.

Drop dasd_eckd_ese_format_cb(); the format-entry slot is now released by
dasd_eckd_free_alias_cp() via clear_format_track() when the CQR is freed.

dasd_int_handler() calls the void hook directly and, for writefulltrack
CQRs (cqr->filldata set), returns DASD_CQR_ERROR instead of looping on
the NRF.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c          |  59 ++++++---
 drivers/s390/block/dasd_3990_erp.c |   1 +
 drivers/s390/block/dasd_eckd.c     | 202 ++++++++++++++++++++---------
 drivers/s390/block/dasd_erp.c      |   8 +-
 drivers/s390/block/dasd_int.h      |   3 +-
 5 files changed, 193 insertions(+), 80 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 243dec4b4484..18f5f097d2b3 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1618,7 +1618,7 @@ static int dasd_ese_oos_cond(u8 *sense)
 void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		      struct irb *irb)
 {
-	struct dasd_ccw_req *cqr, *next, *fcqr;
+	struct dasd_ccw_req *cqr, *next;
 	struct dasd_device *device;
 	unsigned long now;
 	int nrf_suppressed = 0;
@@ -1740,26 +1740,23 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 			dasd_schedule_device_bh(device);
 			return;
 		}
-		fcqr = device->discipline->ese_format(device, cqr, irb);
-		if (IS_ERR(fcqr)) {
-			if (PTR_ERR(fcqr) == -EINVAL) {
-				cqr->status = DASD_CQR_ERROR;
-				return;
-			}
+		if (cqr->filldata) {
 			/*
-			 * If we can't format now, let the request go
-			 * one extra round. Maybe we can format later.
+			 * A WRITE_FULL_TRACK cqr carries the complete
+			 * track image; INV_TRACK_FORMAT here means the
+			 * generated image or the media itself is bad, not
+			 * that the track still needs formatting - retrying
+			 * via ese_format() would just resubmit the same
+			 * write. Let it fail instead.
 			 */
-			cqr->status = DASD_CQR_QUEUED;
-			dasd_schedule_device_bh(device);
-			return;
-		} else {
-			fcqr->status = DASD_CQR_QUEUED;
-			cqr->status = DASD_CQR_QUEUED;
-			list_add(&fcqr->devlist, &device->ccw_queue);
+			cqr->status = DASD_CQR_ERROR;
+			cqr->stopclk = now;
+			dasd_device_clear_timer(device);
 			dasd_schedule_device_bh(device);
 			return;
 		}
+		device->discipline->ese_format(device, cqr, irb);
+		return;
 	}
 
 	/* Check for clear pending */
@@ -2733,6 +2730,13 @@ static void __dasd_process_erp(struct dasd_device *device,
 
 	if (cqr->status == DASD_CQR_DONE)
 		DBF_DEV_EVENT(DBF_NOTICE, device, "%s", "ERP successful");
+	else if (cqr->status == DASD_CQR_ABORTED)
+		/*
+		 * ESE format aborts the request and replaces it with a format
+		 * CQR - this is not an ERP failure.
+		 */
+		DBF_DEV_EVENT(DBF_NOTICE, device, "%s",
+			      "ERP request aborted, replaced by ESE format");
 	else
 		dev_err(&device->cdev->dev, "ERP failed for the DASD\n");
 	erp_fn = device->discipline->erp_postaction(cqr);
@@ -2779,6 +2783,9 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
 			error = BLK_STS_IOERR;
 			break;
 		}
+	} else if (status == DASD_CQR_ABORTED) {
+		/* aborted requests are replaced with a new one so do not complete this */
+		return;
 	}
 
 	/*
@@ -3185,6 +3192,13 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 		}
 		goto out;
 	}
+	if (!cqr) {
+		/* build_cp may collapse a non-transient build error to NULL */
+		DBF_DEV_EVENT(DBF_ERR, basedev,
+			      "CCW creation returned NULL on request %p", req);
+		rc = BLK_STS_IOERR;
+		goto out;
+	}
 	/*
 	 *  Note: callback is set to dasd_return_cqr_cb in
 	 * __dasd_block_start_head to cover erp requests as well
@@ -3978,6 +3992,19 @@ int dasd_generic_requeue_all_requests(struct dasd_device *device)
 			 */
 			goto restart_cb;
 		}
+		/*
+		 * An aborted request was replaced by a full-track write and is
+		 * retired by that replacement; do not requeue it, just release
+		 * it (mirrors the DASD_CQR_ABORTED handling in
+		 * __dasd_cleanup_cqr()).
+		 */
+		if (cqr->status == DASD_CQR_ABORTED) {
+			struct request *req = cqr->callback_data;
+
+			list_del_init(&cqr->blocklist);
+			cqr->block->base->discipline->free_cp(cqr, req);
+			continue;
+		}
 		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index d0aa267462c5..736459477c19 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2400,6 +2400,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->startdev = device;
 	erp->memdev   = device;
 	erp->block    = cqr->block;
+	erp->filldata = cqr->filldata;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
 	erp->retries  = device->default_retries;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8379c8a40382..da488c0775fc 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3214,36 +3214,24 @@ static void clear_format_track(struct dasd_format_entry *format,
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
 
-/*
- * Callback function to free ESE format requests.
- */
-static void dasd_eckd_ese_format_cb(struct dasd_ccw_req *cqr, void *data)
-{
-	struct dasd_device *device = cqr->startdev;
-	struct dasd_eckd_private *private = device->private;
-	struct dasd_format_entry *format = data;
-
-	clear_format_track(format, cqr->basedev->block);
-	private->count--;
-	dasd_ffree_request(cqr, device);
-}
-
-static struct dasd_ccw_req *
-dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
-		     struct irb *irb)
+static void dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
+				 struct irb *irb)
 {
 	struct dasd_format_entry *format = NULL;
+	unsigned int first_offs, last_offs;
 	struct dasd_eckd_private *private;
-	struct format_data_t fdata;
-	unsigned int recs_per_trk;
+	struct dasd_ccw_req *base_cqr;
+	sector_t first_rec, last_rec;
+	sector_t first_trk, last_trk;
+	unsigned int proc_bytes = 0;
 	struct dasd_ccw_req *fcqr;
+	unsigned int recs_per_trk;
 	struct dasd_device *base;
 	struct dasd_block *block;
 	unsigned int blksize;
 	struct request *req;
-	sector_t first_trk;
-	sector_t last_trk;
 	sector_t curr_trk;
+	unsigned int diff;
 	int rc;
 
 	req = dasd_get_callback_data(cqr);
@@ -3253,50 +3241,94 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	blksize = block->bp_block;
 	recs_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
 
-	first_trk = blk_rq_pos(req) >> block->s2b_shift;
-	sector_div(first_trk, recs_per_trk);
-	last_trk =
-		(blk_rq_pos(req) + blk_rq_sectors(req) - 1) >> block->s2b_shift;
-	sector_div(last_trk, recs_per_trk);
-	rc = dasd_eckd_track_from_irb(irb, base, &curr_trk);
-	if (rc)
-		return ERR_PTR(rc);
+	/* Calculate record id of first and last block. */
+	first_rec = blk_rq_pos(req) >> block->s2b_shift;
+	first_trk = first_rec;
+	first_offs = sector_div(first_trk, recs_per_trk);
+	last_rec = (blk_rq_pos(req) + blk_rq_sectors(req) - 1) >> block->s2b_shift;
+	last_trk = last_rec;
+	last_offs = sector_div(last_trk, recs_per_trk);
 
+	/*
+	 * detect if some data has already been processed and the unformatted track is
+	 * within the request.
+	 * If so, finish the request first with the already processed bytes and let the
+	 * blocklayer only redrive unformatted part.
+	 * With this we ensure that there is no overlap of existing data with unformatted
+	 * zero blocks
+	 */
+	rc = dasd_eckd_track_from_irb(irb, base, &curr_trk);
+	if (rc) {
+		/* sense data could not be parsed - this will not resolve by retrying */
+		cqr->status = DASD_CQR_ERROR;
+		goto out;
+	}
+	if (curr_trk >= (sector_t)private->real_cyl * private->rdc_data.trk_per_cyl) {
+		DBF_DEV_EVENT(DBF_WARNING, startdev,
+			      "ESE error track %llu exceeds device geometry\n",
+			      curr_trk);
+		cqr->status = DASD_CQR_ERROR;
+		goto out;
+	}
 	if (curr_trk < first_trk || curr_trk > last_trk) {
 		DBF_DEV_EVENT(DBF_WARNING, startdev,
 			      "ESE error track %llu not within range %llu - %llu\n",
 			      curr_trk, first_trk, last_trk);
-		return ERR_PTR(-EINVAL);
-	}
-
-	/* test if track is already in formatting by another thread */
-	if (test_and_set_format_track(curr_trk, curr_trk, cqr, block, startdev, &format)) {
-		/* this is no real error so do not count down retries */
-		cqr->retries++;
-		return ERR_PTR(-EEXIST);
+		cqr->status = DASD_CQR_ERROR;
+		goto out;
 	}
-
-	fdata.start_unit = curr_trk;
-	fdata.stop_unit = curr_trk;
-	fdata.blksize = blksize;
-	fdata.intensity = private->uses_cdl ? DASD_FMT_INT_COMPAT : 0;
-
-	rc = dasd_eckd_format_sanity_checks(base, &fdata);
-	if (rc) {
-		if (format)
-			clear_format_track(format, block);
-		return ERR_PTR(-EINVAL);
+	if (curr_trk != first_trk) {
+		proc_bytes = ((curr_trk - first_trk) * recs_per_trk - first_offs) * blksize;
+		cqr->proc_bytes = proc_bytes;
+		cqr->status = DASD_CQR_SUCCESS;
+		cqr->stopclk = get_tod_clock();
+		goto out;
 	}
 
 	/*
-	 * We're building the request with PAV disabled as we're reusing
-	 * the former startdev.
+	 * If there are multiple tracks to be format-written, we can not write
+	 * the partial last track since we do not know if it is already formatted
+	 * or not so skip the partial last track for now. Return the partial
+	 * completion to blocklayer and let it redo the remainder
 	 */
-	fcqr = dasd_eckd_build_format(base, startdev, &fdata, 0);
+	if (first_trk != last_trk && last_offs + 1 < recs_per_trk) {
+		diff = last_offs + 1;
+		last_rec = last_rec - diff;
+		last_trk = last_rec;
+		last_offs = sector_div(last_trk, recs_per_trk);
+		proc_bytes = (last_rec - first_rec + 1) * blksize;
+	}
+	if (first_offs > 0 || last_offs + 1 < recs_per_trk) {
+		/* test if tracks are already in formatting by another thread */
+		if (test_and_set_format_track(first_trk, last_trk, cqr,
+					      cqr->block, cqr->startdev, &format)) {
+			/* this is no real error so do not count down retries */
+			cqr->retries++;
+			goto out_retry;
+		}
+	}
+
+	fcqr = dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
+						     first_rec, last_rec,
+						     first_trk, last_trk,
+						     first_offs, last_offs,
+						     recs_per_trk, blksize, cqr);
 	if (IS_ERR(fcqr)) {
 		if (format)
-			clear_format_track(format, block);
-		return fcqr;
+			clear_format_track(format, cqr->block);
+		if (PTR_ERR(fcqr) == -EINVAL) {
+			/* permanent build failure - fail instead of retrying */
+			cqr->status = DASD_CQR_ERROR;
+			goto out;
+		}
+		/*
+		 * Transient conditions - the XRC clock is not in sync (-EAGAIN)
+		 * or the format request pool is momentarily exhausted under load
+		 * (-ENOMEM). Retry the origin without counting down its retries.
+		 */
+		if (PTR_ERR(fcqr) == -EAGAIN || PTR_ERR(fcqr) == -ENOMEM)
+			cqr->retries++;
+		goto out_retry;
 	}
 
 	if (format) {
@@ -3304,10 +3336,44 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 		WRITE_ONCE(format->cqr, fcqr);
 		fcqr->format = format;
 	}
-	fcqr->callback = dasd_eckd_ese_format_cb;
-	fcqr->callback_data = (void *) format;
 
-	return fcqr;
+	/*
+	 * cqr may be an ERP request; dq and the owning request are only set on
+	 * the base request at the end of the ERP chain, so copy from there.
+	 */
+	base_cqr = cqr;
+	while (base_cqr->refers)
+		base_cqr = base_cqr->refers;
+	fcqr->dq = base_cqr->dq;
+	fcqr->callback_data = base_cqr->callback_data;
+	if (proc_bytes)
+		fcqr->proc_bytes = proc_bytes;
+	fcqr->status = DASD_CQR_FILLED;
+	((struct dasd_eckd_private *)fcqr->memdev->private)->count++;
+	/*
+	 * stage under ese_lock; dasd_block_tasklet splices it into ccw_queue.
+	 * Direct enqueue here would invert queue_lock / ccwdev_lock.
+	 */
+	spin_lock(&block->ese_lock);
+	list_add(&fcqr->blocklist, &block->ese_staging);
+	spin_unlock(&block->ese_lock);
+	/* mark origin CQR as aborted; ccwdev_lock is held by the IRQ handler */
+	cqr->status = DASD_CQR_ABORT;
+	goto out;
+
+out_retry:
+	/*
+	 * If we can't format now, let the request go
+	 * one extra round. Maybe we can format later.
+	 * re-queue at the end to let potential format collision finish first
+	 */
+	list_move_tail(&cqr->devlist, &cqr->startdev->ccw_queue);
+	cqr->status = DASD_CQR_QUEUED;
+out:
+	dasd_device_clear_timer(startdev);
+	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(startdev);
+	return;
 }
 
 /*
@@ -4831,7 +4897,7 @@ static struct tidaw *add_track_end(struct itcw *itcw, char **fill,
 	return IS_ERR_OR_NULL(tidaw) ? NULL : tidaw;
 }
 
-static __maybe_unused struct dasd_ccw_req *
+static struct dasd_ccw_req *
 dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,
 				      struct dasd_block *block,
 				      struct request *req,
@@ -5122,7 +5188,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 
 	fcx_multitrack = private->features.feature[40] & 0x20;
 	data_size = blk_rq_bytes(req);
-	if (data_size % blksize)
+	if (data_size % blksize || data_size == 0)
 		return ERR_PTR(-EINVAL);
 	/* tpm write request add CBC data on each track boundary */
 	if (rq_data_dir(req) == WRITE)
@@ -5164,6 +5230,11 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 						    first_trk, last_trk,
 						    first_offs, last_offs,
 						    blk_per_trk, blksize);
+
+	if (!IS_ERR(cqr)) {
+		cqr->start_trk = first_trk;
+		cqr->end_trk = last_trk;
+	}
 	return cqr;
 }
 
@@ -5331,7 +5402,17 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 	sector_t recid;
 	int status;
 
-	if (!dasd_page_cache)
+	/*
+	 * A format-aborted request finished nothing - its replacement
+	 * completes the block request - so report ABORTED instead of DONE,
+	 * but still release its bounce buffers like any other request.
+	 */
+	if (cqr->status == DASD_CQR_ABORTED)
+		status = DASD_CQR_ABORTED;
+	else
+		status = cqr->status == DASD_CQR_DONE;
+	/* transport mode has no dasd_page_cache bounce buffers to release */
+	if (!dasd_page_cache || cqr->cpmode)
 		goto out;
 	private = cqr->block->base->private;
 	blksize = cqr->block->bp_block;
@@ -5366,7 +5447,6 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 		}
 	}
 out:
-	status = cqr->status == DASD_CQR_DONE;
 	dasd_sfree_request(cqr, cqr->memdev);
 	return status;
 }
@@ -5443,6 +5523,8 @@ static int dasd_eckd_free_alias_cp(struct dasd_ccw_req *cqr,
 	private = cqr->memdev->private;
 	private->count--;
 	spin_unlock_irqrestore(get_ccwdev_lock(cqr->memdev->cdev), flags);
+	if (cqr->format)
+		clear_format_track(cqr->format, cqr->block);
 	return dasd_eckd_free_cp(cqr, req);
 }
 
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 468f0b2cc342..05d5366484d7 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -120,7 +120,7 @@ dasd_default_erp_action(struct dasd_ccw_req *cqr)
  */
 struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 {
-	int success;
+	int success, aborted;
 	unsigned long startclk, stopclk;
 	struct dasd_device *startdev;
 	unsigned int proc_bytes;
@@ -128,6 +128,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
 	success = cqr->status == DASD_CQR_DONE;
+	aborted = cqr->status == DASD_CQR_ABORTED;
 	startclk = cqr->startclk;
 	stopclk = cqr->stopclk;
 	startdev = cqr->startdev;
@@ -150,7 +151,10 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	cqr->stopclk = stopclk;
 	cqr->startdev = startdev;
 	cqr->proc_bytes = proc_bytes;
-	if (success)
+	if (aborted)
+		/* base request is owned by the ESE format replacement CQR */
+		cqr->status = DASD_CQR_ABORTED;
+	else if (success)
 		cqr->status = DASD_CQR_DONE;
 	else {
 		cqr->status = DASD_CQR_FAILED;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index b342237b84de..e1ffa20db10a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -413,8 +413,7 @@ struct dasd_discipline {
 	int (*ext_pool_warn_thrshld)(struct dasd_device *);
 	int (*ext_pool_oos)(struct dasd_device *);
 	int (*ext_pool_exhaust)(struct dasd_device *, struct dasd_ccw_req *);
-	struct dasd_ccw_req *(*ese_format)(struct dasd_device *,
-					   struct dasd_ccw_req *, struct irb *);
+	void (*ese_format)(struct dasd_device *, struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
 	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
 	bool (*pprc_enabled)(struct dasd_device *);
-- 
2.53.0

