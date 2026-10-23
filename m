Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777452;
	b=0KdHVKaj+TDPPSkH4AIltnBSmp6ll17Z/G1Ul+iX5DJ26qGLo78GmQlGAbWtRKUXndMF
	 x4V/aMKDjWjhRaOtlT1Cr7j1g37+QqPWPiHdUJG5+meBbpr/WYp24qnCcznHlDemqX54k
	 H+V1Ek9CZwZ8njvfhn5VOeiS3CtF1+RNHo0a3P7jmCq1M4DZ7YVDLgQ7Wk+ncqbdXFZEj
	 SlAwaOZCblan3meDxe2JIXieDqlk3L76CCTeNsIZ/d+jnAYTYjH4Z9GxLq1/EMTxTMPcl
	 ZvqbzpKkXwl3b6t5MbBWonpmLtdesHYgXvemXN1DYpVw5txSBAsyeaHyLJ3a+EQXf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3s+sTbArl3jBXaUMoqxGoQICAMMkO6sHi9c3Vu0UBCs=;
	b=YmQOBPFQJFLEO5Q0Jd+t6vVSccwD6a81gYLZYF7WcIChYrNty8EdQwj2QG0E9pzdw4OM
	 LPxheXU0L50k9jDWNezX9W/JaWFBpracwhjZ7VY9lt/XPfirccT+VIKI26JFvh0mRYHlQ
	 u/IUO29se7288pv922utZLli9Sg7TORfZnbas6PdOEWFD4jU8aq6NIlAL/wP281XsDsAh
	 q52qatXNzVWpFIWRQJzBn6gXJb/eJvDV16kUhajhufhNa6S9v6vO54n3m4jwgiQp2rq+2
	 HQCYoQL0q86nnoSTNrjYiV3lDecaHUk+jTHF1NuTeNeEI2+iChkR5pkzW1YZXM12X+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XAOTctys;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B7606A326;
	Fri, 23 Oct 2026 17:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 984B7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XAOTctys
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGqAvQ3495814;
	Fri, 23 Oct 2026 17:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3s+sTbArl3jBXaUMo
	qxGoQICAMMkO6sHi9c3Vu0UBCs=; b=XAOTctysb/7+bdwYwXcT8fPyFo1PwgPHE
	5InSa9USg1x3WYlMxGMHifHfHdBeUICSOE22t1SeOe5XecpPlkGvlGsv9AT4fsYZ
	KwecSgjGfHLrSkxhvfyR1qq+Xq/HbojToWtKgE0EpHNxjWabggBDXFgileMim6Jr
	5WRe1vf2Hr/KNsNqcMAwVcsmSonRapVUOIudn6hp0zZT8mJUJZ/mndeBkeKofraa
	llD//PVOxbAiVq9ZwhAahSPb8as/ZH4Ql9j/4A7pglHNzsziTpgjNRk/doIrXBkX
	wbzDTGEPsLqq65P269Z8+sNfv3qLSCLgDFO9V1Z2plQEubLk1a2+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b61e1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE63F52220896;
	Fri, 23 Oct 2026 17:44:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHi4hR50725228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC2975805A;
	Fri, 23 Oct 2026 17:44:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51FAC58054;
	Fri, 23 Oct 2026 17:44:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:02 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Fri, 23 Oct 2026 13:43:41 -0400
Message-ID: <20261023174349.3545941-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb9ce6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CHY_6u8Tj3hgPJJQ2rQA:9
X-Proofpoint-ORIG-GUID: 8FhmOQ74v_Yea0ozEERyLJ-yWQ28HPjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX4zmVQSqwtOSq
 wN6E0/FFZ1Ndunxwb7OaF01fwXh4D3ev/YQqxqOpaqsAnQAyI6oew+3ncGxjn1wioahvprbuiqx
 b54ODQ4hfRWUNs7gJDufBivugcxxOGQyraqHNXkr3WDOCHb4Md78wtjKee+YiaAkTOASs5mBkSB
 j0cH+uVqh4o187jjlUGHiEVAjEWzY/CVAuFsjd8433FqPYdBIBGNmi0rR5m2PKAwPxsiLNM4azq
 sj0t+QLtYECCszzDOyG5qB6YsgIXwrRQPLiPMHe0s6FT01Z5htwk1igbRCJL8N5DNft32fqwBmf
 k63V9BMBZUoETB/MSenpKBL+1M4Kc+yr7+mKl7GfXNIXdEf+zYrgVnYvHhgVl5WGpWh9AjFYsUP
 WjFxnYTsrSa8MySbEnowoEyJjf7ivAZAziIJsciLaTw6A+vZGue9+RnkQH/0MRRQt2vmyi+v379
 OO9md5ocPHdwqGesH6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfXwb8LQl6O9J5Z
 mdPyaSPf1RJl+Zwn9RY9THz9oZfoVhqwcfJjLi/zRXLD7ZQdQAv2oEuIOSpaGJQDBPfmCnxLE3Z
 zZat0mQ32FnhtoTuSaWdlE/wOU18ryA=
