Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E703F825B;
	Tue, 30 Jun 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816107; cv=none; b=YPiA0KlssoRrph8E+hTSVbr7GzV+hc95gn8JYMff9N32lnvzEvEtRrQtd+CK79jLqbMl7oKlxEpitgcH0gz/4/Can1DndHEg3LuWLdXmqzOAQEI6FhiE7c1KlvIQVYAtKBy63OB+Vxos3uZoN5GLX47PZga8z4eAvb0JQnmRmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816107; c=relaxed/simple;
	bh=ci3v1gbNhdq5yH58VvYCAs4EhpaA8Q1HEmjXAJUTqhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2TNg9ogRezm0rjeDb49Y5Q1kLTZttSlMmgVIPCm937gRFkYZfOEtdOrQ3Y9LzXuE3urrn8ECvDMSQ9nvE5PhXjAEuLzHRPWLLu6DIIjZszUh1yj5Gox6pXMRV0k3PrqCSpo8h3idwpcjQ3seh3DILKkpnw8/xHTFZMe2FXNo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OhGjgmc8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OhGjgmc8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n2491843253;
	Tue, 30 Jun 2026 10:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cprxg9Kyy7A1DD6yB
	kg/NSErcry718iCbYBH3o92Ujc=; b=OhGjgmc8dQlaDxCUmlspz0LGDFBpgrBqr
	M6KvKnX0rRSETr3SKT0JnzScCUNwnTDROUNZeK0NRJ3LgvuvuVmaFYleSgsg/7jz
	KtdarX5BLnk5ukJoR6ZmrWITZ3DbBVRswmlXfYXVFyH8l2hCIReSRcVCvZr7mNb+
	8aILqru/CCkW1IBTl2TGAprovKnQKbXwjMR31QsweuMYxnfOBUz8kP64UxUHPVAV
	XluKNStu7JDMWoX0fVIFdMG8xbTTyv9DfTqNnIkrGOaEsSsKGuvcpA4FEM6yT0nl
	F+OjM9WKaO10g+kfpRFDMQCVuJqmSECgyTtr+KpyjtGRrKE9oBwDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx5h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYeLX005461;
	Tue, 30 Jun 2026 10:41:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1tfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfbZv18875066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFD6A58067;
	Tue, 30 Jun 2026 10:41:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1BBE58056;
	Tue, 30 Jun 2026 10:41:36 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:36 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 03/15] s390/vfio-ap: Initialize/release vfio device migration data
Date: Tue, 30 Jun 2026 06:41:13 -0400
Message-ID: <20260630104132.1598851-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439d64 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=tPEdKbJYLOb5O3tXgF8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX2WvalVtCgMmW
 w4McKg2elzZpwL/608+A9q2i1vpO5PsrZgI9OB4h8EfNVZ32iZS16Fp0YtF0gyNx6k3QmH/8xd/
 dqTXtuYUCXxG/HRfDBZ2Jllp3F/M8Ns=
X-Proofpoint-GUID: Gbuy-xdkWO-0wxkbpkr8dxXyI_zuU4zE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXzNwYsyhdBEAl
 zpsmaapMPMk4AqrwY6qIFdjSzG1st0bXiYhCDebj3rKZM30SZS6uMnpXLPDQkJS6g8Ql95B/lzM
 Ui9/9EONVBqejwHNY6tjYK6IkbbB9Gc50ZgJ4rfZdbTn+eHPfxiiqfSVCkBElr7BDm8ovFnhIsg
 m75t4b3UbNBb0l4wKt12dxg6UotionisvLe2nseGpLlWfLLni89bBPw6R0ZrcrdDkjcrMdXd76w
 Vkmt75JDiNFBUxW/j3t5qdUhzZjgdL9OfttxJ+5YzK17xSnmvDoeBETXcyBC8Xn8MjaaqViwmfq
 uBbgbSKzZDgBkADU46OdKrRXjL3VEHtNVoPOJeJm2YwhIzwJ0qoARXmsWYlZwYtssnphv2X1s3N
 Q19TpMKsffb9/OICBkPdbGVR2OiFnl5sj0uoeTNKuK9JPuIM+UuFNe7Us3t7gM0yNRCAOzhiCod
 DgK/hvsPN/FlCs8+68A==
X-Proofpoint-ORIG-GUID: Gbuy-xdkWO-0wxkbpkr8dxXyI_zuU4zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Provides the functions that initialize and release the data structures
used during live guest migration. These functions should
be called when the mdev fd is opened and closed respectively. The function
to release the data structures shall also be invoked when the mdev
is released.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 75 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 60 +++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h   |  4 ++
 3 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 239168c4b7ff..5b6d48ccf332 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /**
@@ -54,3 +55,77 @@ struct vfio_ap_config {
 	size_t				config_sz;
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
+	kfree(matrix_mdev->mig_data);
+	matrix_mdev->mig_data = NULL;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 71d3e2c2e07c..813290214866 100644
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
@@ -797,19 +809,30 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
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
 	vfio_put_device(&matrix_mdev->vdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
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

