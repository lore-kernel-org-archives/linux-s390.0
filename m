Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AB21B9D4;
	Mon, 31 Mar 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452544; cv=none; b=NcV+VG5OHBJvMz1NzDT+ZWVCH0hzKuqQP8P3N0UsJsbam8PdD1yltv3eGNp5J+zQkguWHK0D0wVVpvhLKZdie/8SSZSUVlzV8dwJn8QRa26Ci/b+BBU8/rHifCFqALpJVP7HNwxq/SeUeZerrsdo6cFsYpQP4AXI4WmSTYo7bYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452544; c=relaxed/simple;
	bh=HtTFMgltI4qAwHMC3yfg+IBlmksL+v49/IqjdTGFu/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID2Di/eiGuitv1AxvzCprsduUd3Iyn7mHDmNUGUhLKqG0Z3PgMk2qlCqSqJjXe6sUCuiaX0m7EZqhBuP/6vJomEQoXybmkYt7JuP4A+vUb4NEH2MVJCrzcQw8mwidHNvHUIVUqnoazfUWh6TJlUxmkF5IL+lcYWj8ytISaExFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K1uVeJQa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K1uVeJQa"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHBcnZ028358;
	Mon, 31 Mar 2025 20:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MYKS5+fstXt4SowN5
	PAn91bu+mAs7kk6UAjqLUbzqj0=; b=K1uVeJQaCz6MeGq/VEU9NnE8PT0xBV9G3
	dAixp6ALZ0cykiPrnBcLwqqDG2DVPnHY/DLBAVPDbn3NZdZUPI8GYURPf8YT8435
	W5wmijIS5j6yPTPMobIJIV4kPuOrFTyxM2lBzqWDVlR7U2WYhXkmN3kE8KxYxg3/
	pGkO3yleLtoziCAEAHpsyFm28i9UbWk05CgSRbHYnzSsXaZd0Gl/7hERzhngJu9t
	fzyOIRrzyuTFsWqhN2WrtJ7QgLgqPQf/yibg3tEXIihyqWm7G3AZKz/8SC1EMF2Z
	sSPLG3sw+Gl7af9KNyldf5besTszN7bqO+Wu74yyLzD4SccY1f4dg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qy7x8tfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHNMf7019391;
	Mon, 31 Mar 2025 20:22:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6symsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM9lt18022992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2E2958043;
	Mon, 31 Mar 2025 20:22:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC3158061;
	Mon, 31 Mar 2025 20:22:08 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:22:08 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 5/5] iommu/s390: allow larger region tables
Date: Mon, 31 Mar 2025 16:21:59 -0400
Message-ID: <20250331202159.85956-6-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202159.85956-1-mjrosato@linux.ibm.com>
References: <20250331202159.85956-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CL1UUsNO5npEVkLe0ezogNgu86LZRGPI
X-Proofpoint-GUID: CL1UUsNO5npEVkLe0ezogNgu86LZRGPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxlogscore=851 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310138

Extend the aperture calculation to consider sizes beyond the maximum
size of a region third table.  Attempt to always use the smallest
table size possible to avoid unnecessary extra steps during translation.
Update reserved region calculations to use the appropriate table size.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  1 +
 drivers/iommu/s390-iommu.c      | 71 ++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 8d8962e4fd58..d12e17201661 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -25,6 +25,7 @@ enum zpci_ioat_dtype {
 #define ZPCI_KEY			(PAGE_DEFAULT_KEY << 5)
 
 #define ZPCI_TABLE_SIZE_RT	(1UL << 42)
+#define ZPCI_TABLE_SIZE_RS	(1UL << 53)
 
 #define ZPCI_IOTA_STO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_ST)
 #define ZPCI_IOTA_RTTO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RT)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 46f45b136993..30306321616d 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -511,9 +511,25 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static inline u64 max_tbl_size(struct s390_domain *domain)
+{
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RTX:
+		return ZPCI_TABLE_SIZE_RT - 1;
+	case ZPCI_TABLE_TYPE_RSX:
+		return ZPCI_TABLE_SIZE_RS - 1;
+	case ZPCI_TABLE_TYPE_RFX:
+		return U64_MAX;
+	default:
+		return 0;
+	}
+}
+
 static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 {
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain *s390_domain;
+	u64 aperture_size;
 
 	s390_domain = kzalloc(sizeof(*s390_domain), GFP_KERNEL);
 	if (!s390_domain)
@@ -524,10 +540,26 @@ static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 		kfree(s390_domain);
 		return NULL;
 	}
