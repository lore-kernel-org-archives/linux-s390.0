Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978613;
	b=0if7EvurxXacRlRRoFeEFDAXEgkvhHeyAk7JjQ9YVVlYxv/EsVoMsXfgSTYDQuErpMkl
	 xBgC1jf8uSZgpnLHWmDA2KZ9uMxKvhUzaxFQmjnALtZe7W5x/A79TChzbNPmVaZNtCRfp
	 SjkofvbLpMbEbPVn7ZtshE9JTH6QiiEvigfyT4nPnlIjZ1lLC8mezJvzYAr9VTFOJU39+
	 CJbFQ4Ngz+agTDAmw0EJznafKGn1pr0bqFl/yMBEJo/71Vt6t6q0l/fhfhuhemfdBApU/
	 c7y1Nt9ypp1mj2RmWPYs5/vSOjjoYU3zfanNc/S8eavgl2lI7NxiHddNMSdSJCVe6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZX38sRcqU/3qJc7kmB9k5dlZiWn18NqAnxxTQpxKp5o=;
	b=q3Ve44r8dvfYsEYdLPTCpnooC0TcO1szHaSXOcgmC1ZlfBd47q0Q0x31edgFJSDXpOpk
	 4oG0SecfRCXQxdTVCL693awXKqObSK8cuS+dFYNG6Ku6ZUMWyzO35c8Dc/hhACVgq+TZK
	 9ij/Ag/QTmiB4BVROlDX0+SAFvg2zORmh+QJj4DqJvki0PNccQXhO7sv2Zu1IjDPVMJpj
	 TsFSWswJfiUFrH7x3iPDOzgpMc9QSR/VxeiWkO0zlmNWdXsrycvWe2mylKMP/9LCr6jjn
	 37ZuYYN5dyWb8XpLwgxwUUFdjN0RM+P0uwR6rcxoXYoItpbKTYQVDeyMWwbHkVMJjZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q3Dx1hC+;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03ED6082BF9;
	Fri,  6 Nov 2026 15:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03ED6082BF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q3Dx1hC+
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE5651094480;
	Fri, 6 Nov 2026 15:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZX38sRcqU/3qJc7km
	B9k5dlZiWn18NqAnxxTQpxKp5o=; b=Q3Dx1hC+GpUqBCmiVLZlbTA8rNeKA4HSo
	DrcH3cEwzqc3ExmaUT2Lg/X2eHdtw0rEBu6BZpxkjMY+TCX3KgCAi2+Ks9ApJgZJ
	Kni67k/DSSRw8jkOOMnABBh5zEzt98VHp8UElSFQuvKBJ3ZTQGKbVOfsQU/E4KNG
	un7gt7YBU3DcGjMvzP4oFkm6doPKOYZ6L+vgTO9E7yFOX9BTy0zkjZoPPYBFBupu
	v9rcnh4j5saCKv6D+df72/1Yh4b8V5WWjKM9rZzynYmKqLCVWOcbbjMFJ5MGOfet
	9eGWJHNawOQUjZHJsMkjiOStuFfJtsjg+fBAdE88Hn/ZW7GWrgJAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raw79a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xxe3617252;
	Fri, 6 Nov 2026 15:23:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ua24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNOCL20841176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8656658054;
	Fri,  6 Nov 2026 15:23:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A385804E;
	Fri,  6 Nov 2026 15:23:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:22 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 12/14] s390/vfio-ap: Set up for vfio-ap device migration
Date: Fri,  6 Nov 2026 10:22:57 -0500
Message-ID: <20261106152259.1360651-13-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedf0ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=HPJWAd_ergi89gPIvREA:9
X-Proofpoint-GUID: HEGfbKWIGUahVXJfuGrbb3kvAlqestA6
X-Proofpoint-ORIG-GUID: HEGfbKWIGUahVXJfuGrbb3kvAlqestA6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX+7FgMIwyCH6A
 WmDXGiqKnLsUFEUpej5XMHUane3Kj2w6jIhXs5PrlGWexORrVu+FpFpRP2GOzq15sXj/eHut7g2
 Ws8ld0wdSqh+8XMW6QrJaLicikRYXH8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX2pSEc1s6K4mN
 3VLGTHlNF0x0yhQro5hwMVB6RS6XffMFZFITHQYSNLTiIKcmAYrz9s+fdNUtyGQ4SKjjnC5Rfrm
 egUsoXJUVcb7Mupci1xn9YnRfbEDdFXpRDl5oFtAL8lNnsQgmoZJcKD9/n3GCI5iAVLNqqa9kOo
 qqJMsYrJtkFPiM+zhhEA/imq4rqNwxMx7S1eBhqQR4cryOO+yG9hfuwp8mgwo+zAfW0OKg0zxro
 KQCUwA2o8S/Xni/3QRcW8P8ORT+dIQ9ZZQTb4yX2NNochiWZcjaib8WvK2HZ7fkv4lSltVdnioH
 BXeXgG24JPSOPw7VH2ODv8JW+pt5Ir0CtCZScvCjDkPLtiKRpcY1jwbm+T4RjUun9V13NCmvIla
 DAx3cWMKexF8+W8qC9lKpW6vIIE2iRS+bCLcpzihVb3DlzqgWXMT9FxWLlsPSMQq3RJvL81IVzV
 XvScVLO95K6flzB8odA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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
index 4af734aeee17..924c25585987 100644
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
index 8d70089eb9c9..52de74dc2c6c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -811,9 +811,19 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 
 	matrix_mdev = vfio_alloc_device(ap_matrix_mdev, vdev, &mdev->dev,
 					&vfio_ap_matrix_dev_ops);
+
 	if (IS_ERR(matrix_mdev))
 		return PTR_ERR(matrix_mdev);
 
+	/*
+	 * Set up vfio-ap device migration before calling
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

