Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1E2253F6;
	Fri, 24 Jan 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749859; cv=none; b=R7hqjTqziffba77LegZ0/aT7u5PGePHnykJ2ST4rINYgknVCt5ZPTBAGuSEAh+lX3VTBQWUK2vfLRSbFdd5E02XE0f/3tvyXC21VOIg5SVzDqcuVY7rrYUEQ2hnZ0q9kf0LGlaJsUCavWTDAppoYIyCP4mT1Z8Zdb9cjI0WpeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749859; c=relaxed/simple;
	bh=qomaoNtwKc4f1cUvuWzX1k5KjAKL2/badCx0Fkfe5sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR9mYyoAs3894LVQ2cIJYPpQZrji5nD6wbFxtTKf+Eii5hriMO9PV/ntwutkcPobNuyRmiNhC9DI0q1Rlu7AzMPlJekMyYutPpxfYIFL8tzY6wfLAcLn9RU+Q9zi7+a2+TsLdrOJ6OSPCLkviUY+GnFeWAHIs6IvGg6q5wjAJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hh86CmXj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hh86CmXj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIXemt017575;
	Fri, 24 Jan 2025 20:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vnWgB6sIKU8b+dpca
	uO0Iw9YWJ3ws3Uz+AHtg2bv7a4=; b=Hh86CmXjeQ5k7mfv36BPd6B4ulSQQ5kAX
	rBsMthSEXAWc/oZN7KbsjzEjn8nFcIavZRMY7jsUNAvUk+AVnomz1zf1487XgRo0
	hLb2P2wyJGNhQ65UfSbWhQ4OteELJMniVTjsN7nW2/qR6xY5IqIfrHvloTv8DloO
	U1SvL+DBYDdlXZ3M09Sz/IE4V4xD5nNvBE6xy7x7oNO+3/FAGjE8Y5P4CCgp0wK2
	ZabM+NJJ4/CYkyvoor4+hwV6iFSATDEMro1jS7Ez5QNlwa4gb8ImfR60dbA5/KBw
	e3V0jTmA8B/t+cFpbxeaQNJHmvdGt9OfH1NPXdvyf/x8Tx5952MqA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x95yr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OHFS8N021012;
	Fri, 24 Jan 2025 20:17:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1vwca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKHNPW15598236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:17:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6670E58050;
	Fri, 24 Jan 2025 20:17:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E174058045;
	Fri, 24 Jan 2025 20:17:21 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:17:21 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 2/3] s390/pci: store DMA offset in bus_dma_region
Date: Fri, 24 Jan 2025 15:17:16 -0500
Message-ID: <20250124201717.348736-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124201717.348736-1-mjrosato@linux.ibm.com>
References: <20250124201717.348736-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ieYKbDoPOPvSCMqGpHFaGcG1uBUYo-cj
X-Proofpoint-ORIG-GUID: ieYKbDoPOPvSCMqGpHFaGcG1uBUYo-cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=764 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

PCI devices on s390 have a DMA offset that is reported via CLP.  In
preparation for allowing identity domains, setup the bus_dma_region
for all PCI devices using the reported CLP value.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index d5ace00d10f0..51fa993b64fc 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -19,6 +19,7 @@
 #include <linux/jump_label.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/dma-direct.h>
 
 #include <asm/pci_clp.h>
 #include <asm/pci_dma.h>
@@ -284,10 +285,27 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
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
+	map->size = zdev->end_dma - zdev->start_dma + 1;
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

