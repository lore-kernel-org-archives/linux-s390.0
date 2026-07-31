Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43717445AC8
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512353; cv=none; b=hsXW8sjwP9JqEv4FecN3cOyaBPs7C781JgPZQFMF+xALYQvbVLisjQKvZwJU15xKBOZyadw93ep8UI+GiL95/3rAK2E5vjk6ahT/qK4c3sqOsW2NASXkSUvAVTKQfKeU365QVa5DSC/v1wTKMSBHQVCOfWH8R3QnNe8OXZKPJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512353; c=relaxed/simple;
	bh=azamzGVYaEsA4j7bErt29RgFsOVWWVplFBBrv5u+PXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdSQK1hd+MKiPidYPfXag39WOz0BIh6CrtRQLomJx5KpDtARucb0QCF0sivI7+0wqctZid7o9N56I9LR/qx2lQPOmc/BZdTz7TXNxMeBnz8vwvfSeHvWtBDPisUSVPcdbfICiPFk+HV7UPNAk3BFRhkQLQrqwMOMvpQF48BQpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVR3x2Y9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVR3x2Y9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBliJI4072815
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6NZdmE
	MdFBapKWYxz8VKfzfNoePPpxxavV/nG4qtKgw=; b=KVR3x2Y9u54UF/o2n2eLtI
	CALJpAEFR7pZ2C10scQNpqDKXthRBHACiOTP7TOtRNqDStTm32QbvRUKgL2MDf7X
	2fz9jHl4Bzfzt04ZgGM2kZ4eEj6abAcU3+si3MYtGCvWlB94uRobUC+vZtyRUW7o
	ipqNn+5afq8UeX75xnzzvI7OYG+xQwgjD+NB31dHLoGJh8YbmkK8kB7dUpovDyeD
	U/jMaUE7QZ163gxJfUTCv10sG5IjT6J5ZooD1Z55Ki29Xi3Joe9Q/FH5WCTuxoBs
	Wp08qRYpNhkj2Fcsf5phnw7qpKWJhkCBP8zledQfkBGosbAU36dwVVifv8lhgyDA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycwqd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQqiJ009465
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yg7rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd1Xm32702896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD4F2004D;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E34982004B;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 11/17] s390/dasd: Add full_track_bias to control fulltrack write mode
Date: Fri, 31 Jul 2026 17:38:36 +0200
Message-ID: <20260731153842.1729627-12-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N82nKTK21yWwOA17Lrz9obbo6Q0aZRYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX1TQeEV24WlSr
 Zs+XyrX08O1ewCR1UNVUYTABe15rRzwBscomswka8trgRM23N6BjZMrNL31iTWySxtx4qQx0s+O
 pgIAWhdWHPF2YL6ZT8p49Jxwcz2I8z7ZUqx1S8ALhjREnqDs3fi0cvzMjMUY/3u9uyOSpQt6jvQ
 R7YAuhhx59BN+wIlCyBjUGQqs4fFjg+lO1cVcJuHfBEAWvM3+LqAC/qiTqFvqu76NHXw+O4JVMK
 DKjxTbbi7MnixoKWb3ZFfv+6sCr2hKFkN9NqSz3C3SKPuNkEAfq8jtDEtQRB4HRMSIPoJgKflso
 +i6OkN4iwV84kAjKpbfzBgo5w27INMuZYpsIawMqErlNLF5JPnwAiz7u9tpXshylVXEq6aNEG+F
 tUF3kjyunpXa1n1k73JGKhao61Zvh5V31F2XWFywjheTj+dutCGU54m8iSDGmrOqzX5M8Nte8Ld
 jzNRFhVdHSseH3zQPww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXxeiC7JpjGxoo
 2BFwFpytW0UbGszu5Ku8LYgUjkBmy7PeXGTDNN0bSdjnzQHLwzyc/HznIbQ3pTSzRfko8gFp9wW
 P3C7O6fGkqRs6OOx0C8A2Ldq+gFwDyM=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6cc199 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=EGcN5M5RbvjoWc33k-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N82nKTK21yWwOA17Lrz9obbo6Q0aZRYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

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
index 4fdeab98870f..ebb24d7da1c3 100644
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
@@ -5194,11 +5211,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
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

