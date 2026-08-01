Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF73812EC
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582627; cv=none; b=Weezg15WJ/YbnDOu3BdfX/WKyI2rjqV1Gsh5o6V7AeSkiAERcc07k15SVi/7GDv9+qmpYcVm32zpjq+cINE385U6HIt3/Sn900WHMFUokMisMUut0E2PpzMZsoztY6oAFS2/YvyZ+d3P4sghd46WXBuihS4vruFvvdOva6fb4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582627; c=relaxed/simple;
	bh=yRDFUsGmO4tf3St56qelqVgxBECiMf4Ut3tNgNqPd3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNdRflOsTNbpZwPKt5dd+ii5wsnD1CP3fZOvvVWQjSn+h63YCjPZLluj/5R8mmI5/5a3yaCSZWiP4F0b9YSkywrQGvn/+0X4eh6KS+VGgHSXxiK/lEBWaWGsrj7TcSuJCd8DXuMpfAMMEojR/NZMFMlQhwmJGjZSNdAxbTPSsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=llgoCP5n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="llgoCP5n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6711WmZO3410565
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c/AzTb
	5vkTkNtm2ac4FjaJMO0+wRVtSFd8WV4bQZN/w=; b=llgoCP5nCA4NdQTez1SVn3
	jddTeTAsKsKMcLO6Kkz9WqzYlW+tVxzFRMzu3MT/tJNRez6vLSQzBep8bMz5vIn9
	qpuSR1gKd1HsdkovE9EkQXw9jqhYQLKcueQmRvRkvrbYUlujN4qucu/q4treVG0O
	EfP7OuXqqAxicD+7R63YItgnMYXHOCegsYe72e3RuCmGnLGL1jbXObYRasnztlB+
	CLvbXXDei0631XRH/WrfK4MllGKYIblAz7DjG7ElYFe/2xyVeLuoo0t1jEATOIGv
	pbDyavWrvcWjvx2GHlsxlLryVRQQDbWdIfxrTPlyCasWb2Un2dKGYbTfDAUoTWbw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fs8es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuKrh014329
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhum1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAIDs50332072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61FA520040;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED9B2004D;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 12/18] s390/dasd: Add full_track_bias to control fulltrack write mode
Date: Sat,  1 Aug 2026 13:10:02 +0200
Message-ID: <20260801111008.3391031-13-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXxnXn9ZBhb8b2
 fKjvFEqoRZHmwHgAfI9i3hRBMkTukZETOeuO+r+lUKwLeKR4lsczF4oBnZ2qdXO0D9aj6OCRVwE
 rFwMVZnssbydckZmduax0JYJN/q1kWTOYgEdoDVWidC+gv/APMWyKv2KIcqe+j07o24jPjvcjjG
 aGMjidvarwoqGB46QBgqSp2vD1SuFWKM+NKakZB1z2dHQBVlGpfQSCPaJpvUYgOj2XMH70/Szea
 ONdMVfLuwbPIgQ7BuffM+Q2AqUw/YSygJPLdld+X9SjeTp2PsDKg5mFOWK3iOLWckiqVa0PWWrq
 1wAvpl5eyCFvHlcUfmS81u5eoRPuB8atYrMwhEQwszIFk2HVCLvBU27W5QtpbyBXWaTxlyksarg
 Yx1mJ7HdraSgT09jG8ISZ5/bCzXHfLQm9gcgi/G3wOx6AN+FfKtPjQe6KHNKXHDfhFYMU9nqUSU
 fVZ56CYJTAZotT0hOYA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6dd41e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EGcN5M5RbvjoWc33k-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: StmzuR36Up-rwcbGfMNPwoIR85fiymdg
X-Proofpoint-ORIG-GUID: StmzuR36Up-rwcbGfMNPwoIR85fiymdg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX60XxVuRHAjw2
 zoRemoTC8ifsPIjVygf7VzvoiAc6tjrXJUneb2EpQqhqQWf5np9+yxWXNONbQ0Z3cbKeib1UKlt
 uUOGujWOxrBMPEzKg8Uz8kXW5BjUaw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

Add a single per-device 'full_track_bias' sysfs attribute (0..100) that
gates the full-track write path. 0 disables it, 100 routes every aligned,
full-track write through dasd_eckd_build_cp_tpm_writefulltrack(). Values in
between are reserved for the adaptive heuristic added in the next patch.
For now any non-zero value simply enables full-track writes. Internally the
value is kept in the per-device 'ft_bias' field.

This will control the default IO path only.
In case we get an unformatted track error it will always be used to format
and write the track in one go.

The WRITE_FULL_TRACK command has an advantage on sparse formatted ESE
devices but it has an overall penalty for maximum throughput compared to
usual track based IO.

The attribute lives at /sys/bus/ccw/devices/<devid>/full_track_bias and
accepts 0..100. The default is DASD_FT_BIAS_DEFAULT; together with the
adaptive heuristic added in the next patch it uses full-track writes only
where they pay off, avoiding the ESE format penalty out of the box while
keeping the throughput cost off already-formatted volumes.

A 'full_track_bias' module parameter sets the initial value applied to
every device at online time; individual volumes can still be re-tuned
through their sysfs attribute afterwards.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 39 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 36 +++++++++++++++++++++++++----
 drivers/s390/block/dasd_int.h    | 18 +++++++++++++++
 3 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 381d616ad433..035c022255b6 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1630,6 +1630,44 @@ dasd_expires_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(expires, 0644, dasd_expires_show, dasd_expires_store);
 
