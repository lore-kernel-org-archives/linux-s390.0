Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7915A858;
	Wed, 12 Mar 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775563; cv=none; b=eOyuej3ZtDolcKl0h43ZB1sNv8veoiRVYzwIsfPf7w7vQg0awDVXgVYCN8RzLkynKVKnzUj1LfaM4k5pGIkmwkmYwCHb9d1SaAZjHecmtQBeq9kd5OCX80MEEWwXlRnP7iebfl/tv1uWQzaCx4atzXxjYGuI1ho+P+v0KUlaehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775563; c=relaxed/simple;
	bh=1Zrl7XJlODTMn2xzf0QDsKnwExXLa7Dq6fAETI8+/Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dnhqoNRpHBAFuh2HE29+jppRz04KRRkl1GuItEWbaZvL5Yy3yDjo96qgxfJA+hDeAQ6DK4gPlGyAofCANpItwjCaXNecl1328418eBb95ZPKXcssCrgBGJE3Y+rfULNr6PPUXIsEFUAyFjKL4Wa1UkFz/cOFdMhZ2SqixRrYmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pAZAZIst; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pAZAZIst"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7vF5A008923;
	Wed, 12 Mar 2025 10:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=UWvIREE7AL/FzZAsFF7hbrg0uAsb
	UXJLdwxTI53a890=; b=pAZAZIstYQRwNWY+v8x/SOnEwcQpIWndlG3I0WD53TFm
	qjwagVGIBe9cuU3Cy6ZkF4ZNe749v+SMI/qWaC76GUHepWUalJgHS4uqvpOarqIx
	znC04KN697imJeBqDL41pCvo7MYVRAdGTD4OIZaaP78WHRn5FYrVPATARd8osfuH
	1C9RwI1OgXIgZWeEX+ksk98GyDBNOb3w+6T+rktM0gIzoyDx7ACFeRhJCvRv/dzk
	N+S7aEpbyQMuVPe0X8FIW8xda9xdcxJvLjmfKO/a/NgsEeTXeXqK0rqG3Lp7fXmE
	jIlJOoXQ0askq5dcww8RcnUpUW1URxWJ8dUUjw82vw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4b3x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 10:32:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAF22l003141;
	Wed, 12 Mar 2025 10:32:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstkjyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 10:32:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CAWSHC25559688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 10:32:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02207580AF;
	Wed, 12 Mar 2025 10:32:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6F9580AC;
	Wed, 12 Mar 2025 10:32:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 10:32:27 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 12 Mar 2025 11:32:18 +0100
Subject: [PATCH v2] s390/pci: Fix dev.dma_range_map missing sentinel
 element
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-fix_dma_map_alloc-v2-1-530108d9de21@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIALFi0WcC/32NWwrDIBREtxLudw1GTaH96j5CCGpMc8FH0FZSg
 nuvzQL6eYaZMwckE9EkuDcHRJMxYfAV2KUBvUr/NATnysAo6ymnV7LgPs1OTk5uk7Q2aKK4ov2
 N8lkvCupui6aWTucwVl4xvUL8nBe5+6X/bLkjHVFikUJwKozUD4v+vbeoXKuDg7GU8gXxzattt
 gAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=1Zrl7XJlODTMn2xzf0QDsKnwExXLa7Dq6fAETI8+/Q4=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNIvJu3aEiNxcX/wHY4nb2fISMeUbI6xUNhu0qAbeWq/T
 ZDCrJr3HaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzk1kWG/5XTWZZ9D2g43jAv
 w4uB8ZW/5xunty+se83d9apuKsh+DGdkuHLBaIrXx8Xe+9nEA1L3SDc/WNA451mPSuA1XcOOK7k
 LuAE=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6y4N96oHAM06SXiSsYvxVeXjOfJeGrWo
X-Proofpoint-GUID: 6y4N96oHAM06SXiSsYvxVeXjOfJeGrWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120072

The fixed commit sets up dev.dma_range_map but missed that this is
supposed to be an array of struct bus_dma_region with a sentinel element
with the size field set to 0 at the end. This would lead to overruns in
e.g. dma_range_map_min(). It could also result in wrong translations
instead of DMA_MAPPING_ERROR in translate_phys_to_dma() if the paddr
were to not fit in the aperture. Fix this by using the
dma_direct_set_offset() helper which creates a sentinel for us.

Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: Based on iommu/next

v1 -> v2:
- Fixed typo, added trailers
- Link to v1: https://lore.kernel.org/r/20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com
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

