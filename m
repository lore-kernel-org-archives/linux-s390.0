Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632590;
	b=uLnpENNd6PegfkBTW+/NzWYGmaHA2DJ28yUXkNXfYuObZny2RZOEO0xupB54FzPgMJVP
	 ON8ieOBlhJqLk64tXV9EPGRAdbEyjNZTXIZ/gLl6rDY7E5ACIfVIP89PeN8qOBST9mepm
	 rRzNqaHeDuzIP6jd0IxgfZm22gQWf9IFDOC53mR297OP6q7hiDxzTSkHZqaWx2lUEv3G6
	 lUm/ELVHcJsTj0AFvQxwmFHs2tUngbxiC1uKU+dg4EMCcjLT5pJqme8g9Ge5TZaiC5ty0
	 Eb3y/I+ZIA97CDGhm457C6elKIpqZPl3EfKculhTIQIJMAttoP6BVST1r4K7+1Z5WJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632590;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SEaPWp3K/rPaeqRnCZ/8y39yKjtG81qXXQ+0xI2HXtc=;
	b=4R/eAQ9a/LmTUDchF45gyB8C9Jnswi63iEToCPbUrSvHs1Gnq8eWC2H7tAF1IgTdFtVu
	 SoqvHCHTV6K4XKp4k74YW3acGX/mxSb5MkYntawRTSm3iG95rEXic1GmcdDInhEGxaQKZ
	 Lx3fbftETrdkVSeN1aknuZi5TT7F+CXNPU4RfBKmzp4gk7FSCSZ3VzcQRdi1XXExLJzbJ
	 AiUtjcul0dET0IMKKKOzuezUsVFZthBFQOsqAeSrEozvWRHV3P+uSVQsFPMJOMm7ikX+c
	 o2A/ArzSPtnJ7RihykL0csxge8t+bFtXK9Yn+dLlc1Q4Tue094PzMQsjib1y86thDKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DfvNIfUu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AE6074A7D;
	Mon,  2 Nov 2026 15:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D34AE6074A7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DfvNIfUu
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEF2v3103445;
	Mon, 2 Nov 2026 15:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SEaPWp3K/rPaeqRnC
	Z/8y39yKjtG81qXXQ+0xI2HXtc=; b=DfvNIfUu+lUUHxrrVq+BK8J6Rqc4Lk3rr
	ZL1bCmk3WtDLEFp0X4X9eaemXeeQemvdtP04x/qVHtqSKI31sDlOcuGdzPY9EApG
	L/haYyNqR+AQGv/LmhewgIosIeVYo6lEzFCG6KYwaF+pyeWqiE6BeoDCPIblb5s8
	K9J0sYCkjq+TEBehSxiIUnmBXX8l4Qd3nbXtDO6cLZOWD3VMGnpWTocIbzDqPVxg
	z3virs+GfUCzXXvTres3n0kV4FzJ+KgaGT724VxgxIu9yRnbepWZHQ/QmzY98vQy
	hgb7Jh61EESx9Z7X1m7GcdswgtTIg+G5TXG5PUrkOvLE9fZJvyNnw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h8tv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp8Tl932243;
	Mon, 2 Nov 2026 15:16:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxf5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGNit59376040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A95D58066;
	Mon,  2 Nov 2026 15:16:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D555805C;
	Mon,  2 Nov 2026 15:16:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:21 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 12/14] s390/vfio-ap: Set up for vfio-ap device migration
Date: Mon,  2 Nov 2026 10:14:52 -0500
Message-ID: <20261102151604.2150055-13-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 78I1fCQMcqGC3S-RtO2Fn850nobStURy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX5ecMDKnRgS7x
 J/oDidwv7MbgIga4EOoOMSpRf8TfTyFQKdtQqpy+pxVElnBxyvQ80hEyEjICIOtWAAnQQUN+gL8
 AprN4v9Y4yvAu6hmV1nQWgjoGXOu+132rdcqRybELX8Va/+MjoU8j2+/cm7BdO9ipf4MJpUWS7P
 FNObyX1t1cGliSmkmYUozPRd/I8J9mho8M4qyTxoOBgJNTGntjaMwLF0HRxlZZHhvbPZOVNYlBe
 ndpCvkQ6bzsdLjqBUvSHXUYxf/x/1T3J2aH0unNahdsFOxPtV2OFgOvpykCzNgn/O7R3pwe+Okk
 xLSbjRFK8YXnu+PRHqnCdQ97+H6MN1u88bte26l6db5uhgHfhshx2nvrPBKN8kiW6pl9Gg94N+U
 +ajQEYt10oTIFnxrNgicURRTFBIAFAVoF0ED29jGh3P9FQw/Jsos1wywuWk9+xwj3fvYplF6OM4
 S1kEHzqK4bqUf0+eplQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXz+VbhFiBEPzU
 d6S/yVVTDLoWIy1NgBZCjebTTFRA0CI2hNqPV2AbX1rlnLxY2QeD3mY1iLcQ9Th1jb/rwya2Qps
 NAjsAqDeUQV0gBuqfzonKhb71PUlNOA=
X-Proofpoint-GUID: 78I1fCQMcqGC3S-RtO2Fn850nobStURy
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a949 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HPJWAd_ergi89gPIvREA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

In order to facilitate vfio-ap device migration:

* The function pointers to the callbacks used to facilitate migration of a
  vfio-ap device must be plugged in. These function pointers are specified
  via the fields contained in a struct vfio_migration_ops instance:

  	migration_set_state: Set the migration state of the vfio-ap device
  	migration_get_state: Get the migration state of the vfio-ap device
  	migration_get_data_size: Get the estimated data number bytes of
  				 data that will be required to complete
  				 STOP_COPY
* The migration_flags field of the struct vfio_device instance is set to
  VFIO_MIGRATION_STOP_COPY to indicate that STOP, STOP_COPY and RESUMING
  are the migration states supported for vfio-ap device migration.

* The initial migration state of the vfio-ap device is set to RUNNING

* The boolean flag indicating that all data sent from userspace during the
  RESUMINMG phase has been received is initialized to false.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 24 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 10 ++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 35 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 7c282d396f50..57cfaafec4d9 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -217,6 +217,30 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return 0;
 }
 
+static const struct vfio_migration_ops vfio_ap_migration_ops;
+
+/**
+ * vfio_ap_setup_vfio_device_migration:
+ *
+ * Plug the object containing the function pointers to the migration callbacks
+ * used to facilitate migration into the vfio device and set the flags
+ * indicating migration states STOP, STOP_COPY and RESUMING are supported.
+ *
+ * @matrix_mdev: pointer to object containing the vfio device (vdev)
+ */
+void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev)
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
 /**
  * validate_stop_copy_read_parms: Validate the input parameters to the
  *                                vfio_ap_stop_copy_read function
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 79f016a43f56..d4585ea73383 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -811,9 +811,19 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 
 	matrix_mdev = vfio_alloc_device(ap_matrix_mdev, vdev, &mdev->dev,
 					&vfio_ap_matrix_dev_ops);
+
 	if (IS_ERR(matrix_mdev))
 		return PTR_ERR(matrix_mdev);
 
+	/*
+	 * Wet up vfio-ap device migration before calling
+	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
+	 * will see mig_ops as NULL during the registration. This could
+	 * prevent the VFIO core from properly setting up migration
+	 * infrastructure like debugfs entries.
+	 */
+	vfio_ap_setup_vfio_device_migration(matrix_mdev);
+
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index c6e577064e7e..19772e59fdc6 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -173,6 +173,7 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
-- 
2.53.0

