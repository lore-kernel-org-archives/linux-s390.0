Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7339733E;
	Tue,  7 Jul 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414965; cv=none; b=atY5kc96xqYnED2wHLIvchn0LMW7x7dprgEiNAMOVAnDJQfW5TITBeVdGj2WlYX9zskvtJ2kq7BufkyMvLu5I0HAiRFjf/mw3ztpuark1x+kiAqq4MzUTZBWWFob6L4uzfZhwlEoQIdBMC9Rwxwibbmsejuts2nibbizc4RXKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414965; c=relaxed/simple;
	bh=L6ewYYYdIUOwiuGs2CUnGCUMwDYSDYcO61cgu0YzYv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/fARb4WHc8tmu/IbsANn8/exAgK0FUS2PvlCdxiqFmMP0mcBXHR/0zDS//QFTGZO+WQSJRNPYdT3GgC9Ni2t6s4aA/ycwLIKq40D5HJxjP8zQuIgqRHm7Fg45mhbQLf3lGCvWktHmi5sNV9TGG7YH/8lcvs7b7SwojxbPQQJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dJ9NH18/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dJ9NH18/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IQkX2252951;
	Tue, 7 Jul 2026 09:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HqPKVOwswm7bRfi4f
	HTChHkvQ5alY5VxVXGK4viJJj4=; b=dJ9NH18/09qezGLMXjsANHTwvK62T1TNO
	7lRH/oYttRcNe+IcIHIFzFU1w7GEneo4c5cj4SWCOui58+msrvMysoPqnF1Xe18w
	i0MntzLzBffdaAgmfc0SjEasXm1Q+LqbSVYb9QpJH7KhDzuOwDfI9jT0kP8Fva7S
	dS2hlWP3HLM4FObMwHDBH5jQECpkFAnP2AfnenPlV9QEvAUyGiCF8SwQrRQBi729
	zecPPOfKlSY9KBwDJtn2ZuEMSXp7IofivMsbNxHo2djyfeoLwVsFF0ba0RY6n0p/
	Kum/MCLPsz3iQf64j0H/RRnyIHGe9r8wyNIScXmiGDwYfAh6QcVRw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stspmk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZ58028760;
	Tue, 7 Jul 2026 09:02:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq24xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792bq330736964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1667B5803F;
	Tue,  7 Jul 2026 09:02:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D647358056;
	Tue,  7 Jul 2026 09:02:35 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:35 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 07/15] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Tue,  7 Jul 2026 05:02:09 -0400
Message-ID: <20260707090226.3206695-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vqvvolC-y5WAYWzaauCRykdFkF3Cb44z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX//D0d8ZiM/zB
 vC+OqWjV5QwurAuB3CiAbjeQtKKnbaqNP9AIO7dQcwpSQygz5ed4u7xk0fy/0psdBiKOra97Jp+
 wPEnKXRKBTczeqd3IGXZhdwSynAZlLk=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4cc0ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=PIKS6xDsdQn-MxsHYgQA:9
X-Proofpoint-GUID: vqvvolC-y5WAYWzaauCRykdFkF3Cb44z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfXx117ZyVSkHQi
 PClxoreORaFM1BzXnmCxwYCGbYWuIemeIcZYQmKVQltCK5SqKFNbxsv3QwW7D+0YSV/rsbFrOKr
 Z3mP8DzuESTsebQgI1TTJxM8jrBcXsZFpMmrGwwP0l3hwzIckRYihQ1qkTyJ6tzoqH6xBUbowXI
 Qq82Y35dlE0z7HCj9w1Zf9VkxdFZwxlXIup+UUprQdyKRtUgsdGkXeJV9VC45xT98+TC3sH6kf2
 4lKn4OBE0GoqRlY2zXR24aqH8PTl7VB8utGV8FOkrCGVaedfANbrn4XtY0cgYXJDxuzofATTVVF
 1h4QFRq59+JbbfGJBKjZhKD6Zb0oYQJntvg7PEU5wAs8sjr+zrszfQ/ZdXOc8ae52RaZkU0kaxP
 7fHgJMP4+mMX/OqG9sEGynFgrrUli4x7w9X2xqaPNsxZDulaIGvqqHJ7nrFR+dLnl+QZ0o4gRe4
 m+0fKMRgDz+94NfGoNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070084

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
 drivers/s390/crypto/vfio_ap_migration.c | 216 +++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 76e06abe5a9e..5ef7127b697a 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -65,13 +65,6 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 		mig_data->stop_copy_mig_file = NULL;
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
@@ -87,6 +80,215 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
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
+	matrix_mdev = filp->private_data;
+
+	if (!matrix_mdev || !matrix_mdev->mig_data)
+		return -ENODEV;
+
+	mig_data = matrix_mdev->mig_data;
+
+	if (mig_data->stop_copy_mig_file != filp)
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
+static int get_hardware_info_for_queue(struct ap_matrix_mdev *matrix_mdev,
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
+		dev_err(matrix_mdev->vdev.dev,
+			"migration failed: Failed to get hwinfo for queue %02lx.%04lx on target host: TAPQ rc=%d",
+			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+		return -ENODEV;
+	default:
+		/* On a pending async error the tapq info should be available */
+		if (!status.async)
+			return 0;
+
+		dev_err(matrix_mdev->vdev.dev,
+			"Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+		return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_ap_store_queue_info(struct ap_matrix_mdev *matrix_mdev,
+				    struct vfio_ap_config *ap_config)
+{
+	unsigned long *apm, *aqm, num_queues, apid, apqi, apqn;
+	struct ap_tapq_hwinfo source_hwinfo;
+	int ret;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	apm = matrix_mdev->shadow_apcb.apm;
+	aqm = matrix_mdev->shadow_apcb.aqm;
+	num_queues = 0;
+
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			apqn = AP_MKQID(apid, apqi);
+
+			ret = get_hardware_info_for_queue(matrix_mdev,
+							  &source_hwinfo, apqn);
+			if (ret)
+				return ret;
+
+			ap_config->qinfo[num_queues].apqn = apqn;
+			ap_config->qinfo[num_queues].data = source_hwinfo.value;
+			num_queues += 1;
+		}
+	}
+
+	return (num_queues != ap_config->num_queues) ? -EINVAL : 0;
+}
+
+static int
+vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev,
+		   struct vfio_ap_config **ap_config, size_t *ap_config_size)
+{
+	struct vfio_ap_config *ap_configuration;
+	int num_queues, ret;
+
+	*ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
+
+	ap_configuration = kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
+	if (!ap_configuration)
+		return -ENOMEM;
+
+	ap_configuration->num_queues = num_queues;
+
+	ret = vfio_ap_store_queue_info(matrix_mdev, ap_configuration);
+	if (ret) {
+		kfree(ap_configuration);
+		return ret;
+	}
+
+	*ap_config = ap_configuration;
+
+	return 0;
+}
+
+static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
+				      size_t len, loff_t *pos)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	size_t ret = 0, ap_config_size;
+	struct vfio_ap_config *ap_config;
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
+
+	ret = vfio_ap_get_config(matrix_mdev, &ap_config, &ap_config_size);
+	if (ret) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
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
+		kfree(ap_config);
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return 0;
+	}
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
+		kfree(ap_config);
+		return -EFAULT;
+	}
+
+	kfree(ap_config);
+	*pos += len;
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

