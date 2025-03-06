Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6061898F8;
	Thu,  6 Mar 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274751; cv=none; b=G/IXBvQu9FpK17uEVpXwkJlxpsjicpRYusOtcnaChh1TBEZyUwa15DogqkdnPQRqc6DcX4QFJfJvpDcMWudJvmOtK343zADVWEMDyD4rdekfZwJDtMHVhzXBoHf54umZ08mM45LYp5iKFTRL8r45h/1yBVZR6ZCV1x+WQ+K5AzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274751; c=relaxed/simple;
	bh=zeiNMfzgxo99+vnMw5coyNY4NMGJVNsOq+fXyJY/CCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XUSPI/QdqP/5ArYWpNWDOI6nwW2hvn4p0GWLnMNBJlfNXhglSt/IkF4xd4EWO/BRIjRx9PJlp8yz+a0i2McLm+H2GJOB4Mug3WGKkr1HXb68bimO/2+/ZDOnel/mWXlZib/aoplDO3ORRWO0r323HTV+QYe8GT58Jk34cG48pOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nVW6BriQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nVW6BriQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5268cFK6001014;
	Thu, 6 Mar 2025 15:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+9o3XrsSCsDhK59r5sKdttZWDrBO
	VOhUkaFANJsL9n4=; b=nVW6BriQBFr/6MaSgpszG0ssXQ0liQUzTL9WYY2wkkf5
	LrBry7GDAJeBqqf4kpt/5coVIuJEd8NEHrADyF+eu06OEw3LFqWJ7ZdzhY8Aa7Tm
	4Y9+4pSyJHTY0qR9TRECyDdMmvbhTll4yapjuf4MjiiqrXUEc7sHNUq4Hti6dqHw
	GAdIoiCsNn4lQzedBs2opXG5MG5TldCIf30QCJKtTrQkrV4tCQJbIJydlJ+N/O3H
	9wflNVNabSNpm1ygV7B7x9Undcs6m9PWiDVTs1G47+MwmbfVCnPv+x9bF6xHXxZq
	nINFdfoXbE46DNKEd+j6P4+yTQ3WOsS8ngEMMenusQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wspmmb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 15:25:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526F18BW008958;
	Thu, 6 Mar 2025 15:25:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyshkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 15:25:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526FPbPc6816440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 15:25:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10B358054;
	Thu,  6 Mar 2025 15:25:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF0C5804E;
	Thu,  6 Mar 2025 15:25:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 15:25:35 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 06 Mar 2025 16:25:29 +0100
Subject: [PATCH] s390/pci: Fix dev.dma_range_map missing sentinel element
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAGi+yWcC/x2MSQqAMBDAviJztjBaFPQrIqXLqANdpAURxL9bP
 AaSPFAoMxWYmwcyXVw4xQpd24A9dNxJsKsMPfYDShzFxrdyQaugT6W9T1YYaXCYUDq7Gajdmal
 K/3NZ3/cDUnlEmmMAAAA=
X-Change-ID: 20250306-fix_dma_map_alloc-b3b05903dcfb
To: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=zeiNMfzgxo99+vnMw5coyNY4NMGJVNsOq+fXyJY/CCk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJP7ss/oL897u6/0AWynRbX3k2I//WT43iLmRPbxtObx
 E5vEXwk01HKwiDGxSArpsiyqMvZb13BFNM9Qf0dMHNYmUCGMHBxCsBE9LYz/OHSllw5b2Nm3Ju/
 TNUNHZ11Ob0aXRr8R2v67S9vNk/ZYMTIMPld/6tukUeTl+slsNbvft5xQ9Hw7PNfJ2U2q8oHcZd
 2cgMA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h9s9tDUV-G7nmXUHTpACtrSWzqyPSNKY
X-Proofpoint-ORIG-GUID: h9s9tDUV-G7nmXUHTpACtrSWzqyPSNKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060114

The fixed commit sets up dev.dma_range_map but missed that this is
supposed to be an array of struct bus_dma_region with a sentinel element
with the size field set to 0 at the end. This would lead to overruns in
e.g. dma_range_map_min(). It could also result in wrong translations
instead of DMA_MAPPIN_ERROR in translate_phys_to_dma() if the paddr were
to not fit in the aperture. Fix this by using the dma_direct_set_offset()
helper which creates a sentinel for us.

Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
This is based on iommu/next which contains the fixed commit
---
 arch/s390/pci/pci_bus.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 0e725039861f92925a38f7ff7cb6de6b0d965ac3..14310c3b48860a16de13536adf95ef99e6af21cc 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -287,23 +287,21 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
 static void pci_dma_range_setup(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
-	struct bus_dma_region *map;
-	u64 aligned_end;
+	u64 aligned_end, size;
+	dma_addr_t dma_start;
+	int ret;
 
-	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (!map)
-		return;
-
-	map->cpu_start = 0;
-	map->dma_start = PAGE_ALIGN(zdev->start_dma);
+	dma_start = PAGE_ALIGN(zdev->start_dma);
 	aligned_end = PAGE_ALIGN_DOWN(zdev->end_dma + 1);
-	if (aligned_end >= map->dma_start)
-		map->size = aligned_end - map->dma_start;
+	if (aligned_end >= dma_start)
+		size = aligned_end - dma_start;
 	else
-		map->size = 0;
-	WARN_ON_ONCE(map->size == 0);
+		size = 0;
+	WARN_ON_ONCE(size == 0);
 
-	pdev->dev.dma_range_map = map;
+	ret = dma_direct_set_offset(&pdev->dev, 0, dma_start, size);
+	if (ret)
+		pr_err("Failed to allocate DMA range map for %s\n", pci_name(pdev));
 }
 
 void pcibios_bus_add_device(struct pci_dev *pdev)

---
base-commit: e840414e5a73ac02ffba6299b46f535a0b7cba98
change-id: 20250306-fix_dma_map_alloc-b3b05903dcfb

Best regards,
-- 
Niklas Schnelle

