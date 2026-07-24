Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7274457C8;
	Fri, 24 Jul 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911091; cv=none; b=oIw8lgBYW84Z2tf8cqObUuSCi015SFEHEBC/IbRuAruTyKp4xvQGTLY6dt4PSctWN1zUJt1brgpwkG9aUsVlUOklBnop2Aj0rr9VJo67QHM8bllcoSawZLYQQPBExVUq5n91Y7/A7FWrq1Z7kB9rsD1OMb6wHWZp7NS+I5xCC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911091; c=relaxed/simple;
	bh=TULad7R9slwNmvRdtguAk+p+AqxRE0QwPurttrZzOow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUwHi9q+73xjWjSJb4aJT4E4oJyv4IEMK8P7v4pXxfSVHDuj/TFlL2o46M/6nWmLD5TRjwM3p10ibmWqeXAf8NcwNfgN//X/eZiYwW3GCAjKK9tJX6xJKOHUH4qHYc25dYIO945erAiIu07lOzYFbblWWtxk8bXSsTJexpBKG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mzV/+Q47; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mzV/+Q47"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODff40100453;
	Fri, 24 Jul 2026 16:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GoLpGVR92LHFURtw1
	08mfduIBpm8QMxdF4xAURJWoqU=; b=mzV/+Q47aYu3uQSIwS+/MHQ6uSSi2URx8
	U2hO5D4/oKlwQajjx0DHLutv/IqYuNqAUtS5fK2bRS1PRAkx4ukpT59PoRQzP2ER
	Yty8PRtJ5Z7L9sDqMZHzTJC1XBHdGTdmULOrFZqaG9uYSsxoW3ik4jJFh09aXSOR
	EqBTryXjFX8cL0Xu3dq0OyUAnGyLsGMe/JNKAy19W6P+EHJ/jwX4ECk5lbX2LAT4
	bq5tvdq771sCaCVitrLCFT2JytQJwS7JgE0mfEm0whajuBcv9C9M5NLKnvHAXET1
	HKgEpMNKri1ENIAds/hGVrzVaJ+gTDPNBOgPlZBXmY4fwH4/V+fpQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8u5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4bQg028388;
	Fri, 24 Jul 2026 16:14:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk9n2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGE6Pv32768724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 286655804E;
	Fri, 24 Jul 2026 16:14:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 956245803F;
	Fri, 24 Jul 2026 16:14:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Fri, 24 Jul 2026 12:13:43 -0400
Message-ID: <20260724161351.1802644-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXyufsAFunsASw
 8gNj0MAC0FeIKci9xeK8fIIl/EGF3EZ0IptZiEagnhBSE8K6w3NWF3bap+FuTKFZX5QkUjYYJp0
 NNOb35Tq7bQRZ+uxtSD4Gv/MZuomRZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX2wbzz3ftkNeW
 VYV6J6R5dhNs44HrUWTXvl+pLQsRigZVqeq0TXikc5CTmvr1O/c6R2jt1wQtc5AJUbKaLA9+81k
 uPzwbdW8qqac6P4HwXmA7+Rbusr3VXXMZBdlsKHvsNduYvETi9uwhlMdHugzpaOhmmcx5acQCIF
 hdnFjP1gTR0KM19U/+7IyAZ0ggrUpDPpqZWF8+35yaqdIfJFLNdPWV2OCZmHzhnTiTcpfx2u1VZ
 thzrmAYxmAKCPK/4RMYIDwCcgZzCD3bdofVNL/L5aVw/O2BPKipDOnk+xch3YrrJBPjMDJfyu2b
 HxxZmstTK0+8tIqv38svH2gTDRbuIrBA3txuZ1SiYtk+DX/4jdzJutcjhywWPPrXX5hGPuWhgt3
 Po6uqzhYsvLZ95j/fP7n96rfAtHrovhnhvUT+jH7HSp32dlCrrorgWTFzb30DBbvvImICCVJvRO
 VPEouK8bKhnbOasogNA==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a638f50 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BK3xoX9RFYtmYAf9xMEA:9
X-Proofpoint-ORIG-GUID: W2FGDCto2-6TbH9HKhc7VOzjyegxvyRJ
X-Proofpoint-GUID: W2FGDCto2-6TbH9HKhc7VOzjyegxvyRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

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
 drivers/s390/crypto/vfio_ap_migration.c | 278 +++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index e566250a88ea..0d949ec205de 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -82,13 +82,6 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 	mig_data->stop_copy_mig_file.filp = NULL;
 }
 
-static ssize_t
-vfio_ap_stop_copy_read(struct file *, char __user *, size_t, loff_t *)
-{
-	/* TODO */
-	return -EOPNOTSUPP;
-}
-
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -112,6 +105,277 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return ret;
 }
 
