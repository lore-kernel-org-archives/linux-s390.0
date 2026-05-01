Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15541C2FF;
	Fri,  1 May 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663631; cv=none; b=ciQYp0iZWL5hygl3ZvbSFHanihzcN+gc3Ribkm+xm6TzPTd637NGjI47ap1I9L0MkV1j8Dtibv5dUFyYsycb1n0lj5RSZnpkvfduNG5IKBRtrxeFTU9iyqYgXufX/m+GKYsgxu6w9Sztu4bGyj64AuFVgVnolW5y+Th3MSIFljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663631; c=relaxed/simple;
	bh=05Y7MgNIeyX9AUD2z6JcZ4EOO1ulTxQAE361xC5/bSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeeAizb9Hb9HXF7K0TwQeUXcde8E91f41hPeCquj97LSsOD73tvOIM5WVWO1irjzxKznxFSbl3F6HMpcAWJkrAiz5r21is+sdWsmif5U+7MBy0WM/OipEtN6UDIsQvm+oq2RgF+YIcuLKhyIEew/ccIXQF44bKNg5fCf7l2lWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IN6x86/O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IN6x86/O"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641FFWCX2766617;
	Fri, 1 May 2026 19:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=48W2QeYenMYp1w8Jg
	4KOVhhMg71kyh3w/0Kg1u+Sw/w=; b=IN6x86/Oq4JF4FOhwtxteup6o0z4nRLYq
	2xLYzxkwEmtUo9XcGnD+0rOgZ1MFhko9KfrOyqfHTJI5Q5GI96OZIRuvi6oMxDtc
	1opo2h+WX2CDvv3r3uuWJjjxdLOh7vqUq6ls6VCTtoQVEjqQfNK+MeKkj+9MP8FM
	8c5k9NQKbKSIUiTCFMqrEsNKO1/MhG7XJUari48l/0WtI5h9DgH2LwvEGWATBfh/
	cW7kIugVXWrfTwSbICMaPTQXe68pVWaai+kFXdg9bC5nDwBFBlXKZgjxKqVjgTFe
	p5krSsU4GHwz75tV9TV+XyAFtpW6sbNeI9FHvQvOxRIqjwlaRKvsQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rp2vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:27:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JNjn2006833;
	Fri, 1 May 2026 19:27:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkgujn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:27:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641JQaKk54722922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 19:26:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9338558053;
	Fri,  1 May 2026 19:27:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55D858043;
	Fri,  1 May 2026 19:27:01 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 19:27:01 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v1 2/3] vfio-pci/zdev: Add VFIO FMB device feature
Date: Fri,  1 May 2026 15:25:29 -0400
Message-ID: <20260501192530.9429-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501192530.9429-1-oelghoul@linux.ibm.com>
References: <20260501192530.9429-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pWHRyhQxLrGFaO1OrcM-lvFk2gIopmpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5MCBTYWx0ZWRfX6RYOw1hmaRMD
 uYAs7JO8H6i5ORUizu/iSw4v6rj9xFdBteQCK/NHEPK+XA3n3Dz6KNeAvWbJ4tn+IJh1DiuiqIz
 8k9Bjpd2kjecVwg/XDlUdkyfJxuCeZF1eaiIM8RdIEsNEfLIAtnFxslukJpx5x/pfu4jopZktbC
 oYiJGSPtE2w/qxqSgN9j5Qm5gWAhuRp+uZj7B5k/x/3Mn62nQ2i+mEF+lY/eSQR4G55g/N8wIR0
 e6QzP1wUWg6oPeVxJHs6wkIOuz/wzTL/4vdb5xYLiDgAaI7Gq8Ad+4jrzG9IWVA+AAT4nOfCknh
 7s5jYcH2ULpuj0nUsxNEopT8+nDh/2tv8/5NbvtJWp9qtfd3LCvI2yqsnTDQzSZPNE1hXLW8oV3
 uKS3aaOlJoF3LyXcMjA9QzrOYhe37lHMadHqjyHAMpP8hSmzRzbq+sQsNrRnrmRe8oBg24XHGwn
 X1tz+dXxH7ZbJfE1v3w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f4fe8b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=qYbwNa5VYoetIufaySgA:9
X-Proofpoint-ORIG-GUID: pWHRyhQxLrGFaO1OrcM-lvFk2gIopmpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010190

Set up a new VFIO feature for zPCI devices to share the latest FMB snapshot
with userspace. This feature supports the same 4 FMB formats (0 through 3)
that are already supported by the kernel.

With VFIO_DEVICE_FEATURE_GET, allow the user driver to read the latest FMB
snapshot as well as query whether the FMB is currently enabled on the
function, itself indicating whether the FMB snapshot is valid. On the other
hand, with VFIO_DEVICE_FEATURE_SET, the userspace driver can enable or
disable the FMB.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  2 +
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++
 drivers/vfio/pci/vfio_pci_zdev.c | 77 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 43 ++++++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..63e80b6fa0dc 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_FMB:
