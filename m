Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72487348445;
	Fri,  9 Oct 2026 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546193; cv=none; b=HdJhS1FdK2moYvvjdj4ThPzCHBS/iIYfaVGiYL19DP812dZV4aitT4icuOYWLXbpLquE1h/rjeETOUockT4h9hSet2kAQRC5ro1i+9NnOOwoRWuyal+sYV3pouyb/OHnUTjiFV2AB2ej4neWMlorbaWxOxzzvBTLrfbTXJeArGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546193; c=relaxed/simple;
	bh=+Rbdu+WgpNW6/SBsqHhhspwj6McxfRrHzIWBaOEntD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbaIdaGfBF2OsMx8QkSs+sHAY9zhK0AIsSCyqiJjimINewe5G7ftFGzOM2HJMNj/ZUjhaqZQjGD4cyBLyvZq1daRFArHWtf2p4Z+flEnkMv0YWItkljKhsBew1L/jw+8V/5OsCtiuOlOnGbPfyALWw9YIMEtGs3qpYWSJ1bpbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmIhlpCV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmIhlpCV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZcZi3773990;
	Fri, 9 Oct 2026 11:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I9uqpLTnMMtLgmWj2
	VdEU3TCKGd/jzaFx9yFrLdBqqY=; b=FmIhlpCVdo86XZZCysGBQfl+b2fL3IO7Z
	2saHnPak3EsN3S30K3gSIQT8Hj0KQ3ZXqGXn2alegYCiDRjyjWzHpZ5YaXQiwkAv
	mYlJCrAvYfxCyk1UcQqpJ6qZKAtlyHZLgjZ8KIfYUoZFab3a6V9EE/Tzux78gIpw
	2vSr0E/Itw6hcDnahW0ojvZEeTWHPNj7fVQ0k6OTQW2nna+WoR5WXPhbK3i0z0Qs
	fTRWIJqFyKc36qfDxoobgT0CsYx75UGN+JwKmUFI2XX2qx48E4ouBJFLvcFu5YWA
	h1/Y3mipCX+yvWoxuxY7WSeJb1MsGL/ogzQzoOyhZs/yNp5wezxmQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjcj8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I51S3538395;
	Fri, 9 Oct 2026 11:42:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u2rv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:42:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699BgsSU32047624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:42:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6057758056;
	Fri,  9 Oct 2026 11:42:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFED858052;
	Fri,  9 Oct 2026 11:42:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:42:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Fri,  9 Oct 2026 07:42:33 -0400
Message-ID: <20261009114244.1213173-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R0jXcuudwY3k7iWqkYp5P8oHRxIe1sWt
X-Proofpoint-ORIG-GUID: R0jXcuudwY3k7iWqkYp5P8oHRxIe1sWt
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8d340 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OlMDtWmkmZCoppm_HCYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX1+fTdOSvNRU4
 QyxII8vILZTPeSIFZX3MbaH5T4ffU/qoPTU3Oibk07dKv0l+24QpHyN6MWFOyq1fb6Bf6AdfHkg
 jpkqeka3+YHWEDPUQJiKJnQMRctD6JsEzR5i7EeqQf0VSzuJnooky+hAbUZy4IJg7d4+QAJ1ieA
 1SXGRdEnHJOv4qrSeREbbcn14CJFqRuZURiu9XOgdrFcyYwCjNNMSf+Gra6ODeitV5rREvJ5DIr
 OZj0Ioq+1HFT+JpZogIk54ovGbcbxqkhJfp3LmJZyTXxL24ZGs7Sy8qKPYYPLlAoZl/lH1XBe4+
 Seibh6lNqNJRmDwXFPilEGOifMkKjTUnU5gwJ9H+3lh6XTKefhqhBmnw33gc548np0HALLMeSyF
 APKjiDXBeEPXacEohrevfQm5G7EIeRQkyhJHLw0UVK4IOexxWY0DdaLARnIxfzr/tD2UyPa2JSF
 9f6FAq/gHpa71TNKDpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX7k0iEtjGp0pl
 M9Z3a/bG50pRFpPzGSy2i2pekr/khC5xlrf3OlbtM5/l/E/dAvA4dw4MYfMsQ1son4Z3AxQSLnl
 FPGZidqfdzTw2IAi0E5/xYIdb96/WnY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 11 +++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5d912b1b6b88..5b17e3b58a80 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -246,3 +246,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+/**
+ * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
+ *
+ * @matrix_mdev: pointer to the object maintaining the vfio-ap device state
+ *
+ * Called during VFIO_DEVICE_RESET to clean up any active migration
+ * state and reset the device to RUNNING state as required by the VFIO
+ * migration specification.
+ */
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	vfio_ap_release_mig_files(matrix_mdev);
+	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d62f501ab5e6..3095e771b6a5 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2336,6 +2336,17 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		/*
+		 * Reset the migration state unconditionally, regardless of
+		 * whether the hardware queue reset succeeded. The migration
+		 * state tracks the AP configuration transfer lifecycle and is
+		 * independent of the hardware queue reset outcome. The VFIO
+		 * migration spec designates VFIO_DEVICE_RESET as the mechanism
+		 * to return device_state to RUNNING (e.g. to recover from
+		 * ERROR), so the migration state must be cleaned up even when
+		 * one or more queues fail to reset.
+		 */
+		vfio_ap_reset_migration_state(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 6fc10e0d934f..79cd378c30d8 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -175,5 +175,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

