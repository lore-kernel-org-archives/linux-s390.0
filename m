Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2241AAA10;
	Fri,  7 Feb 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961640; cv=none; b=Drqo3/C1D82D0oPKdjH94cZjIlpev2yMA/kuMeMvU4rJTxsiX7zFaqahTbAnRa5ex3IIYz8vlDTAlyi01D4VMayhWTaRcM/lUNMRalxBSfg6DZ8CihwbsCntl9bHjt7gK3Qz66e/EXzo56wlLR9fVhVOotLWjDGAW9fQ6hAjjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961640; c=relaxed/simple;
	bh=57bxcJ3k6ts+xT9gMMcV5+cIMOhNl7V+YIEysbccytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEi1A+XRE0Mxjjsdp6b2WYMOsf0/mhCuDA1yDLe0l0GOQEdXhAY4ORLKKqrqKtkKcc7iBjTikZZk+Ofy9B6yQmkhz7MXcZ4q6SbXlomqH9uuuoNB96MQ1EfJGrbDm3cTGvWspfJx8gCr4XOcHL0syfrcOa97a4CDlIp7ehPRlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RuDGyi5B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RuDGyi5B"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517Fduok030939;
	Fri, 7 Feb 2025 20:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/JHv2FTaezYWzGXSX
	djIoXG6dq0sv7nLa5XzuWaKnvY=; b=RuDGyi5Bnbx6YZMqSzjkmblHDInQKgUrv
	fC/0p26DYDnPxPlzBCN9B57j5hZ81vZxkXrBbzYU9AkWcbJAMtmi3SwDVDGAdOpF
	6jMo1/fSifzxnqVVJcx8XMcCftmUNWRKrstxbUKGIk7Z3C0APXwAvHRLRLsJIDQd
	2KgwPgJ7TUA37A5myYnXUYBYli31xrwT2+53Yavi0tAtn7od+7mItIluf08WCCAg
	5Q1A9Vygk4QVLd1vjK7vlJ2OEPoldvolXe7enmlcr6br3fOEmVsh/bNFRamdBuyx
	yHje+ajDi6NP/74bn/k5rATW1AUfz1uZX75GuYnXqisdoqgT/Rupg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nn0thgg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517HFCQ9021474;
	Fri, 7 Feb 2025 20:53:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1w3mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517KriJv13042430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:53:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA65E58050;
	Fri,  7 Feb 2025 20:53:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D85D58045;
	Fri,  7 Feb 2025 20:53:43 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.30.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:53:43 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 4/4] iommu/s390: implement iommu passthrough via identity domain
Date: Fri,  7 Feb 2025 15:53:35 -0500
Message-ID: <20250207205335.473946-5-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: 7RmOy9Z-AUBYM8Vl9LmKW1AwUR2KXSDy
X-Proofpoint-ORIG-GUID: 7RmOy9Z-AUBYM8Vl9LmKW1AwUR2KXSDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070153

Enabled via the kernel command-line 'iommu.passthrough=1' option.

Introduce the concept of identity domains to s390-iommu, which relies on
the bus_dma_region to offset identity mappings to the start of the DMA
aperture advertized by CLP.

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

