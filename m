Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB940910D;
	Fri, 12 Jun 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287863; cv=none; b=tXUq09yA2N2vqplO53ez9RqjJYvWNVnILPDJzOqdpVYSufpKYjISU0/duD36+djGsvzvFaxAxynlZV62QD+YHDuICMhFksL3epTKSbZ7mrHgQCxDVcGh2CEa55Gxn84mVB/nCCog8YgAyA+gw85dDasuB0mnQp/BjoDBqr9CbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287863; c=relaxed/simple;
	bh=nCzsf4HCvxPIXR4SDdRlORe690fVrB8ZyyoHkWb+b2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+p8GcXGrc+LdrXFEEiVGmvvwKhjaSs8bPED3rbzd69PZppHbnC9Zz7eX0rDVDdN9/OOgQGiKYTk8HHrsS8q7y4+m250VWagg/Kniy5XJ+XjDg7GFJBSf+lFX24ZDvFqncNoOyDzonYvzga++xNiWZqopBHR2CeFHfSDGKwHK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rt+Wx4qb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rt+Wx4qb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CEr3OV722245;
	Fri, 12 Jun 2026 18:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BOVt7cVWDsBa/Xm42
	9cRp4lmqG376b/vLrNSA+l1aFE=; b=Rt+Wx4qbd/eT5Pnq/VBltmFEsL4FsTioK
	bEdYwaxDXGc97uKCvVEQTKu6SQsnaL2iUJk6rmLTSH9/qlVPFJ4PU/YO6Msksfa6
	pg4KCK/XgrDznEFXgGA8Il69XKcyJGx5fa5JR6Kdo0mimoRkZJegOtvRaxfMUqQj
	vEeGZvJBN1m8Za2DmfM4FKolKcq+egPFqWIsjhF8xDzAt1IcMJ176072Qc6Yovsp
	+GWDv5Zo8W+6APOOeQORSkB5ypnYE3k+h7QAsqnZCQI/qjGE/FPkMfJldyv9zqOv
	UhT5UfQOc3rcqrniM7wYiH0ftz7j5GFl59wQm9eI9pdG6DpaaaB+Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dje37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CI4dPP020517;
	Fri, 12 Jun 2026 18:10:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08s22n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CIAr3t29819602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 18:10:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 249EE58052;
	Fri, 12 Jun 2026 18:10:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F8458056;
	Fri, 12 Jun 2026 18:10:52 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.255.20])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 18:10:51 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v4 2/4] s390/pci: Preserve FMB state in device re-enablement
Date: Fri, 12 Jun 2026 14:10:46 -0400
Message-ID: <20260612181048.91548-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612181048.91548-1-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX5CBf3BXRz00A
 aiGWWmrIQo+zuAwlup0MzcsqwkEEaZ12H0Nvfv+5Yr9x5wDeedepzfatQA1ESl+CBuQUP5EK6QZ
 YJJ1uVzkKVS3PJ70KauuRM4t96cxvv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfXzDEQav1bO42Y
 ZyYDcoumRtsySOdmu2e0Yt9/0z8dAM5mXyY3Fga03E+3a/853GF9T669+y4FNq8RPnN97OlsuEu
 buUyoHr31Za1Igwe9hWTKRdgmtnuHn+5RleiC5Nz7DDzgfU2SakwO6DBU7c6NIGUFf2Kxod6zbW
 ICD+l42FzzzivjAbF19s+tPgcXT1TYV/Dzu4yLEkiLDredAIH/EEEahQkfohNGon0RFe3nARH3i
 1Lwj59VfamYj8gSIxac8KDjKLHS1CmR9sF1ZP2H1fqvDRFAVzRmPfGvZYHV9WWbyDao4GoPclL4
 N2gOIv6POTa6+cvAZaFd0CsMe/qnbkqVQ6ouaSE1PJZ/frhEvgrt5oDCFW24VWRHx80eotBoNYJ
 49L8S2KOr9F88/EfbhRZXyUbfnQhZFvi2293sP5Efzsa1mZMwgRT+s8bOTlpBU6DxjLGI36To0K
 yOdg9He3/m+HHqZgAvw==
