Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931413803D8;
	Mon, 15 Jun 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548589; cv=none; b=okcL+flRvAN2KtgCZ6rNcgDDfXCbME6/DngzJhxaO7OHqF6xg0vVFzZxDaxtb47s/9Scqd6Z4fkMUCLtY9m/b3L2v52nS6c29McoCNRkadQJ5fW2fkXyxHAJERuCZhvnYNPYFVao/LR+bb3ETbTCgaCAH7ZD6NglJ2Bp7F9psfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548589; c=relaxed/simple;
	bh=rGZum8urVp8P46+qY7V7L6l//eIxIcKdEfe226A32gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuFCyKJMetbi7gvlXFQ5ys08N6Dd9T/yAr8jyccM/X583Z2gsaP1b8+wSV1Q3q6xKmuTpcVuGMv4a4WnNj/TsmEXMcTQpNnVxPpsO3lQqFZf1tOWVDY5wy2ETRhgtkWe9a2gbnlu5QBBzLsReNE0tmpRNDs5ratEaAGyFqLzB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WaodHUrH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WaodHUrH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmPWT2897279;
	Mon, 15 Jun 2026 18:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5KsPNM0nLckl2b9JS
	OpO0hB5QGksIMAhs/q27SRnIyw=; b=WaodHUrH8oEJXbs/4CxcwjM+j0uybqXIt
	8ipFOTmHqK5VXqa2MNjZ4oezMNRUW9QZbvvx9wq4M8WxVm82b4KyADXeZrGfD0gc
	x8cLh2xjol6ZmXENnM1ldVRUKBEp2yYFZ1bptaas4Ws+jlrxqd+urVIefeJIFi9Y
	5kgllJmgKRR3/cZ0SWkWottU5E+aGgBnjxd538byJJyYKJcEZqsabQ5MZt0QW7RT
	VNswh48/LNvcyZUMZS9mXjcqbJSoezYjO+1HxTPRLYkjQ/TvvxeM0dcVcjOwbAOA
	URvz+XS7h/UgzNFX63IQRgmu6L2Qyo8LanbrsCTXaZqtBlB06CKIw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h825pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYtiB026822;
	Mon, 15 Jun 2026 18:36:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq01fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIaKNg29754028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:36:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E65D058055;
	Mon, 15 Jun 2026 18:36:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE4758043;
	Mon, 15 Jun 2026 18:36:19 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:36:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v19 2/3] vfio-pci/zdev: Add a device feature for error information
Date: Mon, 15 Jun 2026 11:36:15 -0700
Message-ID: <20260615183616.2902-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183616.2902-1-alifm@linux.ibm.com>
References: <20260615183616.2902-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX96mes6X5uFyG
 bF7PekGdYFIcrpB+AJsDoKynTAndIR8QSVYUP6/iwuLJWW7i8mHuaL97FPd+0hnvX/lCOrWqo87
 yolyd4RE9XHxPQB/bExJcYPP5I6vEWI=
X-Proofpoint-ORIG-GUID: cddQXG04w0ZjQKJYuRGMTP-bqblyh1tH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX/4ZWvdwqoxdR
 vkibzfIC5DL6cZTpXYdj6vivG6Utv00E7MmisZK/8nDF2ATedQ2G8Sy2ScEk26zrzihLm87cOyG
 Svsr5x+Tx4keMMeIadLvM+jQNrBlU+HjBPScVRUkLGWmYjzT20B6Nwkl5v5GBwQ8pV2rDACpyOw
 l5nDV1xbxjFCfgcNpYy0m6zd6PMSR5fjWIiz0f5kCrtvpIBNa03Ktzn0KOvEGsYCnjFHrudUE0S
 Tf5tLyezhnoyWDQVltDsyXVWPeZ9MNpAE5/4LlQINI4wyNOmRSulUHEDmwWcceZIWk7968hzo46
 aFK7mBokPtVGsWkyYpBOW0araQQxpS+vjsjbK96LRHNXsh0CQy7WhxwMT4vHcLReDKQLwM4gxov
 QFOynJFbzXBwRtKigusN7tag2EpyBmaw62Xq0CSGbcYpNVul5GS0IAmVn4dUam0aL5jUL0jOjdj
 EazEDjzetXcAgkahHJA==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a304625 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sIuuyFDGXZ7lsjPJAw8A:9
