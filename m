Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DE43FD0E
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814481; cv=none; b=KKq1XzyCy4mYUFZ4Rc2jZFM0pg1LfVE5PRl7W0iMas2NkbL2YUqPgCCGJw3M/XL+Z6omRt+cVHMaDFkuF/n3B0loszJpel7hmNzSDOEcdQKWJ1ckQZvG1vvLb3kxYPFuGbJypr26Vb/Y+6WatYlm85puZj+55aluUoCsSlbRysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814481; c=relaxed/simple;
	bh=pRS7/Xz9tkZ3mb0T3XZuy3dFaYdUR/aKcI1oeeToOUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlQljKP3QwRn5Hxjh3L8EeeXSJiDYqsAnJVOuXqb6FfbWab5txJt0eIeXnp375NvSKJNyPhzuSP533eygQBeV7JyupbDxDJAj4btMLV2VJI3DKCSCJ7hf0KBun79QjoxN2XRZ2UOjfs4UPXmnyPCOD0i9NaGw8mnCDHJIzvzrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IYwfsUkn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IYwfsUkn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC3mF2986964
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pPIqqMdXVFu2qylia
	XyURI5GGr45kVu6/zqmMyz76xY=; b=IYwfsUkn3INXGcY1FtMzeLbBXnLiHsJoZ
	CqR98l7jbjeexy4UXTGpmb0jg8rOI07EP1Z23zPwhnWtrWs0sIa8ZZFd/tOdQcjV
	kb+U9JDDNB/ln4D0vh9A7k/Bn2iZzQbvr+PuIvnknVh6PHwHzj3jYB+4kuwsY+ap
	1VIoAwJsCpzX8BcC+dnYb/qBkXYlxnxjfpTvBHt61rmEy/bz8wfsbFtNCJcOshBF
	AaUFlo829VZFoSvXWRSUvqqdlQUL9PlpxRCthdC7yQ95XuBvLLBHcDbCltFUGgIS
	GVl/FNX1CtCQ12ZIQv5tEc/6eotNP5FGaDDUUV0PvrnQ095uGZFiA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gf6fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYb6v025407
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wcgrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlnsx59179422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F75B20043;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309A72004D;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 12/13] s390/dasd: Re-enable discard support for ESE volumes
Date: Thu, 23 Jul 2026 15:47:42 +0200
Message-ID: <20260723134743.672413-13-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX8PylECcUWkEj
 1WoOz+eCwzMh4vi4u0ChYEyG1xMnC8xkjFMQvTvskryy+LoEERY2L4wCsEaYLLXnf+a98qVUx47
 mp31bbqEO6AkiV8LBr6OSp1T4mc9RwFqxsbHkJfL2z29B03S2BbSxSYWZggoUSNKsLb7wmT1Pkc
 jzuCO3pblUAgz6fZOvICEaH1HCwZS1UeCGzcUAYUJ3uP8xY5vaIgR6YoYq6IlZsm2jS9gwNHaYI
 STIvzo6Q9uynJG9hQ03njIFahbcvdIgPF2nEWHb2v0fRKI7t11Pk9B7SLHvO0NPqkR5tFwNNAjW
 mbrU1BzkgIDO7T8ngLfBVw4G5scPZd9DPajktM1ZwRItLsUgEkQO+XXmnd3ZjpGLCxCFiRDE0JP
 uz2TVKf/2qVlYf2iCt081E+gVl6ly/mVp5GK3OHwgf5AHGwENvIhBO9yRtIIvUyJCfNETtfuiPE
 gbafNqh5qOOUz/fqKnw==
X-Proofpoint-GUID: 0e-E2qxe1N5LhN4cq7e5hlPITMnykYkC
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=OhD5my9WQ1rfqFq6peYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXxvYFJBo6vylh
 Ra6mI7/Qe6epfgH1Puv8WBNki1l9A3RVuh7gOLVlS/5Mw7Pa8N4uWiSkg88rxCMsbVyiXSC5dKu
 IwHk/nAJUbgF3bjPjdKpVVqweGk2RYE=
