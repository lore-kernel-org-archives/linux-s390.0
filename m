Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978598;
	b=2Fj2+QhsZlyzJcv9bwNqNTlXz6UZQeSh4LHvGHlNnHt4qT0Z3MSVwyf0FHO7R4lA8lwX
	 oDxSI9UUg/0kbttob4HD5fUxgDMjW/hbJ3IsCUKFxRyYKkluD0OffEtco7xdr+7LZot18
	 BO6EYe3kxcruZDM6ZL+8XenpPvOyUZ8Iu2yB6CHkuGLDq8+63hvsKQpsC52aeOb4WzhVT
	 t7B7b/dQHlaB0azprGiYyzijkRKLX4wVleklPS7NG1W83niw5a64Dxt/EXzxjTOnEzGeu
	 FWduDklMzrRGHiZm0bcm7Rt0eQdow6vbo9cNWCI25EP0fZkqyL16k5snwD6A9C+8WvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978598;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zuqHFyMnWuP8jZOMCjKG/gDGQ+prlgKzFvTm7jEjvKQ=;
	b=gSmBJJv4fb0BS5gLjusVeg+E6RzuEDAeiqQZtoOCXELXNJ4dRqZ1VkX5OAjCb88xdYBL
	 Ptrurc3k6KP9RQIQHeB2aiFP/W0wqZoyeq+gaaAN/xS35vph9Ex+3Lkl9ZN65vdKLsKSm
	 TNSuePXgEIrNDkuHk3Dh+2Dx4TtCvtvANdzxG8BrjgqTdhmcdwGFrytHzbEf6rQs4BPsJ
	 Rxh4oTGq6QJg3eAogracTsZ8Xxi06Iwiya5jyL7nF9/jfYEqXhwh21DHSOaSjlWGI6ioB
	 iQ5K7aMuiOwSQUTP18r/rYHKIlxc+LtelR49x1wafiHMswLE2b96v0xcFAOPwyMANfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="oVW0JZ9/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B9606A33E;
	Fri,  6 Nov 2026 15:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7B9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oVW0JZ9/
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE8cl2935709;
	Fri, 6 Nov 2026 15:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zuqHFyMnWuP8jZOMC
	jKG/gDGQ+prlgKzFvTm7jEjvKQ=; b=oVW0JZ9/a9oiuFFtJfHeJ/Lx3KvC/XTEO
	hu+GHMLLkvPMKF51gaZWhAIV8VFrFQFLaeqj9u1MogpVgyY5WvyOX+XPfLBfIyy3
	gCErzpMA80+iqNSLH33b0zakSbJHkfeNXED/TqSkxY7A4Vi9/bZRd833NcSONX9l
	3F7mzcH9Hg0wN9nNmoRK7pmpu1oU/NIVarmL2XJT5tOZpa9Xqa+JBOg8VmFCbboA
	2qB4/ygcNSneInLmk09ivRZso737CIrt6RLk8yqIvYfALGzwzN8haRdChTAxnh0B
	sLrqU73ubPmQuzgpfvraphpxhPSMRu6L8paHQ5MnB3C+VQ/RRW2Lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcd70v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FKCVB3577989;
	Fri, 6 Nov 2026 15:23:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v7wsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FN8sU20972128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83215803F;
	Fri,  6 Nov 2026 15:23:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C96F58054;
	Fri,  6 Nov 2026 15:23:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 03/14] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Fri,  6 Nov 2026 10:22:48 -0500
Message-ID: <20261106152259.1360651-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: x_uBf0gDz6R852yOuxsq3chlqOcaDkxk
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedf0de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9A85dA02KUDslgMJtx4A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: x_uBf0gDz6R852yOuxsq3chlqOcaDkxk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX3NjThhkumbYX
 ecmzxwgqmHIVu3h7T2P6PMpnSflm+wBWSWqf8RmGby/COhg2/so/5F5ToX4JMFCF8dO3fZB2lQJ
 GQBr7Oy2Qahan/uS+ywbretgm/0nm9jg72zyv4IJ5WJIOBLWem3xkIgLFW6Wpfa8qrZtOG6jKZJ
 b0VJqEX/FxWbjBjppvD+wK8geJLod8YUqXyQwwFes8dValcXr0UebwaHwl92aN/Djdd6EiLIpWb
 rOIXwRrR0wZsLVS5cFesk7D/7t1mCDVOp0vQGvTAu1cs7ILUKDnCbRNL/ag+OHh/BIx4Ft2XOYL
 WnQTkX1UAy/i+pc1xpU/oeN45Tyv2kiMrwOFjshI3X90sqHarC+GG4c06hJcNhHl0s5FHx0PvIK
 xCjRntgz1clKLgSU+GfydDmHfE0JnGgtcqAquPl8Ex9DZPIzDg4+O4LP74UKsbmpN9pyg2bNf9E
 vloSe7hfNg+3/NJPiiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX1LuKpFbRNZmV
 HZZp64gdVtZpaTri/kX5UgbrzJhqR+Z4rUkC/36NAYMy1PePWzgID9uWKbj0QBrfFi0M2P9LgOB
 uiJrlsedFgvfoAroZJ4pLtOTtSuvyYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

Provides the functions that initialize and release the data structures
used during live guest migration:

