Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414525;
	b=CCqwflXycUou95RLaEjE8JPC/8xMVDqyWHKSXayAUF9QVfBg9JNNRLFpeNYaGuZUO03G
	 O88RhuNQCDR1TsLw9LWwI9fZAMjCaCMYRLLzh/yw/1TvtLspAbFgtbDKxUV09B0g7kRiD
	 G+uSi1pA/PC6uuSn7DfFHcP6W3b8yIy7hdSthvdOk7uSiVCXr0zBzBryPyC6WgoN2SgrP
	 B01a6s4tS+g2NHskrnEmlJeJT0mvXGYiVmCY0q0yyqyk3vp51yEFW6foYIUiEVGHao9IS
	 ZFNkAJz0tO/jwc9NSEtDOojT2jL+rnHoDOVb+gR7BgdU7olgSLroIvn1mG4jsVXdT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414525;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2uun7kaN5ZEJ2pMQ9LKWPL6NGjiC6mpZNaNH2FTwpfk=;
	b=iRTQ+Ino9il5zqNUQPkvfn9JIVpoWAGf3iiwIRA1xXcs0IhBmSEccjJ/Eh5noAvTO25W
	 Z/CgtZMMlXQOIrEkVKlkkBH6m4Lnk0V5JYWF06D1PU+/YGyXAn/xTWnAjWUdLOlll8RM2
	 NnkSaec4ZoGHmfDpsN/x4N5tkXi6Vx3qc84SGrx4ahg6gPOOpLEiBKVBI+KvsXFVco2Ze
	 D9xFJ/JvktethEAKSFfqpRUrX4nn9zXQfheTZkG1YYTjqPfjDljPxaD7OFPogElUsmuNm
	 zy6AJgudEYDpRsAXwIlpL6bP3GYoiu4Gtc+tb0MmFkpOrN1qc59wDHUecZK8aoRqiRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bhPzSiuO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A423606A335;
	Wed, 11 Nov 2026 16:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A423606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bhPzSiuO
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFELQR236907;
	Wed, 11 Nov 2026 16:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2uun7kaN5ZEJ2pMQ9
	LKWPL6NGjiC6mpZNaNH2FTwpfk=; b=bhPzSiuOHOEgDFHLX+M0SGfy9Y8MEdQgc
	Z6a0baCrGSx0JiCsWDq3Ikri2Oi0xYfQtfMfyjTlzC4EDr+Reg5J54X2/Kkyrqzt
	5dDt4lYv1CmmReHk81y6KPYbecRm1+fkm2vil0Q/hstnD3kk1BXlN2X5bYrjx+Xr
	epCqqGwAGnO4CV32ru7209ll+CtkMlYlpHLWik1w3pFWxHdSHzENgnvlfdhF3iDb
	ZopvGi5YuEq4y5VkSfxK68PfudSBJKZ3fRvVPfrgVFsYl8ohnun6ZtmKm9lN0B5b
	op/6KbNZ4XShTr4LN8CAXEdlKX3aQXGK5CTIgT8Hi0FvOHvGXJHSA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgagv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF4vIX3451747;
	Wed, 11 Nov 2026 16:28:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv33256f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGSchS4522748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:28:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F4358017;
	Wed, 11 Nov 2026 16:28:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37C8958028;
	Wed, 11 Nov 2026 16:28:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:36 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v13 5/5] vfio-pci/zdev: Add VFIO FMB device features
Date: Wed, 11 Nov 2026 11:27:58 -0500
Message-ID: <20261111162758.9792-6-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162758.9792-1-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af497ba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=o7ZLYlnJ96k-dGTR9YsA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX7lsbbIrtpkpv
 07H+FwlHea+2qUdNBF55xKppqK8IRl/+SrMe1OoToV7MGTH9xqP3hbolSq1cZXAK32QyomCIsAS
 /4z32MTVtZm/sxO8DnyFzGX8uoEGxN1r+9WqTs3k8T8OMQLTOnm/FHfsk+9OvX3r6SmDPgrd5Wd
 D6qeByUlYAZqBWeoJjK9DqF3cXNfb36Poz8tEtuK7557KvQz7MCSVzdAAtG046aBckAt9GFL0Tc
 tbHLDI/3TLlMZnUxr/rw0xlM02pBDuDjkAfWkUL+gGiNXLu0TGuw0Qn2TWuWZEXHlwywSGRc9mL
 qOvaDdFipKUPITEA+8endSOy/SHR6Q7QtOY2rxVO2cxD8VlhcZ7eW+E/AFlBWKJOAb3HLg84NoY
 dY3lWHo/vzJDjNmVE0hNSCe5JM1GvYaCLEJFrlTOGvonM1hvExva7ZNdGaxyJMR7tPaDYlFT7Su
 Vfj0yqb+aKaMUDMw4IQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfXwAtMmfLBCOrU
 UsWs1GL1fEZl+no+EgeNG/5hPtMm4UE6MPqv8173iF2OsR1/uyyqfMernokkgdGuuPFt/V7uhSP
 xqbj0OqOhzzQrUhDp/YI2abO0pdB/3g=
X-Proofpoint-GUID: a5w50A6Pq-dkwuIo8961GTo6Bu4wZ0TF
X-Proofpoint-ORIG-GUID: a5w50A6Pq-dkwuIo8961GTo6Bu4wZ0TF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace.

Allow the user to enable or disable the FMB using the SET-only feature
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
in the case when the FMB is enabled.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 64 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 30 +++++++++++++++
 4 files changed, 116 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..f2d5b6857925 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1614,6 +1614,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
 		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE:
+		return vfio_pci_zdev_feature_fmb_enable(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_FMB_READ:
+		return vfio_pci_zdev_feature_fmb_read(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..e04d7e9d0c30 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -95,6 +95,10 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
 int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
 			      void __user *arg, size_t argsz);
+int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
+				     void __user *arg, size_t argsz);
+int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
+				   void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -116,6 +120,20 @@ static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
 {
 	return -ENOTTY;
 }
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
index f47f36314a1c..0584fbaf8755 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -219,3 +219,67 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
+	if (fmb_enable.enabled) {
+		ret = zpci_fmb_request_off(zdev);
+		if (ret && ret != -EINVAL)
+			return ret;
+
+		return zpci_fmb_request_on(zdev);
+	}
+
+	return zpci_fmb_request_off(zdev);
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
+	scoped_guard(mutex, &zdev->fmb_lock) {
+		if (!zdev->fmb_enabled)
+			return -ENOMSG;
+		memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
+	}
+
+	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..7e9adb61c5e1 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1555,6 +1555,36 @@ struct vfio_device_feature_zpci_err {
 
 #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
+ *
+ * enabled is treated as a bool, so any non-zero value evaluates to true. Nested
+ * enabling disables and re-enables the FMB, while nested disabling fails with
+ * EINVAL.
+ *
+ * Returns: 0 on success, -1 and errno set appropriately on error.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 14
+
+struct vfio_device_feature_zpci_fmb_enable {
+	__u8 enabled;
+};
+
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
+ *
+ * The user-provided buffer must be at least fmb_length large, where fmb_length
+ * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE. If measurement is not enabled,
+ * fail with ENOMSG.
+ *
+ * Returns: 0 on success, -1 and errno set appropriately on error.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 15
+
+struct vfio_device_feature_zpci_fmb_read {
+	__aligned_u64 data;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.56.0