X-Proofpoint-ORIG-GUID: 0e-E2qxe1N5LhN4cq7e5hlPITMnykYkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

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
 drivers/s390/block/dasd.c      |  29 ++++--
 drivers/s390/block/dasd_eckd.c | 159 ++++++++++++++++++++++++++-------
 drivers/s390/block/dasd_int.h  |   2 +
 3 files changed, 147 insertions(+), 43 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 3c3086b6a769..44e791b6604e 100644
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
@@ -3171,6 +3173,15 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 			rc = BLK_STS_RESOURCE;
 		} else if (PTR_ERR(cqr) == -EINVAL) {
 			rc = BLK_STS_INVAL;
+		} else if (PTR_ERR(cqr) == -EOPNOTSUPP) {
+			/*
+			 * e.g. a discard that covers no whole extent. This is an
+			 * expected, benign outcome (fstrim ranges rarely align to
+			 * the large ESE extent granularity), so silence the
+			 * per-request block-layer error print for it.
+			 */
+			req->rq_flags |= RQF_QUIET;
+			rc = BLK_STS_NOTSUPP;
 		} else {
 			DBF_DEV_EVENT(DBF_ERR, basedev,
 				      "CCW creation failed (rc=%ld) on request %p",
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 40d76532345c..ba429467f3c4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2287,6 +2287,16 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Volume Information */
 	dasd_eckd_read_vol_info(device);
 
+	/*
+	 * Advertise discard through the device feature so the block layer sets
+	 * up discard limits. Discard releases allocated space, so require a thin
+	 * (ESE) volume whose storage reports support for the space-release
+	 * function.
+	 */
+	if (dasd_eckd_ese_capable(device) &&
+	    (private->features.feature[56] & 0x01))
+		device->features |= DASD_FEATURE_DISCARD;
+
 	/* Read the on-disk format label for ESE detection */
 	dasd_eckd_read_format_label(device);
 
@@ -4076,37 +4086,15 @@ static int dasd_eckd_ras_sanity_checks(struct dasd_device *device,
 }
 
 /*
- * Helper function to count the amount of involved extents within a given range
- * with extent alignment in mind.
+ * Number of extents the track range [from, to] spans. Extent n covers tracks
+ * [n * trks_per_ext, (n + 1) * trks_per_ext - 1], so the range touches the
+ * extents from (from / trks_per_ext) to (to / trks_per_ext) inclusive. This
+ * holds for a range that is not extent aligned (e.g. a partition-relative
+ * discard), which the previous length/position mix miscounted.
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
@@ -4157,9 +4145,17 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
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
 
@@ -4191,7 +4187,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	 * not fully specified, but is only supported with a certain feature
 	 * subset and for devices not in a copy relation.
 	 */
-	if (features->feature[56] & 0x01 && !copy_relation)
+	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
 	ras_data->lss = private->conf.ned->ID;
@@ -4287,6 +4283,9 @@ static int dasd_eckd_release_space_trks(struct dasd_device *device,
 
 	INIT_LIST_HEAD(&ras_queue);
 
+	if (dasd_eckd_ext_size(device) == 0)
+		return -EINVAL;
+
 	device_exts = private->real_cyl / dasd_eckd_ext_size(device);
 	trks_per_ext = dasd_eckd_ext_size(device) * private->rdc_data.trk_per_cyl;
 
@@ -5421,6 +5420,55 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_writefulltrack(struct dasd_de
 	return ERR_PTR(ret);
 }
 
+static struct dasd_ccw_req *
+dasd_eckd_build_cp_discard(struct dasd_device *device, struct dasd_block *block,
+			   struct request *req, sector_t first_trk,
+			   sector_t last_trk, unsigned int first_offs,
+			   unsigned int last_offs, unsigned int blk_per_trk)
+{
+	struct dasd_eckd_private *private = device->private;
+	sector_t aligned_first, aligned_last;
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
+	aligned_first = ((first_trk + trks_per_ext - 1) / trks_per_ext) * trks_per_ext;
+	aligned_last = ((last_trk + 1) / trks_per_ext) * trks_per_ext;
+	if (aligned_first >= aligned_last)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return dasd_eckd_dso_ras(device, block, req, aligned_first,
+				 aligned_last - 1, 1);
+}
+
 static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 					       struct dasd_block *block,
 					       struct request *req)
@@ -5455,6 +5503,12 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
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
@@ -5768,11 +5822,13 @@ static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
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
@@ -7654,6 +7710,40 @@ static unsigned int dasd_eckd_max_sectors(struct dasd_block *block)
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
+	max_bytes = UINT_MAX - (UINT_MAX % ext_bytes);
+	if (max_bytes / ext_bytes > ext_limit)
+		max_bytes = ext_bytes * ext_limit;
+
+	max_discard_sectors = max_bytes / 512;
+
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->discard_granularity = ext_bytes;
+}
+
 static struct ccw_driver dasd_eckd_driver = {
 	.driver = {
 		.name	= "dasd-eckd",
@@ -7676,6 +7766,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.owner = THIS_MODULE,
 	.name = "ECKD",
 	.ebcname = "ECKD",
+	.disc_limits = dasd_eckd_disc_limits,
 	.check_device = dasd_eckd_check_characteristics,
 	.uncheck_device = dasd_eckd_uncheck_device,
 	.do_analysis = dasd_eckd_do_analysis,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 18081c649945..9ffcc79e7d78 100644
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