+/**
+ * validate_stop_copy_read_parms: Validate the input parameters to the
+ *                                vfio_ap_stop_copy_read function
+ *
+ * @matrix_mdev: The object device containing the state to be read
+ * @filp: Pointer to the file stream used to read the vfio-ap device state
+ * @pos:  The file offset from which to start reading data
+ * @len:  The length of the data to be read
+ *
+ * Verify the following:
+ * - @filp private data is an ap_matrix_mdev instance
+ * - @filp is the instance opened when state transitioned from STOP to STOP_COPY
+ * - @pos + @len does not cause integer overflow
+ *
+ * Returns: 0 if the parameters pass validation; otherwise returns an error
+ */
+static int validate_stop_copy_read_parms(struct file *filp, loff_t *pos,
+					 size_t len)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t total_len;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (check_add_overflow((loff_t)len, *pos, &total_len))
+		return -EIO;
+
+	matrix_mdev = filp->private_data;
+
+	if (!matrix_mdev || !matrix_mdev->mig_data)
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
+				  int *num_queues)
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
+	status = ap_tapq(apqn, hwinfo);
+
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+	case AP_RESPONSE_BUSY:
+		/* For all these RCs the tapq info should be available */
+		return 0;
+	case AP_RESPONSE_Q_NOT_AVAIL:
+		pr_err("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+		       status.response_code);
+		return -ENODEV;
+	default:
+		/*
+		 * Without a pending async error, the tapq info should be
+		 * available
+		 */
+		if (status.async)
+			return 0;
+
+		pr_err("vfio_ap_mdev %s:Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+		       status.response_code);
+		return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_ap_store_queue_info(const char *mdev_name,
+				    struct vfio_ap_config *ap_config)
+{
+	struct ap_tapq_hwinfo source_hwinfo;
+	unsigned long num_queues;
+	int ret;
+
+	/*
+	 * ap_tapq() is a hardware instruction that may take time to complete.
+	 * It must be called without mdevs_lock held to avoid blocking other
+	 * mdevs. The apqn list was already snapshotted into ap_config->qinfo[]
+	 * by the caller under the lock.
+	 */
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
+static int
+vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long *apm, *aqm, apid, apqi, num_queues;
+	struct vfio_ap_config *ap_configuration;
+	const char *mdev_name;
+	size_t ap_config_size;
+	int ret;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
+
+	ap_configuration = kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
+	if (!ap_configuration)
+		return -ENOMEM;
+
+	/*
+	 * Snapshot the APQN list from shadow_apcb under the lock so that
+	 * ap_tapq() calls in vfio_ap_store_queue_info() can happen without it.
+	 */
+	apm = matrix_mdev->shadow_apcb.apm;
+	aqm = matrix_mdev->shadow_apcb.aqm;
+	num_queues = 0;
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			ap_configuration->qinfo[num_queues].apqn =
+				AP_MKQID(apid, apqi);
+			num_queues += 1;
+		}
+	}
+	ap_configuration->num_queues = num_queues;
+	memcpy(ap_configuration->adm, matrix_mdev->shadow_apcb.adm,
+	       sizeof(ap_configuration->adm));
+	mdev_name = dev_name(matrix_mdev->vdev.dev);
+
+	/**
+	 * Release the global mdevs_lock which guards access to all mdevs.
+	 * Storing the queue information could take a while if there are a
+	 * large number of queues.
+	 */
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
+	if (ret) {
+		kfree(ap_configuration);
+		mutex_lock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
+
+	/* Retake the mdevs lock so we can safely make updates to the mdev */
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	/*
+	 * Verify mig_data is still valid - mdevs_lock was dropped, so the
+	 * device could have been closed concurrently.
+	 */
+	if (!matrix_mdev->mig_data) {
+		kfree(ap_configuration);
+		return -ENODEV;
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
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_config *ap_config;
+	ssize_t ret = 0;
+	size_t ap_config_size;
+
+	/*
+	 * When userspace calls read() with an explicit offset (pread), pos is
+	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
+	 * normal read() calls, pos is NULL, so we'll use the file's internal
+	 * position filp->f_pos
+	 */
+	if (pos)
+		return -ESPIPE;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	pos = &filp->f_pos;
+
+	ret = validate_stop_copy_read_parms(filp, pos, len);
+	if (ret) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
+
+	matrix_mdev = filp->private_data;
+	if (!matrix_mdev->mig_data->stop_copy_mig_file.ap_config) {
+		ret = vfio_ap_get_config(matrix_mdev);
+		if (ret) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+	}
+
+	ap_config_size = matrix_mdev->mig_data->stop_copy_mig_file.config_sz;
+
+	/*
+	 * If the position exceeds the size of the AP configuration data,
+	 * then indicate EOF; otherwise calculate the length of the data to
+	 * read such that a buffer overrun is prevented.
+	 */
+	if (*pos >= ap_config_size)
+		len = 0;
+	else
+		len = min_t(size_t, ap_config_size - *pos, len);
+
+	/* If we've reached an EOF condition, let the caller know */
+	if (len == 0) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	/*
+	 * Allocate ap_config and copy the content of the object caching the
+	 * AP configuration data between calls to it so we can give up the
+	 * global mdevs_lock while copying the data to userspace.
+	 */
+	ap_config = kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
+	if (!ap_config) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return -ENOMEM;
+	}
+
+	memcpy(ap_config, matrix_mdev->mig_data->stop_copy_mig_file.ap_config,
+	       ap_config_size);
+
+	/*
+	 * Give up the global mdevs_lock while copying data to the user; it
+	 * might be a long running operation and we don't want to prevent access
+	 * to other mdevs for an inordinate amount of time.
+	 */
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
+		kfree(ap_config);
+		return -EFAULT;
+	}
+
+	kfree(ap_config);
+	*pos += len;
+
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