X-Proofpoint-GUID: 8FhmOQ74v_Yea0ozEERyLJ-yWQ28HPjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069

Implements the read callback function that was added to the
file_operations structure for the file created to save the state of the
vfio-ap device when the migration state transitioned from STOP to
to the STOP_COPY state.

This function copies the guest's AP configuration information to
userspace. The information copied is comprised of the APQN of each queue
device passed through to the guest along with its hardware information.
This state data will be transferred to the vfio_ap device driver on the
destination host when the state is transitioned to RESUMING.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 272 +++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index bc216c51a1a7..f9b00fb89410 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -6,6 +6,7 @@
  */
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
+#include <linux/slab.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -140,14 +141,6 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
-static ssize_t
-vfio_ap_stop_copy_read(struct file *filp, char __user *buf, size_t len,
-		       loff_t *pos)
-{
-	/* TODO */
-	return -EOPNOTSUPP;
-}
-
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -162,6 +155,269 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return 0;
 }
 
+/**
+ * validate_stop_copy_read_parms: Validate the input parameters to the
+ *                                vfio_ap_stop_copy_read function
+ *
+ * @filp: Pointer to the file stream used to read the vfio-ap device state
+ * @len:  The length of the data to be read
+ *
+ * Verify the following:
+ * - @filp private data is an ap_matrix_mdev instance
+ * - @filp is the instance opened when state transitioned from STOP to STOP_COPY
+ * - @filp->f_pos + @len does not cause integer overflow
+ *
+ * Returns: 0 if the parameters pass validation; otherwise returns an error
+ */
+static int validate_stop_copy_read_parms(struct file *filp, size_t len)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t total_len;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
+		return -EIO;
+
+	/*
+	 * matrix_mdev is guaranteed live here: vfio_ap_open_file_stream() took
+	 * a vfio_device registration reference that is held until
+	 * vfio_ap_release_mig_file() runs, so the embedding matrix_mdev cannot
+	 * be freed while this file descriptor is open.
+	 */
+	matrix_mdev = filp->private_data;
+
+	if (!matrix_mdev->mig_data)
+		return -ENODEV;
+
+	mig_data = matrix_mdev->mig_data;
+
+	if (mig_data->stop_copy_mig_file.filp != filp)
+		return -EINVAL;
+
+	return 0;
+}
+
+static size_t vfio_ap_config_size(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned int *num_queues)
+{
+	size_t qinfo_size;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	*num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_size = *num_queues * sizeof(struct vfio_ap_queue_info);
+
+	return qinfo_size + sizeof(struct vfio_ap_config);
+}
+
+static int get_hardware_info_for_queue(const char *mdev_name,
+				       struct ap_tapq_hwinfo *hwinfo,
+				       unsigned long apqn)
+{
+	struct ap_queue_status status;
+
+	status = ap_test_queue(apqn, 1, hwinfo);
+
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_BUSY:
+		/* For all these RCs the tapq info should be available */
+		break;
+	default:
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+				   status.response_code);
+		return -EIO;
+	}
+
+	/* There should be at least one of the mode bits set */
+	if (!hwinfo->value) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Empty hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+				   status.response_code);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * vfio_ap_store_queue_info:
+ *
+ * Stores the hardware information returned from the PQAP(TAPQ) command for each
+ * queue device identified in the 'qinfo' field of the a vfio_ap_config
+ * object. The APQNs in the 'qinfo' field must already have been snapshotted
+ * prior to calling this function.
+ *
+ * @mdev_name:	The name (UUID) of the mediated device to use in log messages
+ * @ap_config:	A reference to the vfio_ap_config instance in which to store
+ *		the queue information. It is expected that each APQN identifying
+ *		a queue device for which hardware information is to be retrieved
+ *		shall be snapshotted prior to calling this function.
+ *
+ * Returns:	Zero (0) if the hardware information is retrieved for each queue
+ *		device in the AP configuration; otherwise, returns an error.
+ */
+static int vfio_ap_store_queue_info(const char *mdev_name,
+				    struct vfio_ap_config *ap_config)
+{
+	struct ap_tapq_hwinfo source_hwinfo;
+	unsigned long num_queues;
+	int ret;
+
+	for (num_queues = 0; num_queues < ap_config->num_queues; num_queues++) {
+		ret = get_hardware_info_for_queue(mdev_name, &source_hwinfo,
+						  ap_config->qinfo[num_queues].apqn);
+		if (ret)
+			return ret;
+
+		ap_config->qinfo[num_queues].data = source_hwinfo.value;
+	}
+
+	return 0;
+}
+
+static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_config *ap_configuration;
+	unsigned long *apm, *aqm, apid, apqi;
+	unsigned int num_queues;
+	const char *mdev_name;
+	size_t ap_config_size;
+	int ret, qindex;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
+
+	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
+	if (!ap_configuration)
+		return -ENOMEM;
+
+	ap_configuration->magic   = VFIO_AP_MIG_MAGIC;
+	ap_configuration->version = VFIO_AP_MIG_VERSION;
+
+	/*
+	 * num_queues must be set before writing qinfo[] elements; the
+	 * __counted_by(num_queues) annotation on qinfo[] causes the compiler to
+	 * insert bounds checks that evaluate against ap_configuration->num_queues.
+	 * Writing through qinfo[i] with num_queues still 0 would trap.
+	 */
+	ap_configuration->num_queues = num_queues;
+
+	apm = matrix_mdev->shadow_apcb.apm;
+	aqm = matrix_mdev->shadow_apcb.aqm;
+	qindex = 0;
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			ap_configuration->qinfo[qindex].apqn =
+				AP_MKQID(apid, apqi);
+			qindex += 1;
+		}
+	}
+	memcpy(ap_configuration->adm, matrix_mdev->shadow_apcb.adm,
+	       sizeof(ap_configuration->adm));
+	mdev_name = dev_name(matrix_mdev->vdev.dev);
+
+	ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
+	if (ret) {
+		kvfree(ap_configuration);
+		return ret;
+	}
+
+	matrix_mdev->mig_data->stop_copy_mig_file.ap_config = ap_configuration;
+	matrix_mdev->mig_data->stop_copy_mig_file.config_sz = ap_config_size;
+
+	return 0;
+}
+
+static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
+				      size_t len, loff_t *pos)
+{
+	struct vfio_ap_migration_file *mig_file;
+	struct ap_matrix_mdev *matrix_mdev;
+	void *bounce;
+	ssize_t ret;
+
+	/*
+	 * This file was opened with stream_open(), so pos should be NULL for
+	 * sequential read() calls; a non-NULL pointer will be passed only
+	 * for positional pread() calls in which case we return an error
+	 * indicating broken pipe/illegal seek on a non-seekable file
+	 */
+	if (pos)
+		return -ESPIPE;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	pos = &filp->f_pos;
+
+	ret = validate_stop_copy_read_parms(filp, len);
+	if (ret) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
+
+	matrix_mdev = filp->private_data;
+	mig_file = &matrix_mdev->mig_data->stop_copy_mig_file;
+
+	/*
+	 * The data to be returned to the caller - i.e., the source guest's
+	 * AP configuration data - is generated on the first read() call. The
+	 * result is cached in mig_file->ap_config for subsequent read() calls.
+	 */
+	if (!mig_file->ap_config) {
+		ret = vfio_ap_get_config(matrix_mdev);
+		if (ret) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+	}
+
+	/* Return EOF if all of the AP configuration data has been read */
+	if (*pos >= mig_file->config_sz) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	/*
+	 * Don't read past the end of the AP configuration data. Limit len to
+	 * the number of bytes remaining.
+	 */
+	len = min_t(size_t, mig_file->config_sz - *pos, len);
+	if (len == 0) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	/*
+	 * Copy into a bounce buffer under mdevs_lock and advance *pos, then
+	 * perform copy_to_user() outside the lock. This avoids stalling
+	 * all host mdev operations if userspace passes a buffer that faults.
+	 */
+	bounce = kmalloc(len, GFP_KERNEL);
+	if (!bounce) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return -ENOMEM;
+	}
+
+	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
+	*pos += len;
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_to_user(buf, bounce, len)) {
+		kfree(bounce);
+		return -EFAULT;
+	}
+
+	kfree(bounce);
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

