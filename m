Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6C2036EB;
	Wed, 12 Feb 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396079; cv=none; b=sFZZMvZ4XmByw25EvsJB+XGVlJDWgLWNpusqmZezLJoVgKGLfexS6F2ontioBbkHl7oWqnFrLJDSqsudfA3SDLw49mx49QrwLuRAWvxaQOMTf/1Kivrq0gKprECNTZmSrYnoI7bK8Ia9jxPHjnaee3Ot8X9OhPe7PDltjc6uhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396079; c=relaxed/simple;
	bh=Pz27KBxivFB/1h86mWXpvQYtsw4RQhgfR+83qzBhmnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mte2UtarhR5SgxTi11si7CrRX2aOQtxvD94Dma2z1N6NoNNH19a17M+kuVsdMQ9gd2HHCP3OMlCgVcfUAvPJdOvWSkUL5sdDvPFRJoDzPYaUdGnd4cKVzfa4ASm+LneLG7C/QW/0iynuHsIO3acbT4lneHoMut3s8u5bM9AjUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dnhDHfq6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dnhDHfq6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKGA1j011934;
	Wed, 12 Feb 2025 21:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VOi5YzOhZwWrlCPfS
	pxx7Q8bocn48/ZD9KlSCzhf0Hs=; b=dnhDHfq69hFnnYhqxTIqdmxriNRrNeIwK
	Uq2aBGOp14hKmlqOytFDoXXhTDplHzMNodkxZgrxDaDzoajrvTnpCkfIm1W+ZKEy
	57G+PDC2cqGFRaFY3MGp2pl2Mg6aedRE9xVDGWkIFt3+NWgFqAVIuUmymg8lMR7D
	lYEJmNZ+5garKJv97VGwmNYdFPfVH4DgiTzIO0ULSHr+fI5cTjMDjGDMPTgay0OK
	19YaKdzPAEZOCfnMDzpJZkCof/VkCyDmgG54B3sF1VBMpp/mvOCU8VTWJUc0e2oe
	NrR71nnqgSAu1mIBFSQKxpwz1Ec+6tLJt8TnCq9ae57L0IOIg9yqA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa67dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIMhuY021875;
	Wed, 12 Feb 2025 21:34:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksu5ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CLYMEX25625242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:34:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C90F35803F;
	Wed, 12 Feb 2025 21:34:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB67458056;
	Wed, 12 Feb 2025 21:34:21 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.186.234])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 21:34:21 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 2/4] s390/pci: store DMA offset in bus_dma_region
Date: Wed, 12 Feb 2025 16:34:16 -0500
Message-ID: <20250212213418.182902-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212213418.182902-1-mjrosato@linux.ibm.com>
References: <20250212213418.182902-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K5T5_4uNLo_nPJYvu_eeRl2jxD43pfgS
X-Proofpoint-ORIG-GUID: K5T5_4uNLo_nPJYvu_eeRl2jxD43pfgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=768 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120152

PCI devices on s390 have a DMA offset that is reported via CLP.  In
preparation for allowing identity domains, setup the bus_dma_region
for all PCI devices using the reported CLP value.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 857afbc4828f..3fa113c4ad8f 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -19,6 +19,7 @@
 #include <linux/jump_label.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/dma-direct.h>
 
 #include <asm/pci_clp.h>
 #include <asm/pci_dma.h>
@@ -283,10 +284,34 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
 	return zbus;
 }
 
+static void pci_dma_range_setup(struct pci_dev *pdev)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+	struct bus_dma_region *map;
+	u64 aligned_end;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return;
+
+	map->cpu_start = 0;
+	map->dma_start = PAGE_ALIGN(zdev->start_dma);
+	aligned_end = PAGE_ALIGN_DOWN(zdev->end_dma + 1);
+	if (aligned_end >= map->dma_start)
+		map->size = aligned_end - map->dma_start;
+	else
+		map->size = 0;
+	WARN_ON_ONCE(map->size == 0);
+
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

