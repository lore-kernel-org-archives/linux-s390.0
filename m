Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F24448BB2;
	Fri, 24 Jul 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909685; cv=none; b=V+9kKu86DW17AYiHUu2dbVGli+vUoe217NyX1qg3mryBFM17G58asd/SjIDpKj6EicdvjR9pcLfh83/34w0vz83tQdKpf9V55xJYX98Yqw6kNSvRfEWIspNwYON2ksG7qDZ+qEsTweG7gOQNQ/Oiv4rXjpmoYFgOaFToMD9V81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909685; c=relaxed/simple;
	bh=prBGKywt3nO+gLZxeQMk8BAqBKDxaGFtE4uAgURKlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2n7AMbzdcqbOTHKJWC0NXW/Efv2gQdMXVG1fFq/ktQ4E+gHXnUX7kJcJN9Mmgvki99/+0vreaP5jTU6Qc8r4eSvuNChxl8P/ZHkEYycp/vmdhbWA/LvVYsbaFUUYIZRVYRQCLHopktXDD/GFUsYkHhYqvhFAjZ3nmsWPGPSAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XA6G1JEA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XA6G1JEA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODftwR1993432;
	Fri, 24 Jul 2026 16:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8sTowYIP8NOuNegnI
	cX3MrPthDqBd+ZzSw77G+6519I=; b=XA6G1JEAoXX2OAKRfwL5VeNBSKF82pPfY
	u78AymZA2jJAAYzPwCtH4eWLnR/fFAfpr+RqZripywn542s9rXvvDGESnvoSwAZe
	HBtyqpVpTD6Vf8/MX8msma/Y9+l2prqM3HMWAgeetJulfgvk8cEWP90vm83ytPES
	KfqLthw+ukti8KRRavHcjSpZENNmt/jpf3V7dzql1mAmVvFiIkN945PO3tLAE5BN
	rdOODee5UGu8msC0dYWnJlXI+OOmg+FPa8h/0VDAO1eTYfXfioeRjVooUvpaZVxJ
	c0Sj4pi246WAaYSJjfsES7WoCjILc7B6oBkIYY1HCB26ks6wr+/SQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00tyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4bYD010711;
	Fri, 24 Jul 2026 16:14:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gsf7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGDx4D4784908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:13:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C00158056;
	Fri, 24 Jul 2026 16:13:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABFF25803F;
	Fri, 24 Jul 2026 16:13:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:13:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Fri, 24 Jul 2026 12:13:39 -0400
Message-ID: <20260724161351.1802644-4-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a638f4a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jy3f7vMduTvd68GZpnMA:9
X-Proofpoint-ORIG-GUID: cQYELzbJSLKR1A2jYfnA-Aqj4yo1-lxb
X-Proofpoint-GUID: cQYELzbJSLKR1A2jYfnA-Aqj4yo1-lxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXwhKb/mXVDkaq
 FSk5xS7zhUbHuLX9/xg7fnKky4JADhmIj7Akz+WMpuKHfk8K10e6j3r1pO6OsNOvwrSDJPwJLJn
 eLvbuLqL+DF98oLn+pZURP+VEz120R+gBxt01GRAJx9AtlxbrFHWLaefTRlJJyPl/zYtYFsP+G0
 S2sB0YvQLtvGRayIYj43CXVf42hS20Q84Fmtqycm/frSfU6sIO6t+HBCihU8xWd6Y0JvTkL4BmN
 vQpRANlNhz7mNsiAAfEZ3/6MqNxnOHSb42nPj2mfSCe+gmzMhPP7msJl6CkQfms00laVJB84HvH
 IlpK6u64tBSMDJIc10GrZtydzIAJM225lx8OC4WxqEhoDlVYgbTlxiZR5Nb2bd10RtRvrgZhctW
 ginOxi+hzXuOcQDGq86gyofju0jqD2t2wWRVpGqDbkM3CZd2Wh+rqXYRIjzszT0YEF3CcE3HVU+
 Bln9iUlYegG+JcQxtKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX5M3NYqVgCZMM
 lPMEr967BwpsXxfmcJtkfXt3o0+SfR4dPcK1rD0WmMBK6D17XNI6id65/PnJ/Ac4U0uX40f0iZC
 +ktP+1QJpxSSs6E3Lm9SEA0yVfBlB0k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

Provides the functions that initialize and release the data structures
used during live guest migration:

* vfio_ap_init_migration_capabilities

  Sets the migration flags and vfio_migration_ops structure into the
  vfio_device object when the mdev is probed.

* vfio_ap_init_migration_data

  Allocates and initializes the object used to maintain the state of the
  VFIO migration. It is called when the VFIO device is opened.

