Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7D28C5C6;
	Fri, 11 Apr 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403095; cv=none; b=PsYgOVHaLNokqMYgAJb6x4fJs+Si6wOh3um0BpEqC3V5YZpeSLkG9A5gavSn1BDmath8gcqxLZC19DmijS5lAGSui7yKjbqQqw0PXZpnQmagS5kx75sSe4KtQ9M9HFeA59T+xuVDUID1W4pFlh1tLVz6/LliyI5l2Kc9bLR17b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403095; c=relaxed/simple;
	bh=OZlu8f89BYxknWQX/kA3bt6HxJ89EN0pJVICj/4m1H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIrXWnvbDvHWIGu6qkt6dexdA9GTK/birgCjhX5c3PlV+FrobhLPm3jWg+OM5JigTCMYOMx0GHgeELjA2jmHDqXYxAzMhpCGAZs+X7jEoZvq9ggfIDUgFezBNW0B4BJvFgm1ST9g3VayQVwupLmupYOlupqb6sEHstUFEq21XMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hQ2AiEVp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hQ2AiEVp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII4DN022316;
	Fri, 11 Apr 2025 20:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qov1yGhcG5wRklZOK
	SeRMBsnOSzne165QTDxfJ9nals=; b=hQ2AiEVpr2jp+6FslHYjsROpdPph/Ha92
	TWPLvNgcd6RReSf86ZW5Bj9SMuG5N+BoGiPOx0GStggtGRoWS5C9LFOQ0inah7BC
	3hk+MwdnMdujNTq5bKgPhkGcfGJGkkSQbuluQZA+OJj7MZsV8IkJrXyRnor1Gdh8
	TBitV52Gzg8sV8jpfwGi85xozkVvDcehymd/tSsG7ciYjyNw4PCOXWKZwlnNLSFR
	YAiK1RaAIx8mCaUMqPzCr3i/aQ3QlmcIPX5qceKJCKZQ14Tz8zXebXXU5pAfh4Zl
	P5QatcWyIfNUR2X0LfzjWfWYt+wCeiRvTI4KWtOLQxc2crwPOv4DA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343tb6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHcN8J011078;
	Fri, 11 Apr 2025 20:24:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf804ux8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOeLf28639926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F04F58051;
	Fri, 11 Apr 2025 20:24:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62C815805A;
	Fri, 11 Apr 2025 20:24:39 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:39 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 5/5] iommu/s390: allow larger region tables
Date: Fri, 11 Apr 2025 16:24:33 -0400
Message-ID: <20250411202433.181683-6-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411202433.181683-1-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SG2dXj0RIqhu0JwkeonmFgGDZdaryUdI
X-Proofpoint-ORIG-GUID: SG2dXj0RIqhu0JwkeonmFgGDZdaryUdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=852
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110127

Extend the aperture calculation to consider sizes beyond the maximum
size of a region third table.  Attempt to always use the smallest
table size possible to avoid unnecessary extra steps during translation.
Update reserved region calculations to use the appropriate table size.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  1 +
 drivers/iommu/s390-iommu.c      | 70 ++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 18 deletions(-)

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
index 46f45b136993..433b59f43530 100644
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
@@ -680,6 +712,8 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct iommu_resv_region *region;
+	u64 max_size, end_resv;
+	unsigned long flags;
 
 	if (zdev->start_dma) {
 		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
@@ -689,10 +723,21 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, list);
 	}
 
-	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
-		region = iommu_alloc_resv_region(zdev->end_dma + 1,
-						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
-						 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
+	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY) {
+		spin_unlock_irqrestore(&zdev->dom_lock, flags);
+		return;
+	}
+
+	max_size = max_tbl_size(to_s390_domain(zdev->s390_domain));
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+
+	if (zdev->end_dma < max_size) {
+		end_resv = max_size - zdev->end_dma;
+		region = iommu_alloc_resv_region(zdev->end_dma + 1, end_resv,
+						 0, IOMMU_RESV_RESERVED,
+						 GFP_KERNEL);
 		if (!region)
 			return;
 		list_add_tail(&region->list, list);
@@ -708,13 +753,9 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 
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
 
@@ -999,7 +1040,6 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 
 int zpci_init_iommu(struct zpci_dev *zdev)
 {
-	u64 aperture_size;
 	int rc = 0;
 
 	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
@@ -1017,12 +1057,6 @@ int zpci_init_iommu(struct zpci_dev *zdev)
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

