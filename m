Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAA435A8E;
	Wed,  5 Aug 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928599; cv=none; b=J5ZjysxAlAjc8j9XfvX0I6fJ14nkSLPj6CBhMHPRuUB4fn3yZRvr7IT1pobVYYS32Jukqg5Awbe0/hg3VJen0xdfAG+UuxGK3yMb4dd+nVgPduKHqTACm3Pu9DOdWHz4KlqST29iHhtna9A+ZqBusYxvT9/P9HsiAkQ27NqopLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928599; c=relaxed/simple;
	bh=aoMRSL0saqv1yb7tTWAEbyu56Su45r06rOY/0f7CWKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1J9f0aaD3gMezyfezJYVud6rmbF83tZ897K9NXxJl3L/OnOLE9nc004UPspMQJdU0WMin9fS3q9Ecm1Aoqj80ZZnNd/3s6xu1owbBol3uNqmWYLGhNA/5TJAdEBRXuPpzkfcmw9c7dMRGGTcbRWT4DlwN9RXbUZ1h6s3eB0Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pVJSMCOc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pVJSMCOc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lZgv3354428;
	Wed, 5 Aug 2026 11:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F6uKuJ
	ClJX+Y4x/YEgxyhfrV0KtU+PP07SpoEMFO6A0=; b=pVJSMCOcY9c1HyDdSbcnh5
	S1+HRMYBOO0pElz1CxRzq0KtvY5Gd9lpYdwIT8KiK2pjhhmUUvnYlqyIBAFW9nxs
	G9Nn4Uq0xR94ApvprUnPH3IIHLCY2U3PV6hodCWfSHCaZUEDmdlkjdgLNQXd90JB
	4KlGAOc1vk1OjiSIgqqZ95sET+XVfpWeppDyNb2108rm0Q1O7xa33bdGHS1Vm64b
	ZOyPcNbgyL++qQcZQCrfhuYZlRulDNkgvU420ibKasWYkPEeaB1kDU1FOWZbr0zB
	PTo5VFAQVP1fnMwJafVXE7sz7R4JB4tYUwxGuNY9Aiv4E+WTT0octTTKKFeiXG3A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBKAj021068;
	Wed, 5 Aug 2026 11:16:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6bte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGJAT43581912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 801E520043;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64ABA20063;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 18/19] s390/dasd: Re-enable discard support for ESE volumes
Date: Wed,  5 Aug 2026 13:16:11 +0200
Message-ID: <20260805111612.1285190-19-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=BHqjD8HPc08Ugyy6hOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JiL2AHL9F3XQ7AAtinEtOywRbNsiamz0
X-Proofpoint-GUID: JiL2AHL9F3XQ7AAtinEtOywRbNsiamz0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX6sMr6ZgMSJve
 IuCBkLIcZ1BHesBegiu3G96iBYI7f5H71ZiMLLZUNVoHG1sQl1WinMDWBX+CkBElazZehHiLk84
 2xc3hP3k898CEqZ5O/IQjspvqVycvBU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX67Mv6oLRQ2md
 uofzx02l7WAhqHZgO2ApY8a2TSWD7ym1wMAu0nDcs/aU9kLZBLdR5W2yV53MpIGZA+HuZQey4w+
 aLZYqxA22rYzcuEXnypkrnnIQ1mdr95+epVQ1eXza2GhuDvgmrqRXmvz3KwWnpwPRvJkbSYgyZT
 i2MyTUYMjA5el/libJKCY6Wg7Aw+bWXFgID6NYSTwmnUWXJfF3iWDDCNazMe2ruLfQiz4B7ljSQ
 VXXa+Odb3BwMlQjR3ikNDJsJTA8oTjeykYjWEu9LtWKDdHtdsxjAhvMji9of+q0rjCcf0/MDo1n
 1n+g7jttTg394t6S+OWkZM2DX2sMj/xEnFRD9Fce6HqC1x7X2VC4pkvSqIuAzQSxMWLnXXFNI5T
 8T1r3UtVWVnPSpMXviv+2NYRoWp0aO7KW2g34R4+8Rr4GTKunjLKBIbojnHpPB3F7uu/A5dOVMJ
 thDUlolXCHQ808FxS3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

Re-enable block-layer discard for ESE ECKD volumes, releasing thin space
via release allocated space (RAS).
This is based on
commit 7e64db1597fe ("s390/dasd: Add discard support for ESE volumes")
but adapted to the current code and fixed.

REQ_OP_DISCARD is routed to a RAS release over the request's track range,
and discard requests run on the base device only. Discard limits use extent
granularity via the disc_limits discipline hook so the block layer only
issues extent-aligned discards.

