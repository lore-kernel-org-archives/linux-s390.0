Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BF3D88F6;
	Tue, 30 Jun 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838566; cv=none; b=gTKBQdmTErgBcnY+aTwW5lRliVxSsNO2SytZRYSiO57EJTOwsuCpXi88sqkuEPxHsoOXLwyRgIh83w1JcQ8RhadyDaclqJ6RNLxm3sbMuBxjzTutJLhKNyjbBUrZR96sg6/vq47M3Ey6KPrCZVvFU2dkdTgjisLPFSnIxsZ2noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838566; c=relaxed/simple;
	bh=cXfwIr4xmVbPiHTjVgZ1cRQB3Ky7D+Uoew16gGJXp4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA2e5aF31UtP3099UJZ7JKCIzjf6UveEQELDIj3iXMtqXG+XejdiTI8gYRe5iGYsNqAocNwYnNSdVySLK4wWfA4Z6RZUN5Rz04Su5QRpKmMvEACJYwOLC+jIwVexyOAD0Cteob1l1ng23oIp0ahfcwV2BMThMOaJNh3Uhpf+Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RrtsQ3+Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RrtsQ3+Y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIMqk2288634;
	Tue, 30 Jun 2026 16:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0vd0wSWK+CXzoii5J
	0/EkXyZTfB34SAR9ElAZMuaSN4=; b=RrtsQ3+Yg4JHC5cYRK4WLSkDQOE9IsqT2
	NIbsbrBnhYPfx07IDHG3X1ey7YDSk0LCBhcmy8K5xq0e39k3UKXiJRkOcOEVKQDl
	yW+xyxxWC8+mURHyIlB2zDSwdkzL/W6ja9VpmLL0uryiTuyF6BurWBNaT0ep0aHH
	/B1/a8h9UFuOicMJnmJo3h+VhUdpRoIEpspqcU/vgV7XGTddnwkJ84ehTKp2t/Az
	bPHlYgC2XztrXLHqqDXG9BZnJYxMegCY8rB6BNZE5d9/1iaWqTC/wWOIhs/IrnU2
	65S/hu+NnTQyD67hnobwXUuuCqoigfq3McPKvR//8MSafSSSijZFA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe0205-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:56:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGnhlG030847;
	Tue, 30 Jun 2026 16:56:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk3991-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:56:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGtxR728836570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:55:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33B185805A;
	Tue, 30 Jun 2026 16:55:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADDA58054;
	Tue, 30 Jun 2026 16:55:58 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:55:58 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v20 3/3] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Tue, 30 Jun 2026 09:55:53 -0700
Message-ID: <20260630165553.725-4-alifm@linux.ibm.com>
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
X-Proofpoint-GUID: MyOpUnmxozvzaBHWuraVKH5RsDUJZw8_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX2OmLqJMiZW4A
 pislhJiv8Zz3n56POx5KS9/8g+h8p7YrYnBEHkij+w8GGDsq+WrtR4bJNdBGKqL9ioqo9V9tl/z
 faC+1A0gLi8z+G7ck5KinJTfN6qYpHo=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43f521 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=bf5i11FZjm5gBOpVircA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX1ARER95pFH1p
 C57Th7jdHDnZGacV+5lQX6Kd7wZ+aGoR0JDGXq3CubecaqM3CS+aFrfdDxV73QK+V7YWgFX+1HY
 zVdVRp4IsB2PVog8+S6SQ6R0dmwLCQAQCSvP5w8VGxNceobGQhYsJePcssKgxiUuDBBnZ3aaLi8
 J3CiNwOaBh0FxA4OEych2Z8O0iS0gmEoKLkAViQLJ9rN9AAFW3b4OPNYA3LDGNDABG7Rz9ceuNK
 SXWDg6PVXmq46Sd69VwObJ/Dmxmctf/m8ylWw9KmzeAdGrSU02Gk+gEfUcmzwHgxK5X54Xll1AE
 LPNQ59Uzr/iJmlSzdZEO1br5k0FX0lTkQdMykZsD9BTykjbwwIeMmnPitwctiyKmKchARIpGRPR
 cxrDxlLhLrc53xPo32bNE7pM31KIjWuoIqS+tozn+soPamp9eHfyVBx+0UiROlInGxg6GlGBDQt
 48AAsDE5x/ALCJMGPUw==
X-Proofpoint-ORIG-GUID: MyOpUnmxozvzaBHWuraVKH5RsDUJZw8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

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
index 5a6786feadd7..077a122fb602 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -824,8 +824,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1201,11 +1200,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
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

