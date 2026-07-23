Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B63478851
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814480; cv=none; b=IM4rx+hm9OQkrEkuGqMuGkWuUr7EEy1Ain75uC6bk6VtDRJE0wskkzNM8cKGsu59+g0LBKT/n40/ZqqttFsuBVmTmph0JUITbSKRpOxfjQCzhxaY3r1NE4AGVhZAbrYgmO5a2dJe0E+UqIVr/gXkCbc4vpc/vY/3uCHQItDc3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814480; c=relaxed/simple;
	bh=n/yA/nkQos6ItbomGNl9RkLQ1XCaWb7Ty9CnROl2MaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KonMJZRMUFhf0GWyRUgp73sL9m4XfyNF7ct/C12eHH2o6F5PW352XY5azwTohfeU3wpvQpdw7N+O3RwCZaj4fWng9gnKEI42s4IO54/cp/BfdgmHXu/CLIqqc3i8g6dkd4n8CFi+SI4v40Y6npdWfwvpy9OkJ9MAZ8kN+H5gayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ocCJA/lV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ocCJA/lV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBlO23089931
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2l8b3e
	BOV7PsOD/mNpfl0x+g2vvGIdLXFgTxTYMbR/U=; b=ocCJA/lVMn4tlQaDsEqGgg
	iujJJN5OSDx7ypikcndz57BPMrHcxv1ho0moHSJ4YLC1+Hl4xd5RaC1iJs85zHYM
	wUR0iaFlyXKu3X1QmJmN8tETxsERlU6F1ctCy5x5zsyuXHfGs7M/5MvB3yhcdybS
	7Zn3DMw+rkLNcx1wZuee4a+OD0Y0PhlQnAB99ySGajiPEXsmyV8kVxADpN3dKTso
	MkxwMsLAQLUCkACm5TyA8VGPujfY6iPNOIuHP51yOKOnJwZFREqZMX44cG9EXvR4
	FBaZkYqt8eKL+ikibVdsVOaDkMzz7faa+icIfWPmd47nAi9sk6JJkWTGwH0+7FyQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abquq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZ9X028619
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgym52b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlmVw45089130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC91A20040;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D6EE2004D;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 08/13] s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
Date: Thu, 23 Jul 2026 15:47:38 +0200
Message-ID: <20260723134743.672413-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX6EL3a9nwjpEL
 JRMW+bqUDy+ImBneg8mvuM5XV925EMiQ8x0+5EXqBIjhGGI6ZKrw8RPNPrRTTewLwyNpqy5HzhR
 LkAp3r9mJo9bXACemZn9EB9lTZ1kk6u52ihCCWgCzxTxuQ2XWN/xlAedv/RtTL26mzMhHsWb+D8
 5vASwmcUdaZuaLqwrz07UaVevsjJQQ9c51lGiZdBx92vg7lDoya+okrcPmFVlzg6kRY6p1+1x4n
 iova42fP7eUN/UH5Mpa0odl3nq+Ftkcz4MzDCYbl50sL3MSUMF0j9jGk1vhi9OGsCNWPPMfTUcY
 P5x6H84cTii5BiUTNp29FAb9ZyUh0pQCOlXBTpa8wbfY/5AX49GOEyBAIxSGZ7sDLCfue71rSD1
 76Cea4tihEjxA99sqlqCCIyAQRE7FamJt4pE1ftuAigOSe3O+QCZeeYps+ULfKvd9uB5QlIMR3U
 +QY8qEbZNWY/C3mLPZQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=IVptjuxw-tFtak4sdAUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ijpg0oO1IIF4lveatCvHD-Vn51KKf_tG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX2It4asFXOvkP
 n5wTeoFSkJ+pMQ5SqxoVJjbk/S2HGGLNFNl3WZJJp7p+G36oGtV5I58on1MNeLP7dD7WYdcGDqU
 ero3HvlmmVyTZcUE0cqDiVpyN3vBZnY=
X-Proofpoint-GUID: ijpg0oO1IIF4lveatCvHD-Vn51KKf_tG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Turn the middle of the ft_bias range (1..99) into an adaptive heuristic
that switches between fulltrack write (ft1) and plain write ft0 depending
on how sparse the device still is.

A sparse device benefits from fulltrack writes (it avoids the format/retry
cycle); once enough tracks are formatted the per-write overhead of
ft1 outweighs that. An state machine  measures the NRF rate in short ft0
probe windows and flips back to ft1 when it is high
(FT1_ACTIVE -> PROBING -> FT0_STABLE, with a backing-off reprobe interval).

