Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A871A8F97;
	Fri,  7 Feb 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961639; cv=none; b=u3zsD9ZDQmSeUxbNplyf2yxt0gMGaGigt4KA6nBLFgAJirIcTfrsklclzTGqYzf4S/K/GUcxqqqDhJKRVnDEZt1qse1XCScIBBUO2J0gG2SJf7NHtD8jskgPZHQOki1oBp9g33FwsIBxkCsEubAfqlNj+mgUwMYFsCi+3+zHj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961639; c=relaxed/simple;
	bh=zXPlMQVOkeEysfAXDyjBhtBhZgbfMsvWDwt5Q6M+pZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/npWRM5em1uGsaKUQ9Tl5CTm9TvTTT/qAe+NmeePGjgX1l9c3h+9LbAoriQxegnPlXrsE16Mkjzoa2pU5zQDhhGauvoORtOFfwtFgQta4s4KHEg8xB3mW2WE3LaNs0jYPtpcRa5EfXCd8j9yudjLhniNBsvBtFopxqLZN0pgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rCAijZii; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rCAijZii"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DjGwN027672;
	Fri, 7 Feb 2025 20:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F1Kaa0cy8M45eppVo
	lcD+3vcrnRuJQQRRU7eaSuNZAs=; b=rCAijZiiHyh6wD26xEtV9WWH0wxaiZEAA
	q0pMrxYHcvnD8WZovn/qKU6H0rYszD2SYSorseNQ8hX1btQEL65tyLWR4UnXMryA
	wp6PtXZ7doyHuy4pwEN2JLvB9TmOMrQW+xANLjaLmuttmooCL5Rnm8BnJ4yE/2TO
	ZXTa4ADCMiN2zZKxopwN7XD2Ohbhnx0XXieT3jaUk3EjzwFpjfMCVsXwwfewwhOU
	eYK0R/q37DpoEbbzDCEqoiJ4K4hPqgNT8ohNX957QCARyKUixTPGFHsVONYxKbWw
	lkEJ35SFCXSrA/UPYVRpI19GrJQWol9Uy7bqepwND+XjYvRtJ/Lkw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910d1qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517I4VV4016288;
	Fri, 7 Feb 2025 20:53:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxswmnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517Krg8i33686104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:53:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF5458052;
	Fri,  7 Feb 2025 20:53:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C92858045;
	Fri,  7 Feb 2025 20:53:41 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.30.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:53:41 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 3/4] iommu/s390: handle IOAT registration based on domain
Date: Fri,  7 Feb 2025 15:53:34 -0500
Message-ID: <20250207205335.473946-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: d8yjdbiwXpMZvCbZ0dEaQnRGZslwTc4r
X-Proofpoint-GUID: d8yjdbiwXpMZvCbZ0dEaQnRGZslwTc4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=929
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070153

At this point, the dma_table is really a property of the s390-iommu
domain.  Rather than checking its contents elsewhere in the codebase,
move the code that registers the table with firmware into
s390-iommu and make a decision what to register with firmware based
upon the type of domain in use for the device in question.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  2 ++
 arch/s390/kvm/pci.c         | 17 ++-------------
 arch/s390/pci/pci.c         | 35 +++++++++++++++++-------------
 arch/s390/pci/pci_sysfs.c   | 11 +---------
 drivers/iommu/s390-iommu.c  | 43 +++++++++++++++++++++++++++++++++++--
 5 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 8fe4c7a72c0b..7cc6a7cc66e7 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -217,6 +217,7 @@ extern struct airq_iv *zpci_aif_sbv;
 struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state);
 int zpci_add_device(struct zpci_dev *zdev);
 int zpci_enable_device(struct zpci_dev *);
+int zpci_reenable_device(struct zpci_dev *zdev);
 int zpci_disable_device(struct zpci_dev *);
 int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh);
 int zpci_deconfigure_device(struct zpci_dev *zdev);
@@ -245,6 +246,7 @@ void update_uid_checking(bool new);
 /* IOMMU Interface */
 int zpci_init_iommu(struct zpci_dev *zdev);
 void zpci_destroy_iommu(struct zpci_dev *zdev);
+int zpci_iommu_register_ioat(struct zpci_dev *zdev, u8 *status);
 
 #ifdef CONFIG_PCI
 static inline bool zpci_use_mio(struct zpci_dev *zdev)
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 9b9e7fdd5380..8c40154ff50f 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -433,7 +433,6 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
 static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
 {
 	struct zpci_dev *zdev = opaque;
-	u8 status;
 	int rc;
 
 	if (!zdev)
@@ -480,13 +479,7 @@ static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
 	 */
 	zdev->gisa = (u32)virt_to_phys(&kvm->arch.sie_page2->gisa);
 
-	rc = zpci_enable_device(zdev);
-	if (rc)
-		goto clear_gisa;
-
-	/* Re-register the IOMMU that was already created */
-	rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				virt_to_phys(zdev->dma_table), &status);
+	rc = zpci_reenable_device(zdev);
 	if (rc)
 		goto clear_gisa;
 
