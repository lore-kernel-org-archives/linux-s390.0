Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777446;
	b=4bLLvZGg3QiV2UCW7TrI4yFf21s91N36eVdrUYzfMNIEcKHJSHjAAbKP6sQo+eQ0lC7b
	 5QJYBokKzZQzEAdcsc2g9n+g6t54qxCyoVRMlhKYG4foZSfXhuqDHKxDnezB/fE4h8NR3
	 iKDpe2CFKpDp/wAbB2BvuwsUFcts6WKdMMwG44VXXmVcAqn35u/DT4NtCWv86WWv21vwN
	 nut+JtgtbsSrjj2VCHjkIfHddg34b9HScGIKxUAschyr4jmb+PdbrTAM9+eNpWp8A+i8B
	 ASDiIAWDOKt6hMZekQB2WHWLRBg9OUbDnw9FNAVel4dcd0kZzAiLBxh5WqkmJiy2ncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777446;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fQMvNQG9WZYFxDPkaKIodDoo8ZML14WY4/DYyFCdLuI=;
	b=FFzc41rsIN0w6cyLsPgS7dZTsLEVtqzG/qGJKdrejSN5WFX/5vACbQwP82/jhoCMoz9D
	 198ysQZv6mn3f2TbBWUsHBiWJX6b6ANZBfFcPk+FbwhhJ5LjwqhLvI22+z1AklNm4nVoB
	 mLRvtO18xUQgg489rXfGxqbEwa/xUxI5/xuOApyhMJ5HUtGhoVzM32SE2YHJhThtsTdIG
	 m4yMAYeGTeF5k5kGpOuihojkI2kULLZ6e+BKEcDM2y1+IRjFDQdakF6iiy6xM+scIWF86
	 2+3KjHaZq9JylIklf69YloNzwlIfL3WCW7aRAapnwDmKopVy2Yc/F+vIpElUas/jaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o0sUgvD6;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE2606A323;
	Fri, 23 Oct 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DCE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o0sUgvD6
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoULd1896035;
	Fri, 23 Oct 2026 17:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fQMvNQG9WZYFxDPka
	KIodDoo8ZML14WY4/DYyFCdLuI=; b=o0sUgvD6nCfgxeFpZikodF0QsVu5UmShN
	oBaTQ+hl3IyrtrTv72sb22/Td4A7snGgURl70Cc3kL1H0U2/wPUC8T3jZyd6Z6DD
	P0U+N2myJ1Jr2sIgJ8QNkHWd0qIZHRs5KvxTgSXCeyO26cWlBiD3jzznmZBgXMrJ
	Z+dJBBTwDQUnNujbfDzIVSw62jXYxIF/RzHIJxRacrhztEj1Zgi5gKOrXnKXSTI0
	mzTXAGj5U2hVuoZxei21tDvQvXFp9SnuQTxoGXxDAyPysz71nFmPaQCOZEGHz0xG
	rNnxqQoABpdKaeiTTs9wLdkz/HgnxXw7D7J+b+NkhyVxOCdDW5lsQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bxrrh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE65db2260517;
	Fri, 23 Oct 2026 17:43:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn5nrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHhu081573616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCED95805A;
	Fri, 23 Oct 2026 17:43:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3272458054;
	Fri, 23 Oct 2026 17:43:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Fri, 23 Oct 2026 13:43:37 -0400
Message-ID: <20261023174349.3545941-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: Ui7ImTIL50FmHqNa_nSrjE0fU3TB9fVh
X-Proofpoint-ORIG-GUID: Ui7ImTIL50FmHqNa_nSrjE0fU3TB9fVh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX+piqXxrwIuj+
 tqnlexKATXlsLjRBaLvmG6j2fvXhr4rNvO5XDAYOYk2RyfS9LkX98wP0K0oGE6v5NPoFtYlw2wR
 2CKsXBqrX07IBkX37kEe3643gk1m+wU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXzALqBp71bNwO
 YBCmg5s+0MQ40J2ZppV7/ax0/+bBDK7PtceCmTNSxGIRb1lfhjkRPh4pPn7sGGp5JRpqmLCrQ7z
 8U1Z75ygetmmntUWY1Ru1WL/D0zfchGRC0WBIPfaT8EyfSrtg1ShZdfyz6lRixKjGWGX9xvmoL1
 3507TKZmL6j99Sk1IDNOvdjam6OiFep8z5kCMZw3DmuivKOJqxP3i1atP0rnJQxLzWLYVctyNJ+
 5NbHZPoi0bvKz2s0v5wzIwvihTTrbcrZ1E+sh0sfxEkGHZ+A0b/Jyn1/SZRFWmQ3rH1LsafA5U+
 /NtNmjoskYpJvYGqgbqAm/1Dvhabp+Fd76Sx+/2i2/nnjFdVSvnMqgCA0Doh9bjNAw6XxXzuBmL
 dsXkaMBvl6OuZXQdsEoQLkJWiUXAJzeaGbVuylH06Sf0UP+t4Uki9Gb2/gFYfjHLLGX2BeDzeNN
 x/xX5WgzI4ZP3YgOXrw==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb9cdf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4zGFQnvuUtQ_bt32bIcA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230067

Provides the functions that initialize and release the data structures
used during live guest migration:

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
  and .migration_get_data_size function pointers).

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 97 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 41 +++++++++--
 drivers/s390/crypto/vfio_ap_private.h   |  3 +
 3 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index f01a37e4c418..ba86a1afbb33 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -119,3 +120,99 @@ struct vfio_ap_config {
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
+	mig_data->resuming_mig_data_complete = false;
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
+ * @mdev: pointer to the object containing the state of the mdev
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
index 345c52a328ad..9cbc5ecb19d5 100644
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
@@ -2059,19 +2069,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
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
@@ -2397,6 +2427,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
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

