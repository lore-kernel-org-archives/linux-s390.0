Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B503BCD33
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607244; cv=none; b=mhVJE+sfmfCApFLhPZFmdqhhhtCDgQfcYa3GOcko8zL5CkfoRpdNsjG38UsAo4EBbdalYwHPrk8Kw+fh0Q/rd+rsWiLFJF5zzu3uA+dQOMqYmxVu5kjlZITbyYXg900loPCQg6r4xGI6TgbFkEiHT1wJzEM1RpePLzTQM1uWkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607244; c=relaxed/simple;
	bh=5HbafWZ/3YAsRoHW6QmQRwFnCgAifpcfpm30ePtYUv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G75BCeACiWsud9W7XjP3Skf8ReuHN4z82zC6ck01k/hYhyhzvB5d3QePzuKyKve8IqXy9a2xJVuAGK8tuarHwSYWManyjc9SlM1VGAf/qzycbTOvjFpGO08VoTMnw5a35io+6kMHPZErq73bQNrmDXAf1KIzBaboO55BKEohoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GjkNltaQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GjkNltaQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Flacu3271862
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8dDpYc
	wX7D7+UXVpzb6OZBzFWyRWWZx9zRjrUqPcvQs=; b=GjkNltaQDKI6dZ8fTzce1h
	bENxVO5xaz578hMsOb5/UhL1i5sL9BTtvQhAcXdYqJaKRuwBoSLNunK7xZscwDWC
	/g5GmkB30TSgAaAgN3BtFbIvMaK/FIMEA0nKY8bKzvAH1lLWLgQk//GUrmu897UX
	MnBG7/hLRZ/w71e8IodkiEa7IH3O4NoxSray6aP6GgLTutZ6vo3pueiioCPqqd/b
	OpcdXhVIOub0VoCCk49A9euSsaCObcfEuXrYWqqz7JEsjzylwnjLfhkyzgkEOpGG
	gau4wL914RMsZF8uZzNJzKvidF5QwSaWZDhMBxw+6GJZkQzVJkl7hK1X+x2ddMLQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqa23y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuHkS022173
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqvw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0bBC35127782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538E52004B;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 346F420043;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 09/19] s390/dasd: Add range-based format-track collision detection
Date: Sat,  1 Aug 2026 20:00:23 +0200
Message-ID: <20260801180033.3679412-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: verUK7mCHgLwkfK4UIhc4htUWUPrmHOY
X-Proofpoint-ORIG-GUID: verUK7mCHgLwkfK4UIhc4htUWUPrmHOY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX/mbMUqgJiln3
 z1UeL4br4urDQ1n0bzWBH985dQh7k48zKfqwwKqcZvW0sxbZK0XU+sjan8sPZg6BXJyWQFas/pL
 bOcC6hLRoiS+227Kmux7y3K6aZsi7kM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=GaJKkLePmxIg6gA0iAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX43dh4Xuef3OX
 +IkBd7TQS9QRpaNEjjFKW4w7NbIGJoJvWZra5Wx3MRCnBiJt+vFf4b+8q+BpWR2Pfg8H8YaEpRT
 tQKYrmJ0MQN1tmz4PdcO0gtZLTYVM9qRy+kuhH3LDRRZGV+N7s97jogfDjuEJbg0cURIH0Y3Qil
 fqHwismHOIKHEqxDJ4hUBfXy/I6iB/7Fq21yRIQ/AzyDNm5WChUlJveTei3CVOEKDjHAel+qxKP
 SJBZHZXsmNK93G0gOzjU0z9NQ5n76Cd0vuLSrcIhx8lkZSB7G7nMMKr/ZGL3zrDQPcIxgoFL3xn
 1lOOCqEmpdjfJ4TkAKOqIzzu5Xam6zxjG3/OqP6P1s6qdJ1Tebq9P2nWtb6GoERj6JqgxGD2P85
 fa/1DurlKC0iCVq+djmc7Fy1Tekk9oBfoaM1alhiKJEvVNdMeAowkrfB2GcZ7gaUjY2oun+/R51
 8BBDU2a1QFf1rRslDeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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
 drivers/s390/block/dasd_eckd.c | 60 +++++++++++++++++++++++-----------
 drivers/s390/block/dasd_int.h  | 19 +++++++++--
 3 files changed, 80 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 6481303821bd..fe144d41b029 100644
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
@@ -2880,6 +2873,28 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 
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
+			WRITE_ONCE(temp_cqr->collision, true);
+		}
+	}
+out:
 	dasd_schedule_block_bh(cqr->block);
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index db07fafefe04..e1b096b9271f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3150,32 +3150,44 @@ static int dasd_eckd_format_device(struct dasd_device *base,
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
+	if (cqr && READ_ONCE(cqr->collision)) {
+		WRITE_ONCE(cqr->collision, false);
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
+	while (i < DASD_NR_FORMAT_ENTRIES &&
+	       READ_ONCE(device->format_entry[i].cqr))
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
@@ -3188,8 +3200,8 @@ static void clear_format_track(struct dasd_format_entry *format,
 	unsigned long flags;
 
 	spin_lock_irqsave(&block->format_lock, flags);
-	atomic_inc(&block->trkcount);
 	list_del_init(&format->list);
+	format->cqr = NULL;
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
 
@@ -3211,8 +3223,8 @@ static struct dasd_ccw_req *
 dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 		     struct irb *irb)
 {
+	struct dasd_format_entry *format = NULL;
 	struct dasd_eckd_private *private;
-	struct dasd_format_entry *format;
 	struct format_data_t fdata;
 	unsigned int recs_per_trk;
 	struct dasd_ccw_req *fcqr;
@@ -3231,7 +3243,6 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	private = base->private;
 	blksize = block->bp_block;
 	recs_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
-	format = &startdev->format_entry;
 
 	first_trk = blk_rq_pos(req) >> block->s2b_shift;
 	sector_div(first_trk, recs_per_trk);
@@ -3248,9 +3259,9 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
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
@@ -3262,17 +3273,28 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
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
+		/* occupancy marker; the free-slot scan reads it with READ_ONCE */
+		WRITE_ONCE(format->cqr, fcqr);
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

