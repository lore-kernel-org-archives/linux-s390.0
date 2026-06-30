Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E483C0610;
	Tue, 30 Jun 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838566; cv=none; b=uiVw7Q5vq1sRAxv3odf72qscIALTPiyKmCecotVAvoJU3OkCpqJRFZhoXdkJ5Z6wvZZIzaVp79tFrg943JN/yFfOyTsM8WbwQi1ChgVPylVfF2vql+/5onJtVWMvQJkn7rHeBe5iHKm8RbsiRpM+E2CiyWDncma7azojIkVm2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838566; c=relaxed/simple;
	bh=lxQFAYKKEeMtA+2AbjOf3j3Fi6NydddBmd32i7k9pNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3gtVJ49TqaCydB5jwWEp6dlaLa941hWQZjLu95RKsLMbJuhsjq1gaufb5jXaCkt60sVg3cqVyK/cQ3tPWLei+m2xs6BkvJAchbf2QQyaOsprmsuxUIy6neM1ZK9mijBMxbJWzu1CMoSbIjE5wDLxqHyt1w1UgpDwrR6kgm9BIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tjYwQQpq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tjYwQQpq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIF6L2288429;
	Tue, 30 Jun 2026 16:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8pSPehLSEXE81GCN3
	SSNBgFMuZRRyi/JXfgOuc2zlWc=; b=tjYwQQpqRuRGp/nO4mprql1XE5s+3oxld
	anNeXbRqY3asr6BvHE6TZ1UkKj6INdDUr9bMAuJvyCIfQ6sW1IrDG6rQG0ZLsRQ4
	q3/adV4F9rtpiTowEak6q5cbpdbMO399lyaszL4Vfjpy3EYljZMooHj2930msGad
	gXYmReY3v8ih/410G4zRR6rHYHx2DL38DKGRreBQoLB+lCIbiE2dZv7F3z31hIpJ
	Ojp9128339l/P6ZXDXdTnTNoDmmM87JoGsHjxxd0Ir4zJMo9R1y1SnzqIaGw+WDF
	xRmvcw59fFEMhOz5WjnUkrhXYDbHza4e6a6G67BCvo0HyKQ2+ui+Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe0204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:56:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGneHT002024;
	Tue, 30 Jun 2026 16:55:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyb0tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:55:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGtwnV55837050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:55:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F38735805C;
	Tue, 30 Jun 2026 16:55:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE0CA58054;
	Tue, 30 Jun 2026 16:55:56 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:55:56 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error information
Date: Tue, 30 Jun 2026 09:55:52 -0700
Message-ID: <20260630165553.725-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630165553.725-1-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qw-fAo6ObpcZOoAbFth7yI8ddl65km7Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX7K+4IKXjevgV
 1Qx3Dn0aJQ4ujwPuFrMR1RdPMoJwT8QD0wGBgjQ/KkAyE/B5ya3aQq1IAX+r+PymJAeNcWTmxBW
 fd8wfNVgfQDjHPK4l+bTc2XAFOzl01A=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43f520 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=bTCNcXUL3vjCFlhXTfcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX8Z8gssnBMCbG
 nBi2fDZq/og67huCKIXte2rrFrzfhh/jCb2MH/R/Q0nqLK8g42thFyM5iz975COPADRYPyHzL/w
 nW5X/K4o7/hSGwNi4CLmaRsFgckRRfWe5NK/vAxrddvwHHfZBVIFXP4xbn76GVGb2OtwRyLL0/3
 1ifZN5h/QOnCu3/oQKczZI1NqTtF4zcLSkx2GKZMSdXyn7ScPxggBCcdbdvFQ5QNHJyoEAL4jRc
 1SFf4rlXv0jaYvymh/u5fBwQh2zgu+kNMneKr+HhPhQkE+i/yx4QjolzeBRSuhH2Zj1IU9vJ5Sk
 oJEdgIn05jgI/j0U8Fr1/sfDQlxZQUzmREEUNHisMG62j/eFDuu1qwiAnEEWGnz8LSmsKqCMY1u
 GPuigsyEK63txoDZpHuL8fs6XhDaIctS52BYXo8iVuuXs3TL+W/gAWMmYGNhCe6Sjpd6F3LxEP7
 VqchyUA9wuW1IWGuriw==
X-Proofpoint-ORIG-GUID: Qw-fAo6ObpcZOoAbFth7yI8ddl65km7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

For zPCI devices, we have platform specific error information. The platform
firmware provides this error information to the operating system in an
architecture specific mechanism. To enable recovery from userspace for
these devices, we want to expose this error information to userspace. Add a
new device feature to expose this information.

Userspace needs to be provide a buffer of fixed size. This size is provided
to userspace via the VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  2 ++
 arch/s390/pci/pci_event.c        | 19 ++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 45 ++++++++++++++++++++++++++++++--
 include/uapi/linux/vfio.h        | 23 ++++++++++++++++
 include/uapi/linux/vfio_zdev.h   |  2 ++
 7 files changed, 100 insertions(+), 2 deletions(-)

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
index a28f1e99362c..5a6786feadd7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1572,6 +1572,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
index 78a28db00c6d..49aa800fe153 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -24,7 +24,7 @@ static int zpci_base_cap(struct zpci_dev *zdev, struct vfio_info_cap *caps)
 {
 	struct vfio_device_info_cap_zpci_base cap = {
 		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_BASE,
-		.header.version = 2,
+		.header.version = 3,
 		.start_dma = zdev->start_dma,
 		.end_dma = zdev->end_dma,
 		.pchid = zdev->pchid,
@@ -32,7 +32,8 @@ static int zpci_base_cap(struct zpci_dev *zdev, struct vfio_info_cap *caps)
 		.fmb_length = zdev->fmb_length,
 		.pft = zdev->pft,
 		.gid = zdev->pfgid,
-		.fh = zdev->fh
+		.fh = zdev->fh,
+		.ccdf_err_length = sizeof(struct zpci_ccdf_err)
 	};
 
 	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
@@ -141,6 +142,46 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct vfio_device_feature_zpci_err err;
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
+	if (copy_from_user(&err, arg, sizeof(err)))
+		return -EFAULT;
+
+	if (!err.data)
+		return -EINVAL;
+
+	ret = zpci_get_pending_error(zdev, &ccdf);
+	if (ret)
+		return ret;
+
+
+	if (copy_to_user(u64_to_user_ptr(err.data), &ccdf, sizeof(ccdf))) {
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
index 5de618a3a5ee..6d224e7e9fa2 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,29 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390. On s390, PCI error recovery
+ * involves platform firmware and notification to operating systems is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device.
+ *
+ * Userspace provides an opaque buffer of fixed length, and the kernel
+ * fills it with the zpci_ccdf_err data structure. The length of
+ * zpci_ccdf_err is provided to userspace via the
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
+ *
+ * The ioctl returns -ENOMSG if there are no pending PCI errors.
+ */
+
+
+struct vfio_device_feature_zpci_err {
+	__aligned_u64 data;
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
index 77f2aff1f27e..d6c1175c884e 100644
--- a/include/uapi/linux/vfio_zdev.h
+++ b/include/uapi/linux/vfio_zdev.h
@@ -32,6 +32,8 @@ struct vfio_device_info_cap_zpci_base {
 	/* End of version 1 */
 	__u32 fh;		/* PCI function handle */
 	/* End of version 2 */
+	__u32 ccdf_err_length;	/* PCI CCDF length */
+	/* End of version 3 */
 };
 
 /**
-- 
2.43.0

