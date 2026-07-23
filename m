Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77882477984
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814482; cv=none; b=LZ06DkVDxFV3cKoNNcKIWfeO6O2ICYci4eUbQ7e8VE7KdA5TBg0f3oNxMnbO9Njz9jSaWoCGj1oLWzYuslP4BryLp175FTRzFUEFHRWNNziGVwBlMMqNAeoeCJroQaBl58ZfmHEEFXis6hW/o6QRXreL/G4CsWz7yEAwwqiMrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814482; c=relaxed/simple;
	bh=2XY2d5Jtaw5FeYvTpNcQD6Y27GJ6peZQkOIRTCJ5Z+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDXfsSZ44KCN6EESlGFCe0QG+GVrOgsP4L//CsvHE+RwKH+PJu/lJGPneXybgkFwU7a0ZHLOXHDzieAzWziqb+MB0+Nsgln8dtyGyHRzruitKmwUhksRT6xVefj3pxoDvKRPJtmgAHKQP3+U5nq96eEalmM6a+4jMzemB4QziWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTzzsnJa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTzzsnJa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDCFdU2987386
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+3XDc3s8hGQjCXT3c
	3rlqJgjw9FX8xO0zlBhp15wjxA=; b=rTzzsnJapKkmBIuyEdOr7M2SwvcCA7ODE
	ZidyuypLtV9gNeagI2Be53kX7l7BEUWPvL6wckntxxYioyPDeG1BJWoy0FzEwW88
	BPTdXL0LAXXEneefHHfS2Ap/SgrJcvfZNtCd8wd6fDeZyM68eSsLXKWcM46ncJpG
	EAdFGACm9WAfk0RtTWPihwZOZRvx3K5hYqZifwdimtcoYHNveUhHknzKMSdoEAlc
	rI5btATa8tWFu/Hm+jMCrl5kIh4snNWwrOnBIkxCLBnCdc2zIOVk5BXaBZMIFDY1
	wt12Crok9bY0eQ01uMDjW+1IP7UMnmuMiOSdVBL7pBfQiHrAogswg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gf6fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZDO025842
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4dug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlm1s39911774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983462004B;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80B8120043;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 07/13] s390/dasd: Add full_track_bias sysfs attribute to control fulltrack write mode
Date: Thu, 23 Jul 2026 15:47:37 +0200
Message-ID: <20260723134743.672413-8-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX4+5As+iaffP6
 FULNsZk5otbRCxJxLWm+G9qS04FgohKbJ85llcpsRVAeISIntm7CN0FuXEao7Z1bMA2mPSsPxvR
 iRaC0K2h6AVxMOpmwDa1wCob3l6cqbXRDOf/Q1Ro8OxKcvD/d45nB2jd+5nVJk8bbpZdA+XVVwT
 vsWzebj6WCPQpTDcaQ52dli8mvabWuG7HCUIzTrduJDt3DjnTB6lkcBsgLKBMU2xM/+xktJaNyZ
 VM/rOeTNTqgF2/IHD5kvyNYSI2u24gU/kW7vADzDglG1Bz6TGk0y5W5to9lVEmvHchsDk4Yj7c0
 TDwPx9t4GQrGWjO6ZWSVw2XHKVGGZhAHTceU3tX+HOOooTN01sEYUsf++utU2i5xBK/p7JZn/Ql
 O9sMMsdKpTlpAn/bSY0cAPz8cVxZAct4SysHmwNPITgWDBBIpzsyHZ+G8SERG9DKRKVZ3tZxGOM
 0K3Q4bk7d8vfQ3aX9og==
X-Proofpoint-GUID: IyZOkUnWGWWi5lQLGlcGc8RjSdwX_CjU
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EGcN5M5RbvjoWc33k-sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX34zaKS3rfDAS
 UwPsI+FV5cbq07swFUzQwyD1tzQzC1cunOnbRugC7ixtMDlfIUlaCJT2frYCUsM9zgPe/6x15D3
 404rnznu6rLcGSnn6XYA/9K0/Jvgxko=
X-Proofpoint-ORIG-GUID: IyZOkUnWGWWi5lQLGlcGc8RjSdwX_CjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

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
accepts 0..100. The default (DASD_FT_BIAS_DEFAULT) enables full-track
writes so the ESE format penalty is avoided out of the box.

A 'full_track_bias' module parameter sets the initial value applied to
every device at online time; individual volumes can still be re-tuned
through their sysfs attribute afterwards.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 39 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 35 ++++++++++++++++++++++++----
 drivers/s390/block/dasd_int.h    | 18 +++++++++++++++
 3 files changed, 87 insertions(+), 5 deletions(-)

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
index daddb8727d82..11d1fc83c5a3 100644
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
@@ -2118,6 +2130,10 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->path_interval = DASD_ECKD_PATH_INTERVAL;
 	device->aq_timeouts = DASD_RETRIES_MAX;
 
+	/* default ESE fulltrack write aggressiveness from the module parameter */
+	device->ft_bias = min_t(unsigned int, full_track_bias, DASD_FT_BIAS_MAX);
+	device->fulltrack = device->ft_bias ? 1 : 0;
+
 	if (private->conf.gneq) {
 		value = 1;
 		for (i = 0; i < private->conf.gneq->timeout.value; i++)
@@ -5165,11 +5181,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 		/* do nothing, just fall through to the cmd mode single case */
 	} else if ((data_size <= private->fcx_max_data)
 		   && (fcx_multitrack || (first_trk == last_trk))) {
-		cqr = dasd_eckd_build_cp_tpm_track(startdev, block, req,
-						   first_rec, last_rec,
-						   first_trk, last_trk,
-						   first_offs, last_offs,
-						   blk_per_trk, blksize);
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