* vfio_ap_release_migration_data

  Frees the memory of the object used to maintain the VFIO migration state.
  It is called when the VFIO device release callback is invoked and when
  the VFIO device is closed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 80 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 60 ++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h   |  4 ++
 3 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 1b0856aacb69..9187cfe26da7 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /**
@@ -70,3 +71,82 @@ struct vfio_ap_config {
 	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
+
+static struct file *vfio_ap_set_state(struct vfio_device *vdev,
+				      enum vfio_device_mig_state  new_state)
+{
+	return NULL;
+}
+
+static int vfio_ap_get_state(struct vfio_device *vdev,
+			     enum vfio_device_mig_state  *current_state)
+{
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_get_data_size(struct vfio_device *vdev,
+				 unsigned long *stop_copy_length)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct vfio_migration_ops vfio_ap_migration_ops = {
+	.migration_set_state = vfio_ap_set_state,
+	.migration_get_state = vfio_ap_get_state,
+	.migration_get_data_size = vfio_ap_get_data_size,
+};
+
+/**
+ * vfio_ap_init_migrations_capabilities - initialize migration capabilities
+ *
+ * @matrix_mdev: pointer to object containing the mdev state
+ */
+void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (ap_is_se_guest())
+		return;
+
+	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
+	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
+}
+
+/**
+ * vfio_ap_init_migration_data - initialize migration data and functions
+ *
+ * @matrix_mdev: pointer to object containing the mdev state
+ *
+ * Return: zero if initialization is successful; otherwise, returns a error.
+ */
+int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = kzalloc_obj(struct vfio_ap_migration_data, GFP_KERNEL);
+	if (!mig_data)
+		return -ENOMEM;
+
+	mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
+	matrix_mdev->mig_data = mig_data;
+
+	return 0;
+}
+
+/**
+ * vfio_ap_release_migration_data: reclaim private migration data
+ *
+ * @vdev: pointer to the mdev
+ */
+void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	kfree(matrix_mdev->mig_data->resuming_mig_file.ap_config);
+	kfree(matrix_mdev->mig_data->stop_copy_mig_file.ap_config);
+	kfree(matrix_mdev->mig_data);
+	matrix_mdev->mig_data = NULL;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 71d3e2c2e07c..47aca908701d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -775,18 +775,30 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 
 static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev =
-		container_of(vdev, struct ap_matrix_mdev, vdev);
+	struct ap_matrix_mdev *matrix_mdev;
 
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
 	matrix_mdev->mdev = to_mdev_device(vdev->dev);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	matrix_mdev->pqap_hook = handle_pqap;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
 	hash_init(matrix_mdev->qtable.queues);
+	mutex_unlock(&matrix_dev->mdevs_lock);
 
 	return 0;
 }
 
+static void vfio_ap_mdev_release_dev(struct vfio_device *vdev)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	vfio_ap_release_migration_data(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+}
+
 static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -797,18 +809,29 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	if (IS_ERR(matrix_mdev))
 		return PTR_ERR(matrix_mdev);
 
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	/*
+	 * Migration capabilities must be initialized before calling
+	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
+	 * will see mig_ops as NULL during the registration. This could
+	 * prevent the VFIO core from properly setting up migration
+	 * infrastructure like debugfs entries.
+	 */
+	vfio_ap_init_migration_capabilities(matrix_mdev);
+
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	return 0;
 
 err_put_vdev:
+	mutex_unlock(&matrix_dev->mdevs_lock);
 	vfio_put_device(&matrix_mdev->vdev);
 	return ret;
 }
@@ -2052,19 +2075,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
 static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev =
-		container_of(vdev, struct ap_matrix_mdev, vdev);
+	struct ap_matrix_mdev *matrix_mdev;
+	int ret;
 
 	if (!vdev->kvm)
 		return -EINVAL;
 
-	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	ret = vfio_ap_init_migration_data(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (ret)
+		return ret;
+
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
+	if (ret) {
+		/* Clean up migration data on failure */
+		mutex_lock(&matrix_dev->mdevs_lock);
+		vfio_ap_release_migration_data(matrix_mdev);
+		mutex_unlock(&matrix_dev->mdevs_lock);
+	}
+
+	return ret;
 }
 
 static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev =
-		container_of(vdev, struct ap_matrix_mdev, vdev);
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	vfio_ap_release_migration_data(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
 
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
 }
@@ -2374,6 +2417,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
 	.init = vfio_ap_mdev_init_dev,
+	.release = vfio_ap_mdev_release_dev,
 	.open_device = vfio_ap_mdev_open_device,
 	.close_device = vfio_ap_mdev_close_device,
 	.ioctl = vfio_ap_mdev_ioctl,
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 2b542648964b..a2a713f93674 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -172,4 +172,8 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
+int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

