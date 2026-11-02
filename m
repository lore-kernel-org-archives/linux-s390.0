Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632579;
	b=Y/2oYTlo33wBWJ3NoC/QbZryp9jqLaR+f8EBaA7E28yibIBkbEwzEkLlW1xNA2KAGCG8
	 Wo5aBKJWpuV+8Vi0zf4L4zr3V9lDvGUhT+77jkslEaBPmb3zxegAMlpV2GmG8Vq8tGlKE
	 EZsqDUUfHdEhQWcqBd5Wch8526s/vye94rufI/UGq7pCfUETG5gOlJjSTRCPbwz2zS7Rt
	 HJ6GQQF2lsEHGSt2jzZLsC9gW/uS9IBGTwm+uHAh2r2OInv1XTmT5EEZ+fAgsRjGEgMWN
	 kKuNnWiP8ftL9P52YlZaJFOYABn2kaexeRtjtUCfdP+0uCJpXmfgpAF7Horp8NO/upg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632579;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t9tzNOSfGAdvZJEvXwMCeko+7i65W0qdVbWO7tUDDFg=;
	b=L6TAUt1gx4ka6ea7+SwISH7bkiy0Xv/V4KdG14w8E+WQuFX7vbNg1ZyMSPPIQZQ68fVM
	 luXjCRUZ0ItWvepy6p2FUzVCxAvk+QQPEt15OKR6DnO93blX6uobmTCXsqqbP5T8Fzwot
	 hnO2+p2NDa3mPfY7Gf6zhaPeykAbqYW7WAE+Yg9fRPFAAGR6lHH+wTKSp+xF/nqXDlRtF
	 9ASv57NKfwOdSM50/zZAE3hVHreAi6HU76FyPMz7sHHDPuJEmIJCMEuPPkLRm3+N8N3Dg
	 lmoITidWuM5UW4gLX5NCaIPvwJIzdyWw+WfNzYAr6BZyU39IX500KaN4c8wUsjqD+4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WedBknEI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096E607BD31;
	Mon,  2 Nov 2026 15:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7096E607BD31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WedBknEI
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EE8a43103376;
	Mon, 2 Nov 2026 15:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t9tzNOSfGAdvZJEvX
	wMCeko+7i65W0qdVbWO7tUDDFg=; b=WedBknEILZjqNe2TTKTgJ/mNNr1U5Yo2X
	ztS8Iw7RDPVEM3Snr8z/pQ3NJMhDJn9RPNoi1N49uCYq0Dp3zsVSn2zsllZY5lLY
	iF67BkcwqzBoHb24USfm2MUqZcAHh07yLJVkqsK1iqWxfESYzK/h6OqVta955OrD
	4j0Zp9lvucYuQv4QBs6p2t7morSfDUFSK7pMEk6rdGpPEnzEm66cDoGGymTn/xNJ
	+zxdYWlotvZOQ9I055fdQD8Wa5co4RN2VzXknPO4btImCfZj5w8/61zVEd1B/e5H
	70xosXVKRuBEINJkNgTQJ42j9XWqe9km3vHjNQIRlKHHEsS1R1h9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h8s7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpBP51068948;
	Mon, 2 Nov 2026 15:16:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gpd21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGA0j55378206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 815CC5805D;
	Mon,  2 Nov 2026 15:16:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A36A58054;
	Mon,  2 Nov 2026 15:16:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 03/14] s390/vfio-ap: Functions to initialize/release vfio device migration data
Date: Mon,  2 Nov 2026 10:14:43 -0500
Message-ID: <20261102151604.2150055-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: HGg98o_ofVfwEd2OpkqXrABIgVo4_mlh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX6WFoKqNfwT85
 hIAdJ5yF+L4INZP/JGwOArVSVA1uWxo3o9PSfA4mTZorXdGwwJAFxfbzifOXUT2eKmpCcPrd/JM
 +fz/+0xYVxcIMNFLrbrI+WCO6ifAhwU+k85fdfmETXmVy2l4+8vtNd1K8a5ijtO2qru0MtxNbxv
 GX2qqqdzwwSz31ojwR+XIXnHELY4gThrwug/GltTTixV4uX+CtdZMqqxPXcuCRva8ThvrUQXvfn
 AxySM+ONC2qJ6YgJqsJYUTtJKXZeTEdbHNfqQLoQ61LdmyS5avwRFnCVlfKNS8zlR4UfPXDlSPv
 bzBFYgW3TcTs/4urLpUBH7O5zlo2/uFuqXhnjfhqw3/uiZW5hpJbZ1qRPEjg5C+fxEMc+lXxOvs
 26ZWa32xKYMOE8VmdYm7Bsdb8Rt+uCD+dolwNT5KmlIkEg5ZqpMNcNNObHfEIvJpR5H1+3G25bl
 eKa1dOFqSejiydAe8Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX5udzx4kI7Tq4
 wTjHKLPAT5IM79F9drjgk4jr78SawK1UiTXL/llfs8evrKRV18SW28SyagYFNisAvlUsVPEgK3v
 Nzp1uzaSej/DFZxTWTWUb4EtuEkhamI=
X-Proofpoint-GUID: HGg98o_ofVfwEd2OpkqXrABIgVo4_mlh
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a93d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4zGFQnvuUtQ_bt32bIcA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

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
 drivers/s390/crypto/vfio_ap_migration.c | 103 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  41 ++++++++--
 drivers/s390/crypto/vfio_ap_private.h   |   3 +
 3 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 2a0a8c76f820..d525dec782a1 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/file.h>
 #include "vfio_ap_private.h"
 
 /* Magic number and version for the vfio_ap_config migration blob */
@@ -123,3 +124,105 @@ struct vfio_ap_config {
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
+ * @matrix_mdev: pointer to the object containing the state of the mdev
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
index 83ba4193bdc3..8464d2e86d3a 100644
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
@@ -2067,19 +2077,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
 
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
@@ -2405,6 +2435,7 @@ static const struct attribute_group vfio_queue_attr_group = {
 
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