Discard is gated on the DASD_FEATURE_DISCARD device feature rather than a
per-discipline flag: the driver sets the feature when the volume is on ESE
hardware (i.e. RAS is available), and the block-layer setup enables discard
limits for a device that has it.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      |  34 +++++--
 drivers/s390/block/dasd_eckd.c | 173 ++++++++++++++++++++++++++-------
 drivers/s390/block/dasd_int.h  |   2 +
 3 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 18f5f097d2b3..5979758311c8 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -354,17 +354,19 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 	 */
 	lim.dma_alignment = lim.logical_block_size - 1;
 
-	if (device->discipline->has_discard) {
+	if (device->features & DASD_FEATURE_DISCARD) {
 		unsigned int max_bytes;
 
-		lim.discard_granularity = block->bp_block;
-
-		/* Calculate max_discard_sectors and make it PAGE aligned */
-		max_bytes = USHRT_MAX * block->bp_block;
-		max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
-
-		lim.max_hw_discard_sectors = max_bytes / block->bp_block;
-		lim.max_write_zeroes_sectors = lim.max_hw_discard_sectors;
+		if (device->discipline->disc_limits) {
+			device->discipline->disc_limits(block, &lim);
+		} else {
+			lim.discard_granularity = block->bp_block;
+			/* Calculate max_discard_sectors and make it PAGE aligned */
+			max_bytes = USHRT_MAX * block->bp_block;
+			max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
+			lim.max_hw_discard_sectors = max_bytes / block->bp_block;
+			lim.max_write_zeroes_sectors = lim.max_hw_discard_sectors;
+		}
 	}
 	rc = queue_limits_commit_update(block->gdp->queue, &lim);
 	if (rc)
@@ -3136,6 +3138,7 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 	struct dasd_device *basedev;
 	struct dasd_ccw_req *cqr;
 	blk_status_t rc = BLK_STS_OK;
+	bool complete_noop = false;
 
 	basedev = block->base;
 	spin_lock_irq(&dq->lock);
@@ -3184,6 +3187,17 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 			rc = BLK_STS_RESOURCE;
 		} else if (PTR_ERR(cqr) == -EINVAL) {
 			rc = BLK_STS_INVAL;
+		} else if (PTR_ERR(cqr) == -EOPNOTSUPP) {
+			/*
+			 * A discard that covers no whole extent releases
+			 * nothing. Discard is advisory, so complete it as a
+			 * benign no-op: the device does support discard, this
+			 * range just does not align to the large ESE extent
+			 * granularity.
+			 * Completed after the lock is dropped.
+			 */
+			rc = BLK_STS_OK;
+			complete_noop = true;
 		} else {
 			DBF_DEV_EVENT(DBF_ERR, basedev,
 				      "CCW creation failed (rc=%ld) on request %p",
@@ -3217,6 +3231,8 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 
 out:
 	spin_unlock_irq(&dq->lock);
+	if (complete_noop)
+		blk_mq_end_request(req, BLK_STS_OK);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 3c4fcfb1558d..5c1f328b7c8d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2327,6 +2327,18 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Volume Information */
 	dasd_eckd_read_vol_info(device);
 
+	/*
+	 * Advertise discard through the device feature so the block layer sets
+	 * up discard limits. Discard releases allocated space, so require a thin
+	 * (ESE) volume whose storage reports support for the space-release
+	 * function. Raw-track access bypasses the normal block CCW path (discard
+	 * would reach the raw builder, which has no record data), so exclude it.
+	 */
+	if (dasd_eckd_ese_capable(device) &&
+	    (private->features.feature[56] & 0x01) &&
+	    !(device->features & DASD_FEATURE_USERAW))
+		device->features |= DASD_FEATURE_DISCARD;
+
 	/* Read the on-disk format label for ESE detection */
 	dasd_eckd_read_format_label(device);
 
@@ -4136,37 +4148,13 @@ static int dasd_eckd_ras_sanity_checks(struct dasd_device *device,
 }
 
 /*
- * Helper function to count the amount of involved extents within a given range
- * with extent alignment in mind.
+ * Number of extents the track range [from, to] spans. Extent n covers tracks
+ * [n * trks_per_ext, (n + 1) * trks_per_ext - 1], so the range touches the
+ * extents from (from / trks_per_ext) to (to / trks_per_ext) inclusive.
  */
 static int count_exts(unsigned int from, unsigned int to, int trks_per_ext)
 {
-	int cur_pos = 0;
-	int count = 0;
-	int tmp;
-
-	if (from == to)
-		return 1;
-
-	/* Count first partial extent */
-	if (from % trks_per_ext != 0) {
-		tmp = from + trks_per_ext - (from % trks_per_ext) - 1;
-		if (tmp > to)
-			tmp = to;
-		cur_pos = tmp - from + 1;
-		count++;
-	}
-	/* Count full extents */
-	if (to - (from + cur_pos) + 1 >= trks_per_ext) {
-		tmp = to - ((to - trks_per_ext + 1) % trks_per_ext);
-		count += (tmp - (from + cur_pos) + 1) / trks_per_ext;
-		cur_pos = tmp;
-	}
-	/* Count last partial extent */
-	if (cur_pos < to)
-		count++;
-
-	return count;
+	return to / trks_per_ext - from / trks_per_ext + 1;
 }
 
 static int dasd_in_copy_relation(struct dasd_device *device)
@@ -4217,9 +4205,17 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (dasd_eckd_ras_sanity_checks(device, first_trk, last_trk))
 		return ERR_PTR(-EINVAL);
 
-	copy_relation = dasd_in_copy_relation(device);
-	if (copy_relation < 0)
-		return ERR_PTR(copy_relation);
+	/*
+	 * The block-layer discard path (req != NULL) runs in atomic context, so
+	 * it must not issue the sleeping copy-relation (PPRC) query. It also
+	 * leaves guarantee_init off - discard does not promise zeroing anyway.
+	 */
+	copy_relation = 0;
+	if (!req) {
+		copy_relation = dasd_in_copy_relation(device);
+		if (copy_relation < 0)
+			return ERR_PTR(copy_relation);
+	}
 
 	rq = req ? blk_mq_rq_to_pdu(req) : NULL;
 
@@ -4251,7 +4247,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	 * not fully specified, but is only supported with a certain feature
 	 * subset and for devices not in a copy relation.
 	 */
-	if (features->feature[56] & 0x01 && !copy_relation)
+	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
 	ras_data->lss = private->conf.ned->ID;
@@ -4347,6 +4343,9 @@ static int dasd_eckd_release_space_trks(struct dasd_device *device,
 
 	INIT_LIST_HEAD(&ras_queue);
 
+	if (dasd_eckd_ext_size(device) == 0)
+		return -EINVAL;
+
 	device_exts = private->real_cyl / dasd_eckd_ext_size(device);
 	trks_per_ext = dasd_eckd_ext_size(device) * private->rdc_data.trk_per_cyl;
 
@@ -5484,6 +5483,58 @@ dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,
 	return ERR_PTR(ret);
 }
 
+static struct dasd_ccw_req *
+dasd_eckd_build_cp_discard(struct dasd_device *device, struct dasd_block *block,
+			   struct request *req, sector_t first_trk,
+			   sector_t last_trk, unsigned int first_offs,
+			   unsigned int last_offs, unsigned int blk_per_trk)
+{
+	struct dasd_eckd_private *private = device->private;
+	sector_t first_ext_trk, last_ext_end, last_ext_trk;
+	unsigned int trks_per_ext;
+
+	trks_per_ext = dasd_eckd_ext_size(device) * private->rdc_data.trk_per_cyl;
+	if (!trks_per_ext)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/*
+	 * A discard range is rarely track-aligned: fstrim is FS-block granular
+	 * and discard_granularity is only a hint. If it starts or ends mid-track,
+	 * that boundary track still holds live records outside the range, so drop
+	 * it from the whole-track span first. Otherwise a partial boundary track
+	 * that happens to sit on an extent boundary would be released together
+	 * with its live records resulting in silent data loss
+	 */
+	if (first_offs)				/* partial first track */
+		first_trk++;
+	if (last_offs != blk_per_trk - 1) {	/* partial last track */
+		if (!last_trk)
+			return ERR_PTR(-EOPNOTSUPP);
+		last_trk--;
+	}
+	if (first_trk > last_trk)
+		return ERR_PTR(-EOPNOTSUPP);	/* no whole track fully covered */
+
+	/*
+	 * RAS releases whole extents. Only release extents that lie entirely
+	 * within the (now whole-track) discard range by rounding inward to extent
+	 * boundaries - an extent shared with a live allocation must never be
+	 * released. If no whole extent is covered there is nothing to release
+	 * safely (e.g. a sub-extent discard, unavoidable with large extents), so
+	 * reject the request rather than release too much.
+	 */
+	first_ext_trk = roundup(first_trk, trks_per_ext);
+	/* one past the last whole extent inside the range (exclusive) */
+	last_ext_end = rounddown(last_trk + 1, trks_per_ext);
+	if (first_ext_trk >= last_ext_end)
+		return ERR_PTR(-EOPNOTSUPP);
+	/* inclusive last track; the guard above keeps this from underflowing */
+	last_ext_trk = last_ext_end - 1;
+
+	return dasd_eckd_dso_ras(device, block, req, first_ext_trk,
+				 last_ext_trk, 1);
+}
+
 static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 					       struct dasd_block *block,
 					       struct request *req)
@@ -5522,6 +5573,12 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	last_offs = sector_div(last_trk, blk_per_trk);
 	cdlspecial = (private->uses_cdl && first_rec < 2*blk_per_trk);
 
+	if (req_op(req) == REQ_OP_DISCARD)
+		return dasd_eckd_build_cp_discard(startdev, block, req,
+						  first_trk, last_trk,
+						  first_offs, last_offs,
+						  blk_per_trk);
+
 	fcx_multitrack = private->features.feature[40] & 0x20;
 	data_size = blk_rq_bytes(req);
 	if (data_size % blksize || data_size == 0)
@@ -5835,11 +5892,13 @@ static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
 						     struct request *req)
 {
 	struct dasd_eckd_private *private;
-	struct dasd_device *startdev;
+	struct dasd_device *startdev = NULL;
 	unsigned long flags;
 	struct dasd_ccw_req *cqr;
 
-	startdev = dasd_alias_get_start_dev(base);
+	/* Discard requests (space release) can only run on the base device. */
+	if (req_op(req) != REQ_OP_DISCARD)
+		startdev = dasd_alias_get_start_dev(base);
 	if (!startdev)
 		startdev = base;
 	private = startdev->private;
@@ -7727,6 +7786,51 @@ static unsigned int dasd_eckd_max_sectors(struct dasd_block *block)
 	return DASD_ECKD_MAX_BLOCKS << block->s2b_shift;
 }
 
