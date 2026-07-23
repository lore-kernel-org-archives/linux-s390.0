Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74117472F9C
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814478; cv=none; b=M/M9Wqc9u2/P17NCg666bEq/kyXqZve8SAhgAve+7KEr1udAf8brEHNFZ1H+Ak97taVAVg2ReElw/pkR7glzqTB6QrdoQAkrIC+danvuOMAWvZWl7NyL/Sh3L8ywPX3vjATi7WA/X7RujcxL2Lo/b/bI791vwq61GGmUtMF7MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814478; c=relaxed/simple;
	bh=+zn4Y3w1L9ghxJ8ceNTgjHfRaQypI6rm29CbzLV60Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQjthCdDeFWpG0nY37ulei7FDFbL+ExQpw48JUfucfO/wxv0Ll3N9YrpVlkN016xdNGKauOEE6b+JZhMigSn1nPYGVjOH40MwLuL/Kf4Q3KsZMqLqChXJ9J1t4uzOE5vvm0IoS1YTnv9FWzvl+ERa3vV9cnXyEzEnpB1CKHRKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GvUf6/Yr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GvUf6/Yr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC3fa3015647
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N3qzN/mq6btfE1Sjg
	69wFLGK6S0Z03B8TZCduF/WNZI=; b=GvUf6/Yr/nud97S+mLxvvmH24I9KQM2Hk
	CI6ZN/I8fBsh0eMVxGHD6JPJvGk7UUPD6kAod5XRhygKEOJNPDLb/M9ytBhajO1s
	iFkxTNKoJuCwr0rIyxVteBPNcDEgKk9akT1joWEMNoh65xs1LkDacIpCVnbO1hut
	5+yfmEmwaNQuAtqOH3YkHimfoQnimMdp78EQI9Zus/Uv81n3MTJe6eBz6jNT/UgU
	P7FdoxSHi4rJibuEX1YN84b/a8wVzmtQjYhZsKkoBb9bHziVFUrxncVyemplHqrB
	VzHvmgye8p5xZ/oihzaXaK22dEN0qWUgnckczzH/uLp9Z9MNkWTJg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kf8ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZ4E025823
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4dua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlmNn51577206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBB820043;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DD42004E;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 03/13] s390/dasd: Add range-based format-track collision detection
Date: Thu, 23 Jul 2026 15:47:33 +0200
Message-ID: <20260723134743.672413-4-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a621b88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GaJKkLePmxIg6gA0iAYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX4/8q/gCfOJl1
 L293L4nhtdhmMJ/Fg3BABB+4PKCNW7gs+wDGbS2FSao6mkPBx+8yihCBmVHhjsdn8oAbDKl4STN
 gMr6SS9dKW+DWgA3pBMUW7Xq6RoJDPJTlUz8zzSrH9hq6NnUP2bLPtzEVQ50lbfFdnjSVKJXQDV
 gCQ6tWtUVq31C6M5DBl9KwgJTQCMpxR8VDR5n/E+d152jCRxgAlbfkD0ivaTSqFW/QQo/MiAV7o
 JU2hNakFXuD7dRSP2E7V1NSqEWfVVCU2idGQIejTRq2XwO33eQiAbiK7lg79Glf92qUbL1FrRxD
 NnUSRO/h7+o0DtTCtnJuuWQH0vIQYc8RZqG5ZeAMu2joWhlh/CDc95wpVL7kVDC+ERLcqgBjK8G
 qZQDKVV4jVp6URcDeTXq9bN8NxpLh4WZmEkPkcIB87PYFcEvaZfd2Qj7JCfqKkhA7RgAI9tJI1w
 Hm+c36jeseFpYkfG8FQ==
X-Proofpoint-ORIG-GUID: 95C1He_LBdluhyi0Px-6rw0x_ip7kzki
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX6spha0Dx2iB1
 MqirCT4boCXxRn9ZsuJXdB6074w40L5/5fJvh5SuMc53nDVYrscj9egVe5KMw/AC9qUG09QSA6W
 fnEebyGhFXtjvRQeDS0XPVtHzPjpzKE=
X-Proofpoint-GUID: 95C1He_LBdluhyi0Px-6rw0x_ip7kzki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230135

Replace the single per-device format_entry slot with an array of 16
slots so multiple format requests can be in flight at once, and extend
struct dasd_format_entry with a start_trk/end_trk/cqr range (replacing
the single track field).

