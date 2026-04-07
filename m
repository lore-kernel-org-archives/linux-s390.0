Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74B37B033;
	Tue,  7 Apr 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595082; cv=none; b=ZneQuicpcnmjZGsuqem3RE1gNRTy1Zigru3Df+ss/DceUDNr25wBmygqOSz74N2vG5B1AkWYgqpuijBZL3crcyZx39uVx5uFvSmGPxXEf/D3x1obfpGqMDG3oyqg108VEYfJnDgCE898R7eTixmnAzeWR7eZOi7Z7MojrFLeQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595082; c=relaxed/simple;
	bh=MlLDcecdyaVD777q+6/UmR6s9QSKLmgDCGrrrAusv+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA2+9JP9YYQjy7Qe2eNiFwaiJJhL1SU+Shw0sJ/PfyZUL6CCSzKcJwHyf+obXdOKIxGcwYyLhU965/cW/0xkIlNruZVuSAVxSBh5TQLId801rBT51qr7i1J9Pbbvs08istscq5fIeAHwpT0BrQFNCsXvRPbrrqyTGCuE1l0oJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a4Z8u+fd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a4Z8u+fd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DsRMJ2328635;
	Tue, 7 Apr 2026 20:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oMG/4QgQQ26Ja+oGv
	F1RIQ95vnecFeyIJOcq7Zimdow=; b=a4Z8u+fdj0VSkY7AKo5VPReTFzU4GOhKm
	kwMAyBjNTa3JTGMViX+wOabQM3lCNG5ViEzWt28gZdlTE5CT5qX+DNBWZtbS49nr
	0O300dF3rhSeoGT5ZLqhd0sS9NJOnuihKhwyzkcdKZ7ZCpC780n51Nro2ot2Z1s2
	2OgTXC8wEkQzwK9PbHIa0ty215dqZeRcdhxa78W0vndA/0luyr+tjgttNwqeQQHs
	pWHdQ0LJT/duSbnbnxy4VQGjgLR2tQY6WKZxTVtzbkutLV+DwSZ5TItOq7+iWtLI
	lWRnSAD18KE+6DSaGn8w0LrLjYpmy8VEr550gLAPmlsLsJolJ9xog==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcnta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Ikh5n007887;
	Tue, 7 Apr 2026 20:51:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2ctyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpDBp63897982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 973BF5805C;
	Tue,  7 Apr 2026 20:51:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A10458058;
	Tue,  7 Apr 2026 20:51:12 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 06/16] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Tue,  7 Apr 2026 16:50:22 -0400
Message-ID: <20260407205100.331150-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX3VDsv+m+QmWx
 YpS4oqqZGXpDDs7ryHE9hzXeOojRFrMSSyEqUYlUAjE+BcYiB40LMvSZWlm8WLv2RCqbDKRND1a
 WasuHr7b9HHet4kKGPTfH3CO2q7wSAbp3mQMIfL/8kEDaTZhQkBB4hTQViIYurRPqOyLyNrxEUW
 I5vbyGMXKIAJx+O/4YqSOEy9RlbsaVwT4czlXGKe0m4lVW/aEYcRgldxbgOJGTQNt54yqot7Von
 GxyrvHoupi0s/osJ/4ij3q6fK2rEYK5Xe4Okm254WOwvmJdOWb+N3TlIo2R8qlWwoik1Xf21srW
 KRRsXBM9JJEKzjzadD4sGhQRj6pRYzwpe1zARQktlYoTMEK5sHpVQoO82wp/NM8D7/3eZbw5Rgb
 CKRR4i+QldiSgPvBN4PDY+3rtiRjjqhM3cAE4ge0TfdC6XEMb7xRq/GMl55ZxJInhWqFLYoSeBA
 6iLMvTwFXv9pum9dNoA==
X-Proofpoint-ORIG-GUID: AZ9krXXZZDj5eKVvkdFgKSOaEInjtSLh
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e43 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=M0PqInsX-VO7aBZjA1gA:9
X-Proofpoint-GUID: AZ9krXXZZDj5eKVvkdFgKSOaEInjtSLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
vfio device state. The vfio device state is comprised of the guest's
AP configuration which specifies the adapters, domains and control
domains to which the guest will be given access.

To begin the process of saving the vfio device state, the VFIO AP device
driver will:

1. Allocate an object in which to store the guest's AP configuration
   information comprised of the APQN and hardware information for each
   queue passed through to the source guest.

2. Opens a file stream that will be used to read the AP configuration
   stored with the object created in #1. The AP configuration will be read
   from this file stream when the guest is resumed on the target system to
   verify that the AP configuration of the source and target guests are
   compatible.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 166 +++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index a4daa05822fb..21734d3ed7b7 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "uapi/linux/vfio_ap.h"
 
