Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B813AC0EF;
	Fri, 26 Jun 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496607; cv=none; b=qY5gamRWN64zDwODqKc/sLyHsWC52yc6zaEQQOFTXkr/k5cOF7Zj/IJrgLMbtyiG/2SUMBGQTo0usIzmUvhTAArT2oBumGfF5emVx1uNVt//Zh4UcrmxY7bdoWGZaY03LX7KH7NVEoquzhvmKDAdu2UrFwNtlaTyemRtEbtVUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496607; c=relaxed/simple;
	bh=MOR4tpfxZXGEuYHiTRkM8kHke3eLR49y2GkM1xm+tho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEDCi3zMi7y45Gfsahza8VSDdb+dYSjkNhPbAso5UvIruQ10DjAVH8Tl3IcvbZaoSkUP/b4Vq7iw7LlvKsy6M9l8VN2zl40BbAmoNSrUOHmkuri9WKP9yV54vFHW3TYkjkja/8al9gLsGrUGdER4wfXW9l1DyYnIc3LvDnUiPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IQHCKw4c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IQHCKw4c"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFnSHg3362043;
	Fri, 26 Jun 2026 17:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k3tN152VR3+0fscds
	OcC/qd/je8aMITruXbM20/OTdM=; b=IQHCKw4cH9RfkuJJYVRQF5YrWm1/xcXQN
	AHSWLcYMShJARfhVYkSt7KqPCPkj1poZLo1rJeIzn2acvQTboW5D2fjdEVAe6qUV
	oYwP6ytk0PHC1c2OHSIpxptnaWnFQ6L1WZuMBmujl7TWv1QXA4aMmgPR6lxOybuz
	xyOQhty0dtwxYNGurdWbkERplIt1SY211DIcCxE86h/Oo2SaTEx8PA1iZQWy2B/j
	c4mGGRSA6QSxrKXPLvG1rRxn+1E7JBqY1SWPNi6cn4FWt6m+Ce0o9hSOjeg3ePfM
	JiZ4wF/KO2OsC29B4nr7Ntovg8aLAlT1eoLszgXf/3ePtWI7FG5og==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j86cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QHnefH030639;
	Fri, 26 Jun 2026 17:56:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w03vk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QHudMk15467226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 17:56:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1D8658050;
	Fri, 26 Jun 2026 17:56:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EACD58054;
	Fri, 26 Jun 2026 17:56:38 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 17:56:38 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v5 4/4] vfio-pci/zdev: Add VFIO FMB device features
Date: Fri, 26 Jun 2026 13:55:25 -0400
Message-ID: <20260626175525.37370-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626175525.37370-1-oelghoul@linux.ibm.com>
References: <20260626175525.37370-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O1P0Nsd6nmUt04Rlktb23zjkugoK3Apo
X-Proofpoint-GUID: O1P0Nsd6nmUt04Rlktb23zjkugoK3Apo
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3ebd5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wtvrgtD0Hc2VqHSVShsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfXzZKDliwqrI3c
 oedw6xKADDy8s81iRrMsO5h3AyLnLbHVCTbkjOkkjoKXzJB3sD5siD2Gcj5PBx34Iu4hjwkdndz
 tiI9TUfDozRJRQbGjm8ZDFSm5enGRDU+Ys87HJjXE3c13HFK6545MH8g0nvA/bjjpXVeMCi6+tA
 S8W7OeA9eMbh4oJrcOz7H9tlWIHn21rmQ7voAauBD0jAQ70OQBnhAD5gRQh8a7gzyy/6Xtw6BbJ
 4UY/u3vjKnvl+rF2HgfBPCkOCdre8WwURQy9ngtU2mqGlcK8/WlfaJgn/Od4jvp2tTBO6Ok7ayy
 1n4lu3i5stVrCFGgEp5xyX9VxWawcLIc0HyofZPHx104VXcELqGepWJnIw5Wa1ti4oPwAiUjZmj
 Arv7vN6YrCZ5GaxPiRsojWfzz+sV6/MBwmvsdb59cB0l3dwTAciNSOF0LhldN/LhnNfIlxBYD7h
 mkVniWc9kFLeBFwiCiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfXwtLaQeFP1Wsp
 wq8mkONI6Rdx6BnLbmyTwEWFeNmmDRg4f65Qh2+jeHvlbiLRYBqJv1dkLOMaHOFw5r+hXDlDekS
 978dgiyp65oXQmoDaSv1Id10uW1gofE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260148

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
 drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..a4b0717ba8d6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1572,6 +1572,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
index 0990fdb146b7..1bd359ad6e4a 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -167,3 +167,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
+	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
+		return -EFAULT;
+
+	guard(mutex)(&zdev->fmb_lock);
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
+	struct zpci_fmb fmb_bounce;
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
+	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
+		return -EFAULT;
+	if (!fmb_read.data)
+		return -EINVAL;
+
+	mutex_lock(&zdev->fmb_lock);
+	if (!zdev->fmb) {
+		mutex_unlock(&zdev->fmb_lock);
+		return -ENOMSG;
+	}
+
+	memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
+	mutex_unlock(&zdev->fmb_lock);
+
+	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
+		return -EFAULT;
+	return 0;
+}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..2b1b66eeef12 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
+ *
+ * enabled is treated as a bool, so any non-zero value evaluates to true. Nested
+ * enabling resets the FMB counters to zero, and nested disabling fails.
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
+	__aligned_u64 data;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.54.0