Rewrite test_and_set_format_track() to scan the array for range overlaps
instead of a trkcount snapshot, honour the early-collision flag, and
return the allocated slot to the caller.

Add dasd_req_conflict() and extend dasd_return_cqr_cb() to mark queued
data CQRs that overlap a just-completed format range, so the next
test_and_set_format_track() detects the conflict early.

Remove the now-obsolete trkcount snapshot in dasd_start_IO().

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 28 +++++++++++----
 drivers/s390/block/dasd_eckd.c | 63 +++++++++++++++++++++++-----------
 drivers/s390/block/dasd_int.h  | 19 ++++++++--
 3 files changed, 81 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a8dea7503dce..4934253dfd0e 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1402,13 +1402,6 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		if (!cqr->lpm)
 			cqr->lpm = dasd_path_get_opm(device);
 	}
-	/*
-	 * remember the amount of formatted tracks to prevent double format on
-	 * ESE devices
-	 */
-	if (cqr->block)
-		cqr->trkcount = atomic_read(&cqr->block->trkcount);
-
 	if (cqr->cpmode == 1) {
 		rc = ccw_device_tm_start(device->cdev, cqr->cpaddr,
 					 (long) cqr, cqr->lpm);
@@ -2867,6 +2860,27 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 
 static void dasd_return_cqr_cb(struct dasd_ccw_req *cqr, void *data)
 {
+	struct dasd_ccw_req *temp_cqr;
+	struct dasd_block *block;
+
+	/* only format CQRs are candidates */
+	if (!cqr->block || unlikely(!cqr->format))
+		goto out;
+
+	block = cqr->block;
+	/*
+	 * Mark queued CQRs that overlap this just-completed format
+	 * range so they re-check in test_and_set_format.
+	 */
+	list_for_each_entry(temp_cqr, &block->ccw_queue, blocklist) {
+		if (temp_cqr != cqr &&
+		    temp_cqr->status != DASD_CQR_FILLED &&
+		    temp_cqr->status != DASD_CQR_QUEUED &&
+		    dasd_req_conflict(cqr, temp_cqr)) {
+			temp_cqr->collision = true;
+		}
+	}
+out:
 	dasd_schedule_block_bh(cqr->block);
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 52f3859ef537..541b8eff647e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3120,32 +3120,43 @@ static int dasd_eckd_format_device(struct dasd_device *base,
 					     0, NULL);
 }
 
-static bool test_and_set_format_track(struct dasd_format_entry *to_format,
-				      struct dasd_ccw_req *cqr)
+static bool test_and_set_format_track(sector_t start, sector_t end,
+				      struct dasd_ccw_req *cqr,
+				      struct dasd_block *block,
+				      struct dasd_device *device,
+				      struct dasd_format_entry **entry)
 {
-	struct dasd_block *block = cqr->block;
-	struct dasd_format_entry *format;
+	struct dasd_format_entry *to_format, *format;
 	unsigned long flags;
 	bool rc = false;
+	int i = 0;
 
+	/* marked as a collision by dasd_return_cqr_cb last round: retry */
+	if (cqr && cqr->collision) {
+		cqr->collision = false;
+		return true;
+	}
 	spin_lock_irqsave(&block->format_lock, flags);
-	if (cqr->trkcount != atomic_read(&block->trkcount)) {
-		/*
-		 * The number of formatted tracks has changed after request
-		 * start and we can not tell if the current track was involved.
-		 * To avoid data corruption treat it as if the current track is
-		 * involved
-		 */
+	while (i < DASD_NR_FORMAT_ENTRIES && device->format_entry[i].cqr)
+		i++;
+
+	if (i >= DASD_NR_FORMAT_ENTRIES) {
 		rc = true;
 		goto out;
 	}
+
 	list_for_each_entry(format, &block->format_list, list) {
-		if (format->track == to_format->track) {
+		if (!(end < format->start_trk || format->end_trk < start)) {
 			rc = true;
 			goto out;
 		}
 	}
+	to_format = &device->format_entry[i];
+	to_format->start_trk = start;
+	to_format->end_trk = end;
+	to_format->cqr = cqr;
 	list_add_tail(&to_format->list, &block->format_list);
+	*entry = to_format;
 
 out:
 	spin_unlock_irqrestore(&block->format_lock, flags);
@@ -3153,13 +3164,16 @@ static bool test_and_set_format_track(struct dasd_format_entry *to_format,
 }
 
 static void clear_format_track(struct dasd_format_entry *format,
-			      struct dasd_block *block)
+			       struct dasd_block *block)
 {
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!block || !format))
+		return;
+
 	spin_lock_irqsave(&block->format_lock, flags);
-	atomic_inc(&block->trkcount);
 	list_del_init(&format->list);
+	format->cqr = NULL;
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
 
@@ -3181,8 +3195,8 @@ static struct dasd_ccw_req *
 dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 		     struct irb *irb)
 {
+	struct dasd_format_entry *format = NULL;
 	struct dasd_eckd_private *private;
-	struct dasd_format_entry *format;
 	struct format_data_t fdata;
 	unsigned int recs_per_trk;
 	struct dasd_ccw_req *fcqr;
@@ -3201,7 +3215,6 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	private = base->private;
 	blksize = block->bp_block;
 	recs_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
-	format = &startdev->format_entry;
 
 	first_trk = blk_rq_pos(req) >> block->s2b_shift;
 	sector_div(first_trk, recs_per_trk);
@@ -3218,9 +3231,9 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 			      curr_trk, first_trk, last_trk);
 		return ERR_PTR(-EINVAL);
 	}
