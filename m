Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96E1DE880;
	Fri, 28 Feb 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779124; cv=none; b=tp2Lc/Ru9ED8IGv53MAWmatKSlmfNZ38I+c7slG7CAPvFj4ICRDxwqLtEM1uKVNzyw/N9RPGM+VXm27kEJsL37ad5Nu7z6lVQX//CAM87jNFAvnhAfm++F5JyLWUl3kYAT4SSEYlI2sm2jYtKghdIt34W69jCIVs9WmNOdrVWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779124; c=relaxed/simple;
	bh=daEM+RAEcsH/jE9emccQ9eCNhNaxhQpP7XaZTiQK5EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcpR42irXLzullbXnWdoDCII87eTJS2AN4PEHyhZAw4W5zvW7AnCAHiXycpO57Zz1Oxtfd6/RCwtrjvQmgn54ISqsBateWywOdziqXYvM24XUiBtAHMDaGDOFRHyI5phPnIr5dPiNDOy4NT+E6WudFcqioID9MlhyNWN2OFMSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D0MXJcbz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D0MXJcbz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SGXbF6025467;
	Fri, 28 Feb 2025 21:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=diV9BNp06QurCisXc
	W2kXaHm3O+xbsShTRwJUW9Jjk8=; b=D0MXJcbzc7HZmN05XQxUcNhqJDWb/HElx
	O40CASnaT+ZJsijh3qmLbi6rZ0XETjFUxESAB3Zyhs1RH2Vo8Su+pg1KVFjCHJTv
	xUWVZQHSaTCtKZ3APyilvwQudKntxMypr9upBnEqbcm7iJLJ0I1GPqB8IH8qW/AT
	QvhW8X/tXEA6ncYL0ERBrifCiiyMYGYLFaf+SLEpNum5YadG7zHwROY0QPqp4s7N
	YpwzQXhDYFi6K2Ykkj6GgEU/8lKVyP5F3IDPmCAlMWvkkfkpQAy56IqlI9sUH0QD
	gCJklM4dpnCVNHj5cWhkvivYs/sZOOfGmVJ+bSvEvyD7glAuzw72w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq408q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJCl0q027333;
	Fri, 28 Feb 2025 21:45:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum2gcvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SLj8PR24838838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:45:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92B5758055;
	Fri, 28 Feb 2025 21:45:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280AB5803F;
	Fri, 28 Feb 2025 21:45:07 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.46.135])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 21:45:07 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 5/5] iommu/s390: allow larger region tables
Date: Fri, 28 Feb 2025 16:44:56 -0500
Message-ID: <20250228214456.440641-6-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228214456.440641-1-mjrosato@linux.ibm.com>
References: <20250228214456.440641-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -h0T2EEt91XSJ997dhV-I_5FULrBPYJP
X-Proofpoint-ORIG-GUID: -h0T2EEt91XSJ997dhV-I_5FULrBPYJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=820
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280156

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
index e6f9ce983a57..e36a061ee6da 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -515,9 +515,25 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
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
@@ -528,10 +544,26 @@ static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
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
@@ -684,6 +716,9 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct iommu_resv_region *region;
+	struct s390_domain *s390_domain;
+	unsigned long flags;
+	u64 end_resv;
 
 	if (zdev->start_dma) {
 		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
@@ -693,14 +728,23 @@ static void s390_iommu_get_resv_regions(struct device *dev,
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
@@ -712,13 +756,9 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 
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
 
@@ -995,7 +1035,6 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 
 int zpci_init_iommu(struct zpci_dev *zdev)
 {
-	u64 aperture_size;
 	int rc = 0;
 
 	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
@@ -1013,12 +1052,6 @@ int zpci_init_iommu(struct zpci_dev *zdev)
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
2.48.1

