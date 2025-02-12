Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625220371D;
	Wed, 12 Feb 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396081; cv=none; b=T6qyVjgfYi3enL2Mt9qqBODPSuTUSdQJXVcxpGP8tT9pB6dOQoLzb72a7iwZRzVA/dMDka1YYRe0gEAjIkQYx5m5Jeccf3a22cl7x5SOccVj00zEIh2rs0i/6MozrfyIBAXfZNjb+iPkQpP9Suvu4fXPwBeYXokvA06MW81DDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396081; c=relaxed/simple;
	bh=lVLVvKssvh23Wa1P5dfJrqLc+D1LxadSc52EeR3Ak7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqUzSP1FTgn/9kcmzISo9UUQCScfo/Pnvl/xRXVCVJ4KUCqtYWpYnCxULp0SM9slsH59ihV1Fc60VUTo3OpPcLXbBL66SI0IqDwrOzEEq/w5UkisVijG4QBl5NKWPXu4sdUpH4LyNPqyLOX8vZx7NWsjpIms42uA/GTFC/0t9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnUHyp3d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnUHyp3d"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKGFap011996;
	Wed, 12 Feb 2025 21:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jr1qt4yvIuAZDAiDh
	a5koiFFri8NBXeUCFli7Bilgdw=; b=nnUHyp3da/+sGZLGOzqkRMxQVH0Om3Lzl
	sCCLjpe8629vIGk6rGvNcrVAPUCfr5jRAWy93Xiiaqij0C8r8mYZhFy02S19WuSe
	8zAF1s9ZEZ/nod4cXfuYm5o9lagcdKzn5DjsRAsC9/+el1iQv0P0VvkJm8biwMjR
	GBn+RClZ9cXQkcLldirRVpEccVEbr4zIhs7j4k9+vOJKxsmG/NCRXnF3wOBcveuP
	Jhge3QYEKj8A2qsGraVZ6h1fHkV5Bx1honrhkWZfrme+UqM7Pzxp8N9B8DAG/0ZB
	Dksnoda9qz2978oiR/homNMLjF7P9axrDgzyUotHEpnp9PZsY2zmg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa67dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKsVIb029203;
	Wed, 12 Feb 2025 21:34:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1tm0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CLYP4235455560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:34:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5377758060;
	Wed, 12 Feb 2025 21:34:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ADDC58056;
	Wed, 12 Feb 2025 21:34:24 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.186.234])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 21:34:24 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 4/4] iommu/s390: implement iommu passthrough via identity domain
Date: Wed, 12 Feb 2025 16:34:18 -0500
Message-ID: <20250212213418.182902-5-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: QZcHwOmbSWqWWFvDk7uWCZ4JBjAcDChX
X-Proofpoint-ORIG-GUID: QZcHwOmbSWqWWFvDk7uWCZ4JBjAcDChX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120152

Enabled via the kernel command-line 'iommu.passthrough=1' option.

Introduce the concept of identity domains to s390-iommu, which relies on
the bus_dma_region to offset identity mappings to the start of the DMA
aperture advertized by CLP.

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 007ccfdad495..e1c76e0f9c2b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -16,7 +16,7 @@
 
 #include "dma-iommu.h"
 
-static const struct iommu_ops s390_iommu_ops;
+static const struct iommu_ops s390_iommu_ops, s390_iommu_rtr_ops;
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
@@ -432,9 +432,11 @@ static int blocking_domain_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	s390_domain = to_s390_domain(zdev->s390_domain);
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_del_rcu(&zdev->iommu_list);
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	if (zdev->dma_table) {
+		spin_lock_irqsave(&s390_domain->list_lock, flags);
+		list_del_rcu(&zdev->iommu_list);
+		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	}
 
 	zpci_unregister_ioat(zdev, 0);
 	zdev->dma_table = NULL;
@@ -762,7 +764,13 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 	if (rc)
 		goto out_err;
 
-	rc = iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops, NULL);
+	if (zdev->rtr_avail) {
+		rc = iommu_device_register(&zdev->iommu_dev,
+					   &s390_iommu_rtr_ops, NULL);
+	} else {
+		rc = iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops,
+					   NULL);
+	}
 	if (rc)
 		goto out_sysfs;
 
@@ -826,6 +834,39 @@ static int __init s390_iommu_init(void)
 }
 subsys_initcall(s390_iommu_init);
 
+static int s390_attach_dev_identity(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	u8 status;
+	int cc;
+
+	blocking_domain_attach_device(&blocking_domain, dev);
+
+	/* If we fail now DMA remains blocked via blocking domain */
+	cc = s390_iommu_domain_reg_ioat(zdev, domain, &status);
+
+	/*
+	 * If the device is undergoing error recovery the reset code
+	 * will re-establish the new domain.
+	 */
+	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+		return -EIO;
+
+	zdev_s390_domain_update(zdev, domain);
+
+	return 0;
+}
+
+static const struct iommu_domain_ops s390_identity_ops = {
+	.attach_dev = s390_attach_dev_identity,
+};
+
+static struct iommu_domain s390_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &s390_identity_ops,
+};
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
@@ -833,23 +874,31 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
-static const struct iommu_ops s390_iommu_ops = {
-	.blocked_domain		= &blocking_domain,
-	.release_domain		= &blocking_domain,
-	.capable = s390_iommu_capable,
-	.domain_alloc_paging = s390_domain_alloc_paging,
-	.probe_device = s390_iommu_probe_device,
-	.device_group = generic_device_group,
-	.pgsize_bitmap = SZ_4K,
-	.get_resv_regions = s390_iommu_get_resv_regions,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= s390_iommu_attach_device,
-		.map_pages	= s390_iommu_map_pages,
-		.unmap_pages	= s390_iommu_unmap_pages,
-		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
-		.iotlb_sync      = s390_iommu_iotlb_sync,
-		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
-		.iova_to_phys	= s390_iommu_iova_to_phys,
-		.free		= s390_domain_free,
+#define S390_IOMMU_COMMON_OPS() \
+	.blocked_domain		= &blocking_domain, \
+	.release_domain		= &blocking_domain, \
+	.capable = s390_iommu_capable, \
+	.domain_alloc_paging = s390_domain_alloc_paging, \
+	.probe_device = s390_iommu_probe_device, \
+	.device_group = generic_device_group, \
+	.pgsize_bitmap = SZ_4K, \
+	.get_resv_regions = s390_iommu_get_resv_regions, \
+	.default_domain_ops = &(const struct iommu_domain_ops) { \
+		.attach_dev	= s390_iommu_attach_device, \
+		.map_pages	= s390_iommu_map_pages, \
+		.unmap_pages	= s390_iommu_unmap_pages, \
+		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
+		.iotlb_sync      = s390_iommu_iotlb_sync, \
+		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
+		.iova_to_phys	= s390_iommu_iova_to_phys, \
+		.free		= s390_domain_free, \
 	}
+
+static const struct iommu_ops s390_iommu_ops = {
+	S390_IOMMU_COMMON_OPS()
+};
+
+static const struct iommu_ops s390_iommu_rtr_ops = {
+	.identity_domain	= &s390_identity_domain,
+	S390_IOMMU_COMMON_OPS()
 };
-- 
2.48.1

