Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A25328DB;
	Tue, 13 Oct 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905565; cv=none; b=cKn1cUdAED+8td98VGpAJ6WPFRKXNfay3D2JmP5G+yGOUBCYRqIZVZFgAuURLe6vNH5hhSez9O9VGsM5uSXlEr7DMhxUTf0sYhEOWGD7f5Y6vmvhBIz93j7FIIV/u9jkDDd8RwOTkQYZhB9YCfbITU2x5RTQThb0Fai5/Sw0rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905565; c=relaxed/simple;
	bh=1p/B8HdF+1OdYM5wo+ITb1BeWtYWlgmX8Qhv8m7e9Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks27MpxJCeEF7Ki37ZVWrwMUiOEY8RS64nUf0WaseAi4/Sv9jQfEoNYnI9AasFZ4HPvXcarjYHynJeZQvhkmZmZ7dff0AW4hUT5OtgVGikGwKDRej3ws9XoBkogbfsHi7kWEZlX/AaiPbTUJICzhoxbBlhqz8KX+dL/0TBO/ZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHxAo6oU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHxAo6oU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDlWnk2015675;
	Tue, 13 Oct 2026 15:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TbuItcCC25Ua4d4hR
	PenTj0vT50PIp1a4aJB/ZOzatA=; b=LHxAo6oU5tJckutLak2wpw7g5ecKQaHsa
	Sq4iJ77LVI42GuXltNurmkFL/P1QyNIEiBSST3wdRBSTB4D309WYdHTQ/UybkhRv
	8dXBMsNAtRyswJ0KJLfjvoKvsxPPiN6D2LxOLkiT9Q7RdoR0ex3v1eMoc/ZkdpGL
	cOlyrfil6VDIaEU6t9n+jS3TvyRhSBKfmkbB4eA/ghZeiuKoaLdSVH7OMA6aaCA1
	OGGGzcMtFwFntNCPl/RyLCQwJf68EdXiXM/v0Rq5PUbdbXaHFpRG88eGcWNCUnBd
	dxwOApoggjY+kBBlXBh68JM3YH6lPyOtHEpOX6cQ90PAyC6/1EOlg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugf2ng-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCUbpl2667561;
	Tue, 13 Oct 2026 15:32:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vtrp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWYjk30016184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C693158063;
	Tue, 13 Oct 2026 15:32:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C035804B;
	Tue, 13 Oct 2026 15:32:33 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:32 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Tue, 13 Oct 2026 11:32:11 -0400
Message-ID: <20261013153219.3534306-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace4f15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZWre1ubLZxLeUn0Ve90A:9
X-Proofpoint-GUID: AN-dN6Da1a1Kf9UhX81-XtFXuuni_zkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX4LjfFCyZisKY
 xG3ZaQkrF5lZzl5yz1vcWlYnx6xvZSNpw/Adc+5dhHWat7HgrgSIxwAI6qLloZVH+WIudPCNidu
 ugGLitSQH2jCQSV2QW8AoxA69fh1A2ZJJaTOYleMZQn5jojghCQ77vQIQ0o1ZaSqcZGU6pJmnfJ
 WNdTwMlBuDQ+qE2jThq7v7pIJ6hIvlVdguTKRKO73oD8/QD7UHw0LBRYoT+tegSyPpWGn6X16z0
 6SH5gGRMC1Zf1z1LJcJDSKN4wckQ6KoBjM2TjebQjJic/YN39ugLTWSXCxYFqgiY0G+PMmaC56X
 F0JtIfFMrfbK3Z5QV3MT2caDAp5cZ4YfOrs200AiNYTq5c3WlO56M0hRNsBPFtSOIOmPnC1Hr3E
 xot7YTszEpxWcj9ciZLMfkfK1FRIYAlHc87Sx+9UFJMKkhP0LPeaG9nfpiXCV08jFcb9O0XIO+N
 mGKTPep0zyWEY2hHOKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX4z6bCW+BBdzf
 WlNxw9lTsmSVQ2nS4vfiUwbXbwQyOJ3ev37c0nzFgoh+dscdi3NUP94Q8x4R59MhxDT68ryhtj4
 F8eJ9PCbs11sPc8tJU5sV5kXtmGmDW8=
X-Proofpoint-ORIG-GUID: AN-dN6Da1a1Kf9UhX81-XtFXuuni_zkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

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
 drivers/s390/crypto/vfio_ap_migration.c | 275 +++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index bbd007c06a77..cf3f95e2846c 100644
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
@@ -150,6 +144,267 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
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
+	 * the number of bytes remaining. The mdevs_lock mutex is held until
+	 * *pos is advanced below, so concurrent read()s on this stream file
+	 * each see a consistent position.
+	 */
+	len = min_t(size_t, mig_file->config_sz - *pos, len);
+	if (len == 0) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	/*
+	 * Keep mdevs_lock held across copy_to_user() to prevent a concurrent
+	 * vfio_ap_reset_migration_state() from freeing ap_config while we are
+	 * reading it.  copy_to_user() may fault on a non-resident user page,
+	 * but that is legal for a sleeping mutex.  The data transferred is at
+	 * most a few KB for any realistic AP configuration, so holding the lock
+	 * here is acceptable.
+	 */
+	if (copy_to_user(buf, (char *)mig_file->ap_config + *pos, len)) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return -EFAULT;
+	}
+
+	*pos += len;
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

