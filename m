Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425000;
	b=dkSpKvFxlAHMGX3okJ8mqDExYo/LBER53n0YZTl8F3RmuawaDd/J2l1TO4ZIMxyWWPYs
	 ituRNCJJ+KhWwnM73uhUxHD45vCUsm226Wajqq2FvptEwJqUSGCXDAx66nIESWPyhUdLE
	 vJPiQi5ZomIQuBsb36C3tobPFfAkHC/qXfbwxW7fk3QtjokGYjXzUlq59WuEKstxCbr8J
	 xMobC1FZWg85WtF41I47XbXuFlglMpKsFuK022WbDOsRtKBZ8JyuUApTzlRz4BDiThbXK
	 Mwx7v/+qXt1hlBOiqLSH9l8BRiO2CQlbNVb/QCDC2Nx60w/bpVibtwMq7BY3u9XQMNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zuqHFyMnWuP8jZOMCjKG/gDGQ+prlgKzFvTm7jEjvKQ=;
	b=F1Gg722jO3qy74YckFUUI8d5AxT2vxPFIADYRWd2ABnCqDTzy+p83UGSKeBciXnVJMvy
	 RUKUwQCG/5l0I/1iptM816oRKGaIEWXpqx9DWHvNuM19pVvaH+ISXD+EpwMVSJ90EIPEL
	 3VZKjuZnTjBiQxDvfAR9vP3rwMUPK95E38rJz+UuBHOJ2eEkj2CW5g5VbdJSEZaqH11vP
	 2ixCCcUN9rnnQIHhBiXp9lnzjrojBD3nGVNdOhhOGN/SKideHGV8hnrfD4wsaTXw2ooQF
	 9GIHWHAtuLLi6EmJ+UVecZInj0sqA5rwp/YlNmSkFCB9pTrekLl1JBf6YtT2Y/qyo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGta+4mD;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E9606A324;
	Wed, 11 Nov 2026 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGta+4mD
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiHeF1828796;
	Wed, 11 Nov 2026 19:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zuqHFyMnWuP8jZOMC
	jKG/gDGQ+prlgKzFvTm7jEjvKQ=; b=XGta+4mDSxRqdANtRoGQ110RlYMcfZBTP
	DonQBA/prQtbcX7QOmkE4id5ZVQuZ8fHNcx3mQ0JPXXgNAGII/XgaN5EMExrC/Gl
	wF7nzHnQbrM3KrLVEA4i4Om8FuNNkPdexIPpgLr1Al8TiZ99Ro2QhTP+5ltoDLOX
	JoF2+jBJ+bkewtgnYz0+MVJFLpyrvw3QVN+yFWRHxH3xQ5zemwb72rNfxQbc2u23
	fHjCTLxBNis4n/hmmfv3nDuVdMX2oQ4CCLz2eL2DLF+4/TtMSdnhzfcjBkx86UsR
	tw/dhwuvAUm6QbHuj+jl2mT99Orgw67tlhL7i1Pe9CVzhlOdMqKyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkuux6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ3Q93690399;
	Wed, 11 Nov 2026 19:23:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3325ut9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJND1K27001438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11305805D;
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D85F758067;
	Wed, 11 Nov 2026 19:23:12 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:12 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 03/14] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Wed, 11 Nov 2026 14:22:57 -0500
Message-ID: <20261111192308.2585984-4-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4c0a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9A85dA02KUDslgMJtx4A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXwoPBglTMyEYs
 Ki6gbgbrJDoH1tdnFBnfA/C4KOJ3K3AeBH4bKukl63H3YeGS2uU7yXQBN7rCurLZaFt638QAeCF
 aEJlkGQH0z8DF01a5dzQu4ZGiW7GuHMR8SWG4bE3IgTL6p2NqAAewKo11jzHY2JZdjDu4jmeSr9
 bWkU7A+WLwPFRKx2I5h6qfdaHCFt8KpbxFCeLQJI1mgeya+86OZ8AsCal7Dwq0gux9jIH5CcsFH
 qSFP4eN37VRVmE+mzB5XY43I5PnncMuw3vXbiHGS9jbohmyQGa/eK87f0yyCsldIJgPaxZ+mlbq
 i1OCFpHA+L0ouRZzd8XTZmEzzRgdD971es4XEnrBU57viHH9bfYViRfWdW9ZzBECzORx6mPGkc/
 vXUa+R6ebddbHlj9psxN1ChukhziP1Ju5VGuGDOGX59mBaI5e6LNJdc8vJuuw3dJIXvMlniw/Mf
 FNoO8yTcLelvxGjltTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX8/TwHfia5tHS
 7gGIirtefrJbTB9DI2ZmyYnIRH/8kE65iRkPFBp15J8qye/svT+mtBs3aanTZHfyBXX6geSuuhE
 OX+aI/dE0RXFUYiKNipCBU42DmfJGuw=
X-Proofpoint-ORIG-GUID: IY9W0FF3fdYA2KzK5n5U9g5HzqLN82Tm
X-Proofpoint-GUID: IY9W0FF3fdYA2KzK5n5U9g5HzqLN82Tm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

