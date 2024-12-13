Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974019992C;
	Fri, 13 Dec 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130202; cv=none; b=Mh5VGhqp4KxOfsl7ZgRx0na5D/ha3VFFm5i3JDD+aJi1rnkt3AlTAJwHML/MZ9JjFNR+kcqEvxDEvUnLAzZeRlOLdYQj1zcEHWzbnzn+6vA6STANE2BfebwVoraB+ZMSS/oTdhDkF625+armMPy/UXNuwDibsWFJP0FtSzwlu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130202; c=relaxed/simple;
	bh=NV8s4CDPlzXfozxFeCXvR/Xud5ZSw+WUm6fxmIWPfEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvmGEJhZWXGR3rgZqZAoHGKLHuJnu7ACUgbcT1CO0m6Jrz2GEDNn6cMGzXnhleUm2r6b7phY4vOAdyY1zSrWoI5SWFxgzCjo68mStVhGzQ0d6MP6NWxinJKp0jJyqxiH3eUQoSTExcdubI9XEayhNIkd6EWD1N8sSYR7gAkoS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XOEMgqSa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XOEMgqSa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfF49020128;
	Fri, 13 Dec 2024 22:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U6IvUlDr62v5uqIXD
	HVMMi+43c+GZHQaTwOfqWN7TzE=; b=XOEMgqSaaoXyQR2NngIFt4h6vUJPUk+R1
	C2wk1JXIZyyxQzg/mhWKMYPZTt0QYfsBMsHkLtYiTXkll3Y+88nnIZBDwrFTIuva
	Jg4xbluXq9VnXCIghXwIOd4oZR/a9IfxWzn7v/dQvLa7lIQMdWMAhFsBS3UzRJmc
	8zpHQkM9wQ/zKqf1Ad7o5YuGSiOfLb1jjoEHZ2YnO8BN9AZR/WH81uc3LKMHMVRK
	lTbpsT0ngus+JtzSM2nNSvALlEeSU+PKqgWnMYJhaudRLb6H6M36pQjEdrL7G/cf
	IBwFB3paLzo8yDoKbJ86xnnaddZwJV7uWpRfuHlLyDiFcRSiKQnNQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbw0su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDIcBC0029231;
	Fri, 13 Dec 2024 22:49:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43gcprv9vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:49 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDMnmmS7209616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 22:49:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE635805C;
	Fri, 13 Dec 2024 22:49:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3AA58054;
	Fri, 13 Dec 2024 22:49:46 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 22:49:46 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 2/3] s390/pci: store DMA offset in bus_dma_region
Date: Fri, 13 Dec 2024 17:49:40 -0500
Message-ID: <20241213224941.571060-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213224941.571060-1-mjrosato@linux.ibm.com>
References: <20241213224941.571060-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1kJc52XyvCxOVmHk5Bdc4F01FsGhN9qO
X-Proofpoint-GUID: 1kJc52XyvCxOVmHk5Bdc4F01FsGhN9qO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=800 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159

PCI devices on s390 have a DMA offset that is reported via CLP.  In
preparation for allowing identity domains, setup the bus_dma_region
for all PCI devices using the reported CLP value.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index d5ace00d10f0..14527687d0f2 100644
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
+	map->size = (u64)virt_to_phys(high_memory);
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
2.47.1

