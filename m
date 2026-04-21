Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543537CD4C;
	Tue, 21 Apr 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789051; cv=none; b=g1wZNsnL/PBzv1VXrcE+N9I3XMPArh+k7CJJKn8wcOkDYLa8QMZ0PZ6o6O+uKuof7qQOZuBnJFIREsQP9Sdhq2qtLLkJtg0Ulb3VpfXqtiHtIXsAuSoLgps3x3+eP+p65zXoAf6ckNIbOnHyKUoxdFBcsxmydpQEhkulmawU0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789051; c=relaxed/simple;
	bh=eiJrB5o9TZHJJ9HAMSy4/jT0X60NhIPg1P4PGgCUZXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMCEUFZArnh5zWB+LoIedud4pItVVe0LkCeK5KxzyOFkU5S7/1wdclRW6GZA1Phz+5aC8XwxHMbYtNrUvx1JmtCCh7ZKD9olhfreOZz6R+ong5zZoTd/RGKOC4AN92j2BNamQwLClG7wVt1YpRrRd+m+xkEOHBPxl/Yjt3eCaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tYF/H0OI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYF/H0OI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCsms82037597;
	Tue, 21 Apr 2026 16:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u5vmS2PtUA7pd+9JN
	Atk4kukSpva1fgCV6pdm1ydphQ=; b=tYF/H0OINj4u4u85NyZIyllBqcCq0pjeU
	YxRujMWZl5NCWQeeslh+Wydu5OHbVObo7+ydydeCO+0o4rLjVadWtBVcoiVjI49B
	+IueEvm1IYr+iepWZcUa6T2IdgoTPRWm6nAFrm9W7X6q6ahABwfkQ0/FwZwFSjp5
	9JQuZ9oUx3WyFawUIXcDLONIJJb+YwLySc+Sm6WuMi4TYAyXqLN6H2C+OoC8kBTm
	W0h+V4PVUv0oaCCtSEH5LKNCPsE6iIUyKXABQ5YV3qTPf39GpvXY3dOX/DG0CNCu
	bqDdAlPGaRyJIZuHBWErGgURKgHOfO2pfCyFWelfbYYMqXI0PvSbw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9mg51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LGKN2C019186;
	Tue, 21 Apr 2026 16:30:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q1ksm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LGUev131851118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 16:30:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2873158054;
	Tue, 21 Apr 2026 16:30:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E4075805A;
	Tue, 21 Apr 2026 16:30:39 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.17])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 16:30:38 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        alifm@linux.ibm.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v14 5/7] vfio-pci/zdev: Add a device feature for error information
Date: Tue, 21 Apr 2026 09:30:29 -0700
Message-ID: <20260421163031.704-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421163031.704-1-alifm@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y2D0O8dydVFHz1qhCWQkjU-NruMsLYeb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX0QxDb317dh3l
 zLPm2lTn+S6SRUEzR1KiU83ubYMhZwomp/UV8veg/dNJWBeIoVGaR1+M5TP+4j1Qs0B5R2c6y08
 uMMteBnL0twGr7m1W4Up5uyasq1ABzQH2yKhJVdoKtj3i4cGfdsJ3o67K3yJrAUR1XjQSfggP5h
 nMXnB8UR7CHfHdw4t/WOSn4i9K1hxLzx5e85YW83oqgb7Z1u6uuq5qxs7z8GDO5tDGioiST4vw8
 +D4z1w4GaGSe7OJPTKdRm1IHXCINQq0ZJzfIGPPiPqtBcSSGA4fdGbg/0mJLRpX6z60C2HTayTh
 5D2DuxjFfc2oOWKZPY8N8oLm0Rsvgpot1UrfwXkcuhNSraGjk0COvsXBptAZR/bSC+pAKAFzjqh
 fCBpo6BknanWeEgyucDs1dxFT2B/Z/d5IoD+Q1qklbpuSa+R1AH2tGKYx9lp21cSWk8g5x3y/qb
 JftdsgmRUo8NkOiFdAQ==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e7a632 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sIuuyFDGXZ7lsjPJAw8A:9
X-Proofpoint-GUID: Y2D0O8dydVFHz1qhCWQkjU-NruMsLYeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210162

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  2 ++
 arch/s390/pci/pci_event.c        | 19 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 ++++++++++++++++++++++++
 6 files changed, 100 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 9a6a4eb9d7c1..b1858d512fec 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -360,6 +360,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
 int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
 void zpci_start_mediated_recovery(struct zpci_dev *zdev);
 void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
+int zpci_get_pending_error(struct zpci_dev *zdev,
+			   struct zpci_ccdf_err *ccdf);
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index c279a9f50a64..227a939fcad3 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -74,6 +74,25 @@ static void zpci_store_pci_error(struct pci_dev *pdev,
 	zdev->pending_errs.count++;
 }
 
+int zpci_get_pending_error(struct zpci_dev *zdev,
+			    struct zpci_ccdf_err *ccdf)
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
+		sizeof(struct zpci_ccdf_err));
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
index ad52abc46c04..5403730786a1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
index 0658095ac5b1..679d9fb44692 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -141,6 +141,45 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
+	if (copy_to_user(arg, &err, sizeof(err)))
+		return -EFAULT;
+
+	return 0;
+}
+
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..e78f53ab561a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
+ * involves platform firmware and notification to operating system is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device.
+ */
+
+struct vfio_device_feature_zpci_err {
+	__u32 flags;			/* Indicate feature in non CCDF reserved space */
+	__u32 reserved1;
+	__u32 fh;			/* function handle */
+	__u32 fid;			/* function id */
+	__u32 ett		:  4;	/* expected table type */
+	__u32 mvn		: 12;	/* MSI vector number */
+	__u32 dmaas		:  8;	/* DMA address space */
+	__u32 reserved2		:  6;
+	__u32 q			:  1;	/* event qualifier */
+	__u32 rw		:  1;	/* read/write */
+	__u64 faddr;			/* failing address */
+	__u32 reserved3;
+	__u16 reserved4;
+	__u16 pec;			/* PCI event code */
+	__u8 reserved5[28];		/* Non CCDF reserved space */
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

