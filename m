Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777463;
	b=5oeFgB+TFUtSnz8mZcg9pWFOzW8HPI/MFvEXCVIll8IzFQyB/CLYMl9fbNj5w5MLPWbt
	 7g6HkE+2QpxpqW1t4qGXOIio5Sflkv6dvyGD00VGR+hZ6yYO7SSkPQy2QbTdcztvF7wTV
	 PYJMfiuGBtdyN+Q51jKzTZXVh+qRbHntvyTk3zltXsOBnQkLsWUr3v9HAB6J2nSL33JqG
	 Cg9sHOo3AMyF/4EanpeZb5DuoVH9zf6Yb8wAuLkCfcdsAbJkvq6pByH3bWepO+AoirfFr
	 dZN8yvrv7cLftgqIoys85IgSsoOIJYEB5c4LC89qi0eJeh+4HuK9gJ4pOtzxrQ7dAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777463;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BffYzSG3zk+KXtP0dlE5WPHmMvvARi14sXd5Md4g5dE=;
	b=I0JdqNXNNa7mmmq0vhsViZjSqLpVdPxGN4QfjFW34PfBrIoDtxzcusZFpgMvcQghrxan
	 uVm9AdmlayAv0ES/xWjfthCdRhLYG+z14N0Qn5+jjd2Ob6NYxRCEWJNpHeIlDkdCY/XUu
	 d5b6Vymo+RnpNpoJf5cjHpNBCsUW+cTiR5XNSa/CQQdAdtOVzrIxAzUQn8uaPuojFI+xG
	 L9C4e5OQq97ujKAJAGqqVxXh7v12Jfr1VBXof1MWxyQLH8utSqyvOZPK2mFAUMlOaBtlQ
	 QJZW0YzXOFTmrdRONz6f6QD+6VkdVsb/wuiYHvyO03NTn97QLg3pSqicdBnSJMvDYYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEISrrpn;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583C60A3810;
	Fri, 23 Oct 2026 17:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0583C60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEISrrpn
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGqAvR3495814;
	Fri, 23 Oct 2026 17:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BffYzSG3zk+KXtP0d
	lE5WPHmMvvARi14sXd5Md4g5dE=; b=NEISrrpn2eygoFYIQu/0YcZ+a03a9uGfP
	Od5ECjDhRnfT15EkLGLT4g9o1cQ27J1GtWS8cwnGM4Xirq/93jRc9AMD/XRulPZZ
	JJE35d4bBOHnBhKS6KCNVdZv7NnFf7Ei4atEwizHwEZYyvQfJ7m9mobaWhEQ7NFv
	5ghuP/20i/BS95aanjqEVgVkGkp8pkjrVuvxTlizAoWt36vScF2blSZoPR19djyo
	+F4wFs4mV8uBSSvg7uoEck1g8xSHpQmbZdqWHzMKDuWgTBqlCRMkYgyXfV/NrEsA
	bW3L8560GYGqT0XbXXSIkIQN7wW9PSlbJt57U/sQmOXELzDEuNNjA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b61em-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NHfZh21018725;
	Fri, 23 Oct 2026 17:44:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hg5exsqvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHiFMC29622854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B5385805F;
	Fri, 23 Oct 2026 17:44:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9C358054;
	Fri, 23 Oct 2026 17:44:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 13/15] s390/vfio-ap: Set up for vfio-ap device migration
Date: Fri, 23 Oct 2026 13:43:47 -0400
Message-ID: <20261023174349.3545941-14-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb9cf1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Xzg2XN2OUL-0lKxcjZwA:9
X-Proofpoint-ORIG-GUID: XDAtJ7ImuNKWFTJFjwbJXdWCD_KIAl2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX0rLv4gmrGIkz
 59rVIHtMr0Q5DwpojmqyFaqZoJ2QNrbKIh2cALeQ752gpWJF2QpYSOS9dhM2GDXu9YhiC+S9Dl8
 hT0LR9ATPtMyzmGPx5MdulJwbBHa9E7ikK8LkB2Gv0A9E3AklCeiqMylzGnL5uDHHrJcjor3Bhs
 v1Cro6fu6Py+UlAZ958AvFy6fsFqVXcW7TIhDxd7nqNraHbSRCkX37Ab4F+uOX9MX5XIARUKMcn
 xjRaC/GMRPQUl79CrHf1u9yPq+4e3SOp32t3MPMQEvMI4kWIWZk6u9i9fCMvGXUs/X2Rbx06tpK
 rYZgfed2+3ACwIXl0JMsPE4t+vGw0iajLOK81NN++zOgX113V8Dlgidcc54aabqp2CNSrAp2A+q
 yBfp0CbaNo/7KbRuSbErz1ooqufa8yWnaRmDymAc/bsMd4WzFyOBsPAR1XzXgYQWFe6tZbHFSDL
 EONg2+TIa/fhOiYF5rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX0/HRkHMhMOVN
 VroYZcWLYFwDskgf8TXCB4ti0q+RkzpGAJGOd14Jw9P6rjK0vsG4B0Qvz+sfGU/EtU0Fp+OmN93
 sa2vZRO65j+0jkWbVSTTOf5spWpuESg=
X-Proofpoint-GUID: XDAtJ7ImuNKWFTJFjwbJXdWCD_KIAl2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069

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
index 38098968eaa2..660b5a21fe9e 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -212,6 +212,30 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 	return 0;
 }
 
+static const struct vfio_migration_ops vfio_ap_migration_ops;
+
+/**
+ * vfio_ap_setup_vfio_device_migration:
+ *
+ * Plug the object containing the function pointers to the migration callbacks
+ * required to facilitate VFIO AP migration into the mdev
+ *
+ *
+ * @matrix_mdev: pointer to object containing the mdev state
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
index a4eed70b05d8..ee24297d7b38 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -763,9 +763,19 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 
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
index 1324d94638d8..d44188f12221 100644
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

