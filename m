Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C0435AAE;
	Mon, 27 Jul 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173585; cv=none; b=Kljb4UE8jeZcmpP3UF3aELCl1RJJaYlm5/6rHkOgbMJQ120fbEzEMrvQwcUWi/9hqTZZiujD3RTLnvDjM0rwz8x/I+jJbkFnJfxzQMkMD92dqE9KicNyl2F9R7/38udB7ZgNS8yKvtdpU2orVXSwJZX599a+LP4Q1aZfT9MaUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173585; c=relaxed/simple;
	bh=HNvgzQWLflUF4sJLOGjEMazuEPM8NS8IaEAjFrJ66Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDAOsNMVzdLEuWtsNckoElbjvuaRm6vfbVZggP0rKEkxi2zgVQAvTWzZozHYJqS2MOBX1hNfiJFTZRd6sbh089FJ0fpL/LH/36xUUANv6wedHXM4S2Tw/H0YYr75dFsUwwIGjG3jPwXKMDj4joD78BybtlPRfSk5YEGzOf1Jgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oaCMOC1O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oaCMOC1O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmhQq2406401;
	Mon, 27 Jul 2026 17:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EXPVLBJkevH/LMQ9l
	b3B6bBpAJDeySXR8UzAZoDAN3w=; b=oaCMOC1OQsTxWqbKVPDyyMlNWwbBFJ2M2
	x8TsIye62FLQCLEzs1VcYFeyj7zm3WfuOVp0nr9Pfol5+3G5k4XzJEWWtTEaNj8M
	/ItBjOLbTGaH5GefTAplT8kjvTpHZ61y2d8m3dWKpSrWsl4mHIpzJTAW8hIF6ukv
	7idpyjVXTQCHAipzZcyd9dLDfopAV0Vh45qRBvSpKHwlcWqgKxuBFU/mLk5Z7phZ
	3uhZlFdI/6OaCSTcV/9/l/00A8mUNZZ7p6o3j3gJ6kKFCtn93zla7TYjpRIGpl6T
	JK5nC1WETvYWDma2rb6B3nt79Kgfq+5ZuKVhE2jN107VsIjX8boqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xha7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQMDo031860;
	Mon, 27 Jul 2026 17:32:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg651k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWtCG15270430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121DD58059;
	Mon, 27 Jul 2026 17:32:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62EBF5805E;
	Mon, 27 Jul 2026 17:32:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Mon, 27 Jul 2026 13:32:31 -0400
Message-ID: <20260727173239.2420754-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wg09KssFBg207ebNS_xtUYRt9DnuWOCz
X-Proofpoint-ORIG-GUID: Wg09KssFBg207ebNS_xtUYRt9DnuWOCz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXzhkfrWCTZggp
 jpaLyri5YR0junTacqIgmj0Lg1jjckW6k4UC+C4qxmbxU8P0e6ENPRkzyr5pZcAr630111wcEOe
 /qNdoSCUGTUsp+MT3s2NVUOGzWSvDWs=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a679649 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=BK3xoX9RFYtmYAf9xMEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX3TnxoQljW+D3
 /G4zsnO95FC7CN4fIdYNXiQEEDBQ/ezVcFrN3A1B9OUzlc9kcQMaBqWQAew2svfFx4mhHTkfX/g
 ouw460ZZJ35hPFvCNduwMgSW7I94DDVc34cwmqEMbZtRp8hla4fsQhKGAw/g/MMKB9nzvRwBThM
 fZNnlb1i6hDyBzGM88jQB50c02Cv80+8YhggdLsHKwm2Y78PyDHS328v8dBZGvtHmoMjbOx6J0K
 wM6CRbNH0F7i63xq+mXUaq2or+WDwRYabC+lbFRWUukFuHJOpBmUR6dHeMzNQ4049h1rQe9l5nj
 5RppShla8eZLV1ikgTT5WHuensLXMTXFaj1CqgOCwt9aMN4r+hamVWD9drMTxr3xqYUjyrBu7Ul
 pDuKMsi7XLJKzKcEOCbmNILMVe5PYFQTn+Q3/6veWwv+sJAAkQYUAQzWLuX1QPYdnZ0+ENZvM75
 CuGW8dcyD5wQoww3yBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

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
 drivers/s390/crypto/vfio_ap_migration.c | 255 +++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 2b736bab7729..e4bc67b1eb84 100644
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
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -115,6 +108,254 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
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
+static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
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
+	 * num_queues must be set before writing qinfo[] elements; the
+	 * __counted_by(num_queues) annotation on qinfo[] causes the compiler to
+	 * insert bounds checks that evaluate against ap_configuration->num_queues.
+	 * Writing through qinfo[i] with num_queues still 0 would trap.
+	 */
+	ap_configuration->num_queues = num_queues;
+
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
+	memcpy(ap_configuration->adm, matrix_mdev->shadow_apcb.adm,
+	       sizeof(ap_configuration->adm));
+	mdev_name = dev_name(matrix_mdev->vdev.dev);
+
+	ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
+	if (ret) {
+		kfree(ap_configuration);
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
+	loff_t read_pos;
+	ssize_t ret;
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
+	mig_file = &matrix_mdev->mig_data->stop_copy_mig_file;
+
+	if (!mig_file->ap_config) {
+		ret = vfio_ap_get_config(matrix_mdev);
+		if (ret) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+	}
+
+	/*
+	 * Compute the offset and clamped length fully under the lock so that
+	 * concurrent read()s on this stream file each see a consistent view of
+	 * the current position.  *pos is advanced here while we still hold the
+	 * lock; copy_to_user() then uses the snapshot read_pos.  This prevents
+	 * two threads from calculating the same offset and both copying the
+	 * same region (or one reading past the end of the buffer).
+	 */
+	if (*pos >= mig_file->config_sz) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	len = min_t(size_t, mig_file->config_sz - *pos, len);
+	if (len == 0) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	read_pos = *pos;
+	*pos += len;
+
+	/*
+	 * Drop the lock only for the copy_to_user().  The ap_config buffer is
+	 * stable: it is allocated once in vfio_ap_get_config() and freed only
+	 * in vfio_ap_release_mig_files() / vfio_ap_release_stop_copy_file(),
+	 * both of which require mdevs_lock.  Since we already advanced *pos
+	 * above, no other thread will compute an overlapping region.
+	 */
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
+		return -EFAULT;
+
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

