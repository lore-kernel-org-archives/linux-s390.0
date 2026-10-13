Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEE5326B4;
	Tue, 13 Oct 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905563; cv=none; b=QLRqtX5nW054aAl/5y+q3JZgMxFjScH2sGK/FL7pcL5fNg5mBKj1SaslB33dNy6CfiZ3YPAfhk6GZrp4evRbGSuv+TO/vzDsx4tPkb2uAbeyde7D+GBoADtNTVY9K9FpHZWwTWcz+UM2aRuV5QpE36ACE8wN1rf+mewzp0XyRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905563; c=relaxed/simple;
	bh=5ixyBKHgcNoH1oE4dOnBc3/lQc4ICkY5cUQ248M5wqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIJH27tiUa7KGOn8gCmdaS1jgb16NmnO4svIm8Ig7YnYHbWuiVpjjzYuaAz11CE9YvJanlJlQVN6B8SJXi28CI8l7UDfc0e6OhetdAW4PerDGuhBEdakb7MGORWwkxj/v5IC6Z3FrTjEwCcatx68cCYqcPd074T9c44URdxyNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RX0jHyE/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RX0jHyE/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDmbok726055;
	Tue, 13 Oct 2026 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=645OoDCqw/YgGCOab
	2ZLb5dwbuI68S5Xjx8Lwx4vetc=; b=RX0jHyE/lYx6DaWZR2PNoas9aRadItSaY
	dpaK9OKmu4xBLOzxbuqN4eWNZ9RZAzDZEw/f1ficf95GtddvXkaz/cuulaUN5R15
	AHD78HXvpTi6DIJoF0SFY2L6AUCQhJYpf7wDzi/9tomzj5FBeODIqzW7w9i4q49/
	VWn2g0I28ojKf0dPMvJ8nepkc+E0eFrVhGJNI2ZGt8YAf8ssFRG3kGBGz1K4jfe9
	TBUdaUtdN8V1+3HpfjoTrm7G0gB1SflsY5B2UHVAEmB0yunpzHol4+UuU7oi4SoO
	DfRyWJttJkZievDFlt67V5bPJK0VbhdkXkhWzvF2UobSJVKX4LRcg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0enb0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFPCwZ2667524;
	Tue, 13 Oct 2026 15:32:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vtrnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWRSl10093292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D70158067;
	Tue, 13 Oct 2026 15:32:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF61A58063;
	Tue, 13 Oct 2026 15:32:25 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:25 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Tue, 13 Oct 2026 11:32:07 -0400
Message-ID: <20261013153219.3534306-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX2MQ3evEQiWCs
 YtOvfVTJ6kOXElamYEbUkBOUXjrNO06x1uZPaBFlRjBYVt3CW08xgB9JrOzj9egML3fNQ15l92/
 oh7+CQ0Is3BLdiwf3kICrhdnabWsX08Bqke1oHhKPdySIpoK28qo8IyoK8Yy6o03/FfoJNdFAeQ
 pX9rfHfj6+KUu5kHgcEXik0zFDDomxOppA4AGi5uj9waADdPyoVs43Jx3GdQ129bmg0B4U91zR7
 Ho/Qwwxy1uQjwUBsivj98HE4zSG8bq8J+LFwLtSs8qXN5AnMiwzPzDlGt2qxu/PIOg3fMGa7He4
 UAf3BfEn7Sqt5pSBRlsNvx3rRMvx0sxZThvkNH9k1qGMRnFm+xX7CBVTNcFaQeVqd29tMO9qEmj
 QVI0VraNtjqMo4Q9v3PwBInzW7dqlLcTrdrGUufHaEVC5+h49uF1ClR1BFoH2xMBeXV63BteGVB
 21ID3vkcKL/7FfJVuLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX+YOYpd4Vt9Ah
 5GP4Dz9zc83hyzYzqmq1X2BGSigqvk8n+gaYg9CaO/YLj+epdsnd+FyZ3j/KMvjVLhGlAUyLxBc
 70uS6TYYLVXsvPHMXTPzu0WOCsf0zQA=
X-Proofpoint-ORIG-GUID: UCSrPh1q4dwWPowRHmgcY5tZKoCELw8c
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace4f0d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uLHEPvNt_cHMVgTJCW0A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: UCSrPh1q4dwWPowRHmgcY5tZKoCELw8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

Provides the functions that initialize and release the data structures
used during live guest migration:

