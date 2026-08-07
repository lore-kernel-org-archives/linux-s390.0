Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05351477292;
	Fri,  7 Aug 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141138; cv=none; b=lRdjQ/+M8sNU68aENXM86kP20YDSeVZWTxFK/lZKgwRB7COMAKpbn2qxdB90Q2yqCECb3qiYtlen1s4VYYQMC3dBP69G/gHH4KGXJnUy5cGuSwG55Eg6QSHs+4LkhzoukLYu9g1AQI9jB+ao04G3TY0DAnqC7kNHNDVeVRoQcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141138; c=relaxed/simple;
	bh=DETwYA/fsCR6HP66TuVDV8nGY0drcaItry6nbQp/XDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0bommOvOz4JC1YStJQxW/hJ2a2MuCBO4WBcqubWdXekRSKRmDKwvlJ+dybnksV4gRKJnNt9+Ssi1n1UTFxGUTP9TNQLyGN+qTXjJt28vbHDmv/aQjYfFmht/FLSjuZMps0DQnL4p8/FIRYEonjedUpcxgYNPI/GHuS0oPcPLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ji06xb1K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ji06xb1K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lm5ii2720893;
	Fri, 7 Aug 2026 22:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/5wt7dOXojoVzOAnl
	+PRBjGXT7nPRmCwx20cAwIt2Ow=; b=ji06xb1Kx8gMPwoIjI4MAcFAZIIJUpeDr
	nmLyHFiPcZZZiBe5qxfSpwZ0Ll6Q/qm6UN/fyf6sIpFbhd8wfKLMULcEidv5Wj/c
	uZ6vrBlV0NCFzSa/+u7Yi6Fxk0WOJhEzijxn+SoZxyaDlC69nm1Nvzx4FoMTlXIH
	6YM8Sf2wFH8zPLU7I/xe/Gii7Yl3BIErLQ8s3uyGn7j3R+NiF21OUYwWEYji/gB8
	8rC1jUlv/ZpL/sOQTikMe+LihAErd1tl7hcU/GlMwClTQM3e4kL2LZ+EKQTOwGof
	s8RpPBlMgVe9vjAF+5zu5Au/t3CbMrDHitdU/xVntVPIM5duT/nFA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00e0yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBMqs021695;
	Fri, 7 Aug 2026 22:18:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4khpym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIhVH27919030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8B8F58058;
	Fri,  7 Aug 2026 22:18:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2A258062;
	Fri,  7 Aug 2026 22:18:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Fri,  7 Aug 2026 18:18:26 -0400
Message-ID: <20260807221834.562851-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXyiain8t+iyqE
 KMiM6FVSRxzz7/UY1XLRalBl7wwR7OWT+ojBvubslh0Zj3t6lW6I3C8lEyjTTucZWhSQkcsTn/Q
 v2k5EBt/eWW2EUOqaiY38S8Jkgo86g0=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a7659c5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ZWre1ubLZxLeUn0Ve90A:9
X-Proofpoint-ORIG-GUID: F9LdEvOiuJT7RWIHpUygCgHoccdVGqUF
X-Proofpoint-GUID: F9LdEvOiuJT7RWIHpUygCgHoccdVGqUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXyXuZT4+hI8MM
 vJArhfy0OzsuB/jPBh1vmHwUVtwz0zsqsT0KI/xdH1Bfd7ifOLYv/fHz6dmh6z5jGyB8xE10OOc
 VnOeYcuRJgexj1Che8GQlY8TIIeOtcxtUWbY/44bBNrZ7T9DZV0t+41esMGnVj1+9j7nIAGMuEP
 4+441OfIOUpdOSyCUeAtRIfoRT3VdbJm+uoXpt5PHe17IA4nj6U9PeNQHkc1xlwQ7P0zMRF4oth
 EgICn9eUfb2seJtiHTbd4U4zp/Auqw/dQMRuai0ZsS9+XmcoLYaBGqH19xkCLGnXl8tv8kRATXS
 jJfNiva0cB46x3ZW3w79PVfknwOoB4pDn2wz++oTEdBCIanYL7aG1IHdhzRtOabGbBl9zOLUQdW
 JEfKe55rrEIiAgVzHmxFQPxifWue463oXF/I2iLijOXybmcM8+VAD/LGiNejWnO9o0viGPBT+BP
 7Lz/bXwpBnf6jJwtAOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

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
 drivers/s390/crypto/vfio_ap_migration.c | 287 +++++++++++++++++++++++-
 1 file changed, 277 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index de693b308925..50781b61f7f1 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -117,9 +117,10 @@ struct vfio_ap_config {
 static void
 vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 {
-	/* Stub to be implemented when the mig_data->stop_copy_mig_file.ap_config
-	 * object is allocated.
-	 */
+	kvfree(mig_data->stop_copy_mig_file.ap_config);
+	mig_data->stop_copy_mig_file.ap_config = NULL;
+	mig_data->stop_copy_mig_file.config_sz = 0;
+	mig_data->stop_copy_mig_file.filp = NULL;
 }
 
 static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
@@ -129,13 +130,6 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	 */
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
@@ -150,6 +144,279 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return 0;
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
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+				   status.response_code);
+		return -ENODEV;
+	default:
+		/*
+		 * Without a pending async error, the tapq info should be
+		 * available
+		 */
+		if (status.async)
+			return 0;
+
+		pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
+				   status.response_code);
+		return -EIO;
+	}
+}
+
+/**
+ * vfio_ap_store_queue_info:
+ *
+ * Stores the hardware information returned from the PQAP(TAPQ) command for each
+ * queue device identified in the 'qinfo' field of the a vfio_ap_config
+ * object. If there are a large number of queues for which hardware information
+ * must be retrieved, this function must be called without the mdevs_lock
+ * held. This should not be a problem since the APQNs in the 'qinfo' field
+ * should already have been snapshotted prior to calling this function.
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
+	const char *mdev_name;
+	size_t ap_config_size;
+	int ret, num_queues;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
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
+	/*
+	 * Unlock the mdevs_lock so other mdevs are not precluded from being
+	 * accessed while a potentially long running operation is performed.
+	 */
+	mutex_unlock(&matrix_dev->mdevs_lock);
+	ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
+	mutex_lock(&matrix_dev->mdevs_lock);
+	if (ret) {
+		kvfree(ap_configuration);
+		return ret;
+	}
+
+	if (!matrix_mdev->mig_data) {
+		kvfree(ap_configuration);
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
+	struct vfio_ap_migration_file *mig_file;
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t read_pos;
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
+	 * in vfio_ap_release_stop_copy_file() which requires mdevs_lock.
+	 * Since we already advanced *pos above, no other thread will compute an
+	 * overlapping region.
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

