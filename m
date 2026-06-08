Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B753D7D6C;
	Mon,  8 Jun 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939223; cv=none; b=sR5+H/ZDNbi0ABaUPzZC0dNWpaWJgl8nS8g1qTlXle/gNkOn3EnTFMczUAIIp0nyRIwvu/fCnZ5jJnGFuNqWqYmnvWa+ZckJBUMx81hOvmdHjN0v28jeLuj8ivAjxH9bzP2awveKaujl0/IRL+9xSAZB5drmUmvRkL+5YxIvKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939223; c=relaxed/simple;
	bh=CBrkamJy3FIYuK1gFczZaD8DxdodxAq7HlhfYfDLaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ9JMrIdFNo2u95bGaAFfQbwYnDKNMHXWyWqavkJruiEPfymB4Oz1sf/FDQOJlYKb3+Y9K5C3r0/wElo/OwS1jlSLfs+X0LLvsrUOVVC7cfWhmgzbYs8QvtNAaIGsXEqTsr8vjFIZk6cSoi5JalJR2pHslhzZsPeFi7giZONzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxRbKJAa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxRbKJAa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BggrW647384;
	Mon, 8 Jun 2026 17:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5ft+gZUk5hSgkcxbd
	++kdstLQcsgFedkiN78GilRTfI=; b=hxRbKJAadWtuiMqJUPYracKplBPN4+iNb
	8CoLkzDOIsnH5nXBXczh8GTIamI+qvzpmwgE4YMWKmSAAtV9WQCegrqfHDqvrwvX
	gy2jc0jCmYpPmc8FARwBcBhFsHBnD94BvXhBPls9CeL+7cnFEhZAHuFHuk3lojZn
	pmyRQqnMDFzRLtdZ44nWm4v8vBuULTZOV+9jaYcoSbMAkptP4+WOP6N8jb08zxqw
	5cpVlAnc0iUgGh5+hW2NA8ACvfoZnZjjn0ZNCMwXFs5xwZsg65PZZwmnjD5ptiY+
	+pWQx4QmBTNgMPS61H99YzavplKo2IOv+sW/fd9c88lT36wr3NYCA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye0en9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HJeHN004039;
	Mon, 8 Jun 2026 17:20:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vxf25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658HKFTo21496480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:20:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 943635804E;
	Mon,  8 Jun 2026 17:20:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B82E58055;
	Mon,  8 Jun 2026 17:20:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.81])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 17:20:14 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v3 3/4] vfio-pci/zdev: Add VFIO FMB device features
Date: Mon,  8 Jun 2026 13:18:49 -0400
Message-ID: <20260608171850.62829-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608171850.62829-1-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX6QURuQ52S8VI
 PZHHn//2v7JrcnFaMubNQYN1n3O/bGyWrmtkQBL3rgBZbtvAacGePjk0pRmSKhZ3Bzkv6nHuiub
 xDi63lSMY6XqxO8fASNXVZBZJSSufmn92/wOTBDRo82lVzojcApl7eMlItuuJapuqc8KoBVN/+4
 Ts730MDfytL26ZSoHeLAUy0LzQt9T409dhmxC2ODfYMFy7zRWo5rGKfcbRx3xIci8jA4ZfqWAFC
 9xZrfxMkyrzXCrkG5m5APNBuODB8HttMCHw1avYhn8uRU/FQd4ybV4p9wtQNM7+xJJEUbMZALXq
 opUY/hozPU+5hki6ZZOIrH3E+qY93G67qQBdtJ64pLxTz/j4JjDKx1fe+jygPjS52YWnZoMmmJJ
 PIap3/4V+wwgdd7Vu40MlPoTf6IMWPzIXD2BjWREMJntgmoZVjHt7gyng51CPKdYy2tL5PWBh3f
 cnqoPONFHzkBLY9DGtA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26f9d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=wtvrgtD0Hc2VqHSVShsA:9
X-Proofpoint-GUID: BpqdmU9PCgIo3C0NkkAZDOh3ORdTwsiZ
X-Proofpoint-ORIG-GUID: BpqdmU9PCgIo3C0NkkAZDOh3ORdTwsiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace.

Allow the user to enable or disable the FMB using the SET-only feature
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
in the case where the FMB is enabled.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  4 +++
 drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 57 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 ++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..44e8e5526eae 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1569,6 +1569,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE:
+		return vfio_pci_zdev_feature_fmb_enable(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_FMB_READ:
+		return vfio_pci_zdev_feature_fmb_read(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..b7db064a6a95 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -93,6 +93,10 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 				struct vfio_info_cap *caps);
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
+				     void __user *arg, size_t argsz);
+int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
+				   void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -107,6 +111,20 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 
 static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
+
+static inline int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev,
+						   u32 flags, void __user *arg,
+						   size_t argsz)
+{
+	return -ENOTTY;
+}
+
+static inline int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev,
+						 u32 flags, void __user *arg,
+						 size_t argsz)
+{
+	return -ENOTTY;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..09454495ee23 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -167,3 +167,60 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 	if (zpci_kvm_hook.kvm_unregister)
 		zpci_kvm_hook.kvm_unregister(zdev);
 }
+
+int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
+				     void __user *arg, size_t argsz)
+{
+	struct zpci_dev *zdev;
+	struct vfio_device_feature_zpci_fmb_enable fmb_enable;
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, sizeof(fmb_enable));
+	if (ret != 1)
+		return ret;
+
+	zdev = to_zpci(vdev->pdev);
+	if (!zdev)
+		return -ENODEV;
+
+	guard(mutex)(&zdev->fmb_lock);
+
+	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
+		return -EFAULT;
+
+	if (fmb_enable.enabled)
+		return zpci_fmb_reenable_device(zdev);
+	return zpci_fmb_disable_device(zdev);
+}
+
+int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
+				   void __user *arg, size_t argsz)
+{
+	struct zpci_dev *zdev;
+	struct vfio_device_feature_zpci_fmb_read fmb_read;
+	struct zpci_fmb fmb_temp = {0};
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
+	if (ret != 1)
+		return ret;
+
+	zdev = to_zpci(vdev->pdev);
+	if (!zdev)
+		return -ENODEV;
+
+	guard(mutex)(&zdev->fmb_lock);
+
+	if (!zdev->fmb)
+		return -ENOMSG;
+	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
+		return -EFAULT;
+	if (!fmb_read.data)
+		return -EINVAL;
+
+	memcpy(&fmb_temp, zdev->fmb, zdev->fmb_length);
+	if (copy_to_user(fmb_read.data, &fmb_temp, zdev->fmb_length))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..3988e8690e0b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
+ *
+ * enabled is treated as a bool, so any non-zero value evaluates to true. This
+ * feature fails on attempt to double enable/disable.
+ *
+ * Returns: 0 on success, -1 and errno set appropriately on error.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
+
+struct vfio_device_feature_zpci_fmb_enable {
+	__u8 enabled;
+};
+
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
+ *
+ * The user-provided buffer must be at least fmb_length large, where fmb_length
+ * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.
+ *
+ * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
+ * when the FMB is not enabled.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 14
+
+struct vfio_device_feature_zpci_fmb_read {
+	void __user *data;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.54.0

