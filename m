Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B83DEACF;
	Mon, 30 Mar 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892430; cv=none; b=ChiTLAu2ZOUeAkBXWbwtdJnHbtRTQqSSbSn1WI56+wcwP+1nKw9LC7TQY6KBzisIqokSB+rAngSw9pSqBovozi9Y9BdoIkMFi46iwxAwY/hwFXXWaw9X8yD+Xhlvj9sOt2j+P9nkqe1hnfyGB+9fIlHHeJUACck5UlDAXgN12A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892430; c=relaxed/simple;
	bh=vRU3D1yc4J7O0JKYCViE2EsYVKuGDcwFu272wOP/l4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGwvGwUX8dvL4agtKvjlGwZRC7iMhsY6TpK3F1uFy5Bley3dbPxIULdDC263nZGSQaAsCkJdf0AWGC+WLK8OcCOqGxh64vuJejDpEgl3W6ALm1zY2QkIa/MMnfHZOdrGb8nm0D3LhmUrBOeQJxejvbGDPKeNx0y9wSs8w1Eky5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=th7aPtLr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="th7aPtLr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UFLrct371620;
	Mon, 30 Mar 2026 17:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RbF67R4sdld7817hu
	l/0b9urpWXCeSzDuBX3kWwxd0w=; b=th7aPtLrotNv3vwXoe84FbYDQjIh2eQY/
	rfwB2OhJbWor9SebgJ/fPUiAh+4+GQXlQCGRxSoDuT9VKq5kTGjgJXmeK/UUfh+S
	dEmx713n0+CaQXF3iU/V1YSQ4gBDBQNMYiF/ICOO5DdH3gmBTrgJlsAEzoh05Evt
	UFBGuV4SLz31aUjc7q1ugz6rAylNv19C3DM3tUfNBTfSQaZIaSfYWVdOycYKoHJH
	D0zR/LGftRveifC1399WcVaK5IgcVpLCRloP0DAFRbA1+zR1dQp2kA3K5LNQzCtd
	2HkzSDrVr7nFy16dQEepc37P1Kg8a71yfQRmSYIF7MX+DGcpReDYg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc7pvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UESON7022227;
	Mon, 30 Mar 2026 17:40:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamwups-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeKL17209750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B226C58052;
	Mon, 30 Mar 2026 17:40:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96A458056;
	Mon, 30 Mar 2026 17:40:19 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:19 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v12 7/7] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Mon, 30 Mar 2026 10:40:11 -0700
Message-ID: <20260330174011.1161-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330174011.1161-1-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cab586 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=bf5i11FZjm5gBOpVircA:9
X-Proofpoint-GUID: tD28TRGDMcX6DK1y_s4etGcoW7PsiZNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX3L9pgkFMQvCL
 GUz1fNbrwy7Q/3RLvRcPny4rb7j1zABzwltsvFuc7XeGmWWOBYlsxblzLVkHUg98FzruLdgJFgA
 5uSAN/5u9lM+Z6vMmLrGCudotXwbU3OBpmO2vQ7M8We24ChalnuQ/Q9TGEGY3V464nJvjMR21Yf
 158jMRTFUfkEWxVKrrWCj87KJUOTpX7baSOAU8WI5WgawxHoNa0hPcg7TPQjIAf301xZGa2n7k6
 7xjheslue77p8Bk74Mc+M/nE0F6zHubbbY4heQLD+mBjG5+7PIdEiYmVi9JMgT6kxbL+Klk6p4o
 2/LALMzKBImRuqQNrSrlV2jHw1pK2sa86ElX8fEtIC+8RI1lhNn6+VYFm4BFgwaLRZD8El3zPz2
 RRPA7BXklowsnfnRL2dZQMb8uV0rHLVK+HKgS2D107uFA6uqe6r8p04w9d6vP1WR6drxzyTW1Ov
 LbGh4q6GbNQEQzBNNAQ==
X-Proofpoint-ORIG-GUID: tD28TRGDMcX6DK1y_s4etGcoW7PsiZNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141

The error signaling is configured for the vast majority of devices and it's
extremely rare that it fires anyway. Removing the pcie check will allow
userspace to be notified on errors for legacy PCI devices. The Internal
Shared Memory (ISM) device on s390 is one such device. For PCI devices on
IBM s390 error recovery involves platform firmware and notification to
operating system is done by architecture specific way. So the ISM device
can still be recovered when notified of an error.

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

