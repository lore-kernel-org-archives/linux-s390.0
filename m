Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3223994D7;
	Thu, 22 Jan 2026 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111126; cv=none; b=isR5eNjUDdX+7rneJtmemk4GRerY8MGBowuZ1ifZ+WavO14/KzYubBJsyZT15PUB+zClx73VlPpicdrTMOIrIdtPqWPh4ybsCYIFKGAxfU6UR0tk8O5ZLfyoBZTLUZqQ8z9B13wnMlRaYh6HsOYWe1IgLCCRIfBkG1mFf/wBl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111126; c=relaxed/simple;
	bh=nSmySBySN2Hw/5EveVaUYdlLwQnt1kcp5+gNd5r/IIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBib1ItB7QJUwOIjMPcJT/oZr9JRUfBKrxtEXxe7K7RXpICN5zIlqEKm6RkQy/2NgbYVIjoLQR5QVS80HOdeSm2NQQJvDtHHP0vitDUMp7vsBD20gy36B73aFF8zICnXeIG8pqWhwjpR1BqNa7n49jekbPEViyIsDBNZbuVIvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a0Jajtzd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a0Jajtzd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCo21S028543;
	Thu, 22 Jan 2026 19:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JFB8K2p7vYMAhirId
	hFMBgDuwuin6nX5Bg2vjH4kOmg=; b=a0JajtzdXrcvf/YGhE/lHZ/zSd/qDRmLF
	HQGArGEVwYbFIGMR8ZgyIIXlQ+K6jDVqpzFSjcUTK7IOhcIvf1p/1VJT6m6m4vfo
	q3ek8dOJH3drgP/HSAHy6/Ag+y9BZ74XpkN6EdjmpL/aNtnCMZKtj+a3isvAaH7C
	jNo0AQ34EEJYamzSBdE+YqYBBxJGzYE7IQWWnMZ8euyPJXIA5gcONKaC5mNm9tC9
	c1IOpdJHCS7oUoIDjZC1rtMqi312a+S1six167t1t/qyeOTy2xl5sFirX39f7hVu
	YHq5KJ84fR/Foh6K1rGUWPNBS85qgZbolkBpqC2F3kBDhTClIQQ+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60eycxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MJ5X9T001441;
	Thu, 22 Jan 2026 19:44:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk49xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJimHc19923678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A0B58060;
	Thu, 22 Jan 2026 19:44:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D672558056;
	Thu, 22 Jan 2026 19:44:47 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:47 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 9/9] vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Thu, 22 Jan 2026 11:44:37 -0800
Message-ID: <20260122194437.1903-10-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69727e32 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=9wliL4UQvNVLrYCoNVcA:9
X-Proofpoint-GUID: uB2SGKpzz1QKxIOpcEkg3bPA05Gqv7oQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX/qbkvG3RNTxI
 0Z4nHy5CmRVB9boqXQac/5hPESgGwOm0S1+kD1FRS4rfdCXfz4zYJxQLBLAu3pNc2gDMXYQF6R2
 F1GX6Y1G1GYJksoaNprFMpC21K8aGh7ovDt57m5gD8tiaAad2GVyEBJDERkBhJQEbraLD2W/ly7
 KCh7KdtkOouDEtky3cSfC0M0sD4A9JQgCRkQkbKXuTpL4Dw5be+1L+NqLQazagaM9yQlZtlE9z+
 bAxnKzf2fK6jnMVWi6syuVzsMmIkZUez2gQUTLnEDENyVsa6/GCKRIEtTpT6sDY3dewZPoVPInl
 Gt8Qf60IeDIzhA3sux7V85qNtLgPc/Eu1OxDHuVkxGBhEor3wrJ9aBoapRFSIJsYwFjbdjIMMlg
 mQi8EHB7EMpYo6MMn9J2jw8WEVhKq5bPGr57HtYFGfp0z999O6WXSoznq/lSwwCZ6ClRy+ip46M
 6emdZJuoeJjhVwotQVQ==
X-Proofpoint-ORIG-GUID: uB2SGKpzz1QKxIOpcEkg3bPA05Gqv7oQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220148

We are configuring the error signaling on the vast majority of devices and
it's extremely rare that it fires anyway. This allows userspace to be
notified on errors for legacy PCI devices. The Internal Shared Memory (ISM)
device on s390x is one such device. For PCI devices on IBM s390x error
recovery involves platform firmware and notification to operating system
is done by architecture specific way. So the ISM device can still be
recovered when notified of an error.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c92c6c512b24..9d44df9e21db 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1155,11 +1154,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
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
index c76e753b3cec..b6cedaf0bcca 100644
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