-	format->track = curr_trk;
+
 	/* test if track is already in formatting by another thread */
-	if (test_and_set_format_track(format, cqr)) {
+	if (test_and_set_format_track(curr_trk, curr_trk, cqr, block, startdev, &format)) {
 		/* this is no real error so do not count down retries */
 		cqr->retries++;
 		return ERR_PTR(-EEXIST);
@@ -3232,17 +3245,27 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	fdata.intensity = private->uses_cdl ? DASD_FMT_INT_COMPAT : 0;
 
 	rc = dasd_eckd_format_sanity_checks(base, &fdata);
-	if (rc)
+	if (rc) {
+		if (format)
+			list_del(&format->list);
 		return ERR_PTR(-EINVAL);
+	}
 
 	/*
 	 * We're building the request with PAV disabled as we're reusing
 	 * the former startdev.
 	 */
 	fcqr = dasd_eckd_build_format(base, startdev, &fdata, 0);
-	if (IS_ERR(fcqr))
+	if (IS_ERR(fcqr)) {
+		if (format)
+			list_del(&format->list);
 		return fcqr;
+	}
 
+	if (format) {
+		format->cqr = fcqr;
+		fcqr->format = format;
+	}
 	fcqr->callback = dasd_eckd_ese_format_cb;
 	fcqr->callback_data = (void *) format;
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 0ca039126ae9..a7010f24eb41 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -545,9 +545,17 @@ struct dasd_profile {
 	spinlock_t lock;
 };
 
+/*
+ * concurrent ESE format ranges in flight; also caps a WRITE_FULL_TRACK's
+ * track count, which the LRE track bitmask limits to 16
+ */
+#define DASD_NR_FORMAT_ENTRIES	16
+
 struct dasd_format_entry {
 	struct list_head list;
-	sector_t track;
+	struct dasd_ccw_req *cqr;
+	sector_t start_trk;
+	sector_t end_trk;
 };
 
 struct dasd_device {
@@ -617,7 +625,7 @@ struct dasd_device {
 	struct dentry *debugfs_dentry;
 	struct dentry *hosts_dentry;
 	struct dasd_profile profile;
-	struct dasd_format_entry format_entry;
+	struct dasd_format_entry format_entry[DASD_NR_FORMAT_ENTRIES];
 	struct kset *paths_info;
 	struct dasd_copy_relation *copy;
 	unsigned long aq_mask;
@@ -834,6 +842,13 @@ static inline void *dasd_get_callback_data(struct dasd_ccw_req *cqr)
 	return cqr->callback_data;
 }
 
+static inline bool dasd_req_conflict(struct dasd_ccw_req *cqr1,
+				     struct dasd_ccw_req *cqr2)
+{
+	return !(cqr1->format->end_trk < cqr2->start_trk ||
+		 cqr2->end_trk < cqr1->format->start_trk);
+}
+
 /* externals in dasd.c */
 #define DASD_PROFILE_OFF	 0
 #define DASD_PROFILE_ON 	 1
-- 
2.53.0

