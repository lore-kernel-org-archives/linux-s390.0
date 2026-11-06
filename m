Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978604;
	b=uKWPE2mIY/NuND6k7za9rlA6h0YQQ6RcKbRcpH+DJiP1pNf2juYev2sRVps86MFsIqeP
	 +e+AGGrgnZCy3UM2RuxuTpKu9gXIt+YWvuczNv9NkNt5FSxGjfbGbuN/MnMmRoDKBnqLk
	 5Gx4xPqm25g5qzhklNOwOwbuFUqj3cTVycyglKPtw37D9EPJAu5oFKahAwK5OXXiYOUbQ
	 P8blrRnnEER6h01NN9p4d0EU+JkAaXoqK180kFIPDfTcSUsnCGVJR/t6MqEMhkMG7O/XP
	 KrmlAvgYdf4wLW80yqQcZc478KV07bZ53Sfi1SRk1IQZB3IvrhpA1Png9QTho1+Q4ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978604;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N+lxRvpytyBHBhpKXKAGf9Yy69eLG20WBu+XV+JEl9A=;
	b=GYNYbNkQg9QxvQlqQ9xKqWMf9fZJYXPrjBBPGw8AN83uJZ1j7PMkdAnPbWddVOB+MGkT
	 1y+Q/8PZiK0PQP9RisQXwhurn5IC2NtjCHO64yU0M3UIFa2bLb1gpcV4Py9uJwJeNDIvF
	 Q+QSOWrytYZF5yDyh08m8kYpBrroiX8uAHSQKyt7jRUiBZ/BSAwVa+jkRBEqzpHnBQXg3
	 /NBdPIFAz8aAM8hhh3SQYYQAwmLE5LogTrvqULfPKrTzLXVnAMkuNgr40Z2zhdjHsDkBZ
	 8W4saRIug+Ay4F7QhTi8f392io6wS9rwrsyClOBb9QJvp0yebjYDWYaJeimmAjFeKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UiIAQNU4;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAF6082BC0;
	Fri,  6 Nov 2026 15:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCAF6082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UiIAQNU4
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEJhp1095102;
	Fri, 6 Nov 2026 15:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N+lxRvpytyBHBhpKX
	KAGf9Yy69eLG20WBu+XV+JEl9A=; b=UiIAQNU4nCTkJNtkCi0h0J7PH3Uis8ZvP
	AUKSMTINr/qXklcUIk/58/cvA4/VCxzadlkb/3iwuw/kYYWJU6skI/N+eDqnNc1s
	Kti/IK38cJX5Q9+sIH2bKI2BxllwDJUoqKJTzO8NUKoMQGhaRU3oJVuEQEYwXpVu
	caZOdRP3qAAv0zCiDWXulYV80B3CSUGPfQHBS2Z23YWqlCRDqa+xpza2qAOru1Mi
	vGp19MXxzSu4Ykp2UzqX2AWDIh9+zTKkKJbiARGXNu6hURgl12yeWQx9sqKr645+
	xHCZBC/gqbEuTAuXGz8jzPuDLOEBobj0yVtKlPImwZKaPytIVOMug==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raw78b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4ved3617218;
	Fri, 6 Nov 2026 15:23:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ua1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNF6F25821730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 498F85803F;
	Fri,  6 Nov 2026 15:23:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F93D5806A;
	Fri,  6 Nov 2026 15:23:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 07/14] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Fri,  6 Nov 2026 10:22:52 -0500
Message-ID: <20261106152259.1360651-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedf0e5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4Z12YvErNgmQQiZL72QA:9
X-Proofpoint-GUID: Xnmu20d2fWVwF_bwL0nCTMD7e1VCvnWT
X-Proofpoint-ORIG-GUID: Xnmu20d2fWVwF_bwL0nCTMD7e1VCvnWT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXw7abdXd0DeaY
 zXXrIro8jdne7cr1kDSAZ6dMUzLIkId8SYBqZ9sAyZNRCShCGxBfTjyDv6j/8O8U65+3qhhDqek
 1UlrQaV0Q8qd1ss+EP1lo95/ZCuDgeg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX/r4yzKQBQJzO
 rupXa9Ev1+2WITnngNARdoNmZ5TSUSqcbFK4hvNVVh1Ai3Nn4fOOhCqExWa30RGw2QLvy77Fbus
 bnZIQAWxZ6EqcBWhpnm3Ra/yJs+wNfVABrk3CGwl5Il4D8FhahNp+pZ6tqWjUiLwO20pi6uZPz3
 tBOORlQ2ntMZjejfOC33ACIC44qg4+O4/2S0rOYVxUzK53kfFOwq0D3KqVUA2dLjwsJT26aoosl
 KMyGcm0DLzrEXrcISELoXy6Ut9y/YWcVJaA/gJaBc8XrRb2VBNwlV4mLc27pfgQbknRLMnLxr7u
 k9yAKcB2tjuerKN8a5D67bYoTnHzCmJIVWEEwpf/daYLbgTLCmyySTFHKDaCazzzfZZL90HLGK8
 UY6ERQ7lZfCXbUAVxQEOmO0wJGwbGLQ7tl2dD0A+b84IsndTNijUyke8jgUp04ygwvfHFkM/rSZ
 sLCoH7/zGblR2t0/b9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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