+
+	aperture_size = min(s390_iommu_aperture,
+			    zdev->end_dma - zdev->start_dma + 1);
+	if (aperture_size <= (ZPCI_TABLE_SIZE_RT - zdev->start_dma)) {
+		s390_domain->origin_type = ZPCI_TABLE_TYPE_RTX;
+	} else if (aperture_size <= (ZPCI_TABLE_SIZE_RS - zdev->start_dma) &&
+		  (zdev->dtsm & ZPCI_IOTA_DT_RS)) {
+		s390_domain->origin_type = ZPCI_TABLE_TYPE_RSX;
+	} else if (zdev->dtsm & ZPCI_IOTA_DT_RF) {
+		s390_domain->origin_type = ZPCI_TABLE_TYPE_RFX;
+	} else {
+		/* Assume RTX available */
+		s390_domain->origin_type = ZPCI_TABLE_TYPE_RTX;
+		aperture_size = ZPCI_TABLE_SIZE_RT - zdev->start_dma;
+	}
+	zdev->end_dma = zdev->start_dma + aperture_size - 1;
+
 	s390_domain->domain.geometry.force_aperture = true;
 	s390_domain->domain.geometry.aperture_start = 0;
-	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
-	s390_domain->origin_type = ZPCI_TABLE_TYPE_RTX;
+	s390_domain->domain.geometry.aperture_end = max_tbl_size(s390_domain);
 
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD_RCU(&s390_domain->devices);
@@ -680,6 +712,9 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct iommu_resv_region *region;
+	struct s390_domain *s390_domain;
+	unsigned long flags;
+	u64 end_resv;
 
 	if (zdev->start_dma) {
 		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
@@ -689,14 +724,23 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, list);
 	}
 
-	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
-		region = iommu_alloc_resv_region(zdev->end_dma + 1,
-						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
-						 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
+	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
+		goto out;
+
+	s390_domain = to_s390_domain(zdev->s390_domain);
+	if (zdev->end_dma < max_tbl_size(s390_domain)) {
+		end_resv = max_tbl_size(s390_domain) - zdev->end_dma;
+		region = iommu_alloc_resv_region(zdev->end_dma + 1, end_resv,
+						 0, IOMMU_RESV_RESERVED,
+						 GFP_KERNEL);
 		if (!region)
-			return;
+			goto out;
 		list_add_tail(&region->list, list);
 	}
+out:
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
@@ -708,13 +752,9 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 
 	zdev = to_zpci_dev(dev);
 
-	if (zdev->start_dma > zdev->end_dma ||
-	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
+	if (zdev->start_dma > zdev->end_dma)
 		return ERR_PTR(-EINVAL);
 
-	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
-		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
-
 	if (zdev->tlb_refresh)
 		dev->iommu->shadow_on_flush = 1;
 
@@ -999,7 +1039,6 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 
 int zpci_init_iommu(struct zpci_dev *zdev)
 {
-	u64 aperture_size;
 	int rc = 0;
 
 	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
@@ -1017,12 +1056,6 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 	if (rc)
 		goto out_sysfs;
 
-	zdev->start_dma = PAGE_ALIGN(zdev->start_dma);
-	aperture_size = min3(s390_iommu_aperture,
-			     ZPCI_TABLE_SIZE_RT - zdev->start_dma,
-			     zdev->end_dma - zdev->start_dma + 1);
-	zdev->end_dma = zdev->start_dma + aperture_size - 1;
-
 	return 0;
 
 out_sysfs:
-- 
2.49.0

