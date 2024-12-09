Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A981990C1;
	Mon,  9 Dec 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772265; cv=none; b=lX+Yz9E7llsDr4J91+6EsSOJtfkGQW4HLfi0nnv1GJvffO+w+hxgoocGhC/cEtbBToFbBx/A5z+9glq4M6I9HEzwDgQlZYPd4hBi7da2NXJ5isDeSUtL5VRTiM7HsBI2vCmQeHSoCa+KYZsobcDF81SUXBv7NyjBpLRsyCsl4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772265; c=relaxed/simple;
	bh=pSw1N4FI61HybzwNZ+a7Qr2Vhm9SDMTeFa0yrrrgChI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSMH7B7ugnK1gS7Dd97a0dboj6WumBYZpFhLASQ3T57H2YBXd9BfVlr0oEPor9zMZhRWr4LYpt5D9eGILcsuNU6TwbjLgB/izJdZbT6SRsuHBRBpY6DPRI1+qMvG03iiFPPC+um4LounwJH1z+dUp9n1CyxBj5vhDUUoiR3ZHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQK4lFmE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQK4lFmE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DnR24018963;
	Mon, 9 Dec 2024 19:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i3l7CNlENhH1dNAsP
	NCHDAa46sjVE3KXrPJEIhT2E30=; b=VQK4lFmEw0q0+h1YEXnzvUBdYn+UDl/f3
	7boaI3cJ8H1SjVvD+Ujbk/ZKuPrcJQi75450br4IXoTJt+O1MF1K7YY0/8tIen+Y
	/yMXRa4uHhfR5BAKc/YMZTzZGkYclWk79bSsyagS1hKSL1kzbPyJYLv44iaCG/vJ
	Lcu/yGWKOVTO42HtNwztuoY3vmciDUvyBLnldLvwoiPnxOtH9ZrCBTBu/cSISdve
	NiY4N7AveVMKL/FgAhBgnWyzQ/kUIHzRq9Kg55zq2OH48eQyKOwkaJ6xydDO/Ojp
	Rkkg0+nTHsZ0FwYt5UKLTzk06mOMjUYx+8D6xaOcvmVad5GFeFF8A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xa6bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FILRK023023;
	Mon, 9 Dec 2024 19:24:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjqt1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JOCcN47317622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED295804B;
	Mon,  9 Dec 2024 19:24:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 468F45805B;
	Mon,  9 Dec 2024 19:24:10 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:10 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/6] iommu/s390: implement iommu passthrough via identity domain
Date: Mon,  9 Dec 2024 14:24:00 -0500
Message-ID: <20241209192403.107090-4-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192403.107090-1-mjrosato@linux.ibm.com>
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gj3kztyv_sivNZ_rE3P1UZfEBhVXKUh8
X-Proofpoint-ORIG-GUID: gj3kztyv_sivNZ_rE3P1UZfEBhVXKUh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=964
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

Enabled via the kernel command-line 'iommu.passthrough=1' option.

Introduce the concept of identity domains to s390-iommu, which relies on
phys_to_dma and dma_to_phys to offset identity mappings to the start of
the DMA aperture advertized by CLP.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c        |  6 ++++--
 drivers/iommu/s390-iommu.c | 42 +++++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..758b23331754 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -124,14 +124,16 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 	struct zpci_fib fib = {0};
 	u8 cc;
 
-	WARN_ON_ONCE(iota & 0x3fff);
 	fib.pba = base;
 	/* Work around off by one in ISM virt device */
 	if (zdev->pft == PCI_FUNC_TYPE_ISM && limit > base)
 		fib.pal = limit + (1 << 12);
 	else
 		fib.pal = limit;
-	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
+	if (iota == 0)
+		fib.iota = iota;
+	else
+		fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, status);
 	if (cc)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fbdeded3d48b..18979d8109b2 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -392,9 +392,11 @@ static int blocking_domain_attach_device(struct iommu_domain *domain,
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
@@ -787,6 +789,39 @@ static int __init s390_iommu_init(void)
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
+	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+				0, &status);
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
@@ -797,6 +832,7 @@ static struct iommu_domain blocking_domain = {
 static const struct iommu_ops s390_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
+	.identity_domain	= &s390_identity_domain,
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,
-- 
2.47.0