index 3b5c60c1ece5..dc1d951a8479 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -6,6 +6,7 @@
  */
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
+#include <linux/slab.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -144,14 +145,6 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
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
 	struct vfio_ap_migration_file *mig_file = filp->private_data;
@@ -167,6 +160,269 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return 0;
 }
 
+/**
+ * validate_stop_copy_read_parms: Validate the input parameters to the
+ *                                vfio_ap_stop_copy_read function
+ *
+ * @mig_file:	Pointer to the object used for storing the vfio-ap device state
+ * @filp:	File stream to which to write source guest's AP configuration
+ * @len:	The length of the data to be read
+ *
+ * Verify the following:
+ * - @filp is the instance opened when state transitioned from STOP to STOP_COPY
+ * - @filp->f_pos + @len does not cause integer overflow
+ * - @mig_file->matrix_mdev is not NULL
+ * - @mig_file->matrix_mdev->mig_data is not NULL
+ *
+ * Returns: 0 if the parameters pass validation; otherwise returns an error
+ */
+static int validate_stop_copy_read_parms(struct vfio_ap_migration_file *mig_file,
+					 struct file *filp,
+					 size_t len)
+{
+	loff_t total_len;
+
+	lockdep_assert_held(&mig_file->lock);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (filp != mig_file->filp)
+		return -EINVAL;
+
+	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
+		return -EIO;
+
+	if (!mig_file->matrix_mdev || !mig_file->matrix_mdev->mig_data)
+		return -ENODEV;
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
+	/*
+	 * mig_file is guaranteed live here: vfio_ap_open_file_stream() took
+	 * a vfio_device registration reference that is held until
+	 * vfio_ap_release_mig_file() runs, so the embedding mig_file cannot
+	 * be freed while this file descriptor is open.
+	 */
+	mig_file = filp->private_data;
+	mutex_lock(&mig_file->lock);
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	ret = validate_stop_copy_read_parms(mig_file, filp, len);
+	if (ret) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		mutex_unlock(&mig_file->lock);
+		return ret;
+	}
+
+	pos = &filp->f_pos;
+
+	/*
+	 * The data to be returned to the caller - i.e., the source guest's
+	 * AP configuration data - is generated on the first read() call. The
+	 * result is cached in mig_file->ap_config for subsequent read() calls.
+	 */
+	if (!mig_file->ap_config) {
+		ret = vfio_ap_get_config(mig_file->matrix_mdev);
+		if (ret) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			mutex_unlock(&mig_file->lock);
+			return ret;
+		}
+	}
+
+	/* Return EOF if all of the AP configuration data has been read */
+	if (*pos >= mig_file->config_sz) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		mutex_unlock(&mig_file->lock);
+		return 0;
+	}
+
+	/*
+	 * Don't read past the end of the AP configuration data. Limit len to
+	 * the number of bytes remaining.
+	 */
+	len = min_t(size_t, mig_file->config_sz - *pos, len);
+
+	/*
+	 * Copy into a bounce buffer under mdevs_lock and advance *pos, then
+	 * perform copy_to_user() outside the lock. This avoids stalling
+	 * all host mdev operations if userspace passes a buffer that faults.
+	 */
+	bounce = kmalloc(len, GFP_KERNEL);
+	if (!bounce) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		mutex_unlock(&mig_file->lock);
+		return -ENOMEM;
+	}
+
+	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_to_user(buf, bounce, len)) {
+		kfree(bounce);
+		mutex_unlock(&mig_file->lock);
+		return -EFAULT;
+	}
+
+	*pos += len;
+	mutex_unlock(&mig_file->lock);
+	kfree(bounce);
+	return len;
+}
+
 static const struct file_operations vfio_ap_stop_copy_fops = {
 	.owner = THIS_MODULE,
 	.read = vfio_ap_stop_copy_read,
-- 
2.53.0

