Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABE4CC26A;
	Fri,  9 Oct 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546199; cv=none; b=jlpBtsaCvlikRoC4STA14H/MlWBR1WhXVk6ahYBCuZzHXTUzN9k+LL3xbbDk0cV3dWSaFg1psql1udHSGQFDWzVHpAQ5J7eYn6l7ZM3bG+qXj2xKWi/ygAPZxr2EctFTpHdMWFC8P+LxXZ4xvOmnjB0bXvQXWsQBL0dJXefW+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546199; c=relaxed/simple;
	bh=JC1CK88ePsM9OS+thuff0gsNgpF9PgRizobi4TNPs+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T73Az3YWZNWg7XCU5PPYfW4K/797MsWxzBDlR7JAA1TbL7adkP+xDsPeXHRvkH3m21/+vWZ4WmG/qV0HbDKzojuj01gKVe/0vmqHAJ6GpWaWuD1HsvqycP7JFK8atcTVDf6uWpfye1ur9C112YsY5KqCnlcEJDXtla7W9OCfyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LduWsnNh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LduWsnNh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZTg02007509;
	Fri, 9 Oct 2026 11:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t8L5yX5WuFLQN2SG/
	Jg8rDZt8k/Wc5W5GaluxLJrQeo=; b=LduWsnNhZPEZSjc0QBYeh7REkDRQa1U7v
	dLcyJ4+GplIgp7ytkqPBVmrejtHh3cusObbZIYBqQz/8Wf6KellRzgR/NYNLF46c
	4jJRIT4NFu2aDiEmoKz2fMlm/Gd92QLqAPQOaWupdahJSztXfsj0BzpW1yrAdM2U
	Y+ZqiR2Doxn7gTJpbQHAoKFIL39MTZK11N9WOQHayr5dmxTk8zgc7wUp4atTJtTX
	trab0Hq5Hgewx4THldC/CU0oVMF5lAzFqmd1FyBM3M63TLBSOKGHRFO2vMO8Xqyb
	JJMJt4DXG2fWtfrBtlXGWyokYL/QrgzprVTgqMAD3eZo6GpVE/1nA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwae76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I3sA621423;
	Fri, 9 Oct 2026 11:43:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bh0kS25756172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC4F258050;
	Fri,  9 Oct 2026 11:42:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4634B58054;
	Fri,  9 Oct 2026 11:42:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:42:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Fri,  9 Oct 2026 07:42:36 -0400
Message-ID: <20261009114244.1213173-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EOlP3LIVqXYBUi7tER4sGWRc8D3iaWOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX3n5QEt+vvzqi
 /m2Jwdq5Z6iPYzNlfmU+1uxD5Y/usz3KeZRlqmdtZp/l1IzBdPjPzwoAhpG4XrJ0J3lAkjDbuif
 UCvekTV+cpR53YnIKXR/8Pc1w+HHSLJVqUUwmEqrxqxk/AG/3KY7pcFMBkY2ofiy9BM7F8rOYYH
 nvVKrTp/k27KFJnp93ZlbWsNW/SNYzhygmIFa6i+7wZ3srTWOVkYUA+75kzi+IYLm+1WhgjZhTh
 QrSflbchZ2UNbVjIyLG1dbBv5J6bGWi7a5UkXmviXovMK7eYSTH7NC8eK3LtR0GrnxRWwsyIsY1
 TCDc/1JSsTiIfweO6pvVVl7huM5igEj8+IOtyJo8hzZDeA97McNCM0nuz5l7vHSBzT5YMo92tAQ
 LqMkTVXofGrTVVFyoozBryz4qYAox9eVNALCpCcaYw3S+SVddjny8eLnnvrWF1kDOydBoCTW5NJ
 5LJaX9sxqsfF+WzAAJQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8d346 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ZWre1ubLZxLeUn0Ve90A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX7sErzISp3Pc0
 Bt16/Q1/7EcdPExLxXf5x743pk0OsLPsd1COSns4w4T5lMRx1Ho8wLL19F7Y+AMMg0hDvyW+9H+
 O9NT+0URJmLJYCMLaD8c4eguJZD0aAI=
X-Proofpoint-ORIG-GUID: EOlP3LIVqXYBUi7tER4sGWRc8D3iaWOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

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
 drivers/s390/crypto/vfio_ap_migration.c | 284 +++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index bbd007c06a77..0c43f25e2d9b 100644
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
@@ -150,6 +144,276 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
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
+	 * Lazy initialization: the migration config is generated on the first
+	 * read() call. vfio_ap_open_file_stream() initializes ap_config to NULL
+	 * and config_sz to 0. On first read, we generate the config by
+	 * snapshotting the guest's APQNs from shadow_apcb and retrieving hardware
+	 * info via TAPQ for each queue. The result is cached in mig_file->ap_config
+	 * for subsequent read() calls. The config is freed when the migration FD
+	 * is released (vfio_ap_release_mig_file -> vfio_ap_release_stop_copy_file).
+	 */
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
+	 * Keep mdevs_lock held across copy_to_user() to prevent a concurrent
+	 * vfio_ap_reset_migration_state() from freeing ap_config while we are
+	 * reading it.  copy_to_user() may fault on a non-resident user page,
+	 * but that is legal for a sleeping mutex.  The data transferred is at
+	 * most a few KB for any realistic AP configuration, so holding the lock
+	 * here is acceptable.
+	 */
+	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len)) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return -EFAULT;
+	}
+
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