X-Proofpoint-ORIG-GUID: 8quAazH_9QieQvyfyx9IPRzzjx0o0wFp
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2c4bb2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=6Vtv6p8LYkiH6MEZsLwA:9
X-Proofpoint-GUID: 8quAazH_9QieQvyfyx9IPRzzjx0o0wFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120169

Introduce a function zpci_fmb_reenable_device() that checks for the state
of the FMB and reuses the same buffer where appropriate. If the FMB was not
previously enabled, enable it for the device. Call this function during a
zPCI device re-enablement, which in turn implicitly ensures that the FMB is
is enabled for host devices during their KVM registration.

Besides re-enabling the FMB itself in zpci_fmb_reenable_device() also clear
out the software counters, such that a program resetting an FMB sees all
counters start from zero as expected. Separate this clearing of software
counters out into zpci_fmb_clear_iommu_ctrs() and reuse it in
zpci_fmb_enable_device() and zpci_fmb_reenable_device(). Likewise separate
the FMB enable logic into zpci_fmb_do_enable() to be reused in the same two
functions.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 95 +++++++++++++++++++++++++++++--------
 2 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 5dcf35f0f325..65014e52d559 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -323,6 +323,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
 int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_reenable_device(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2910d4038d39..21d3fccac789 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,24 +164,10 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 	return cc;
 }
 
-/* Modify PCI: Set PCI function measurement parameters */
-int zpci_fmb_enable_device(struct zpci_dev *zdev)
+static void zpci_fmb_clear_iommu_ctrs(struct zpci_dev *zdev)
 {
-	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
-	struct zpci_fib fib = {0};
-	unsigned long flags;
-	u8 cc, status;
-
-	lockdep_assert_held(&zdev->fmb_lock);
-
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
-		return -EINVAL;
-
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
+	unsigned long flags = 0;
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -194,17 +180,49 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		atomic64_set(&ctrs->sync_rpcits, 0);
 	}
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
 
+static int zpci_fmb_do_enable(struct zpci_dev *zdev)
+{
+	/* This helper assumes that zdev->fmb is already allocated and thus only
+	 * takes care of the actual enablement.
+	 */
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
+
+	return cc ? -EIO : 0;
+}
+
+/* Modify PCI: Set PCI function measurement parameters */
+int zpci_fmb_enable_device(struct zpci_dev *zdev)
+{
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+		return -EINVAL;
+
+	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+	if (!zdev->fmb)
+		return -ENOMEM;
+	WARN_ON((u64) zdev->fmb & 0xf);
+
+	zpci_fmb_clear_iommu_ctrs(zdev);
+
+	rc = zpci_fmb_do_enable(zdev);
+	if (rc) {
 		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
 		zdev->fmb = NULL;
 	}
-	return cc ? -EIO : 0;
+	return rc;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_enable_device);
 
 /* Modify PCI: Disable PCI function measurement */
 int zpci_fmb_disable_device(struct zpci_dev *zdev)
@@ -231,6 +249,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	}
 	return cc ? -EIO : 0;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
+
+int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->fmb)
+		return zpci_fmb_enable_device(zdev);
+
+	fib.gd = zdev->gisa;
+	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
+
+	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
+	 * because we are re-enabling function measurement for the same function
+	 * handle.
+	 */
+	if (cc)
+		return -EIO;
+
+	zpci_fmb_clear_iommu_ctrs(zdev);
+
+	rc = zpci_fmb_do_enable(zdev);
+	if (rc) {
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,9 +790,13 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
 
+	guard(mutex)(&zdev->fmb_lock);
+	zpci_fmb_reenable_device(zdev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_reenable_device);
-- 
2.54.0

