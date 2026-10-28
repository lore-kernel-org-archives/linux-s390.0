Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202255;
	b=CtAM/TaJbBuQukNDzAskPV0vGjyVUFooCblI0KmZyfGNY2OyTZSaL8vbIaBZiao4vkVQ
	 ijqDcyFQEYc7p+PE+hoQ5tvZ8OgXLWQ7AExXVx4s0hxU/1fVqUotPc9RGQmN9gLqXPm14
	 xxjUuvg9ZmkdRpEVy2W/pMGafYic+bCPtAgZbPkEfCEoRfFwXbNM4odfWdJAAkw28uVol
	 NSnmMwRfzY3jURpdslzBkB/J0ALoEH+XWC+W1bPNT6kjb4UjnAjL3XMieSKzU6s85s5/b
	 WBaEGXTihhvidivU6I2VZYhhxoVsiqPQ3xKd5DQ4Aua/9Jybgc9SShni/VCQmtNnCMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202255;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bOgF5ikzMKUuUDgv/vm2Ch+e8FNs0kJzkLULdKGPfBY=;
	b=YikiIuS7CdHpeWWyNqRK7uESvozxSm2j0Gdey+fTxEyXqb8fvalkb8brvbfpAH+7VWGd
	 pQ3mcvqK0yMlnPIzwn4nLAg9dnxKzdhTkllSIVQjhakAlxVhO9WgkQtKnh2yUQvnmSJca
	 JmbohiHHunX78lyRDbLWFXT7v+pClcpyP/8PfH8dRJd5rMXvrRDWtcLcKG4TqRh+7nmjv
	 SOg6YUWotzurf+XJShHJndgqEHWFXr5x0VVbSsf+WQEEOCbW0oW73Bh+T/JdOQfwGrXM3
	 uCeErfvpaQJDR3jHJ/7lSc7q+VAGqa6Dlo682bGtJ+p1DcpoP8W0cRi2AFI5DiT3bRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aEysPRuS;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDD60A380A;
	Wed, 28 Oct 2026 15:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEDD60A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aEysPRuS
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEsDh425241;
	Wed, 28 Oct 2026 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bOgF5ikzMKUuUDgv/
	vm2Ch+e8FNs0kJzkLULdKGPfBY=; b=aEysPRuSiEBmNkD9751pSKo14aj4o0q8b
	ouWTS21+vEjAXSq/lI86vMT0oZho24EAVQchK6EgH4JZgYcDA3xaJ3WcSN91iu7D
	q5py5bBCZBS1NMiU7LlMZLwv3esXOk85yqf53afeUYQdVA8q3MyxbceHHQ9HjevB
	yETGYhMnmOBjUVpze1pHCPjMKQlaGHGrnAhTW9FfncT5TxJfDWKqMsVQBTXKK1ks
	XgOAIRAA4XF0D+/dAC8qSrdqF5giSkjKzo7WrpHzU5iDkEZR6C7iKkkB4ffJAvDk
	AxmUaBuMAJGkR1VZ8vVHc8AzVTqY722NUMWDsErQgEi4Msby4dvjw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g5c82-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFK9LT1784823;
	Wed, 28 Oct 2026 15:44:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh7xnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFi9Si16843338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:44:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ACBE58045;
	Wed, 28 Oct 2026 15:44:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B3F158062;
	Wed, 28 Oct 2026 15:44:07 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:44:07 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v11 5/5] vfio-pci/zdev: Add VFIO FMB device features
Date: Wed, 28 Oct 2026 11:43:52 -0400
Message-ID: <20261028154352.15108-6-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028154352.15108-1-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae2184c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=wtvrgtD0Hc2VqHSVShsA:9
X-Proofpoint-ORIG-GUID: Lo2_HbFZJAvn4fsXCrFZ-pqeuPlfV44R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX0exm0YGw8e2/
 BYOXLyIE1sXTZhg/sX7Ub/pq6dLuxcX6V/Wplelfpoy2X30iwfpfxnvIKobDoUf+H1OEtVPeYUR
 aTj9HiuxBoGxN4Emo0g2pazwFC+HsldPEpCY0AbpyJRobSr/DBbk8icpXKv9TFWGKT/APrT58FE
 zga//GB/8B22wG2gMFTKCKi8sgSMH+pj06w1mh9JFA42JKE27EfKtImzTh10EXo57G4nV9niX8E
 13zbBt8Rx9gO8toBS+E/seyiNMdpQhMzkJ7RS53QMpsh3gkU3DUqAiWSRMnj3ArXTIKx+PW2vop
 HrgxuYSgs4oW25Gkalxnuamn52luLL7zZAR6wJ18TMtLLX86lnpCM9fsH0sraKYw91Nf2xwBsHl
 OvCgeSikIV3c74ARExNrX/uNAvf41uoD9Bh1UNMbRZSYw4vG/I53elVzFRIgA8tY21z1mHZAQnT
 v3yFh2AWOqbAwDKrCMw==
X-Proofpoint-GUID: Lo2_HbFZJAvn4fsXCrFZ-pqeuPlfV44R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX3D98ycOKWgxE
 EXuzwtniDN4Ww7bt9BweNm1p/cpfm31DuAMZsFh9HCGnBL3d0q6K/O9ZKULlhuBqWLoq2GF0468
 Imy34Z52hRIhW75uVe1UEZSKbnrcB0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280062

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace.

Allow the user to enable or disable the FMB using the SET-only feature
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
in the case when the FMB is enabled.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
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
index f47f36314a1c..39921c363892 100644
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
+		if (!zdev->statistics_on || !zdev->fmb)
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