+		return vfio_pci_zdev_feature_fmb(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..208e05942b48 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 				struct vfio_info_cap *caps);
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_zdev_feature_fmb(struct vfio_pci_core_device *vdev, u32 flags,
+			      void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 
 static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
+
+static inline int vfio_pci_zdev_feature_fmb(struct vfio_pci_core_device *vdev,
+					    u32 flags, void __user *arg,
+					    size_t argsz)
+{
+	return -ENOTTY;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..1e9efe2bee69 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -167,3 +167,80 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 	if (zpci_kvm_hook.kvm_unregister)
 		zpci_kvm_hook.kvm_unregister(zdev);
 }
+
+int vfio_pci_zdev_feature_fmb(struct vfio_pci_core_device *vdev, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct zpci_dev *zdev;
+	struct vfio_device_feature_zpci_fmb fmb = {0};
+	u32 ops = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET;
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, ops, sizeof(fmb));
+	if (ret != 1)
+		return ret;
+
+	zdev = to_zpci(vdev->pdev);
+	if (!zdev)
+		return -ENODEV;
+
+	mutex_lock(&zdev->fmb_lock);
+	if (flags & VFIO_DEVICE_FEATURE_SET) {
+		if (copy_from_user(&fmb, arg, sizeof(fmb))) {
+			ret = -EFAULT;
+			goto release_lock;
+		}
+
+		if (fmb.flags & VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED)
+			ret = zpci_fmb_reenable_device(zdev);
+		else
+			ret = zpci_fmb_disable_device(zdev);
+		goto release_lock;
+	}
+
+	ret = 0;
+	if (zdev->fmb) {
+		fmb.flags |= VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
+	} else {
+		fmb.flags &= ~VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
+		goto release_lock;
+	}
+
+	fmb.format = zdev->fmb->format;
+	fmb.fmt_ind = zdev->fmb->fmt_ind;
+	fmb.samples = zdev->fmb->samples;
+	fmb.last_update = zdev->fmb->last_update;
+	fmb.ld_ops = zdev->fmb->ld_ops;
+	fmb.st_ops = zdev->fmb->st_ops;
+	fmb.stb_ops = zdev->fmb->stb_ops;
+	fmb.rpcit_ops = zdev->fmb->rpcit_ops;
+
+	switch (zdev->fmb->format) {
+	case 0:
+		if (zdev->fmb->fmt_ind & ZPCI_FMB_DMA_COUNTER_VALID) {
+			fmb.fmt0.dma_rbytes = zdev->fmb->fmt0.dma_rbytes;
+			fmb.fmt0.dma_wbytes = zdev->fmb->fmt0.dma_wbytes;
+		}
+		break;
+	case 1:
+		fmb.fmt1.rx_bytes = zdev->fmb->fmt1.rx_bytes;
+		fmb.fmt1.rx_packets = zdev->fmb->fmt1.rx_packets;
+		fmb.fmt1.tx_bytes = zdev->fmb->fmt1.tx_bytes;
+		fmb.fmt1.tx_packets = zdev->fmb->fmt1.tx_packets;
+		break;
+	case 2:
+		fmb.fmt2.consumed_work_units = zdev->fmb->fmt2.consumed_work_units;
+		fmb.fmt2.max_work_units = zdev->fmb->fmt2.max_work_units;
+		break;
+	case 3:
+		fmb.fmt3.tx_bytes = zdev->fmb->fmt3.tx_bytes;
+		break;
+	}
+
+	if (copy_to_user(arg, &fmb, sizeof(fmb)))
+		ret = -EFAULT;
+
+release_lock:
+	mutex_unlock(&zdev->fmb_lock);
+	return ret;
+}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..6cbc34ff063e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,49 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
+ *
+ * Upon VFIO_DEVICE_FEATURE_SET, only the flags field is read while the
+ * remainder of the structure is ignored. This allows the driver to enable or
+ * disable the FMB while also leaving reserved bits for future flag expansion.
+ * All reserved fields should be zero for future compatibility.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB 13
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED	0x1
+
+struct vfio_device_feature_zpci_fmb {
+	__u64 flags;
+	__u32 format:	8;
+	__u32 fmt_ind:	24;
+	__u32 samples;
+	__u64 last_update;
+	__u64 ld_ops;
+	__u64 st_ops;
+	__u64 stb_ops;
+	__u64 rpcit_ops;
+	union {
+		struct {
+			__u64 dma_rbytes;
+			__u64 dma_wbytes;
+		} fmt0;
+		struct {
+			__u64 rx_bytes;
+			__u64 rx_packets;
+			__u64 tx_bytes;
+			__u64 tx_packets;
+		} fmt1;
+		struct {
+			__u64 consumed_work_units;
+			__u64 max_work_units;
+		} fmt2;
+		struct {
+			__u64 tx_bytes;
+		} fmt3;
+	};
+	__u64 reserved[16];
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.52.0