+/*
+ * Discard on ECKD releases space through RAS, which works on whole extents.
+ * Advertise extent granularity so the block layer only sends extent-aligned
+ * discards (avoiding partially specified extents), and only for volumes on ESE
+ * hardware. Non-ESE devices are left without discard limits.
+ */
+static void dasd_eckd_disc_limits(struct dasd_block *block,
+				  struct queue_limits *lim)
+{
+	struct dasd_device *device = block->base;
+	struct dasd_eckd_private *private = device->private;
+	unsigned int logical_block_size = block->bp_block;
+	unsigned int max_discard_sectors, max_bytes, ext_bytes;
+	int recs_per_trk, trks_per_cyl, ext_limit, ext_size;
+
+	if (!dasd_eckd_ese_capable(device) || dasd_eckd_ext_size(device) == 0)
+		return;
+
+	trks_per_cyl = private->rdc_data.trk_per_cyl;
+	recs_per_trk = recs_per_track(&private->rdc_data, 0, logical_block_size);
+
+	ext_size = dasd_eckd_ext_size(device);
+	ext_limit = min(private->real_cyl / ext_size, DASD_ECKD_RAS_EXTS_MAX);
+	ext_bytes = ext_size * trks_per_cyl * recs_per_trk * logical_block_size;
+	if (!ext_bytes)		/* malformed RDC data - leave discard unset */
+		return;
+	max_bytes = UINT_MAX - (UINT_MAX % ext_bytes);
+	if (max_bytes / ext_bytes > ext_limit)
+		max_bytes = ext_bytes * ext_limit;
+
+	max_discard_sectors = max_bytes / 512;
+
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	/*
+	 * ext_bytes is the hardware extent size and is not a power of two, so
+	 * the block layer's power-of-two round_up()/round_down() alignment
+	 * helpers compute it only approximately. That is a hint, not a
+	 * correctness requirement: RAS safety is enforced in the CCW builder,
+	 * which rounds the range inward to whole extents and rejects a request
+	 * that covers no whole extent, so a misaligned range is never
+	 * over-released. At worst a few sub-extent discards are declined.
+	 */
+	lim->discard_granularity = ext_bytes;
+}
+
 static struct ccw_driver dasd_eckd_driver = {
 	.driver = {
 		.name	= "dasd-eckd",
@@ -7749,6 +7853,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.owner = THIS_MODULE,
 	.name = "ECKD",
 	.ebcname = "ECKD",
+	.disc_limits = dasd_eckd_disc_limits,
 	.check_device = dasd_eckd_check_characteristics,
 	.uncheck_device = dasd_eckd_uncheck_device,
 	.do_analysis = dasd_eckd_do_analysis,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8c73850f7947..ef4930432c09 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -404,6 +404,8 @@ struct dasd_discipline {
 	int (*ese_capable)(struct dasd_device *);
 	/* Whether the volume is formatted on demand (thin), from the label */
 	int (*on_demand_format)(struct dasd_device *);
+	/* Fill discard queue limits */
+	void (*disc_limits)(struct dasd_block *, struct queue_limits *);
 	/* Capacity */
 	int (*space_allocated)(struct dasd_device *);
 	int (*space_configured)(struct dasd_device *);
-- 
2.53.0