The four parameters are derived from ft_bias by linear interpolation,
anchored so ft_bias == 50 derives the following values:

ese_heu_start_interval - 2000 - IOs in ft1, before first ft0-Probe starts
ese_heu_probe_window - 100 - IOs in probe window
ese_heu_nrf_high - 10 ‰ (= 1 %) - TRACK_FORMAT rate that leads to ft1
ese_heu_max_interval - 500000 - Backoff-Cap: max. IOs between two probes

Higher is more eager to use ft1, and 0/100 skips the heuristic.
The NRF counter is bumped in dasd_eckd_ese_format() for both the classic
NRF sense and the HPF INV_TRACK_FORMAT equivalent.
The state machine resets to ft1 on check_characteristics, full format,
and release-space.

A read-only ese_heuristic_state sysfs attribute exposes the current mode.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 38 ++++++++++++++-
 drivers/s390/block/dasd_eckd.c   | 79 ++++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_int.h    | 81 ++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 035c022255b6..c587817f5cf9 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1660,7 +1660,7 @@ static ssize_t full_track_bias_store(struct device *dev,
 		return -ENODEV;
 
 	device->ft_bias = val;
-	device->fulltrack = val ? 1 : 0;
+	dasd_ft_bias_apply(device);
 
 	dasd_put_device(device);
 	return count;
@@ -1668,6 +1668,41 @@ static ssize_t full_track_bias_store(struct device *dev,
 
 static DEVICE_ATTR_RW(full_track_bias);
 
+static const char * const dasd_ese_heu_state_names[] = {
+	[DASD_ESE_HEU_FT1_ACTIVE] = "fulltrack active",
+	[DASD_ESE_HEU_PROBING]    = "probing",
+	[DASD_ESE_HEU_FT0_STABLE] = "fulltrack inactive",
+};
+
+/* read-only: current full-track mode / adaptive FSM state, for observability */
+static ssize_t
+ese_heuristic_state_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dasd_device *device;
+	unsigned int state;
+	int len;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+	if (device->ft_bias == 0) {
+		len = sysfs_emit(buf, "fulltrack deactivated\n");
+	} else if (device->ft_bias >= DASD_FT_BIAS_MAX) {
+		len = sysfs_emit(buf, "fulltrack permanent active\n");
+	} else {
+		state = device->ese_probe_state;
+		if (state < ARRAY_SIZE(dasd_ese_heu_state_names))
+			len = sysfs_emit(buf, "%s\n", dasd_ese_heu_state_names[state]);
+		else
+			len = sysfs_emit(buf, "unknown\n");
+	}
+	dasd_put_device(device);
+	return len;
+}
+
+static DEVICE_ATTR_RO(ese_heuristic_state);
+
 static ssize_t
 dasd_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -2464,6 +2499,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_failfast.attr,
 	&dev_attr_expires.attr,
 	&dev_attr_full_track_bias.attr,
+	&dev_attr_ese_heuristic_state.attr,
 	&dev_attr_retries.attr,
 	&dev_attr_timeout.attr,
 	&dev_attr_reservation_policy.attr,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 11d1fc83c5a3..439c18a39f60 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2132,7 +2132,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 
 	/* default ESE fulltrack write aggressiveness from the module parameter */
 	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
-	device->fulltrack = device->ft_bias ? 1 : 0;
+	dasd_ft_bias_apply(device);
 
 	if (private->conf.gneq) {
 		value = 1;
@@ -3140,6 +3140,13 @@ static int dasd_eckd_format_process_data(struct dasd_device *base,
 static int dasd_eckd_format_device(struct dasd_device *base,
 				   struct format_data_t *fdata, int enable_pav)
 {
+	/*
+	 * A full format (start_unit == 0) returns the device to a fully sparse
+	 * state, so restart the heuristic from ft1 without an offline cycle.
+	 */
+	if (fdata->start_unit == 0)
+		dasd_ft_bias_apply(base);
+
 	return dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
 					     0, NULL);
 }
@@ -3201,6 +3208,65 @@ static void clear_format_track(struct dasd_format_entry *format,
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
 
+/*
+ * Adaptive ft_bias heuristic, called once per IO from dasd_eckd_build_cp().
+ * Probes the device formatting state by briefly switching to ft0 and measuring
+ * the NRF rate; parameters are derived from ft_bias.
+ */
+static void dasd_ese_heuristic_tick(struct dasd_device *basedev)
+{
+	int ios, nrf, rate;
+
+	if (atomic_inc_return(&basedev->ese_io_cnt) < (int)basedev->ese_probe_interval)
+		return;
+
+	/*
+	 * One wins the race to evaluate, the rest see ios == 0 after the
+	 * xchg and return early, preventing redundant state transitions.
+	 */
+	ios = atomic_xchg(&basedev->ese_io_cnt, 0);
+	if (ios <= 0)
+		return;
+
+	switch (basedev->ese_probe_state) {
+	case DASD_ESE_HEU_FT1_ACTIVE:
+		/* Start ft0 probe window, reset NRF counter for clean measurement */
+		basedev->fulltrack          = 0;
+		basedev->ese_probe_state    = DASD_ESE_HEU_PROBING;
+		basedev->ese_probe_interval = basedev->ese_heu_probe_window;
+		atomic_set(&basedev->ese_nrf_window, 0);
+		break;
+
+	case DASD_ESE_HEU_PROBING:
+	case DASD_ESE_HEU_FT0_STABLE:
+		nrf  = atomic_xchg(&basedev->ese_nrf_window, 0);
+		rate = nrf * 1000 / ios;
+		if (rate > (int)basedev->ese_heu_nrf_high) {
+			/* NRF rate high: device still sparse, ft1 is better */
+			basedev->fulltrack          = 1;
+			basedev->ese_probe_state    = DASD_ESE_HEU_FT1_ACTIVE;
+			basedev->ese_probe_interval = basedev->ese_heu_start_interval;
+		} else if (basedev->ese_probe_state == DASD_ESE_HEU_PROBING) {
+			/*
+			 * NRF rate low: device mostly formatted, ft0 is faster.
+			 * Re-probe frequently at first, then back off below.
+			 */
+			basedev->ese_probe_state    = DASD_ESE_HEU_FT0_STABLE;
+			basedev->ese_probe_interval = basedev->ese_heu_probe_window;
+		} else {
+			/*
+			 * Still stable in ft0: back off the re-probe interval
+			 * (double it, capped at max_interval) so a long-lived
+			 * formatted device is not probed more often than needed.
+			 */
+			basedev->ese_probe_interval =
+				min(basedev->ese_probe_interval * 2,
+				    basedev->ese_heu_max_interval);
+		}
+		break;
+	}
+}
+
 static void dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 				 struct irb *irb)
 {
@@ -3225,6 +3291,8 @@ static void dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_r
 	block = cqr->block;
 	base = block->base;
 	private = base->private;
+	if (dasd_ese_adaptive(base))
+		atomic_inc(&base->ese_nrf_window);
 	blksize = block->bp_block;
 	recs_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
 
@@ -3984,6 +4052,13 @@ static int dasd_eckd_release_space_full(struct dasd_device *device)
 
 	rc = dasd_sleep_on_interruptible(cqr);
 
+	/*
+	 * Releasing all space (RAS) wipes every track and the device is fully
+	 * sparse again, so restart the heuristic from ft1.
+	 */
+	if (!rc)
+		dasd_ft_bias_apply(device);
+
 	dasd_sfree_request(cqr, cqr->memdev);
 
 	return rc;
@@ -5149,6 +5224,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	struct dasd_ccw_req *cqr;
 
 	basedev = block->base;
+	if (dasd_ese_adaptive(basedev))
+		dasd_ese_heuristic_tick(basedev);
 	private = basedev->private;
 	/* Calculate number of blocks/records per track. */
 	blksize = block->bp_block;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index e2df8666520f..2d09c7db26cb 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -633,6 +633,15 @@ struct dasd_device {
 	/* ESE fulltrack write control (see full_track_bias sysfs attribute) */
 	unsigned int ft_bias;	/* aggressiveness 0..100: 0=off, 100=always */
 	unsigned int fulltrack;	/* internal: use WRITE_FULL_TRACK for aligned writes */
+	/* adaptive heuristic (active for ft_bias 1..99), derived from ft_bias */
+	unsigned int ese_probe_state;        /* heuristic FSM state */
+	unsigned int ese_probe_interval;     /* IOs between evaluations */
+	atomic_t ese_io_cnt;                 /* IO counter for current window */
+	atomic_t ese_nrf_window;             /* NRF/INV_TRACK_FORMAT events in window */
+	unsigned int ese_heu_start_interval; /* IOs before first probe */
+	unsigned int ese_heu_probe_window;   /* IOs in probe window */
+	unsigned int ese_heu_max_interval;   /* max IOs between probes (backoff cap) */
+	unsigned int ese_heu_nrf_high;       /* NRF per-mille threshold → activate ft1 */
 };
 
 struct dasd_block {
@@ -704,6 +713,25 @@ struct dasd_queue {
 #define DASD_FT_BIAS_MAX	100
 #define DASD_FT_BIAS_DEFAULT	50
 
+/* ESE fulltrack heuristic FSM states (adaptive range, ft_bias 1..99) */
+#define DASD_ESE_HEU_FT1_ACTIVE   0   /* fulltrack write active */
+#define DASD_ESE_HEU_PROBING      1   /* ft0 probe window, measuring NRF rate */
+#define DASD_ESE_HEU_FT0_STABLE   2   /* device formatted, ft0 active */
+
+/*
+ * Heuristic parameters are derived from ft_bias by linear interpolation,
+ * anchored so that ft_bias == 50 reproduces the previously shipped defaults
+ * and ft_bias == 100 is the most aggressive end of the range.
+ * probe_window is constant.
+ */
+#define DASD_ESE_HEU_PROBE_WINDOW	   100
+#define DASD_ESE_HEU_NRF_HIGH_A50	    10	/* NRF per-mille threshold */
+#define DASD_ESE_HEU_NRF_HIGH_A100	     1
+#define DASD_ESE_HEU_START_A50		  2000	/* IOs before first probe */
+#define DASD_ESE_HEU_START_A100		   500
+#define DASD_ESE_HEU_MAX_A50		500000	/* backoff cap */
+#define DASD_ESE_HEU_MAX_A100		 20000
+
 /* per device flags */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 #define DASD_FLAG_EER_SNSS	4	/* A SNSS is required */
@@ -866,6 +894,59 @@ static inline bool dasd_req_conflict(struct dasd_ccw_req *cqr1,
 		 cqr2->end_trk < cqr1->format->start_trk);
 }
 
+/*
+ * true when device is ese device and ft_bias selects the adaptive
+ * heuristic (neither hard endpoint)
+ */
+static inline bool dasd_ese_adaptive(struct dasd_device *device)
+{
+	return device->discipline->is_ese &&
+		device->discipline->is_ese(device) &&
+		device->ft_bias > 0 &&
+		device->ft_bias < DASD_FT_BIAS_MAX;
+}
+
+/* linear interpolation anchored at aggr==50 (-> d50) and aggr==100 (-> d100) */
+static inline unsigned int dasd_ese_lerp(unsigned int d50, unsigned int d100,
+					 unsigned int aggr)
+{
+	return (unsigned int)((int)d50 +
+		((int)d100 - (int)d50) * ((int)aggr - 50) / 50);
+}
+
+/*
+ * Apply the ft_bias knob. For the hard endpoints just pin the mode; for the
+ * adaptive range derive the heuristic parameters from ft_bias and (re)start
+ * the FSM in ft1 so a freshly sparse device avoids the NRF penalty right away.
+ */
+static inline void dasd_ft_bias_apply(struct dasd_device *device)
+{
+	unsigned int a = device->ft_bias;
+
+	if (!dasd_ese_adaptive(device)) {
+		device->fulltrack = (a >= DASD_FT_BIAS_MAX) ? 1 : 0;
+		device->ese_probe_state = DASD_ESE_HEU_FT1_ACTIVE;
+		return;
+	}
+
+	device->ese_heu_nrf_high =
+		dasd_ese_lerp(DASD_ESE_HEU_NRF_HIGH_A50,
+			      DASD_ESE_HEU_NRF_HIGH_A100, a);
+	device->ese_heu_start_interval =
+		dasd_ese_lerp(DASD_ESE_HEU_START_A50,
+			      DASD_ESE_HEU_START_A100, a);
+	device->ese_heu_max_interval =
+		dasd_ese_lerp(DASD_ESE_HEU_MAX_A50,
+			      DASD_ESE_HEU_MAX_A100, a);
+	device->ese_heu_probe_window = DASD_ESE_HEU_PROBE_WINDOW;
+
+	device->ese_probe_state    = DASD_ESE_HEU_FT1_ACTIVE;
+	device->ese_probe_interval = device->ese_heu_start_interval;
+	device->fulltrack          = 1;
+	atomic_set(&device->ese_io_cnt, 0);
+	atomic_set(&device->ese_nrf_window, 0);
+}
+
 /* externals in dasd.c */
 #define DASD_PROFILE_OFF	 0
 #define DASD_PROFILE_ON 	 1
-- 
2.53.0

