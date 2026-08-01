Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0784322F1
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582625; cv=none; b=ZYW/7NcKWacj0gWOYEaSYWL0asO559aC4ESwMTa5BFyaOBjBiWKqc6kFjw/wT3gd+u8opLinqlaSPZ9fk3u5ET1jQRMOlvq0rxePoAUB/cMyyJLaXDvIg6og4O0v0XxBumq0dKGNNptbwBaIoHMPMJPPBezowdbzoQLTsQgrXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582625; c=relaxed/simple;
	bh=YdVJ3bHnGfTN9c3OGZsGNEROrbLcz2frA2pE0rGrEKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpZShCUHDhfu+oSXtdbnhGiiXogQ3OvcnQ8F2mLN5NTljSaIzOWKL2+0Z0uSKNvlgjrIL8Sq8HGJ/CntOXSdrZ1/Fngzyuu0Y0bwVnA6x3ZSAEqmLKvvpwEvgWNXTVNTMZ+bvaAZi3SuCg+ygyNU8+k6msSWyeZj7/2u9l8o6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b3rMLa+i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b3rMLa+i"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6711WmZN3410565
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sVrZ42
	FCPbD9zM35nLVIQiMuxeyMwQGxkgoCvQpDyEE=; b=b3rMLa+icPaF4CIpNY/lv+
	oScRUM2CrH3C5k4O14jVPXa06U68eUJDXiQI6Q66bXHkYQUK/3tFaKooVWrI3S1o
	58D3eplhz/Lo83jvwfatEFs8RmeSx027G4Wk0dK8O/QQm8K8QtrAAN1rCV799x5w
	5fm+CZvg5zGRsA9cU90fHb5e5ghkyS7E65xABn5T/ckgX5B/uITsPrGs2fP0HFvI
	VyU91yn69i8d2ZblxV9PQpRkzaeq3TO/XYUMeCsOLFvpCm3As5FCI/l93fb0AxeE
	nV7wVzgCc1XAEkspiJwnH9Ulyi919cBWhMScL2kJweiQUqovgB2s2QCRmBvBlTsQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fs8ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671Av6BD014909
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ykeex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAH7h53477706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6A5120040;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95BAF2004B;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 08/18] s390/dasd: Add range-based format-track collision detection
Date: Sat,  1 Aug 2026 13:09:58 +0200
Message-ID: <20260801111008.3391031-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXxqMXApjDdehS
 BZhkKW6T6+gpBuoj24Ghyw9wKvlYPfYVwpZBy4jbigRbgPGNFmKnDRomNl8bd01IL74yHaNOEIS
 yOlPpX4OwAUlP5tM2tqUQWNFoFGk/b9oVvnXycNtHxfn20U3Jsd7eDX4/7DHmzX7gqHgSimYiHS
 27NtpXuN5qyNsZGT0cabZNRaz7F24WYvAP74a3f2PDFM8nL8DHe9RY7I9b/gCmfXSae7iPpfCtq
 E2c6/Kq0CSOtCybc9E/hd01JGi2NVAHsJRbrqRS93T58Ff7x5Xh3fAyXH8ABKRHa29ueXLOHAwI
 /Pi86yqSaTUB0rU9q88HUTQ9iaxRrBszPerjkFRsdlNewq18WOC+ks0uViMCO/T3vLOOqzqlpbm
 dOm+pnmbDx8Exk0pvUNO1hR2600b7GeiglWqfda998vnclb9waFhpRZ4saf+0WD4xwKCAvcZW94
 n1v0lSh3hAmZbeh+TiQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6dd41e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=GaJKkLePmxIg6gA0iAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FJNS67GW1pSi4pDYZ3LjYuktrCta46WR
X-Proofpoint-ORIG-GUID: FJNS67GW1pSi4pDYZ3LjYuktrCta46WR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXxlZ3X4SA0Gxo
 PcB+BAwbPa+d1mjEpJeAGdsadXEb7wUACcQNK+tHLiTjHQVFOl2pIWeoF0XYMhsHf8GE9GlJgiO
 eVt3o19wid86UQ5nbm8C/T55qQ3O17k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

Replace the single per-device format_entry slot with an array of 16
slots so multiple format requests can be in flight at once, and extend
struct dasd_format_entry with a start_trk/end_trk/cqr range (replacing
the single track field).

Rewrite test_and_set_format_track() to scan the array for range overlaps
instead of a trkcount snapshot, honour the early-collision flag, and
return the allocated slot to the caller.

Add dasd_req_conflict() and extend dasd_return_cqr_cb() to mark in-flight
data CQRs that overlap a just-completed format range, so the next
test_and_set_format_track() detects the conflict early.

Remove the now-obsolete trkcount snapshot in dasd_start_IO().

The detection added here only becomes active together with the
WRITE_FULL_TRACK ESE format handler later in the series: that patch routes
the format request through dasd_return_cqr_cb() (so completion runs the
overlap hook with cqr->format set) and records each request's
start_trk/end_trk range. Until then the array and the conflict check are in
place but dormant.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 29 ++++++++++++----
 drivers/s390/block/dasd_eckd.c | 60 ++++++++++++++++++++++------------
 drivers/s390/block/dasd_int.h  | 19 +++++++++--
 3 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 50219c7ff3dc..9cb97df0866c 100644
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
@@ -2867,6 +2860,28 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 
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
+	 * Mark in-flight (IN_IO) CQRs that overlap this just-completed format
+	 * range so they re-check in test_and_set_format on completion; FILLED
+	 * or QUEUED CQRs re-check the format_list on their next round anyway.
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
index db07fafefe04..577ce55da68f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3150,32 +3150,43 @@ static int dasd_eckd_format_device(struct dasd_device *base,
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
@@ -3183,13 +3194,13 @@ static bool test_and_set_format_track(struct dasd_format_entry *to_format,
 }
 
 static void clear_format_track(struct dasd_format_entry *format,
-			      struct dasd_block *block)
+			       struct dasd_block *block)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&block->format_lock, flags);
-	atomic_inc(&block->trkcount);
 	list_del_init(&format->list);
+	format->cqr = NULL;
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
 
@@ -3211,8 +3222,8 @@ static struct dasd_ccw_req *
 dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 		     struct irb *irb)
 {
+	struct dasd_format_entry *format = NULL;
 	struct dasd_eckd_private *private;
-	struct dasd_format_entry *format;
 	struct format_data_t fdata;
 	unsigned int recs_per_trk;
 	struct dasd_ccw_req *fcqr;
@@ -3231,7 +3242,6 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	private = base->private;
 	blksize = block->bp_block;
 	recs_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
-	format = &startdev->format_entry;
 
 	first_trk = blk_rq_pos(req) >> block->s2b_shift;
 	sector_div(first_trk, recs_per_trk);
@@ -3248,9 +3258,9 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
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
@@ -3262,17 +3272,27 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	fdata.intensity = private->uses_cdl ? DASD_FMT_INT_COMPAT : 0;
 
 	rc = dasd_eckd_format_sanity_checks(base, &fdata);
-	if (rc)
+	if (rc) {
+		if (format)
+			clear_format_track(format, block);
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
+			clear_format_track(format, block);
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

