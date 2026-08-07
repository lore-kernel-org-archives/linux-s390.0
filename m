Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C845DF7B;
	Fri,  7 Aug 2026 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141130; cv=none; b=cfB5fdW+MGncIvdHnrSgLu98xS/UXc9/GsYMwAnjFtsfFLXKJpt8+T0sd6EmhRLeifq0xejtvqZnas2ty0UKCLXt9mNGR8z0N7YRs+oJhkPacRdT31Li0bitXP6NhbW+krVKR+ovkZlcpa07Jzssq0PK3LJPul6P4W/ytsS9Gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141130; c=relaxed/simple;
	bh=dhBYbnv8vhaIc60MDNqGy12ceO7k3T4jcyrtXA+ltqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4IYerQ5NWCSqxwBoc1kUhIzQDsY/uehlk+oS6A5Y4VgmvaLFAzA1QAQa7JgvdDtZkSQrwRCsEWy6NeB+VcVENrMI4WFrGxRqQif6QqlhqMqbjs/V9mZAUynChjVCuj85fvW3sM08O7om+Xrl88gD3lwLGzBzO/VEe7gEF5KGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A9zd8FKG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A9zd8FKG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LmQbE2582406;
	Fri, 7 Aug 2026 22:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vnp5StOX//6FmfLLR
	pp9pSoD+XWVoL/sQLaAa7gnd/8=; b=A9zd8FKG0VX7rOatOXBHxpP6Jj7AjtsQr
	xOevBjlRVoueXBHkzipVugUg8E9SxfsbedUmYjJJQLQT23t/1al5kIL8ltetWDHa
	ABwBgn7UsyJVIFMl8C7XHlD1NnTHQ8+bn5NoeHYzPnuhKsfT5EaRp2mJk9tMP39I
	2VGMYkvbm959k94iyvAEsDo0VUo+u1QJtA+XLi0msCA2qxEzc/VkFpv93WKu+MBC
	q0yjth7WhoDk982FegYQlB87/LPGdN9OUfNqbU5ijwLLJyRVcqya3uHzbmGtaBFH
	oJXZtKEeeoOKeGnipuTfejoCZKFc6w/GmuWF68feaGk9K/+2yosXw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0260ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBYOQ020039;
	Fri, 7 Aug 2026 22:18:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu01eu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIduO28050170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C7C758058;
	Fri,  7 Aug 2026 22:18:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A68B58057;
	Fri,  7 Aug 2026 22:18:38 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Fri,  7 Aug 2026 18:18:22 -0400
Message-ID: <20260807221834.562851-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: kV6k6GMRN75lSikjTE7xuuNfs8ms2f9O
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a7659c1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QoJB6SS0Lmr336d-140A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: kV6k6GMRN75lSikjTE7xuuNfs8ms2f9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX1r3qLoxzaaVE
 npewl+QUUBhLH87TAVAeT6CFnZFgYCbfDrn4sB7eoxzV86rNoUay79HZbBknoSR1Z/FLnlco6ul
 od6t+DJjPnuvrC1CEg4ExxsBvrKdATooYyUgAc5We1XAYgf3UsCMp10JBnX7GFLvhf62nMablT9
 +BRvI5sN80umhp914uf/HY8bAMS3GThMjKlZJvv0qc78r3ig10FcsL3haduaj14gF8yTe7zRbn1
 qUyRkJcgW+Koz9VX+80xy2U68cxl8kgx3Hhb7P+u/EQoNQcIniYbBGfPqBhJ/7TyV8Mwl+jbBJj
 tLGRi+WcAtmiV1rDKR6xneAF9DHcM9D5w28z9uyRpyfcSOv+PY6ZMEaHJj8LWtwuCkrKr3WbBlu
 uc5faF/XuJQuUORspjCXIDSKkIS7rFrpJRTrNk9MajvNXXko1CPKD9UND1tzAMMJErUG6Be3hlq
 N7uksVrnsXSpiVGaQ+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX6QRAdQrdDVmz
 XUFdTHh9JvEdhnESrncqEPdOP+t4ve2baTn69UA0/7wj87QF2bRGkvMG+gaKP5nPgJPvfuNlqtW
 EA5Fjq1pagz8i75p23n9rM0ZeDYroUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

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

* vfio_ap_release_mig_files

  This function is called from the vfio_ap_release_migration_data
  function (above) and releases the vfio_ap_migration_file objects
  contained within the vfio_ap_migation_data object used to maintain the
  state of the VFIO migration process.

* vfio_ap_release_stop_copy_file

  This function is called from the vfio_ap_release_mig_files
  function (above) to release the vfio_ap_migration_file used
  during the STOP_COPY phase of migration. For now, this is a
  stub function that will be fully implemented in a subsequent
  patch after the vfio_ap_config object referenced within
  is allocated, as it will need to be freed according to how it
  is allocated

* vfio_ap_release_resuming_file

  This function is called from the vfio_ap_release_mig_files
  function (above) to release the vfio_ap_migration_file used
  during the RESUMING phase of migration. For now, this is a
  stub function that will be fully implemented in a subsequent
  patch after the vfio_ap_config object referenced within
  is allocated, as it will need to be freed according to how it
  is allocated

* vfio_ap_set_state, vfio_ap_get_state and vfio_ap_get_data_size

  These three functions are callback functions assigned to the
  vfio_ap_migration_ops (.migration_set_state, .migration_get_state and
  .migration_get_data_size function pointers). These are implemented
  as stub functions here and each will be fully implemented in a subsequent
  patch.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 127 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  64 ++++++++++--
 drivers/s390/crypto/vfio_ap_private.h   |   4 +
 3 files changed, 187 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 374d3a67cb21..cf303d228a0a 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -111,3 +112,129 @@ struct vfio_ap_config {
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
+	if (!mig_data)
+		return;
+
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

