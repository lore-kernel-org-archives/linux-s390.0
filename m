Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7D433E62;
	Wed,  5 Aug 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928598; cv=none; b=RQC1Ws+gGAo/579qKr68ms6u7o3hEGXcQE5dMvdBmmLNessHCKaAfypRU+0EKICFKmCBRbXgRuUetoWt2ZdOSmtxZTeXv+oHpEWL48Xe34kW6W9becFYsliAo21YOl475sTtENJzb5AzrwYZDzvN5ZbPB2cNvgYeyPgA8UUi9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928598; c=relaxed/simple;
	bh=IS7FD9gbHIyUsQhyx5WcoxHGXPAeflOdc6f24JBLuso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+AHv/6JE51zDhDfN8QjNq+tpQaQOzx228kAzlhirk9xUwW3WU01MmyhlOgs5+WUfJ08OdMtP3+qOS0lTqL9W9P5bjJBaFOWWld66Iph00cVfxHx3QpYcxOiRX/lzmPZqEJyxVv2VweGvFkdbgQS+uCx5P2mmzIYFcWaE6HgcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O/LxTOz8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/LxTOz8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lcuf3288369;
	Wed, 5 Aug 2026 11:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eYCGN7
	cMXo3PpGY6B1S7/U0UbV/vHJVzQ3A4xsMoXII=; b=O/LxTOz87+5c8CblqLcM24
	H5IcIRLPA+t/i0H3qmvOXHh8TUnKjBvQN0TOqQV+ZYFYNlAk3lQHU9Jy2KiIo/z1
	5k3eR4HLcOKuYtmuKS+ApNlUsBKkqF79aW/EKCv/6nT6IojOyg0+XVbQsmA7bdcT
	AYoDjLrgaiZjJTzpFo9LFkwaXvQd0douE8q6cpQgqMh28fB6ueqrc/AvpWc5cDKc
	nKg+x8a/9g+JBfWon90XmwnkCmZp+5q2Dp3BRrbwAsAAb/+YkuYs0FJ1wjkZE6KL
	RO4M2tWrj1gWcDboG7ZvLdnRPYU8EOEdngmQ04YmypXtAbLBuQdR/0bCTXxttDbw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gab6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBFiu020866;
	Wed, 5 Aug 2026 11:16:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6bta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGIUF32375244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B58A220043;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E5082004D;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 13/19] s390/dasd: Add full_track_bias to control fulltrack write mode
Date: Wed,  5 Aug 2026 13:16:06 +0200
Message-ID: <20260805111612.1285190-14-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4e1P1pQr1ZFS
 J/IGI96Qy38yddBWRnVd05G9x0AvvbdeNSu9Jk8RvbRZEHiVD2ebvjyJM/mZZAZjc+0cwz3y6yE
 qjVYKiQrSGEYJdqMdjKhOLb5+YrF5qjHJ5Z9rBuf/NNg88SIBTlYa3Ad4wQyVX80mJ/3jMVZpoL
 l22BgzPaSKYod/6qJBfFtR67fFnDs8zyDmBH3cUzC0zmmI0LhPwbW8COcUEoOcN1Se/Xf5xOm3X
 3+S5STgXLNmF9GWvKQ/iHPX7AZk9zCKjnpJEkBstXHTYD5wNNMMQv2C/kXo+P5L3r0klj14tObx
 DcBYbSlzRAOVAGW2CSO5JBnMMb4gb0mnLANBnF2u2LzwGCvkOr2uU1YErYvMCt+P9sz7TMct3M8
 +1sQjE4gaS6Xa2gp5dZ2By7PGU737YDrDRnnjP+Uq+xKD6pePixvk0eKdAmqdCQPRQsj3SQySS8
 nNkOjrMzoRjMN0c7dew==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a731b89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EGcN5M5RbvjoWc33k-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lyZvSdHZ8z6gnXDImNfwD6SAiEX46MJM
X-Proofpoint-ORIG-GUID: lyZvSdHZ8z6gnXDImNfwD6SAiEX46MJM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXwlU2US9S9uAV
 Un5UfWQpSDXfUmIYoEdKUOJwzVqjUZmna6KSCWZogipd7jBN0gGOf5DQOBlveTvDVOaRm2k3F3+
 PM1XOfuUU1MGtTxWFPgWanccjjmEz0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

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
index da488c0775fc..067ab66209b6 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -48,6 +48,18 @@
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
@@ -2149,6 +2161,11 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
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
@@ -5204,11 +5221,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
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
index e1ffa20db10a..b8a3190c9c93 100644
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

