Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425006;
	b=KoPr7RiUqm3Lv4irvQfttwtytrSA/FRzsBkjD/4YaWDFHyp8fOp9yys957A4VXGYTgfa
	 EOqq+a1kL7lzkrNALQoCRgYx+1+64h1gdEe4eNerHLeQJrpk/5Rep/snOZ6Kkht+M7AQf
	 EIj0jsDsa9nSG1eDsVzsNJPEJI0rBK7dJBTeSL5lISmC4gLH12dA3pBNlnzGBo6ipVquE
	 nVJLcsoZmfTxj5FyxWd4VcAb/OQyx78We0FgleiPHbB0gd3+VBVyz9lz7h4kJGfOdRVa0
	 NZXaugbNtqH0ybkhZYEfytvl4+TwilTGvNhKgbAi0kmKYoc/O5/YanjnJ1QedsEEw7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425006;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N+lxRvpytyBHBhpKXKAGf9Yy69eLG20WBu+XV+JEl9A=;
	b=FagU6qzwXoyyCDU/lL3Wx3usQ4DDvss8qS5fev9sgT+o9KWTPGdu8Z/aoUw//nbcVvfa
	 2GxaaFiW682fDe57ahE5PRDaOI+HNenqPu5Vl/FhERlv/7ju2h2tPkrC+xGjByLpiIbYl
	 UYHKmKir020YNYZTsdMKlYdlyoVmFh+BMBHcno1zhQzzGaEJkeaz4LWdN4FfYmVU2HqR4
	 pZHCcagwaODLR2b4pH7UrGqcwYJsPwAii0fXwJx5taWc/dEWsv0gRV9H3Qe7+ZQyVA8mx
	 ch+OXRckGJpB+KEKnNg/GdAAgmzjogk97LpHdtzx3E81Lukwc7aZX3g8sI0FxY47Uyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Si2FhbWO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE460A261C;
	Wed, 11 Nov 2026 19:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EE460A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Si2FhbWO
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiPC1671900;
	Wed, 11 Nov 2026 19:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N+lxRvpytyBHBhpKX
	KAGf9Yy69eLG20WBu+XV+JEl9A=; b=Si2FhbWOGpvWjQd7hylKsMcZ9u2xHIqg/
	NpBzhntMhv18RUNbGrC4x0HE64wdQr7CfqW2MUs+HgjZ4cxb9KwFUlC7AInaN56M
	528pJZzW3hIOW4G2vZtvfChWSxq7/SMnWxj/KEfEVn7BGeyRHjuL/D7hK631+VkC
	RoDbJ3tm/QxDdiJCj36n4i51gXPV20BFz4BvWA2+Sx+zBTagBCQwVer8LOhyHTGh
	A1g9EWAm4GWdwRIRYvQxDuPPWUFkkOOXWQNF8L9ftnTToCWu/WqYTiSWx+4GE6Uo
	puA3EYvTChd4nS1QmkkgbTFpVq8X+auPBqHuaKDkcEUXnyXRTUR7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgb9p0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ44W3690417;
	Wed, 11 Nov 2026 19:23:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3325utk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNIYH9896610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B9B35805D;
	Wed, 11 Nov 2026 19:23:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 320E458056;
	Wed, 11 Nov 2026 19:23:17 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:17 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 07/14] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Wed, 11 Nov 2026 14:23:01 -0500
Message-ID: <20261111192308.2585984-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af4c0a8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4Z12YvErNgmQQiZL72QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX6v/Y1vrTFjuS
 Dwa7mSAbLoHCXKGABg/J12KEu6myy1wgAjL7mp+2iYAcQhiVw1VtDqh6q7tU5hLGRW048KbI9Ua
 m1VsF18as+404A145/kvcVnR//Gt5FYp2alV3HItEaShiW+0aIV/zUEcpxnqz5gC8FllTAeJ9DY
 3xlVEVmUG64tmpWxoDF8+iUb7GGKEJ0oUr2x/HzxaLfwYvnJdj9/16LgRkq5mfW6VJza/q+DkNV
 eR4ZyBWbo8Sr169M5UNlVsk9RE1eE37XU34pvZx7ylO39YPRc5CHKFw3uwzNlnBbxAGmXRBoVIQ
 Y98IOv/lSI6bzFI0Mx7xI4IiZUziJIN7MhUi/3A6hlhol6j4pxxwbEJaC6HQTLM6kjbgYx+9Fn+
 NcQtIT++VJwoVZNcKJ22qyGsgRt1gaYvFToyUb4LVzqxFUpc1TO1COFTy6rbUFXTMgBgUTm2IOX
 C3y5vWTwR8IF0s/zSiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX+RuxNYM09BoR
 IJdOuuNr/88xq6ghxTRZOEqNUqCP+0s5MCvtT4jcUnWpbq08yNBDa9g0Voa3hvpPfSWVyoJBuxj
 AQ1GyxY0eAkQWXbH690nEOO3m2Idp/Q=
X-Proofpoint-GUID: ajLBztC8RSDlt_K8RTAvbbOWXjBmHCfY
X-Proofpoint-ORIG-GUID: ajLBztC8RSDlt_K8RTAvbbOWXjBmHCfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

