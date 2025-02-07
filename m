Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9881BCA0A;
	Fri,  7 Feb 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961643; cv=none; b=gs8/L696CTQT5Yy443je1c7NImB5Hb1/FI2P3H7wF7q/m13WQPlW0X0ti0vm9/g7E1rLiLrgjz6PQJ3jSSP077FnviWE8t4BrOhxogkh9khYzKw+0djBgU7UjRZJP1+JiJiOxAkmweliRL2R2Xf/X13IdaROJOLTDBsWJXLUQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961643; c=relaxed/simple;
	bh=G/gYVfdR0jGCYe+uCQCGm1RMGyIQd/RmKNk00I4nQYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmgFsgyFDfsTRXTx9hYCaMIKL1FH67qsT860Ydzdg5bVLXxTlENVu/3ldaicU0bdMXQkz73sWsbwms/JbZqeoCFVG+3elHrEM+mKnhdgjiSiEZEc68+NLpuQcabWs50mo3VKFuWehVgJP6T/qjI0jfAU6OjwZ5Wl9DWusHqy5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPm61M57; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPm61M57"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517IteVs004555;
	Fri, 7 Feb 2025 20:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AFaBhEgRHszBQVyqm
	gvXOaJaqN2QA2rXb2b6nnOJXxs=; b=nPm61M576xr0xd2crW+BxDbkfXIA6Azuy
	KyQ3OjorsDckGlSxTJ18s0GL7KS9oBIAinvDPLdLQ3zHXOcaDH+kS9Cx4yIlnWZ5
	jvRsfGtYtz79t+wkzXoO6iFavdmSKXtt1i0fvq2GrmNZV13h4tyy/oYeXbs4i296
	13uvPhSmJU+lDWikOVfnGCY3rG3gwtCUKWGwbHjigrRkarSfjn3OBQiT7zq0+6s5
	S28w629Db3tvtOnHMQCt2U/z13rquCHO6crBGxC52s4Egf27hfE0+QC3MJoHD3AC
	57Z0noplnoOnKVrJd/RtIVp3neStiFc5nMhCkygUHKfgy5fRJorAg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nfn5kcfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517J13xh007150;
	Fri, 7 Feb 2025 20:53:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb05h50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517Krelm22348294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:53:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14ED258045;
	Fri,  7 Feb 2025 20:53:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79D4258052;
	Fri,  7 Feb 2025 20:53:39 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.30.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:53:39 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 2/4] s390/pci: store DMA offset in bus_dma_region
Date: Fri,  7 Feb 2025 15:53:33 -0500
Message-ID: <20250207205335.473946-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207205335.473946-1-mjrosato@linux.ibm.com>
References: <20250207205335.473946-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M2YGEuXe8_QRG5LRmyGCJRELJbZL8kiV
X-Proofpoint-GUID: M2YGEuXe8_QRG5LRmyGCJRELJbZL8kiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=761 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070153

PCI devices on s390 have a DMA offset that is reported via CLP.  In
preparation for allowing identity domains, setup the bus_dma_region
for all PCI devices using the reported CLP value.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 857afbc4828f..b5c35b8e47a4 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -19,6 +19,7 @@
 #include <linux/jump_label.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/dma-direct.h>
 
 #include <asm/pci_clp.h>
 #include <asm/pci_dma.h>
@@ -283,10 +284,27 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
 	return zbus;
 }
 
+static void pci_dma_range_setup(struct pci_dev *pdev)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+	struct bus_dma_region *map;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return;
+
+	map->cpu_start = 0;
+	map->dma_start = PAGE_ALIGN(zdev->start_dma);
+	map->size = max(PAGE_ALIGN_DOWN(zdev->end_dma + 1) - map->dma_start, 0);
+	pdev->dev.dma_range_map = map;
+}
+
 void pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	pci_dma_range_setup(pdev);
+
 	/*
 	 * With pdev->no_vf_scan the common PCI probing code does not
 	 * perform PF/VF linking.
-- 
2.48.1

