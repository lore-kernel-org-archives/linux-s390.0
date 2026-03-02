Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDF37FC61;
	Mon,  2 Mar 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483625; cv=none; b=WPts92ZfyrOmxjFkDF6oZHOSVDjnoDW0xVSX/9eKbJRQV+GsWPnTTcCXFSHzqp4s4tnxiba1njd52vY+WIyYoOEybI3dBQR37968b8WQQomabeowiUwwR4xxkp1TekeSGMN0lyr0fSDmzFZshE/JRDMd4onDH2UF0CsX9Ok2VLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483625; c=relaxed/simple;
	bh=dolDlmty2gDg9KbcjZlyQImF27gwC0nzDfbxrwRpy9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMjIfg3nG+HJ3aPKgA72XzHNM0PXCbIbuMc3sJbiPzkPh1f+znFVdR+UxXAAOnSUaRPOBzIIwTrf62YNB2uQTmHp9nSbllKl5V2strOQG0e8rZZazo5e49bOdZGjXyHOpKIlueY5rbO3rMgZ4Qu/rmEoPmzTbeUOjhobF+Vs7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WB9oQCOa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WB9oQCOa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229lmlu856129;
	Mon, 2 Mar 2026 20:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=va+WUlTzDwquCuYnP
	i0mK7x/VduB97z7b2jwvNjvPr8=; b=WB9oQCOaLNNMIdhDL71qJfjrKzLeM7m3R
	FtfgSgCOTJNHLiD1EZpU4y4DBdZq02C2G2abBKL8Vxczh21YwwDccXe03QeaDHnF
	0TnRZhBT5kuxLlLjRLn0IwkiHO5equ5GCFOzhKyX4sOeKQgFfASsCyS89hKnmDmY
	SDrGxGnBQ/AlXdxC5Bi6K6RDUZNG3tytdwO+SCJ2pvjvA3+f97Mrbw/NchS61VoA
	4hERCWKlrgpqhIgyRVRCnfvDYEyRWq5xbk+v8OYIR08Vry3vxxPVhNea6n/o2GkJ
	TnbwaKRDP1VWJqWhFzxjAPz6mvOwsu4H21h28F9jVOuYFJkxgGttA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbr4n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622H59uE010300;
	Mon, 2 Mar 2026 20:33:38 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jyh6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXFLw19268108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBFA058053;
	Mon,  2 Mar 2026 20:33:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6FBB58043;
	Mon,  2 Mar 2026 20:33:35 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:35 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v10 7/9] vfio-pci/zdev: Add a device feature for error information
Date: Mon,  2 Mar 2026 12:33:22 -0800
Message-ID: <20260302203325.3826-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302203325.3826-1-alifm@linux.ibm.com>
References: <20260302203325.3826-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CDV_8yx_ckkR46jk9cmT3IhMBSppuwRq
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a5f423 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QIy8Zix3hhx26zbqT_4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfXwyGLjCkPUz9G
 oXn+266yHBmMkYkRyhVkCn1/pb1XC0Hdn3Ni1RUN9rrMiDn/HG3kwgwFsrLvHuKSmk/ZHAZ4eqE
 o0VYa+rw6EWvVtLgBzkLE2B4jIpdrhtD/WC7/drWqDP8WLj3kx0ptALS8hSS9d8EwWnIWP+y6Or
 t6XIed69Ta94k4+5s9a8kQtj+gSK+C7iklJphGaPQ1dWD4S366sEIYZruhqYPr4FUjOfEefCRSZ
 1VUsmszyKKLCvb/aQgR3Qwg5A/UChcRRkynyxN6GvFaVuVbtwsIPN3VAtyP1Eo/AbsLmuw2Tdlr
 tmyDO77pLgRAkUeT1eVUF8pn8AzpQgymVyqjj6G0tGIrb4NZ6h9XwW9tfBOf9W33fgkf7iH1r3l
 Dt+Upgtg0wialaTbhnngHsnXLhK5qX8nlBNzI+dKRiW4ZY5yGe7FclGzSc8+eyy4sDb9tp7iAKk
 yu7J9i6QrvepJjOHvwA==
X-Proofpoint-GUID: CDV_8yx_ckkR46jk9cmT3IhMBSppuwRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 36 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 17 +++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d43745fe4c84..bbdb625e35ef 100644
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
index 27ac280f00b9..eed69926d8a1 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -89,6 +89,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 				struct vfio_info_cap *caps);
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)
@@ -103,6 +105,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 
 static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
+
+static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
+					    u32 flags, void __user *arg,
+					    size_t argsz)
+{
+	return -ENODEV;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 2be37eab9279..d2748dd67c55 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -141,6 +141,42 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct vfio_device_feature_zpci_err err;
+	struct vfio_pci_core_device *vdev;
+	struct zpci_dev *zdev;
+	int head = 0;
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
+	mutex_lock(&zdev->pending_errs_lock);
+	if (zdev->pending_errs.count) {
+		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
+		err.pec = zdev->pending_errs.err[head].pec;
+		zdev->pending_errs.head++;
+		zdev->pending_errs.count--;
+		err.pending_errors = zdev->pending_errs.count;
+	}
+	mutex_unlock(&zdev->pending_errs_lock);
+
+	err.version = 1;
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
index bb7b89330d35..21b1473e4779 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1510,6 +1510,23 @@ struct vfio_device_feature_dma_buf {
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
+ * platform firmware and notification to operating system is done by
+ * architecture specific mechanism.  Exposing this information to userspace
+ * allows userspace to take appropriate actions to handle an error on the
+ * device.
+ */
+
+struct vfio_device_feature_zpci_err {
+	__u8 version;
+	__u8 pending_errors;
+	__u16 pec;
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

