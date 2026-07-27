Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC575432BE3;
	Mon, 27 Jul 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173577; cv=none; b=Yc6MnDWt/gkDn9acN81O7m6ZEQUYixhBzjQ6QrEJshpavvJ5CLPdV3kkpwI37ReNED/7XozLy5MthF770MMsZflOnkAJwnu3CGcvhAjOTzvybZsPro/7/jhS87tpZxdaTjBRHUunR8QzhwzD6/EWHPLaubjfB427xeXZO2WDmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173577; c=relaxed/simple;
	bh=itbSRcNmKfgX8NExUOgErdIv07T/aq0tMsGNkOgG6aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFpt/7TMrkpFeSvU/QxAH7IXX0PMqiNgGOMg1bklxjuiRHK3t9cVzGmHILUzCt3jPjz6ggpA/4ae8XXkl+KoF8z+eZDN8FoG+oIfOORlBNnGCRQVmtzEWCNAbbc9BLDPhsQeo7xLErIfFzGZYaxUiAIMw568+KhVG4Yhn/5P7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CxwiiAqj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CxwiiAqj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmdse2373070;
	Mon, 27 Jul 2026 17:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wTBgoy0tyIb0PlcV5
	Vtnxck95jk5K1/IMKmNwTEwWHo=; b=CxwiiAqjFmd7QDidupKuAdCHf5PX8kuEo
	E5XDvsmtQpZwkF3xc6hNi+7PTnKIu33Yje86tMrbw2eP2oSQDo5bZPMApwwLYzOC
	BW+UQBrz8do+rwfW5FeG7Vw6LRFwX02wzETYZIjEQiHiGZ/6x28Mhi2NFFoyXrHf
	kRwCIydc1B5hPgdvtiAm1IZA0V+DvbUJ3djN7a7O+B4ovVILfz9l1zun4yx5xq0s
	fhpMcKxp+EpojYxyI2Ghh8yVR8ufE0475gT2D6tvsKM3VB6g6Q1UeU2M6AxrUNHd
	Y7rdvrEsjcGorhHoupwRLKH0pkcMaI8M0cZDj6GEHy/1O2XKEr5RQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw799yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQGFf013234;
	Mon, 27 Jul 2026 17:32:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjxbwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWlJ419399208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 794625805B;
	Mon, 27 Jul 2026 17:32:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0F358058;
	Mon, 27 Jul 2026 17:32:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Mon, 27 Jul 2026 13:32:27 -0400
Message-ID: <20260727173239.2420754-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: xDkpgsEPfE3BEh7hksuDxYNnmkYa6cG6
X-Proofpoint-ORIG-GUID: xDkpgsEPfE3BEh7hksuDxYNnmkYa6cG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX5dRwKWc3eJpJ
 fxS8edxuPDkMhu6oEJcSOlv3UUjKB4kHUYhiFbg3Wfve4ADXVq34VPr6BZUyM3qMtV2wDLcb8xV
 3/0rIwf2hL3Hy030tEErQKTwpQNth9a54dK7cv7TVr+Lqezb7fxktQU9w4YVPxi0gz7OnRtDytW
 L9vjswuI4u3nr35Gsx0pwjpsL28Lg1ECxZwSJKKEVKwc6OqkNxCeDhMUPF+ij/UHochEzslTdvd
 3V1okslldLjoxzELpe94nSntbGbaqXAr7ch/MYmPbx0vgPpzGbyqcXpXYAHlWLly14t77N9Gv2K
 Y0FC7ObkR/YKfkoAgM4IiaHqxDNQwHyG/pZFyqV3GRZlFvNnyg571atCB3zAheGYBOti2Q7jGGG
 UMi8rLwC1JafzhlfSaIUBfxlknlqW2/gbawXt3JntCBYZIGpLisj6BKmcKFedAX/msnWlOevPtj
 4ybkgwYa6QMh2qfMzbQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a679641 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Q7k0OFsyBfXhLSpgXRYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX9R/ydBGp4umk
 0t61mF6RxDoyOLjcAftY1KsupzzSpw27tBlr5Xnjh2bPKLHZHEb3Pzs3iOnRnKF2s0a6TGj08Sp
 92dxndg2PIaT2Qj45N1RO7euiS231zg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

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
 drivers/s390/crypto/vfio_ap_ops.c       | 64 +++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h   |  4 ++
 3 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index fc3b2e154ad8..ae0bd1f415fe 100644
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
index 36786d70a88f..90b0fce0123b 100644
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
@@ -797,13 +809,28 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	if (IS_ERR(matrix_mdev))
 		return PTR_ERR(matrix_mdev);
 
+	/*
+	 * Migration capabilities must be initialized before calling
+	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
+	 * will see mig_ops as NULL during the registration. This could
+	 * prevent the VFIO core from properly setting up migration
+	 * infrastructure like debugfs entries.
+	 *
+	 * This must be done before acquiring mdevs_lock to avoid an ABBA
+	 * deadlock: vfio_register_emulated_iommu_dev() acquires dev_set->lock
+	 * internally, while vfio_ap_mdev_open_device() is called by the VFIO
+	 * core with dev_set->lock already held and then acquires mdevs_lock.
+	 */
+	vfio_ap_init_migration_capabilities(matrix_mdev);
+
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	return 0;
@@ -2052,19 +2079,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
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
@@ -2368,6 +2415,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
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

