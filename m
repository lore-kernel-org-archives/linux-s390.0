Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A138423D;
	Tue, 21 Apr 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789053; cv=none; b=AChvsXINc7KWVsUJzhn20EfE1mndpMSaAq7Ilz9ruXfrFDwkNp2cnrzMedXnHXoLxZ3Zfi6zdw4FOG7vJdIzZcQmgGJxv7RWBJ8in7mj28vagy/xKYgigtwN5iE0z//2YikHPas4TVVwbw6lmAByksK4xByd3iwSMSbyN5Tpus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789053; c=relaxed/simple;
	bh=BI37w9SjuKL3yvCM7bDoU4en5ns30NyXBnAazDt1Q0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eneR6aYr4WO33fpSjI92AtdYqh7mQyKMAaUF65+sc671x0tUyOcDO/p0HxP3CYqelvU2QGY7Gr2YHo8v/jZPKzQA4bZGWFukqkxHXJlXrJDcGjTModu/LUCd2XNI9mRcrdxyHdWSe2U26xKvGJs6Fh468/ZXOHT235AGKLQWcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QBbGJc0N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QBbGJc0N"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LC24Kp1685435;
	Tue, 21 Apr 2026 16:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ptCH11AOccuUefO9O
	9jqin/FEkhD0OjCVnd7OxBRv5U=; b=QBbGJc0NlJjwTwaYTcEh1t+OdBhA2dHNb
	xXtedBucnY6irNrMiLZIcTnun9oPibup2TM+W+LEc9IXZGLsEZ/u8RyMKjPySD4t
	tfXYncP/7CGqaRRnyV3UT/ujmBtrPkTiFCDwyGCjwGjigys6WRVrHtrWnkgSzudX
	1Fty4UlEwUoB8BOzPwgxhv78Eu4mbX7P6bNqwahZoQakGj3EUToK8hWMOkpdjjn8
	S3p0AFLQXtiPAtffKiRtRTYbNH4rz8ZqN6CCRUP2jj46LipOdbqUobe8zNUe3Lan
	fn9zArrFTC3z8FKMRr4pJBRDb4EpP/yI5zPDB8ti7CNuWkZgEcIvA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6n903-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LGKPTk025434;
	Tue, 21 Apr 2026 16:30:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k1ead-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LGUhoo29426396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 16:30:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CBC458054;
	Tue, 21 Apr 2026 16:30:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1045805F;
	Tue, 21 Apr 2026 16:30:42 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.17])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 16:30:41 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        alifm@linux.ibm.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v14 7/7] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Tue, 21 Apr 2026 09:30:31 -0700
Message-ID: <20260421163031.704-8-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX73/SrHfMXC7Z
 vR/AHEs23GpdaeFjs3gLFcKjKUMhdkVZZj1renW+u+ksgXn5SGswnvsC6e7/V8GrL2cQKJUbISt
 lC0YbzYKaVraWzItQjJG3C6qBPKZJncS+MYWmoOxjcSI2xnlH5xZk/jKvSweNO30OtnKEsfnCHR
 XvnbwOdqnURxNtAVyYcSwcuDrXZ0B3R/Glzt1MZ6NzoeOKaRyaCRMCO+0RnA4pHNyN6UtFpwa97
 IEUle4OsDlwB7grWKW6rQge69XWQGr41DLornjmZo16fKNFbOSQea2e6Iplg1EGYevVpYoLT76f
 xEvd7PB3Mo3Q8ODUOseCdKGV5y002Prfn4gONsFqT3gI9rgt3lC8shgiDCTLlzBURtQWNhtXWni
 zNGeMbdasIT01fojH88jwuI8OaDVJ/YdEsYGFeWIDp/gluBrFSXxU180PJI/0tXMhUA2lG9u07h
 PdanURmORYQ3l5lcRcA==
X-Proofpoint-GUID: AYj6J4XkIPDisDyKP5fhnW2nJv1-CT-e
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e7a636 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=bf5i11FZjm5gBOpVircA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: AYj6J4XkIPDisDyKP5fhnW2nJv1-CT-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210162

The error signaling is configured for the vast majority of devices and it's
extremely rare that it fires anyway. Removing the pcie check will allow
userspace to be notified on errors for legacy PCI devices. The Internal
Shared Memory (ISM) device on s390 is one such device. For PCI devices on
IBM s390 error recovery involves platform firmware and notification to
operating system is done by architecture specific way. So the ISM device
can still be recovered when notified of an error.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4485d85e4419..407be85dd565 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -786,8 +786,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1163,11 +1162,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 	switch (info.index) {
 	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
 	case VFIO_PCI_REQ_IRQ_INDEX:
-		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
-		if (pci_is_pcie(vdev->pdev))
-			break;
-		fallthrough;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 33944d4d9dc4..64f80f64ff57 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 	case VFIO_PCI_ERR_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-			if (pci_is_pcie(vdev->pdev))
-				func = vfio_pci_set_err_trigger;
+			func = vfio_pci_set_err_trigger;
 			break;
 		}
 		break;
-- 
2.43.0

