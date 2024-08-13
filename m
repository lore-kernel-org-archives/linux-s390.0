Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF019D089;
	Tue, 13 Aug 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577306; cv=none; b=YHGvP0KvFDCR1fssPgTorhR+7zZl1n4mXTyucFwdov1pDSA80Ho3RrjE2eg27Pjg9zxnpr9uy6XeTR2F40VaUAZUNJkyfrAZY6v5LI6+Y3xmUIRGu0HaHs0yDQG3C/w9kiN951Lvp2c5iQ1Zv9mhWpNpThjEoCao3iQAs05qg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577306; c=relaxed/simple;
	bh=0mQBvfCgARN6YgvU4oSzZdpPL66BZCSsykfOz9Gb/5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6Lt+gi0ze5lnWUSvI0dC9PjbMh0GR0urQNI0m89VLTaSmHA8+w0tPqSNOJrMOsp2SRbJYQaxXexHYv5WgbMJWm0/PF/rLwHw9xNuNmoqARx0OsQJ/MT72+UDuC/OORGw9YfSTMDRlLisaagsntzB/Css2SQNrotDgz3rQfCEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8x9+qD1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8x9+qD1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DIkJH4031433;
	Tue, 13 Aug 2024 19:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=dTgI1xpBR4sq4RcSHFCsSrrdA0
	5uWNjQbymJCHmL8v0=; b=e8x9+qD1ACdk9EHcL+y04SIrpGrqoRSk6gQKDS/qt1
	ajH6aW1FZfGNp1ZGupCr1u59BM3y8FXfC5+hFoPAFy9jsPhbxDi/kjxvw+x6eJGm
	Da1bVFkUwq3xs/Nz4O4+0R2hi/nqItEQNqxfxZSW4/JdSGwkT7SZaHhSuUr62O9L
	SVCaahc8bCdeq+ikR3assUk8B255LVSJB+HSHerDMPP1m0tBjZU0o1I3YdJDKtKI
	tRI3/u0LCqHdoTbVQKnFUWZHlupD7mrRFPMP0McpmlyBN+LMLW+rb7OZAvsy/aFz
	YvFKt+SaAfnxTwFhnNZBTjPNHCJbzhyRIZ7FgWWA8arQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410d2c8687-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:28:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DH6Pq9020882;
	Tue, 13 Aug 2024 19:28:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn834w00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:28:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DJS5e018875068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 19:28:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0A5458056;
	Tue, 13 Aug 2024 19:28:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFE8F5806F;
	Tue, 13 Aug 2024 19:28:03 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.62.204])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 19:28:03 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: jgg@ziepe.ca, baolu.lu@linux.intel.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        jroedel@suse.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2] iommu/s390: Implement blocking domain
Date: Tue, 13 Aug 2024 15:28:03 -0400
Message-ID: <20240813192803.129449-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pD0h8cvcBm5wU9hjK27PR-Hkez0KhZ8E
X-Proofpoint-ORIG-GUID: pD0h8cvcBm5wU9hjK27PR-Hkez0KhZ8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130138

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
Changes for v2:
- Added co-author tag from Niklas + my SoB
- Removed changes to drivers/iommu/iommu.c
- Revert back to -EIO for failed attach in s390-iommu
- Set blocking domain during probe_device / remove s390_domain check during
  blocking attach
- Remove s390_iommu_release_device
- Update commit message to reflect changes
---
 drivers/iommu/s390-iommu.c | 64 ++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index d8eaa7ea380b..11663a920cbb 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -33,6 +33,8 @@ struct s390_domain {
 	struct rcu_head		rcu;
 };
 
+static struct s390_domain s390_blocking_domain;
+
 static inline unsigned int calc_rtx(dma_addr_t ptr)
 {
 	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
@@ -376,12 +378,21 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	unsigned long flags;
 
+	/*
+	 * The static blocking domain doesn't need to track devices nor
+	 * does it have an IOAT registered. As there is no harm
+	 * in keeping zdev->s390_domain set to blocking until
+	 * it is overwritten detach is a no-op.
+	 */
+	if (s390_domain->domain.type == IOMMU_DOMAIN_BLOCKED)
+		return;
+
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_del_rcu(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
-	zdev->s390_domain = NULL;
+	zdev->s390_domain = &s390_blocking_domain;
 	zdev->dma_table = NULL;
 }
 
@@ -403,16 +414,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	if (zdev->s390_domain)
 		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
-
-	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				virt_to_phys(s390_domain->dma_table), &status);
 	/*
-	 * If the device is undergoing error recovery the reset code
-	 * will re-establish the new domain.
+	 * Detach set the blocking domain. If we fail now DMA remains blocked
+	 * and the blocking domain attached.
 	 */
+	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+				virt_to_phys(s390_domain->dma_table), &status);
 	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
 		return -EIO;
-
 	zdev->dma_table = s390_domain->dma_table;
 	zdev->s390_domain = s390_domain;
 
@@ -466,19 +475,10 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 	if (zdev->tlb_refresh)
 		dev->iommu->shadow_on_flush = 1;
 
-	return &zdev->iommu_dev;
-}
-
-static void s390_iommu_release_device(struct device *dev)
-{
-	struct zpci_dev *zdev = to_zpci_dev(dev);
+	/* Start with DMA blocked */
+	zdev->s390_domain = &s390_blocking_domain;
 
-	/*
-	 * release_device is expected to detach any domain currently attached
-	 * to the device, but keep it attached to other devices in the group.
-	 */
-	if (zdev)
-		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	return &zdev->iommu_dev;
 }
 
 static int zpci_refresh_all(struct zpci_dev *zdev)
@@ -702,6 +702,29 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 	return &zdev->s390_domain->ctrs;
 }
 
+static int blocking_domain_attach_device(struct iommu_domain *domain,
+					 struct device *dev)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	unsigned long flags;
+
+	if (!zdev)
+		return 0;
+
+	/* Detach sets the blocking domain */
+	s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	return 0;
+}
+
+static struct s390_domain s390_blocking_domain = {
+	.domain = {
+		.type = IOMMU_DOMAIN_BLOCKED,
+		.ops = &(const struct iommu_domain_ops) {
+			.attach_dev	= blocking_domain_attach_device,
+	}}
+};
+
 int zpci_init_iommu(struct zpci_dev *zdev)
 {
 	u64 aperture_size;
@@ -777,10 +800,11 @@ static int __init s390_iommu_init(void)
 subsys_initcall(s390_iommu_init);
 
 static const struct iommu_ops s390_iommu_ops = {
+	.blocked_domain		= &s390_blocking_domain.domain,
+	.release_domain		= &s390_blocking_domain.domain,
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,
-	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
-- 
2.45.2