X-Proofpoint-GUID: cddQXG04w0ZjQKJYuRGMTP-bqblyh1tH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150194

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  2 ++
 arch/s390/pci/pci_event.c        | 19 ++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 43 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++
 6 files changed, 105 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 016386f7ef4a..88a125b92bdd 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
 int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
 void zpci_start_mediated_recovery(struct zpci_dev *zdev);
 void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
+int zpci_get_pending_error(struct zpci_dev *zdev,
+			   struct zpci_ccdf_err *ccdf);
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 8934b640a095..3ad16038e005 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -77,6 +77,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
 	return 0;
 }
 
+int zpci_get_pending_error(struct zpci_dev *zdev,
+			   struct zpci_ccdf_err *ccdf)
+{
+	int head = 0;
+
+	guard(mutex)(&zdev->pending_errs_lock);
+
+	if (!zdev->pending_errs.count)
+		return -ENOMSG;
+
+	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
+	memcpy(ccdf, &zdev->pending_errs.err[head],
+	       sizeof(struct zpci_ccdf_err));
+	zdev->pending_errs.head++;
+	zdev->pending_errs.count--;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_get_pending_error);
+
 void zpci_start_mediated_recovery(struct zpci_dev *zdev)
 {
 	guard(mutex)(&zdev->pending_errs_lock);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..27642f10fe97 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1569,6 +1569,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
+		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..4e7162234a2e 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 				struct vfio_info_cap *caps);
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 
 static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
+
+static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
+					    u32 flags, void __user *arg,
+					    size_t argsz)
+{
+	return -ENOTTY;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 78a28db00c6d..c0d6362cc4eb 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -141,6 +141,49 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct vfio_device_feature_zpci_err err = {};
+	struct vfio_pci_core_device *vdev;
+	struct zpci_ccdf_err ccdf = {};
+	struct zpci_dev *zdev;
+	int ret;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	zdev = to_zpci(vdev->pdev);
+	if (!zdev)
+		return -ENODEV;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(err));
+	if (ret != 1)
+		return ret;
+
+	ret = zpci_get_pending_error(zdev, &ccdf);
+	if (ret)
+		return ret;
+
+	err.fh = ccdf.fh;
+	err.fid = ccdf.fid;
+	err.ett = ccdf.ett;
+	err.mvn = ccdf.mvn;
+	err.dmaas = ccdf.dmaas;
+	err.q = ccdf.q;
+	err.rw = ccdf.rw;
+	err.faddr = ccdf.faddr;
+	err.pec = ccdf.pec;
+
+	if (copy_to_user(arg, &err, sizeof(err))) {
+		dev_warn_ratelimited(device->dev,
+				     "Failed to handle PCI error event for PCI function 0x%x",
+				     zdev->fid);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..83c93193b22d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390. On s390, PCI error recovery
+ * involves platform firmware and notification to operating systems is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device. The ioctl returns -ENOMSG if there are no pending
+ * PCI errors.
+ */
+
+struct vfio_device_feature_zpci_err {
+	__u32 feature_flags;		/* Indicate future features */
+	__u32 reserved1;
+	__u32 fh;			/* function handle */
+	__u32 fid;			/* function id */
+	__u64 faddr;                    /* failing address */
+	__u32 ett		:  4;	/* expected table type */
+	__u32 mvn		: 12;	/* MSI vector number */
+	__u32 dmaas		:  8;	/* DMA address space */
+	__u32 reserved2		:  6;
+	__u32 q			:  1;	/* event qualifier */
+	__u32 rw		:  1;	/* read/write */
+	__u32 reserved3;
+	__u16 reserved4;
+	__u16 pec;			/* PCI event code */
+	__u8 reserved5[28];		/* Allow for future expansion */
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

