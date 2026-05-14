Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F739934C;
	Thu, 14 May 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781679; cv=none; b=rPd9TYNXi9F9emwe49CUPd+k9jxjxxcP+g9VLRwmv3/zd/Zv5ApALYNTwRiEh8KrLKal9QgwWxW0eTX8xADcHv3OK7vvnV7Zjeb6XjTpko9TsLAdW0Pz/Eii+dYVd5f7Q7Kh5YsvuYvF/zC61HZgrc1OvY9+AF1EnGXXD/V63oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781679; c=relaxed/simple;
	bh=x5Q77cCRyz7/WtoDOsZ3XDBNysRpLWGmgsNhx46XEeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0wuP8QSY2yk8PJvejB9b1pCcj9t3rO8nOKbRwcERCxv/JGU2CkKViUnttrePj4FwnfXS2S7tcSL2woKC4GV0FY2A9IfEqClDuQBzYECvY6h1su++EyMyHmUt0yb7NoH1PW5hjCqPFzaDompuRjHJpIC2vaJYWyoBkoQUrS/cO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQKMoq3O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQKMoq3O"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E8D8ZP3775668;
	Thu, 14 May 2026 18:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kXpcXE7cBeLctIAKg
	FJsAKfQYASNox2v+wC8hMNR1lI=; b=AQKMoq3Om6dQTYufpXg5HrKpZW6/TC9D2
	yOPDF4ghZ9Wi5AY5lW/EEOAaNJeu9j8plp1FexcQD/R4iew0lyQygreQTIw8Uz5p
	fXmDVYiewH4HzwFY1FtK8/lCtEnR9P5s7a4Heh+RwYUTaj6h3vE3e7KM9d6rfAiz
	BO2oHFKQvMvTcHbvro3fSQwYa+9+FUtFJ5/5Edw6RJvSj7XTAHGP4qpNKGLLJYhi
	iQPBYvcJ59jkw4Eer7+pjtrkg2F1rLYqQi1zOOmfUu71CZTuv/JRslFSUaBiwzbG
	lTfwudXxRPv+lMsHfwwiwBAunVgTrwUzNuGgJqubiJoa/ORTlAICw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6w613-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsZ1T028803;
	Thu, 14 May 2026 18:01:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgwjc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI19QE15729182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2211F58062;
	Thu, 14 May 2026 18:01:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414B758050;
	Thu, 14 May 2026 18:01:08 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:08 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v16 5/7] vfio-pci/zdev: Add a device feature for error information
Date: Thu, 14 May 2026 11:00:57 -0700
Message-ID: <20260514180059.1553-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514180059.1553-1-alifm@linux.ibm.com>
References: <20260514180059.1553-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a060de7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sIuuyFDGXZ7lsjPJAw8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfX729Ctx311AX8
 7ovyKuzYIjCXDCLnrDty5avtY+aR2C1zi0t9Qnk1tQ8ffxErS7JIJJULCMDOrujtEtErSJZZW48
 caT792hOCUkC59rM3JLdEM5fPGa6hEf3zULon3qSCS6++b7A4PgkNahc59Pkk2dz8C+44ayOU3j
 d27dQaOaV5IZJ9iLTsovXuby0DTi8kkWpfZbgBF1PKJWgRudjfTtuMTnEJsdL9x2uAVkNbunqzQ
 97QKwLyNeUromiWeLrthpkTtwUvToAo+YyuP++BTYjdh5ASXxJVfMTQteG3WT/7IXy5qEeyUqvI
 urryC42Fe0SmfustqpTQsxihhamm+2KXDbQFeH/N/HSLT54S2PL6winJovUHvurayuySS/Mneya
 sniU0X4iY5Kkdd11MnHunKs7SYZO0OAP5P0/JOAkM+qMe4tF8yV/fZQYU7DSRIjnx067A4m7cf8
 hhh/ax5eynMIxUEFIGw==
X-Proofpoint-GUID: UmFq9glEqVSkNqW0unwgrh9t4dc_vYoD
X-Proofpoint-ORIG-GUID: UmFq9glEqVSkNqW0unwgrh9t4dc_vYoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140176

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
 arch/s390/pci/pci_event.c        | 19 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++++
 6 files changed, 101 insertions(+)

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
index ad273decb1c2..ec42b81eff33 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -75,6 +75,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
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
index 3f8d093aacf8..f47a49ca67fa 100644
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
index 78a28db00c6d..cc148123a97b 100644
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
index 5de618a3a5ee..3eead86a00ab 100644
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
+	__u8 reserved5[28];		/* Allow for future expansion */
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.43.0

