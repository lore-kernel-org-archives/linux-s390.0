Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C691B9B43;
	Fri, 23 Aug 2024 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445094; cv=none; b=X6ReOmsuk7t6PUZYG2imuyR4sOp66rUz0vpVOQDOE7TV6DptRK6+Ientp1SLY+aZJeS86uINiPmfCSMQLmAz3SHzoaFzgRi4NjY8mh3RwrsOgzerUAm5oiCXUJb46NLTsDiHguQ5anJ7ZvXghTHuAEyrCuBuyWFzGI+tMgtczBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445094; c=relaxed/simple;
	bh=SwAbLsSUorE8PD/5SF1C8G7Y+wbUpnoqyPGCRtElLB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ja1zBTbRQsdwSDqgDkJZ1vyOiKvrWucYgYvqeffw5QbGdJ8mOO7Bb18kX1DyUGptm0Q9n8ShhiTnHPWDMHSOsptk7XyfCwh/HVgP8ZsiWlU91eLgdPLti7WZZQhsCFzqo2ZRLEW6dS86Zpl9bJYYsuzhcsp4UZoFtMnQpwf3FPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T8u19it5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T8u19it5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NKJRUM026762;
	Fri, 23 Aug 2024 20:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=ykE186t3MaR3dCKAS8dKqoxEmh
	h2jV3WGPr0OhRflZ0=; b=T8u19it5JgVrzr7LQS7cwGScsTVKPvFnyBh0I32W5r
	vM3QAbOmE+05GIJy2OW1QGTX461lO3+UPofA+PxuvgoS9EbpbDu0CnSHDHwN0K2A
	sQkQZ8fy8blGc9hBX6qt3RYHvoC3BuGDQdlyeVFkXHFtsXubWRMscmeo9nXYpsWu
	Eg54vB/sKdSeeDZAnOBoelZ0/TdoLP5A1EMuueiW6PZlpyU2h9QlaTW/3Lc98gdQ
	LrBVf6kIAcUqcSn7eYsm4k6lySb9w//B02/1jpzPqfSao41f/t7qTJeJsXgKdQtZ
	G2ofrLWF6UFVMfS3CeBcuKRIJiPzTEvDlOTvGDGGw/+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4171byr15a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 20:31:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NKIQ6I029237;
	Fri, 23 Aug 2024 20:31:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmud3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 20:31:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NKVAZH22282872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:31:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9336A5805A;
	Fri, 23 Aug 2024 20:31:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E90758052;
	Fri, 23 Aug 2024 20:31:09 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 20:31:09 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: jgg@ziepe.ca, baolu.lu@linux.intel.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        jroedel@suse.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3] iommu/s390: Implement blocking domain
Date: Fri, 23 Aug 2024 16:31:08 -0400
Message-ID: <20240823203108.304054-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e28A0lPFvwD66QE9PwennwO9rXQ5gFml
X-Proofpoint-GUID: e28A0lPFvwD66QE9PwennwO9rXQ5gFml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=727 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230148

This fixes a crash when surprise hot-unplugging a PCI device. This crash
happens because during hot-unplug __iommu_group_set_domain_nofail()
attaching the default domain fails when the platform no longer
recognizes the device as it has already been removed and we end up with
a NULL domain pointer and UAF. This is exactly the case referred to in
the second comment in __iommu_device_set_domain() and just as stated
there if we can instead attach the blocking domain the UAF is prevented
as this can handle the already removed device. Implement the blocking
domain to use this handling.  With this change, the crash is fixed but
we still hit a warning attempting to change DMA ownership on a blocked
device.

Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
Changes for v3:
- make blocking_domain type iommu_domain
- change zdev->s390_domain to type iommu_domain and remove most uses
- remove s390_iommu_detach_device, use blocking domain attach
- add spinlock to serialize zdev->s390_domain change / access to counters
---
 arch/s390/include/asm/pci.h |  4 +-
 arch/s390/pci/pci.c         |  3 ++
 arch/s390/pci/pci_debug.c   | 10 ++++-
 drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
 4 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 30820a649e6e..a60a291fbd58 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -96,7 +96,6 @@ struct zpci_bar_struct {
 	u8		size;		/* order 2 exponent */
 };
 
-struct s390_domain;
 struct kvm_zdev;
 
 #define ZPCI_FUNCTIONS_PER_BUS 256
@@ -181,9 +180,10 @@ struct zpci_dev {
 	struct dentry	*debugfs_dev;
 
 	/* IOMMU and passthrough */
-	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
+	struct iommu_domain *s390_domain; /* attached IOMMU domain */
 	struct kvm_zdev *kzdev;
 	struct mutex kzdev_lock;
+	spinlock_t dom_lock;		/* protect s390_domain change */
 };
 
 static inline bool zdev_enabled(struct zpci_dev *zdev)
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index cff4838fad21..759983d0e63e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -160,6 +160,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
 	struct zpci_fib fib = {0};
+	unsigned long flags;
 	u8 cc, status;
 
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
@@ -171,6 +172,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	WARN_ON((u64) zdev->fmb & 0xf);
 
 	/* reset software counters */
