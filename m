Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A03988E4;
	Thu, 14 May 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781688; cv=none; b=oZA8grESz6CpGuR625fAXL7KpWj8VI0dpBB1tBhd1DdCqWMB9MExD712sauuMNKbPT8v4XbTUfvcvd26XqMqatk3CIrGtqi7YEcuw7/Jtvgy9qXi0yGvlxg/GA0jVNs2NRfArgljw6At+TIfoanOr7RjZjuWhGMiSb5G9tDTQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781688; c=relaxed/simple;
	bh=3TYFc6itqVc3zvA3ORsy9QJMk5peLve+M+b/RlDFXR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKYBvxpdy+zNmDxRDQ2uy2XO7HS43kWcDPzALBLto+1UJebMGnfazHcWwmQIXewv8psylOHZ2BVW70l3JbDt+fNB5kWmPKVfbhmsnTYdgzEpx2cciKo2E75K7nf8nchjKQPRm2BaxMYi68zgqEsSJEpiyxGfnWqxlcRwB0oU99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YS0alzfL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YS0alzfL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E82KxV3178345;
	Thu, 14 May 2026 18:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2t4MJ6w9XSNqCnRGI
	TK3LALBDAsPD/NV/iok/YHO6WA=; b=YS0alzfLFiOoKdbArEWN62QC6Klb/UpVa
	CysNHtZsTitkZAN2tLwChiUCMfb46vn9pud3RtkCJhmqZGpgO8dmQwfj/t07cipt
	/XhKqSyxDxmULLC2Yyl9VWFOBvj1E0jZlG+n21wO7tA2MKNV9ySw9k2PNsoylHQq
	jXdQweVPCbS/GD45YrXbs0SMDclxVBU39rt6Vbo6c62PcxWcaV4Zkkcw/QtGEfm+
	Ts6K+PnQ9ZYsUEWjN8ZZwRJODN2nNaXJqrJxiaOPREIDBcN6+lZqoEA3wPf1+okj
	yH4dk6KdiMaD2sFyOytyuHz65TPg++AmEnZOdn4wtJFwYW+LT7K0w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6w60t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsVAB019461;
	Thu, 14 May 2026 18:01:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgwh1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI1BBP22151912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BDDC58054;
	Thu, 14 May 2026 18:01:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DF4758045;
	Thu, 14 May 2026 18:01:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v16 7/7] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Thu, 14 May 2026 11:00:59 -0700
Message-ID: <20260514180059.1553-8-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a060de9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=bf5i11FZjm5gBOpVircA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: nyEJLopEp_Jwbo1yUwayZDoROe-6xWV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfXzBscWbGvk/zO
 skXbplEBIZnZRbDrHJryqd/PtIuo/5IiI5PiBffcvE7unSb1+F+TGERLojbLKRyDstPAE9WJ0Us
 pU4lQtJWPD4rExBPfFIl6Lg4+757+HR8xq76APPIsMHMTDmmuh7UPG2rEq0uoI6HB6dNwrSiIcj
 W1gNpx8wObNL0SvKJ9Npem41HEBPy9h6NuNvSsaxhXavvovywsRdnZJYb2ffS8FdUQDk6apfXlw
 0ZGaaCN0f+49gut5YQITDIdHqgJoVQc12iNW2tw9+xm3eOrK33cdzABfXXfw1liCN35bUAcfOo/
 q8hky1+9GYBDBY/37PCRVY6hXyLEYims5qkh1osfeEtiZXoe0eATT7laTlTPai8mQwP2c03mr7Z
 e34cYUlss9CGi3rtiwABdcdQAXnBMGbS7LYxsusNNG+AJ9nfyKuHqAGxk6gQfnTJofiaNbw6EKt
 +Rm/3OkCIvEw8tmXaiA==
X-Proofpoint-ORIG-GUID: nyEJLopEp_Jwbo1yUwayZDoROe-6xWV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140176

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
index 6358b59fab2b..cd9f31b28160 100644
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

