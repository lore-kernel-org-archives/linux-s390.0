Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0D382385;
	Mon,  2 Mar 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483629; cv=none; b=O2leacNgMXJTW6OWpA8hpk/KQVbPRtHo0AaVnszN4EfF/D71+kj1ygOGFKzsBDzbw0KHBuqG4T9RuBOvfg7XzaHErbheNkPFsIQsWHdPSWBA6TmBd5mCdrSts5gKG/Q72OOlr4AP/QetLPDgtRrd1v5p43ysaV08xsHsYo5g1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483629; c=relaxed/simple;
	bh=8OogfMIhqpJmvSOuDItyCiOh2Iao9nb8IfUV5zKlBKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwBi33w+B1kaCQTt+BaJChU6Ow4uZKcP9MMqj8hAO0rTHP/iHFaKZtcaMLhSTY9jpRsxXDLK/pMuROaB3J+ZJRehf4NCKMZnZP27KtBre6TG78UvtAh3BZgeAcC26ehTVtZbFV8TrgGH+nXo0ljYChX/8daFlTUBud1QX3v6ysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EN4sIbBH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EN4sIbBH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Bxp8J1210015;
	Mon, 2 Mar 2026 20:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lx/c25tISjemDlf4Q
	BUKY5eA8DcTv+7gKChhoPKjTEk=; b=EN4sIbBH2TmJBA9U3xNgCWxNBvSWW18/c
	YA7g8tWBtSwEFilGTe6chFo74pTRsULWu8RG4AhOMI4aV6YVhz7u5oZp0BJJA6Fp
	Z/qcOew4u4LQGIyM8RVh4vg5eZb0JiBZzM+rZytxlXhlEPDwJkEj88IETpkeJTVK
	DNx+/t+OzcB1+RYfj3mP62UmTqxrK9CcdqhcgKMi0z7QP0jDYHdjuQfZ+ejv8Rmz
	P0cvnIUdKrEvb+Ce0D0vJ+rJFsb40eGfoLqB2NSJUOkVqWrHCW3vqUWGf1nfuqwm
	2M+miBw75tXzJhgFJtxymu2fHuLn6KYdUeiZBkivw6OwPMVZSY6Qw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd8dae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622GQPcv028922;
	Mon, 2 Mar 2026 20:33:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapryrxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXdxp42205552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE55558043;
	Mon,  2 Mar 2026 20:33:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8448058053;
	Mon,  2 Mar 2026 20:33:38 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:38 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v10 9/9] vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Mon,  2 Mar 2026 12:33:24 -0800
Message-ID: <20260302203325.3826-10-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a5f426 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=9wliL4UQvNVLrYCoNVcA:9
X-Proofpoint-ORIG-GUID: yegKC0-XCN24WaHlhkU3EULszsKh4PXe
X-Proofpoint-GUID: yegKC0-XCN24WaHlhkU3EULszsKh4PXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX5JJGuJXZizHQ
 59ds8s2qVX0ZD7sJplMc6/j6nSnQEGrlL663eWdDFkv4pKrTzcYLDEB5iIgj//tqIvQJ6Uy1fbU
 NmanBn8tUDpFWKcz7uNvQXkCGDsMB7ZfGgETus19MvRVSnI2ku4ZTc/Egl6MeKIGB8vZ+csbktM
 IxTrsvvCwGLu/CCPzbYRFmTkoQILix8tdbeO0iXWj5N/nYBoEd9tOIPIHjbzTxQ7b4okm6TBz7g
 OsrAy0403TGQXQqKAdQJZMpvtCFQcliL1aULuPDX7qS0NYPEznorOHZQuoBzyPGGoU2FF8b4Tlx
 5WXhF2vtNWreLD8W15xzIqDvHX2si8k2avW4GqvtBLc3PZ0uzOfoafOI66fd0LcCRuxiJHhBg6R
 eUzAQCdClj9LMafp/10VPvUeduvh2fwZUi6i3sLGqkVaEIGBWDJ9JALPXk9ioqSZix+IRsou9ls
 +9GDLdGDoL7QNtOjp3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

We are configuring the error signaling on the vast majority of devices and
it's extremely rare that it fires anyway. This allows userspace to be
notified on errors for legacy PCI devices. The Internal Shared Memory (ISM)
device on s390 is one such device. For PCI devices on IBM s390 error
recovery involves platform firmware and notification to operating system
is done by architecture specific way. So the ISM device can still be
recovered when notified of an error.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f1bd1266b88f..cfd9a51cd194 100644
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

