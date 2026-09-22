Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8464A6CFC;
	Tue, 22 Sep 2026 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106734; cv=none; b=dcqQ1vFmPxU5s76Wit9iZK6RCmwxtrosUnv+lTm8FpbCGik+LSqmzuQ7KRy58XCSDDxzi5vsB3CqwgkuW1uuhjc53o8czKgxsnJeIueQK5mzNqK2nqSi4k7A3MW9nMoDQ/DctupOXqQdS8sESgpnz60iE3+ReADFvdD6YJYuOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106734; c=relaxed/simple;
	bh=mY4UP2f4L77OnrXNl12uKtgZB9nrnrL7BdEDy+bgdE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK1h9GvUq96UzMCQ3CUfPr2znHyH/Nudpasd2NogDtIfsiRVAO/mraN8uWPK/Xqe31GBS36flyYmw0Z+gnW2Q8Iyf5CVLqASH1BeBCawJCKQINmFMXbqRwrHYlJbnn/Lk0MFxB8WnuPTBS55xuLp4PJPJNaQ3DzhfdCmo6GgzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e3wOmI5r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e3wOmI5r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI6wXn1128975;
	Tue, 22 Sep 2026 19:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WNswMr65Ld0ueut0A
	bNhAv6uW4AjKityQDyk7FgOIZk=; b=e3wOmI5rhFd7wTrWoXfAc2KdIk4p1Tvma
	Oeln3MPhqQCOIbRp01YRQBNGt89r7kwKbZKFkEpxS2pg5kjaf0I2yB1S4dO/9HxS
	h8tS39NAg/dSbA3rwskTN8n1oZvjhUAUHvk2jP04uY1LfIY3ACD5o5a8VE7WksJw
	6J+SJNiBBvOOg/6L6UVyBmSsSihzBmmbTpzuANCdlW8cH0Eyq5Z7GsD5GlGs5epx
	7C6wUPE9D2LCs/fsyw9ZVfXUdw20OA/KYBxVbz065SQBgWmYE0JmL/bkyIl5ZePw
	eA+EGYuiD2bmq4ctPT0cUuWVgCS2qapXlb/RMd3tkBEq5iTt0p/kA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2fr1j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHdGj3279480;
	Tue, 22 Sep 2026 19:52:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbd04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MJq6OX51183982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 19:52:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 886F958052;
	Tue, 22 Sep 2026 19:52:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4C2358050;
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.246.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
Date: Tue, 22 Sep 2026 15:51:41 -0400
Message-ID: <20260922195141.94548-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922195141.94548-1-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ih2ZwN7__0c5mkxLI7SuZyeFSp3J2mJ-
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2dc69 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wtvrgtD0Hc2VqHSVShsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfXxsObF/FjpK+d
 oNrS/XTNC3H6/1bqX3Qu4fmRyvJQWZc6T1Uyu7S8AZIqr+Od0mModclZKL+7gbp7yXR5i6tv8IR
 d1dFrQ1HNard2twTWaPt+bhOsxzS+mUQnJ4ohnQIOFLIpumYhxMFzLhsXudupWzqPPktzvrt5oH
 QLl7SaX2v2/7jvM4x78UhO6giOMk3kqp2gDsLAMKq8rqy/7iFLP5h4P9RjlJ9GuzF7N2ZMLPm7F
 0frkQOgn2v3gIdKOTmXsTQG3eRvcyOF3XXKgA8eDZlNhjibiRuPCiGrN3zhH3KzqLdkv6eCU6Jn
 USzBg6IPQC8GHl04iSGqdvP2Ima38TIN/3QM/rrbuO70jhK/ijq0wWMghMjPC742dzlXnE9wUMG
 sivyJeSWi9frqn7U4pt0Z42AU2nlRKSeWD9I3l7xLVEURLFRDtmEFqQRItas37m7W7PHcqHl0l3
 4vqkN+adOP6HSg/LR+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfXzKTaGNEsx5Ha
 Waz0eyrkeTZoVgw/ikSwlJ7X76DOOz9mfcIilxUIw7Q8h5Kl22BHQY9QReNbgL7tTAiPVby0qOD
 LdPcTCyo20FO1BEfb03xjw81918Qk4A=
X-Proofpoint-GUID: Ih2ZwN7__0c5mkxLI7SuZyeFSp3J2mJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace.

Allow the user to enable or disable the FMB using the SET-only feature
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
in the case when the FMB is enabled.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  4 +++
 drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..3c827a77725b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1627,6 +1627,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
index f47f36314a1c..b028de8e08a4 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -219,3 +219,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
+	if (!zdev->fmb_enabled) {
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
index e41437fa17ad..a8d501e42ef9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1555,6 +1555,35 @@ struct vfio_device_feature_zpci_err {
 
 #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
+ *
+ * enabled is treated as a bool, so any non-zero value evaluates to true. Nested
+ * enabling resets the FMB counters to zero, and nested disabling fails.
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
+ * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.
+ *
+ * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
+ * when the FMB is not enabled.
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
2.55.0

