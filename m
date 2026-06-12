Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD7408635;
	Fri, 12 Jun 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287862; cv=none; b=qaWuhbsa/qdX4a5SlqSbqDjtUnw0SpUFP5zxgxaJS84WyLVIL9XNmZW2b5uCKymnoDmruL1ig2hL1tqgFJGJ9GvIzhWaW1WsdNdCR12Ct3Niwhq6732NYnjEjpzEKpo8lmE9XGBqIoEbly9tMEHjk/Gagu0mKMESXuUV1HYDHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287862; c=relaxed/simple;
	bh=X7JoI+UTOag6Fvenxb27uYoaUdR1ZVKZkca26MhzwJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JheINsRJaueFiIznJ8ZgiLGF2YVgJh8vslGFNleEABfDEvsOz2nBKcfKnmi4srxAo1OpBMxGJPB/gZeXw4EMGTKu4sppQrO2n+fU26GpQtMo0FUo91ax0k+FUk5QHwiVpXndVYKQI+f4UkmJNqudaI7IEnH0K4Ky2mu47QnR404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aa4Sr2KR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aa4Sr2KR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CFCEbO1742531;
	Fri, 12 Jun 2026 18:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7gM9eIB7jVJSrqa/i
	GDI7rSFFyVZ2GXsY/V4LWEaiNw=; b=aa4Sr2KRPHjD91yXVMKi4Hv6E8Bh/6PtO
	kY2Dx56Nug93ZgCf3Cc6RNg+UKLvi6rT/675KArw+kYLN9vNBcVGIg74bEJeLw/j
	nZCKbmUEAd/cAmNRccIxv/K1Hi0V1D5xeB3Q1dqPyF0xi0pvXZBy2q+1UW8XdFPB
	NNCS5L44iMHkyTdtqMcmQlIXIOez9sxmabr5Hhi3XyloPLLXlBDyXC8P3jNA7Pys
	rLbIxT6WM9aqvnL/Ex1cnEOsw4valZgMmNV/X6K37VkbCVmwSOcy1mDe2AwEm4vz
	4GvyPLxdL31/Tfgvtqeo2t8d4LWuwypZjDOvSZ/oWuUdc7wGY868g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bswdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CI4dnm016406;
	Fri, 12 Jun 2026 18:10:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09s2j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CIAsOF28705426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 18:10:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 559F85805E;
	Fri, 12 Jun 2026 18:10:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427595805A;
	Fri, 12 Jun 2026 18:10:53 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.255.20])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 18:10:53 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v4 3/4] vfio-pci/zdev: Add VFIO FMB device features
Date: Fri, 12 Jun 2026 14:10:47 -0400
Message-ID: <20260612181048.91548-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612181048.91548-1-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2c4bb1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=o7ZLYlnJ96k-dGTR9YsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX8m758jtOcptt
 r8eXxp16RTiqokRJFzHj3X3tdXgIrX45zRDvqa08Chd/Ddi4IYVgGiPwWxNt0M804XiX0SIrYV6
 0MDE8DnJepEjZZbqstWXXTASAH+Oub3WqgMWqn4149f2IyxHuOmPzE1hnRHRVgyS2UjyS3O/geI
 oyZtiFaPH5EiW+qgQGBGyWKXL1DMqM+vyYdNHZOp+JaXbwnJOtVLHJt0pxdJSMiusRAaunNyi8b
 w8yuXlV/d/ohOLKV69QO4hwaCZzbq3Guh5QboRKQjIUpomEQyuG5AgM024qsU9JnX1BemvN+D89
 i2gYcz+n+EqgsTB6Z69gEkI366SjgdK/UIM4qXbgCkcxqZrUqOnlWgkcqSqMHy1AyTzHWU2VLqn
 QaD1W2UWw1lZ+fihrq5S/Supe5RO5IdQnAyJ0UW0db0agxmrm7upj1En0X40D44UHeC6JSJzJbe
 ssVnFK8WIfHON/YQ1xQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX80ihRQcuU1rj
 HEfcozQkmBc7exzB1iHE66APL4KyTMXLfsm1800VAtXjAfRCZHu32rzW8Wj+fK6fnAZDQMLNX2p
 QsiD1+i3j/pUyI660d5qBRuW5okvHWI=
X-Proofpoint-ORIG-GUID: g9HyAMrEZ0Ws53mKqkBjPxRKL_cLdxTA
X-Proofpoint-GUID: g9HyAMrEZ0Ws53mKqkBjPxRKL_cLdxTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120169

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace.

Allow the user to enable or disable the FMB using the SET-only feature
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
in the case where the FMB is enabled.

Additionally, when initializing the FMB kmem_cache, allow copy to userspace
within the FMB's structure range.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/pci/pci.c              |  8 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  4 +++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 55 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++++++++
 5 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 21d3fccac789..104a924f8e4b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -1134,8 +1134,14 @@ static int zpci_mem_init(void)
 	BUILD_BUG_ON((CONFIG_ILLEGAL_POINTER_VALUE + 0x10000 > ZPCI_IOMAP_ADDR_BASE) &&
 		     (CONFIG_ILLEGAL_POINTER_VALUE <= ZPCI_IOMAP_ADDR_MAX));
 
+	struct kmem_cache_args fmb_cache_args = {
+		.align = __alignof__(struct zpci_fmb),
+		.useroffset = 0,
+		.usersize = sizeof(struct zpci_fmb)
+	};
+
 	zdev_fmb_cache = kmem_cache_create("PCI_FMB_cache", sizeof(struct zpci_fmb),
-					   __alignof__(struct zpci_fmb), 0, NULL);
+					   &fmb_cache_args, 0);
 	if (!zdev_fmb_cache)
 		goto error_fmb;
 
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
index 0990fdb146b7..ad1bcaf52ff2 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -167,3 +167,58 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
+		return zpci_fmb_enable_device(zdev);
+	return zpci_fmb_disable_device(zdev);
+}
+
+int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
+				   void __user *arg, size_t argsz)
+{
+	struct zpci_dev *zdev;
+	struct vfio_device_feature_zpci_fmb_read fmb_read;
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
+	if (copy_to_user((struct zpci_fmb __user *) fmb_read.data, zdev->fmb, zdev->fmb_length))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..97e0f857fe4f 100644
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
+	__aligned_u64 data;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.54.0