+/* ESE fulltrack write aggressiveness knob (0..100, see DASD_FT_BIAS_*) */
+static ssize_t
+full_track_bias_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_device *device;
+	int len;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+	len = sysfs_emit(buf, "%u\n", device->ft_bias);
+	dasd_put_device(device);
+	return len;
+}
+
+static ssize_t full_track_bias_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct dasd_device *device;
+	unsigned int val;
+
+	if (kstrtouint(buf, 0, &val) || val > DASD_FT_BIAS_MAX)
+		return -EINVAL;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+
+	device->ft_bias = val;
+	device->fulltrack = val ? 1 : 0;
+
+	dasd_put_device(device);
+	return count;
+}
+
+static DEVICE_ATTR_RW(full_track_bias);
+
 static ssize_t
 dasd_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -2425,6 +2463,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_erplog.attr,
 	&dev_attr_failfast.attr,
 	&dev_attr_expires.attr,
+	&dev_attr_full_track_bias.attr,
 	&dev_attr_retries.attr,
 	&dev_attr_timeout.attr,
 	&dev_attr_reservation_policy.attr,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index d757c6ebaea0..5347ebce7c2e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -47,6 +47,18 @@
 MODULE_DESCRIPTION("S/390 DASD ECKD Disks device driver");
 MODULE_LICENSE("GPL");
 
+/*
+ * Default full-track write bias applied to every ESE volume at online time;
+ * individual volumes can be re-tuned afterwards through their per-device
+ * full_track_bias sysfs attribute. 0 disables full-track writes, 100 always
+ * uses them, 50 (the default) enables the adaptive heuristic. Values above
+ * DASD_FT_BIAS_MAX are capped when applied.
+ */
+static unsigned int full_track_bias = DASD_FT_BIAS_DEFAULT;
+module_param(full_track_bias, uint, 0644);
+MODULE_PARM_DESC(full_track_bias,
+		 "Default ESE full-track write bias 0..100 (0=off, 1..99=adaptive, 100=always)");
+
 static struct dasd_discipline dasd_eckd_discipline;
 
 /* The ccw bus type uses this table to find devices that it sends to
@@ -2148,6 +2160,11 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->path_interval = DASD_ECKD_PATH_INTERVAL;
 	device->aq_timeouts = DASD_RETRIES_MAX;
 
+	/* default ESE fulltrack write aggressiveness from the module parameter */
+	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
+	/* only the "always" endpoint forces fulltrack unconditionally here */
+	device->fulltrack = (device->ft_bias >= DASD_FT_BIAS_MAX) ? 1 : 0;
+
 	if (private->conf.gneq) {
 		value = 1;
 		for (i = 0; i < private->conf.gneq->timeout.value; i++)
@@ -5199,11 +5216,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 		/* do nothing, just fall through to the cmd mode single case */
 	} else if ((data_size <= private->fcx_max_data)
 		   && (fcx_multitrack || (first_trk == last_trk))) {
-		cqr = dasd_eckd_build_cp_tpm_track(startdev, block, req,
-						    first_rec, last_rec,
-						    first_trk, last_trk,
-						    first_offs, last_offs,
-						    blk_per_trk, blksize);
+		if (!first_offs && (last_offs + 1 == blk_per_trk) &&
+		    rq_data_dir(req) == WRITE && basedev->fulltrack) {
+			cqr = dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
+								    first_rec, last_rec,
+								    first_trk, last_trk,
+								    first_offs, last_offs,
+								    blk_per_trk, blksize, NULL);
+		} else {
+			cqr = dasd_eckd_build_cp_tpm_track(startdev, block, req,
+							   first_rec, last_rec,
+							   first_trk, last_trk,
+							   first_offs, last_offs,
+							   blk_per_trk, blksize);
+		}
 		if (IS_ERR(cqr) && (PTR_ERR(cqr) != -EAGAIN) &&
 		    (PTR_ERR(cqr) != -ENOMEM))
 			cqr = NULL;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index b523d5a08a17..e2df8666520f 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -629,6 +629,10 @@ struct dasd_device {
 	struct dasd_copy_relation *copy;
 	unsigned long aq_mask;
 	unsigned int aq_timeouts;
+
+	/* ESE fulltrack write control (see full_track_bias sysfs attribute) */
+	unsigned int ft_bias;	/* aggressiveness 0..100: 0=off, 100=always */
+	unsigned int fulltrack;	/* internal: use WRITE_FULL_TRACK for aligned writes */
 };
 
 struct dasd_block {
@@ -686,6 +690,20 @@ struct dasd_queue {
 #define DASD_STOPPED_PPRC    32        /* PPRC swap */
 #define DASD_STOPPED_NOSPC   128       /* no space left */
 
+/*
+ * ESE fulltrack write aggressiveness (full_track_bias sysfs attribute), 0..100:
+ *   0   - never use proactively WRITE_FULL_TRACK
+ *   100 - always use proactively WRITE_FULL_TRACK, no probing
+ *   1..99 - adaptive; higher means switch to ft more eagerly
+ * WRITE_FULL_TRACK has an advantage on sparse formatted ESE devices
+ * but it has an overall penalty for maximum throughput for fully
+ * formatted devices.
+ * The default of 50 tries to balance both and do some probing in between
+ * to choose the best mode for default IO.
+ */
+#define DASD_FT_BIAS_MAX	100
+#define DASD_FT_BIAS_DEFAULT	50
+
 /* per device flags */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 #define DASD_FLAG_EER_SNSS	4	/* A SNSS is required */
-- 
2.53.0

