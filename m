Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C73816E6;
	Thu, 22 Jan 2026 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111123; cv=none; b=sH4nyh1itKLXK+sA+w3YArS6ufwjdt8hydMWaK48eY6iMM/n1g6N8lpXN1jWUqOaEcHpumIzCqABbN2Q575+6wtI7iZsb2jWj4yF+lf0cRoSCcU5GlF5gX0+O53u+qxiZMOefq50QGNf5M4CNKjh7uvlENbqoqOqGA6TLduZdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111123; c=relaxed/simple;
	bh=835fFZrZ5WWiUhTdA3Vik6F+DFzFK8pgVD6cqlJhMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLoJEn3etOK6R2hzehKgGk3MAL5fSp/Og+k8sARGCGLXxwIX3LKiGZyCZFHU14M2M4gxGm1953jBuzARRfZSUP2JCtOpjHjZgvC24PN9+Ku7kdL1cQSTFTBQzbvBWeOJranec2DFRlZFfwP7AVwcvVY8iqLKkwPCHJVVa/QePbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CxIRxkn0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CxIRxkn0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MF00qQ019547;
	Thu, 22 Jan 2026 19:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a/qqyoatum+Z/MheO
	nJ9ycVdJvlJKsHkewjz4AU1YFk=; b=CxIRxkn0Bk+kAhc+nSp/vLegs6bUPNs/W
	UesuF5VEME80AYZ9BKp7DRTeUZONZsf0P+AeYPhj4CjJr8HzHT2cUTmCcvsJg/gv
	QITR+yJyjVoUd+dD7c83O6GCk1uP5LFQZBwW1+Puh/tfKLWj1pNitPKz356OBiIO
	/O2Kb6CqqeC7jD8QaNWeD2vZAW1EqJasQH1RzcDsQQoRg4KAXMOlgtrY9OB2/ZfW
	RYuPiIVFHal1jQDfE+XzDfxR7yy7SGw+jsyB6JDbM8LCQzMdYPdqxmyF9NLIg3H0
	WKHNISkeF9XUdNsB0SbbbXMxsgOduw0DTSEs74g3htrsFfmHPQFJQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256bt3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MHT54T006399;
	Thu, 22 Jan 2026 19:44:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1v64q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJikuu66650438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA83E58060;
	Thu, 22 Jan 2026 19:44:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD10558056;
	Thu, 22 Jan 2026 19:44:45 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:45 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 7/9] vfio-pci/zdev: Add a device feature for error information
Date: Thu, 22 Jan 2026 11:44:35 -0800
Message-ID: <20260122194437.1903-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX2Z5ZFVcPMqWZ
 YMr4nxNbQqi119OyNIX3ITBz7Y8WBJKZnKge0OeHR0FEXYGcL0ZpJDUo03xkmETP7JDfcJUCdOJ
 RPDJzWbZrn/qKCAt6CBS1RKJNRzLDyX0ML7vAc3QXpuBemdmoQaRt+dghqD4RV8r0vE4xGfA6nG
 gqT41rXjFL/QU4wNsvTSTNX5nkY0Kf0TJ3s4CJqQVE+3rzas+Zp6rf///wJRoBYOdBy0A9r2twr
 RajiiVIU1Ru+RIrkHsSrBwGOdVZdSf+lGbxRUubKMTLgmqXWNWyk1KB35keXbSHTMfhC73OVZD9
 +a8/D77kYwIha4CYefIxM4w2KAupLI6AsoZmfHVb5bSvyIXj/O7aGpKNL3YzvTHVgPqbeM0RL1I
 ITrQIRZ5WmSTAmINLY6bCRMzB81Mp1H8EDFB3VEPpMP52WCvc/YKf+7Dpt9WLFJhzAIKhPow637
 Zhpdy6fj1qdWHA2ozxg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69727e30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=QIy8Zix3hhx26zbqT_4A:9
X-Proofpoint-GUID: bzYZNlojqRgN3CJi-tVKMu6cFDpR3TC2
X-Proofpoint-ORIG-GUID: bzYZNlojqRgN3CJi-tVKMu6cFDpR3TC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220148

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 35 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 16 +++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3a11e6f450f7..f677705921e6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1526,6 +1526,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
index 2be37eab9279..b9150782bafa 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -141,6 +141,41 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
index ac2329f24141..89b44762ef02 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1506,6 +1506,22 @@ struct vfio_device_feature_dma_buf {
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
+	__u16 pec;
+	__u8 pending_errors;
+	__u8 pad;
+};
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