* vfio_ap_init_migration_data

  Allocates and initializes the object used to maintain the state of the
  VFIO migration. It is called when the VFIO device is opened and does
  nothing if the object was allocated by a previous open.

* vfio_ap_release_migration_data

  Frees the memory of the object used to maintain the VFIO migration
  state. It is called only from the VFIO device release callback. It is
  not called when the VFIO device is closed because a migration file
  descriptor, which references the object, can outlive the VFIO device
  file descriptor. The release callback is not invoked until every
  reference on the VFIO device taken for an open migration file
  descriptor has been dropped.

* vfio_ap_release_mig_files

  This function is called from the vfio_ap_release_migration_data
  function (above) and resets the vfio_ap_migration_file objects
  contained within the vfio_ap_migration_data object used to maintain
  the state of the VFIO migration process. The objects are not freed;
  they are freed along with the vfio_ap_migration_data object.

* vfio_ap_release_stop_copy_file

  This function is called from the vfio_ap_release_mig_files function
  (above) to free the AP configuration buffer of, and clear the file
  pointer in, the vfio_ap_migration_file used during the STOP_COPY phase
  of migration.

* vfio_ap_release_resuming_file

  This function is called from the vfio_ap_release_mig_files function
  (above) to free the AP configuration buffer of, and clear the file
  pointer in, the vfio_ap_migration_file used during the RESUMING phase
  of migration. It also clears the flag indicating a complete AP
  configuration was received.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 113 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  23 ++++-
 drivers/s390/crypto/vfio_ap_private.h   |   3 +
 3 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 52f9a0524ae9..e2e9a8e7a833 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -123,3 +124,115 @@ struct vfio_ap_config {
 	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
+
+static void
+vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
+{
+	kvfree(mig_data->stop_copy_mig_file.ap_config);
+	mig_data->stop_copy_mig_file.ap_config = NULL;
+	mig_data->stop_copy_mig_file.config_sz = 0;
+	mig_data->stop_copy_mig_file.filp = NULL;
+}
+
+static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	kvfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+	mig_data->resuming_mig_file.filp = NULL;
+	mig_data->resuming_mig_data_complete = false;
+}
+
+/**
+ * vfio_ap_init_migration_data - initialize migration data and functions
+ *
+ * @matrix_mdev: pointer to object containing the mdev state
+ *
+ * This is called each time the vfio device is opened, and a vfio device can
+ * be opened more than once. The migration data is not freed when the device
+ * is closed; it is freed only when the vfio device is released. If it
+ * already exists because the device was opened before, it is reused as is.
+ *
+ * Return: zero if initialization is successful; otherwise, returns a error.
+ */
+int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (matrix_mdev->mig_data)
+		return 0;
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
+	mig_data->resuming_mig_data_complete = false;
+	mig_data->resuming_mig_file.matrix_mdev = matrix_mdev;
+	mutex_init(&mig_data->resuming_mig_file.lock);
+	mig_data->stop_copy_mig_file.matrix_mdev = matrix_mdev;
+	mutex_init(&mig_data->stop_copy_mig_file.lock);
+	matrix_mdev->mig_data = mig_data;
+
+	return 0;
+}
+
+/**
+ * vfio_ap_release_mig_files - reset the stop-copy and resuming migration files
+ *
+ * @matrix_mdev: The object used to maintain the state for a mediated device
+ *
+ * For each migration file, free the ap_config buffer, zero its size and set
+ * its filp to NULL so any migration FD still open from a previous use of the
+ * file is rejected when it is used. For the resuming file, also clear
+ * resuming_mig_data_complete.
+ *
+ * The vfio_ap_migration_file objects themselves are not freed. They are
+ * embedded in mig_data, which is freed by vfio_ap_release_migration_data().
+ * That function is called from the vfio device's release callback, which
+ * does not run until every registration reference on the vfio device has
+ * been dropped. Since a reference is held for as long as a migration FD is
+ * open, filp->private_data remains valid for the lifetime of the FD.
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
+ * @matrix_mdev: pointer to the object containing the state of the mdev
+ *
+ * This must only be called from the vfio device's release callback. It must
+ * not be called when the vfio device is closed because a migration FD may
+ * still be open and reference the migration data.
+ */
+void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	vfio_ap_release_mig_files(matrix_mdev);
+	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
+	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
+	kfree(matrix_mdev->mig_data);
+	matrix_mdev->mig_data = NULL;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 83ba4193bdc3..77b9328bdcb1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -794,6 +794,16 @@ static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
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
@@ -2067,12 +2077,20 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
 static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev =
-		container_of(vdev, struct ap_matrix_mdev, vdev);
+	struct ap_matrix_mdev *matrix_mdev;
+	int ret;
 
 	if (!vdev->kvm)
 		return -EINVAL;
 
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	ret = vfio_ap_init_migration_data(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (ret)
+		return ret;
+
 	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
 }
 
@@ -2405,6 +2423,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
 	.init = vfio_ap_mdev_init_dev,
+	.release = vfio_ap_mdev_release_dev,
 	.open_device = vfio_ap_mdev_open_device,
 	.close_device = vfio_ap_mdev_close_device,
 	.ioctl = vfio_ap_mdev_ioctl,
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 172471793e22..aa8a22585204 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -172,4 +172,7 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