* vfio_ap_init_migration_capabilities

  Sets the migration flags and vfio_migration_ops structure into the
  vfio_device object when the mdev is probed.

* vfio_ap_init_migration_data

  Allocates and initializes the object used to maintain the state of the
  VFIO migration. It is called when the VFIO device is opened.

* vfio_ap_release_migration_data

  Frees the memory of the object used to maintain the VFIO migration
  state. It is called when the VFIO device release callback is invoked
  and when the VFIO device is closed.

* vfio_ap_release_mig_files

  This function is called from the vfio_ap_release_migration_data
  function (above) and releases the vfio_ap_migration_file objects
  contained within the vfio_ap_migation_data object used to maintain
  the state of the VFIO migration process.

* vfio_ap_release_stop_copy_file

  This function is called from the vfio_ap_release_mig_files function
  (above) to release the vfio_ap_migration_file used during the
  STOP_COPY phase of migration. For now, this is a stub function that
  will be fully implemented in a subsequent patch after the
  vfio_ap_config object referenced within is allocated, as it will
  need to be freed according to how it is allocated.

* vfio_ap_release_resuming_file

  This function is called from the vfio_ap_release_mig_files function
  (above) to release the vfio_ap_migration_file used during the
  RESUMING phase of migration. For now, this is a stub function that
  will be fully implemented in a subsequent patch after the
  vfio_ap_config object referenced within is allocated, as it will
  need to be freed according to how it is allocated.

* vfio_ap_set_state, vfio_ap_get_state and vfio_ap_get_data_size

  These three functions are callback functions assigned to the
  vfio_ap_migration_ops (.migration_set_state, .migration_get_state
  and .migration_get_data_size function pointers). These are
  implemented as stub functions here and each will be fully implemented
  in a subsequent patch.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 135 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  61 +++++++++--
 drivers/s390/crypto/vfio_ap_private.h   |   4 +
 3 files changed, 193 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index f76d151a5cce..5d912b1b6b88 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -111,3 +112,137 @@ struct vfio_ap_config {
 	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
+
+static void
+vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
+{
+	/* Stub to be implemented when the mig_data->stop_copy_mig_file.ap_config
+	 * object is allocated.
+	 */
+}
+
+static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	/* Stub to be implemented when the mig_data->resuming_mig_file.ap_config
+	 * object is allocated.
+	 */
+}
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
+ * vfio_ap_init_migration_capabilities - initializes migration flags and operations
+ *
+ * @matrix_mdev: pointer to object containing the mdev state
+ */
+void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
+{
+	/*
+	 * Live guest migration is not supported for SE guests, so there is no
+	 * need to initialize the migration capabilities.
+	 */
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
+	/*
+	 * Live guest migration is not supported for SE guests, so there is no
+	 * need to initialize the migration data.
+	 */
+	if (ap_is_se_guest())
+		return 0;
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
+ * vfio_ap_release_mig_files:
+ *
+ * Free the ap_config buffers for any open migration FDs. Although a
+ * migration FD may still be held open by userspace, it is safe to free
+ * mig_data here because:
+ *
+ *   1. matrix_mdev remains valid for the lifetime of any open migration
+ *      FD via the vfio_device registration reference taken in
+ *      vfio_ap_open_file_stream() and dropped in
+ *      vfio_ap_release_mig_file().
+ *
+ *   2. mig_data is only accessed by the migration file ops
+ *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
+ *      mdevs_lock. Once mig_data is set to NULL by the caller, those
+ *      paths will see NULL and return -ENODEV before dereferencing it.
+ *
+ * @matrix_mdev: The object used to maintain the state for a mediated device
+ */
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = matrix_mdev->mig_data;
+	vfio_ap_release_stop_copy_file(mig_data);
+	vfio_ap_release_resuming_file(mig_data);
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
+	vfio_ap_release_mig_files(matrix_mdev);
+	kfree(matrix_mdev->mig_data);
+	matrix_mdev->mig_data = NULL;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 345c52a328ad..d62f501ab5e6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -782,18 +782,30 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 
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
@@ -804,6 +816,20 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
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
@@ -2059,19 +2085,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
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
@@ -2397,6 +2443,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
 	.init = vfio_ap_mdev_init_dev,
+	.release = vfio_ap_mdev_release_dev,
 	.open_device = vfio_ap_mdev_open_device,
 	.close_device = vfio_ap_mdev_close_device,
 	.ioctl = vfio_ap_mdev_ioctl,
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 172471793e22..6fc10e0d934f 100644
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

