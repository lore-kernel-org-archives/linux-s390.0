Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939B1C3F28;
	Tue,  6 Aug 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951944; cv=none; b=gYnHa/5RFykHyqnYMrdpXALgH7LwSjn7SmBRJCuKZzgP6jlneqci3e5zGjPdQu9goOHkZuUJMyXXrU+rn9oq8XUT9EFRA7OeEuZcqpHVydzH0De8zLbxLnn6CHFkw5lcZ/S1OgNrqsljA2lF/iJBaBeSQlX875JtuscJBjCMBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951944; c=relaxed/simple;
	bh=/O6gOazGAAxZLA8J+7h5p+EN9RuzNwHNrZWDPz0D6VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zi8QOPjk6KWmYzk1BzVtCc7Of80uN1ddjtcHF2RUCPiqEbsALFjuOVXqI0Oe1FH/EwF3psNV4bexmmbcmeSW8NdcllTXrX0V8qeerowsiDG8Jq/odRzn/1qRHeaXvATDxufC/nYBYUCXqeGO0Fo9L8ETPszrwTDo/t5+537h4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kQ0Ya4OQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kQ0Ya4OQ"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLeEQ009143;
	Tue, 6 Aug 2024 13:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=pp1; bh=frDMpRJa9
	nFQdr0/6cy9hz3L1rHXcvTkwMFBF+bYqrw=; b=kQ0Ya4OQ5PipQ7Y4hBRS8z2bv
	Mmq5xuzCTHNOAzqR0Sq1GqFfc0uq2wNMzdRoH1RbBWTGkv7MLXmi96T6x3iNgob7
	DeukS2EhCv/52wkXHIHr4FHeBmyQwzxUq6Y+ycjZuy33kzQav2vy7opyXhmgH0L4
	G/qEEOaE/qw9XmK5mN7aNv+qWbO43QxEjgZm9wOmLMNGc5eH21HaZT2jL7OtUAgT
	cotzZcSQctlNiJc53H+WWpA7eKydm+nOmXZcM0r7Jd3j3H+ol8ex3pZjuZaGCkxi
	MS999/B/csguwWZzBeq45rMl/PQSwPrSU0hVdRKj20Axp3M4QLpPkE0McArvg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uma803r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:45:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476BABj1024334;
	Tue, 6 Aug 2024 13:45:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90m1k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:45:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476DjRF025625286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 13:45:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D8E458059;
	Tue,  6 Aug 2024 13:45:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F32935806A;
	Tue,  6 Aug 2024 13:45:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 13:45:24 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 06 Aug 2024 15:45:15 +0200
Subject: [PATCH] iommu/s390: Implement blocking domain
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAOoosmYC/x3MQQqAIBBA0avErBNsKImuEhFqkw2VhkIE4d2Tl
 m/x/wuJIlOCoXoh0s2Jgy9o6grspr0jwUsxoMRW9lIJcwS7s3fzEk7NXmBnlMXVKq0QSnVFWvn
 5j+OU8weYHwdHYQAAAA==
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6030;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=/O6gOazGAAxZLA8J+7h5p+EN9RuzNwHNrZWDPz0D6VM=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNI2abyTPb79wKe0bYnifz7c7ngbPbGD5e3+3XpK4Wfsv
 c9bM7BxdZSyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjARLlNGhpuTXxy9VZk28/Jv
 j3tHa7f2Oygf423Y/Cyr85d25ZZ13SsZ/ies7rHtUlT+nhliKX8lf2Znd8QqDXHH7/5LFz79oWW
 QzgcA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PqdCjSsG9b9gNfEAzym0p3kSxVVMWTtx
X-Proofpoint-GUID: PqdCjSsG9b9gNfEAzym0p3kSxVVMWTtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=554 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060093

This fixes a crash when surprise hot-unplugging a PCI device. This crash
happens because during hot-unplug __iommu_group_set_domain_nofail()
attaching the default domain fails when the platform no longer
recognizes the device as it has already been removed and we end up with
a NULL domain pointer and UAF. This is exactly the case referred to in
the second comment in __iommu_device_set_domain() and just as stated
there if we can instead attach the blocking domain the UAF is prevented
as this can handle the already removed device. Implement the blocking
domain to use this handling. This would still leave us with a warning
for a failed attach. As failing to attach when the device is no longer
present is expected behavior turn this into an explicit -ENODEV error
and don't warn for it. Also change the error return for a NULL zdev to
-EIO as we don't want to ignore this case that would be a serious bug.

Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I somewhat suspect this to be related to the following discussion
or at least we have seen the same backtraces in reports that we suspect
to be caused by the issue fixed with this patch. In the case I was able
to reproduce with vfio-pci pass-through to a KVM guest I got a different
trace though.

Organizational note: I'll be on vacation starting Thursday. Matt will
then take over and sent new revisions as necessary.
---
 drivers/iommu/iommu.c      |  7 ++++--
 drivers/iommu/s390-iommu.c | 55 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..91b3b23bf55c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -119,8 +119,11 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 					    struct iommu_domain *new_domain)
 {
-	WARN_ON(__iommu_group_set_domain_internal(
-		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
+	int ret = __iommu_group_set_domain_internal(
+		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+
+	/* Allow attach to fail when the device is gone */
+	WARN_ON(ret && ret != -ENODEV);
 }
 
 static int iommu_setup_default_domain(struct iommu_group *group,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index d8eaa7ea380b..3d8b5fe9a555 100644
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
 
@@ -395,7 +406,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	int cc;
 
 	if (!zdev)
-		return -ENODEV;
+		return -EIO;
 
 	if (WARN_ON(domain->geometry.aperture_start > zdev->end_dma ||
 		domain->geometry.aperture_end < zdev->start_dma))
@@ -403,16 +414,16 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	if (zdev->s390_domain)
 		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
-
+	/*
+	 * Detach set the blocking domain. If we fail now DMA remains blocked
+	 * and the blocking domain attached.
+	 */
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(s390_domain->dma_table), &status);
-	/*
-	 * If the device is undergoing error recovery the reset code
-	 * will re-establish the new domain.
-	 */
-	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+	if (cc == 3 || status == ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+		return -ENODEV;
+	else if (cc)
 		return -EIO;
-
 	zdev->dma_table = s390_domain->dma_table;
 	zdev->s390_domain = s390_domain;
 
@@ -702,6 +713,30 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
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
+	if (zdev->s390_domain)
+		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
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
@@ -777,6 +812,8 @@ static int __init s390_iommu_init(void)
 subsys_initcall(s390_iommu_init);
 
 static const struct iommu_ops s390_iommu_ops = {
+	.blocked_domain		= &s390_blocking_domain.domain,
+	.release_domain		= &s390_blocking_domain.domain,
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,

---
base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
change-id: 20240806-blocking_domain-25b6c2fc6a62

Best regards,
-- 
Niklas Schnelle