@@ -97,12 +98,160 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
+static ssize_t vfio_ap_save_read(struct file *, char __user *, size_t, loff_t *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_migf(struct inode *, struct file *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations vfio_ap_save_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_save_read,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = vfio_ap_release_migf,
+};
+
+static struct vfio_ap_config
+*vfio_ap_allocate_config(struct ap_matrix_mdev *matrix_mdev, size_t *config_sz)
+{
+	struct vfio_ap_config *ap_config;
+	size_t qinfo_size;
+	int num_queues;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_size = num_queues * sizeof(struct vfio_ap_queue_info);
+	*config_sz = qinfo_size + sizeof(struct vfio_ap_config);
+	ap_config = kzalloc(*config_sz, GFP_KERNEL_ACCOUNT);
+
+	if (!ap_config)
+		return ERR_PTR(-ENOMEM);
+
+	ap_config->num_queues = num_queues;
+
+	return ap_config;
+}
+
+static void vfio_ap_store_queue_info(struct vfio_ap_migration_file *migf)
+{
+	unsigned long *apm, *aqm, num_queues, apid, apqi, apqn, data;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_queue *q;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	matrix_mdev = migf->matrix_mdev;
+	apm = matrix_mdev->shadow_apcb.apm;
+	aqm = matrix_mdev->shadow_apcb.aqm;
+	num_queues = 0;
+
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			apqn = AP_MKQID(apid, apqi);
+			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
+			if (!q)
+				continue;
+
+			migf->ap_config->qinfo[num_queues].apqn = apqn;
+			data = q->hwinfo.value;
+			migf->ap_config->qinfo[num_queues].data = data;
+			num_queues += 1;
+			dev_dbg(matrix_mdev->vdev.dev,
+				"%s (%d): qinfo: apqn=%04lx data=%016lx\n",
+				__func__, __LINE__, apqn, data);
+		}
+	}
+}
+
+static struct vfio_ap_migration_file
+*vfio_ap_allocate_migf(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_file *migf;
+	struct vfio_ap_config *ap_config;
+	size_t config_size;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	migf = kzalloc_obj(struct vfio_ap_migration_file, GFP_KERNEL_ACCOUNT);
+	if (!migf)
+		return ERR_PTR(-ENOMEM);
+
+	ap_config = vfio_ap_allocate_config(matrix_mdev, &config_size);
+	if (IS_ERR(ap_config)) {
+		kfree(migf);
+		return ERR_CAST(ap_config);
+	}
+
+	migf->ap_config = ap_config;
+	migf->config_sz = config_size;
+	migf->matrix_mdev = matrix_mdev;
+
+	return migf;
+}
+
+static void vfio_ap_deallocate_migf(struct vfio_ap_migration_file *migf)
+{
+	kfree(migf->ap_config);
+	kfree(migf);
+}
+
+static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *migf,
+					     const struct file_operations *fops,
+					     int flags)
+{
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	filp = anon_inode_getfile("vfio_ap_migf", fops, migf, flags);
+	if (IS_ERR(filp))
+		return ERR_CAST(filp);
+
+	stream_open(filp->f_inode, filp);
+
+	return filp;
+}
+
+static struct vfio_ap_migration_file *
+vfio_ap_save_mdev_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct vfio_ap_migration_file *migf;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+
+	migf = vfio_ap_allocate_migf(matrix_mdev);
+	if (IS_ERR(migf))
+		return ERR_CAST(migf);
+
+	filp = vfio_ap_open_file_stream(migf, &vfio_ap_save_fops, O_RDONLY);
+	if (IS_ERR(filp)) {
+		vfio_ap_deallocate_migf(migf);
+		return ERR_CAST(filp);
+	}
+
+	migf->filp = filp;
+	mig_data->saving_migf = migf;
+	vfio_ap_store_queue_info(mig_data->saving_migf);
+
+	return mig_data->saving_migf;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
 {
 	struct vfio_ap_migration_data *mig_data;
 	enum vfio_device_mig_state cur_state;
+	struct vfio_ap_migration_file *migf;
 
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 	mig_data = matrix_mdev->mig_data;
@@ -110,10 +259,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
 		new_state);
 
+	/*
+	 * Begins the process of saving the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read out the internal
+	 * state of the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		migf = vfio_ap_save_mdev_state(matrix_mdev);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+
+		if (migf) {
+			get_file(migf->filp);
+			return migf->filp;
+		}
+
+		return NULL;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.52.0

