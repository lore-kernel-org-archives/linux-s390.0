Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D372B21;
	Tue, 17 Feb 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352598; cv=none; b=VAmVY79hnvDQi9hEL7CNJfaoClhbVe/pyQhRmPHnM5LjMKHRxts81iW0p5XNAX+y1xhsYF8t9BsaHh4XfrwKap7DabNRyS0DbiW4L02qIE6wqw+Zyux0YykK8To8aOVx2XJ4HPps+tQY3KmF6fw9rjDGA/n99kaGpzLb96LVNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352598; c=relaxed/simple;
	bh=FC7k6npU4EkqkvyqX0fF1OeBEG2gL272qe/MVOKH8E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4uq3/eChe/kRSdIqezeoL7pMKyGS94o0cVjUrz6qcYKuvrcFudmpZOGbSs0VCSSbBhewCMFzER7yU/zXGtp0rJtdazXn2HXeqJlCAr7XSnJE+b7ZUnnGlTieY17C7xeCxxapzNSB7sArvSxzl384IN9uXgMnG8zxGV5Wv+93Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a/whckNu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a/whckNu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBn2qv1915831;
	Tue, 17 Feb 2026 18:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u8WeFfuY8wxbxns7A
	zTIs3CrhJUGqqQfuDJbWcxBIqY=; b=a/whckNuCNYIi/4lJVm/UHPysHc8u34d/
	OXmHghvLssGMA5I4Deh1kRGfMmP0H0h7R9VRDw3l+4KtIJVQljvZJoH9ax550/cd
	+qza9quTT6xIUxz6xyewfgjnzuUD1wLsDSYkwmqiHGMzyVuApzuqG/SIH95iI/FN
	TcHv4Tj1vlSc0GR3SaNsNgrn6i5s+P2vQeiOZnuYDwagB1XcP8HW7Q8b6lQEe3Vm
	gUlypmcgPZTq7U2GQbDBS4XD7fMRBQxJMAmvtd7ER7U7C0I3cG/Za6GYWWYPs0+J
	jt3xyk9xLjg3ZO251dLhCCXxTrftH4x+WXelX/g3K8iDhywFpQxGA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6unjx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HG1VUn023899;
	Tue, 17 Feb 2026 18:23:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb454424-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIN5I861407624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:23:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9259E58056;
	Tue, 17 Feb 2026 18:23:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C13D658052;
	Tue, 17 Feb 2026 18:23:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:23:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v9 7/9] vfio-pci/zdev: Add a device feature for error information
Date: Tue, 17 Feb 2026 10:22:55 -0800
Message-ID: <20260217182257.1582-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217182257.1582-1-alifm@linux.ibm.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994b20c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=QIy8Zix3hhx26zbqT_4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX8j5I3zqyuWDX
 apktNaGDPskXpVFxz4cjWCzi9i8ow8Sx43Z2WX4Fx1gxAUbTol5UF2TdJ/X2fLZl14imAZWdIQT
 L9Pmbtm3Bx7FtjJbFobuV7TW+9O6KBOZRCWH4nLPxgMQI1PNnm+cKTgaE8gLDRISneUE8E2zbY+
 1JKXvh1se64ff3n01+Zey6NBccEQcWZdn/trUEUq0D/dv2ul/Qpvoml59ZgGdUXqtOnP3nutK1z
 RKnZJVziB3Np/+AoybtBQlbAU4wuC5hOqaD+ABV3gZ7DTLfWPTM8a/s/5NIC3MEvoF7RB8bRkQK
 4wJwvMD15UJ7jeH+oYEW9OiBbWUxqL612LbQXV5mhxSXMNr4t1mo7g7pdyrc0icaRlz3eL7ZB8U
 V7ZXteJoW0mFWCJBa8uYtGENvNNyeDbVHPzKvpnC5mgXjkrbWfMpy1X+T86kiiZ6Ue2XqnpEOlK
 w/yaan+gG3a7WK6+dCA==
X-Proofpoint-ORIG-GUID: 4dwI4RzOKfFK_PMcUh8m-yHv4EhzMjt8
X-Proofpoint-GUID: 4dwI4RzOKfFK_PMcUh8m-yHv4EhzMjt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170148

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
index 72c33b399800..d2cb498c026b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1535,6 +1535,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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