@@ -516,7 +509,6 @@ static void kvm_s390_pci_unregister_kvm(void *opaque)
 {
 	struct zpci_dev *zdev = opaque;
 	struct kvm *kvm;
-	u8 status;
 
 	if (!zdev)
 		return;
@@ -550,12 +542,7 @@ static void kvm_s390_pci_unregister_kvm(void *opaque)
 			goto out;
 	}
 
-	if (zpci_enable_device(zdev))
-		goto out;
-
-	/* Re-register the IOMMU that was already created */
-	zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-			   virt_to_phys(zdev->dma_table), &status);
+	zpci_reenable_device(zdev);
 
 out:
 	spin_lock(&kvm->arch.kzdev_list_lock);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..fa879351efb5 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -124,14 +124,13 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
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
+	fib.iota = iota;
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, status);
 	if (cc)
@@ -690,6 +689,23 @@ int zpci_enable_device(struct zpci_dev *zdev)
 }
 EXPORT_SYMBOL_GPL(zpci_enable_device);
 
+int zpci_reenable_device(struct zpci_dev *zdev)
+{
+	u8 status;
+	int rc;
+
+	rc = zpci_enable_device(zdev);
+	if (rc)
+		return rc;
+
+	rc = zpci_iommu_register_ioat(zdev, &status);
+	if (rc)
+		zpci_disable_device(zdev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zpci_reenable_device);
+
 int zpci_disable_device(struct zpci_dev *zdev)
 {
 	u32 fh = zdev->fh;
@@ -739,7 +755,6 @@ EXPORT_SYMBOL_GPL(zpci_disable_device);
  */
 int zpci_hot_reset_device(struct zpci_dev *zdev)
 {
-	u8 status;
 	int rc;
 
 	lockdep_assert_held(&zdev->state_lock);
@@ -758,19 +773,9 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
 			return rc;
 	}
 
-	rc = zpci_enable_device(zdev);
-	if (rc)
-		return rc;
-
-	if (zdev->dma_table)
-		rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-					virt_to_phys(zdev->dma_table), &status);
-	if (rc) {
-		zpci_disable_device(zdev);
-		return rc;
-	}
+	rc = zpci_reenable_device(zdev);
 
-	return 0;
+	return rc;
 }
 
 /**
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 2de1ea6c3a8c..0ecad08e1b1e 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -52,7 +52,6 @@ static DEVICE_ATTR_RO(mio_enabled);
 
 static int _do_recover(struct pci_dev *pdev, struct zpci_dev *zdev)
 {
-	u8 status;
 	int ret;
 
 	pci_stop_and_remove_bus_device(pdev);
@@ -70,16 +69,8 @@ static int _do_recover(struct pci_dev *pdev, struct zpci_dev *zdev)
 			return ret;
 	}
 
-	ret = zpci_enable_device(zdev);
-	if (ret)
-		return ret;
+	ret = zpci_reenable_device(zdev);
 
-	if (zdev->dma_table) {
-		ret = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-					 virt_to_phys(zdev->dma_table), &status);
-		if (ret)
-			zpci_disable_device(zdev);
-	}
 	return ret;
 }
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fbdeded3d48b..007ccfdad495 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -381,6 +381,46 @@ static void zdev_s390_domain_update(struct zpci_dev *zdev,
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
+static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
+				      struct iommu_domain *domain, u8 *status)
+{
+	struct s390_domain *s390_domain;
+	int rc = 0;
+	u64 iota;
+
+	switch (domain->type) {
+	case IOMMU_DOMAIN_IDENTITY:
+		rc = zpci_register_ioat(zdev, 0, zdev->start_dma,
+					zdev->end_dma, 0, status);
+		break;
+	case IOMMU_DOMAIN_BLOCKED:
+		/* Nothing to do in this case */
+		break;
+	default:
+		s390_domain = to_s390_domain(domain);
+		iota = virt_to_phys(s390_domain->dma_table) |
+		       ZPCI_IOTA_RTTO_FLAG;
+		rc = zpci_register_ioat(zdev, 0, zdev->start_dma,
+					zdev->end_dma, iota, status);
+	}
+
+	return rc;
+}
+
+int zpci_iommu_register_ioat(struct zpci_dev *zdev, u8 *status)
+{
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+
+	rc = s390_iommu_domain_reg_ioat(zdev, zdev->s390_domain, status);
+
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+
+	return rc;
+}
+
 static int blocking_domain_attach_device(struct iommu_domain *domain,
 					 struct device *dev)
 {
@@ -422,8 +462,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	blocking_domain_attach_device(&blocking_domain, dev);
 
 	/* If we fail now DMA remains blocked via blocking domain */
-	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
-				virt_to_phys(s390_domain->dma_table), &status);
+	cc = s390_iommu_domain_reg_ioat(zdev, domain, &status);
 	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
 		return -EIO;
 	zdev->dma_table = s390_domain->dma_table;
-- 
2.48.1

