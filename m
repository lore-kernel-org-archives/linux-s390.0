Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721363BE17E
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607248; cv=none; b=Akr7wXaXzofRTX6AG1YLsnxHeufuBF5uyFQW6F6JOtoVLOHjCuFw8DERoNIk/vl1vGk6Z3sLKzr3HrGR2aL3pyIZ33BdwgGgdAkDvs8ak4mWZIQnYWFPnGFa8ysKC3z1bdGzkRsUFw3s41kJHJs6uYtDot53P+2TvTXTJMM3faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607248; c=relaxed/simple;
	bh=7Wf9A/TYGebM1dmudWMtoPHsOxF0qowqpzG+uJ5jQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+X662xjONCThQvs2Z8OG/tAUvrYoAZ9gO3lx1MdKepTASyF5I3/I+GXLRcvejXQeeYpHyrkRW+EVrhmHAFFEiMuCQp2Us8GCTLAwRU9D7JaKU20t69US6NWuMtGIrbbcHO9ShR/1vjtNDXyjx0bQ51jHNWaJTzF2G2h4TDl2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlFwhxwr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlFwhxwr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Fm8vq999329
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cIBlEeEmrUfEiYFfk
	zrjOE/fRdIUPl6JSRc73ZwG3W0=; b=HlFwhxwrNMJYRTEW582R8UC7VLEy5VANz
	C+mYJiltTQ6Ja6elgJqukC1B9S1UWetf5stzJEnQbnEAXJD3AnbGkYaI3a/LV37a
	9BYXuqAG8TP/zzwYF0mnmS0MwWf+rpKkRm6xpJMapjEbz8nfwQ0r9hQQylmwo7QV
	yXS3ZeGZeENgXzrNKidE33pWxsYte3NKJxD3v7b4xaK0F8FSa7LjtRXkUlA6VVBL
	IAFD0F6hnutHna/Jl2f1GgwSOwgJb3BW6UhDJzm5ONxJRGwQL2DA13OCyIsvHYeJ
	xwkxxzdurapEhH/TUcy1FV5um1zu/vHDs0nIh7Z7BLCOgj01xW0/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9y7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuIxC027804
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgvhhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0cfj6619544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A60AA20040;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863682004E;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 18/19] s390/dasd: Re-enable discard support for ESE volumes
Date: Sat,  1 Aug 2026 20:00:32 +0200
Message-ID: <20260801180033.3679412-19-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 06hUXCHv_AHd9dUra5nT7ICVDEU30_1f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXxGuQ2MJ3SS/T
 /DKHGFJEvs1ixWhQyMkLFcIIUqG2OxJAJ0iYpfnwguUK4PaoB72lhvmSeXZd5neUE3XA7WN8l3Z
 Oq5wZMbIBlBoq1LaZ9b3jvZVuEt4unQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX9RNZ3ZrFs32S
 d4orXNsegWLG4IAG9xAw92YDs0m01Sjb5hkKSn/9o4VJafFILhWF/7jzHfCYXKsPihiEL5JFO0j
 C7QH2DKNmCLsrgFB++RwLjiOLJUivaJAtag18al7sGto9AeocYAUmYjxp0Mj/H8bpvoulh1B2OB
 P1rQVkSLrHaFO+6GytY4fyP0bPCDy6i+SwZ+XTewez316+1F6pdjKwe/klMCs04649wHn18mYcf
 F1/vcjQtqLuiDRA0ZyEzEqaE1cWjLQhbqs5GHVlel8Db3Nu7Ur7hSmDivNJ8uKay+w1zuUgykJq
 5/n97Qf6NloxivZ+aK2JqzJabKxuEKzMkwk0yy2uC4tMA/ruciDfatrrDgM0i4NaAJlg5xconh6
 N+VQDcgeIXGPduRhMbTMRYikYAZMTk97eooVCF+YcmNXD9NWUke5BhzYjwGup43k4zSapQILc3U
 9kIyR58zOkoxz2hm/7Q==
X-Proofpoint-GUID: 06hUXCHv_AHd9dUra5nT7ICVDEU30_1f
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6e344b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BHqjD8HPc08Ugyy6hOkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      |  35 +++++--
 drivers/s390/block/dasd_eckd.c | 173 ++++++++++++++++++++++++++-------
 drivers/s390/block/dasd_int.h  |   2 +
 3 files changed, 167 insertions(+), 43 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 800b957e6ee7..d59d63003c1a 100644
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
@@ -3184,6 +3187,18 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 			rc = BLK_STS_RESOURCE;
 		} else if (PTR_ERR(cqr) == -EINVAL) {
 			rc = BLK_STS_INVAL;
+		} else if (PTR_ERR(cqr) == -EOPNOTSUPP) {
+			/*
+			 * A discard that covers no whole extent releases
+			 * nothing. Discard is advisory, so complete it as a
+			 * benign no-op: the device does support discard, this
+			 * range just does not align to the large ESE extent
+			 * granularity. Returning BLK_STS_NOTSUPP would make
+			 * filesystems treat the device as lacking discard and
+			 * stop issuing it. Completed after the lock is dropped.
+			 */
+			rc = BLK_STS_OK;
+			complete_noop = true;
 		} else {
 			DBF_DEV_EVENT(DBF_ERR, basedev,
 				      "CCW creation failed (rc=%ld) on request %p",
@@ -3217,6 +3232,8 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 
 out:
 	spin_unlock_irq(&dq->lock);
+	if (complete_noop)
+		blk_mq_end_request(req, BLK_STS_OK);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index b8b862205db0..c634876b9807 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2326,6 +2326,18 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
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
 
@@ -4133,37 +4145,13 @@ static int dasd_eckd_ras_sanity_checks(struct dasd_device *device,
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
@@ -4214,9 +4202,17 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
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
 
@@ -4248,7 +4244,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	 * not fully specified, but is only supported with a certain feature
 	 * subset and for devices not in a copy relation.
 	 */
-	if (features->feature[56] & 0x01 && !copy_relation)
+	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
 	ras_data->lss = private->conf.ned->ID;
@@ -4344,6 +4340,9 @@ static int dasd_eckd_release_space_trks(struct dasd_device *device,
 
 	INIT_LIST_HEAD(&ras_queue);
 
+	if (dasd_eckd_ext_size(device) == 0)
+		return -EINVAL;
+
 	device_exts = private->real_cyl / dasd_eckd_ext_size(device);
 	trks_per_ext = dasd_eckd_ext_size(device) * private->rdc_data.trk_per_cyl;
 
@@ -5481,6 +5480,58 @@ dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_device *startdev,
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
@@ -5519,6 +5570,12 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
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
@@ -5831,11 +5888,13 @@ static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
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
@@ -7723,6 +7782,51 @@ static unsigned int dasd_eckd_max_sectors(struct dasd_block *block)
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
@@ -7745,6 +7849,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.owner = THIS_MODULE,
 	.name = "ECKD",
 	.ebcname = "ECKD",
+	.disc_limits = dasd_eckd_disc_limits,
 	.check_device = dasd_eckd_check_characteristics,
 	.uncheck_device = dasd_eckd_uncheck_device,
 	.do_analysis = dasd_eckd_do_analysis,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index f61af45deab0..26ecf9f47d2e 100644
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