+	spin_lock_irqsave(&zdev->dom_lock, flags);
 	ctrs = zpci_get_iommu_ctrs(zdev);
 	if (ctrs) {
 		atomic64_set(&ctrs->mapped_pages, 0);
@@ -179,6 +181,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		atomic64_set(&ctrs->sync_map_rpcits, 0);
 		atomic64_set(&ctrs->sync_rpcits, 0);
 	}
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 2cb5043a997d..38014206c16b 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -71,17 +71,23 @@ static void pci_fmb_show(struct seq_file *m, char *name[], int length,
 
 static void pci_sw_counter_show(struct seq_file *m)
 {
-	struct zpci_iommu_ctrs  *ctrs = zpci_get_iommu_ctrs(m->private);
+	struct zpci_dev *zdev = m->private;
+	struct zpci_iommu_ctrs *ctrs;
 	atomic64_t *counter;
+	unsigned long flags;
 	int i;
 
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	ctrs = zpci_get_iommu_ctrs(m->private);
 	if (!ctrs)
-		return;
+		goto unlock;
 
 	counter = &ctrs->mapped_pages;
 	for (i = 0; i < ARRAY_SIZE(pci_sw_names); i++, counter++)
 		seq_printf(m, "%26s:\t%llu\n", pci_sw_names[i],
 			   atomic64_read(counter));
+unlock:
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
 static int pci_perf_show(struct seq_file *m, void *v)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index d8eaa7ea380b..a0aca308909e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -33,6 +33,8 @@ struct s390_domain {
 	struct rcu_head		rcu;
 };
 
+static struct iommu_domain blocking_domain;
+
 static inline unsigned int calc_rtx(dma_addr_t ptr)
 {
 	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
@@ -369,20 +371,36 @@ static void s390_domain_free(struct iommu_domain *domain)
 	call_rcu(&s390_domain->rcu, s390_iommu_rcu_free_domain);
 }
 
-static void s390_iommu_detach_device(struct iommu_domain *domain,
-				     struct device *dev)
+static void zdev_s390_domain_update(struct zpci_dev *zdev,
+				    struct iommu_domain *domain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	zdev->s390_domain = domain;
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
+
+static int blocking_domain_attach_device(struct iommu_domain *domain,
+					 struct device *dev)
 {
-	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct s390_domain *s390_domain;
 	unsigned long flags;
 
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
+		return 0;
+
+	s390_domain = to_s390_domain(zdev->s390_domain);
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_del_rcu(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
-	zdev->s390_domain = NULL;
 	zdev->dma_table = NULL;
+	zdev_s390_domain_update(zdev, domain);
+
+	return 0;
 }
 
 static int s390_iommu_attach_device(struct iommu_domain *domain,
@@ -401,20 +419,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		domain->geometry.aperture_end < zdev->start_dma))
 		return -EINVAL;
 
-	if (zdev->s390_domain)
-		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	blocking_domain_attach_device(&blocking_domain, dev);
 
+	/* If we fail now DMA remains blocked via blocking domain */
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(s390_domain->dma_table), &status);
-	/*
-	 * If the device is undergoing error recovery the reset code
-	 * will re-establish the new domain.
-	 */
 	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
 		return -EIO;
-
 	zdev->dma_table = s390_domain->dma_table;
-	zdev->s390_domain = s390_domain;
+	zdev_s390_domain_update(zdev, domain);
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_add_rcu(&zdev->iommu_list, &s390_domain->devices);
@@ -466,19 +479,11 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 	if (zdev->tlb_refresh)
 		dev->iommu->shadow_on_flush = 1;
 
-	return &zdev->iommu_dev;
-}
+	/* Start with DMA blocked */
+	spin_lock_init(&zdev->dom_lock);
+	zdev_s390_domain_update(zdev, &blocking_domain);
 
-static void s390_iommu_release_device(struct device *dev)
-{
-	struct zpci_dev *zdev = to_zpci_dev(dev);
-
-	/*
-	 * release_device is expected to detach any domain currently attached
-	 * to the device, but keep it attached to other devices in the group.
-	 */
-	if (zdev)
-		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	return &zdev->iommu_dev;
 }
 
 static int zpci_refresh_all(struct zpci_dev *zdev)
@@ -697,9 +702,15 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 
 struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 {
-	if (!zdev || !zdev->s390_domain)
+	struct s390_domain *s390_domain;
+
+	lockdep_assert_held(zdev->dom_lock);
+
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
 		return NULL;
-	return &zdev->s390_domain->ctrs;
+
+	s390_domain = to_s390_domain(zdev->s390_domain);
+	return &s390_domain->ctrs;
 }
 
 int zpci_init_iommu(struct zpci_dev *zdev)
@@ -776,11 +787,19 @@ static int __init s390_iommu_init(void)
 }
 subsys_initcall(s390_iommu_init);
 
+static struct iommu_domain blocking_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_device,
+	}
+};
+
 static const struct iommu_ops s390_iommu_ops = {
+	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,
-	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
-- 
2.46.0

