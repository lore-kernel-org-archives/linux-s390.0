Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB323F787E;
	Fri,  1 May 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663608; cv=none; b=OPwp8VPa+9ANPiQK+sVtTM7OM8U/xn7eAvlr3XiFk7QosLRzQjYBnomaYpf6cL2oWV8uxqWxxr5bPtKq+h4Tl3BIRPnivHdPrHS+ndAga5qorZ+SRe3vkBNqQ6mUhjJllS74SnBiCVw/o38HysY5JYrb0FPR/GI/GLVXiXgJKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663608; c=relaxed/simple;
	bh=RWHLEYTvACOIkJcpQeZF7m+uxDKtXoN4/UoRkmCEtfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfM+a30p+A5JQ5d6U+FEmTi72v27z/qafPDs0S18H+1hryOezzs2BJanz1cIumxqs8JRNLbLGu6u3zvgCEBGx9ThOsvd7oWT4QjbIIINKG5tc/uZPFwOL1VUeCIyT0igdIlXC9RKuOMtbfqAymD58+80bYLNofTWAEVQBcgXJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VnssU3Y9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VnssU3Y9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6417ctWb3961718;
	Fri, 1 May 2026 19:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6dhk6oPMjcd/tLceq
	t102Cix8j/Hvs1RPLzVjDwP/Ro=; b=VnssU3Y9dDQn1y+Sk3L8p9shyBkT45JUw
	h9wbeI4mbTPdc/+CRbqxFuBXNUd7q7nU5Dm7dgllysJX43IaKyxaTTvNJOpIoiqV
	lpNVxV1AxdHMHH6AMdNsn/mXqhtm89rP8kp6VxWnw0RNwwk+mUK3yQ62TbC1PcfE
	Ol4LWx1GEI30xG7ZM8cBExnks6zjklEuQub/xaw3NsIrNZFgrO1/bRRg5rSuZVZF
	5Xmbcsg4jPLEIwLfCwk39UKiPwKu+/26IZiJI8NJ2lbwkowx3LqY9QK6giSwP4F7
	J5lTPnGzlKlwUMaHt+a5JoNyZbl1uj8WYXQZ6Paq2Nwivhqpt0DvA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn4568ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:26:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JNtHv013160;
	Fri, 1 May 2026 19:26:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqryda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:26:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641JQd4S18219632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 19:26:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E212958043;
	Fri,  1 May 2026 19:26:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4120158053;
	Fri,  1 May 2026 19:26:38 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 19:26:38 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v1 1/3] s390/pci: Preserve FMB state in device re-enablement
Date: Fri,  1 May 2026 15:25:28 -0400
Message-ID: <20260501192530.9429-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501192530.9429-1-oelghoul@linux.ibm.com>
References: <20260501192530.9429-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: odcMXheFGBk5onxttqMqV8hLu7h7lQXo
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f4fe74 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=sdm-MloC9ubkM-Nm6RcA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-GUID: odcMXheFGBk5onxttqMqV8hLu7h7lQXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5MCBTYWx0ZWRfXw/EwYTVk+90b
 BCOhoBxNFYWGYrCA7C9W12YNAVIkLBmUgdZ/IQ1wcW2tm7nIy38LSdcWOAg4bm1KMmmk2KVHIZN
 Qwx0XBjPAmOI6u+XqeCKctw9K/twgxnxlJvhoZrwyIOtHZHbIHEp2lUdtl8U5B6pGs1wZ81o65+
 md+SmQ9kpRz+a4ulVoIDfDRPHq8rROrR3Q2N16x1PVaO6Xcd4PVbB8hWyugs4GSsjtICYGCCVdS
 KOgwYWSga9A/5wcz1iTVP919C+DepXLy5PklSBAtKZn0I+syNn6rMIHjLE8LKlViRXJZc9hThy6
 /t6P7qtzEdV9cCuaSE0wb7P8fsfeUmtHq878wryvbgDL9dntYI5GB0S6W/csjjheZkfFulDkF1b
 k9KPj6X88WlOxz5osC5mgNB8p58tKvRO+fOAQ+UPENvXzC+S6dux41P3jJRg+OWppgCS1IQIVjS
 i98lBvh6Z+zUTIhKFSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010190

Introduce a function zpci_fmb_reenable_device() that checks for the state
of the FMB and reuses the same buffer where appropriate. If FMB was not
previously enabled, it enables it for the device. Call this function during
a zPCI device re-enablement, which in turn implicitly ensures that the FMB
is enabled for host devices during their KVM registration.

This function also clears out the software counters, so that a program
resetting an FMB would see all its counters restart from zero as expected.
The function to clear the software counters is also separated into a static
function as it is now reused in both zpci_fmb_enable_device() and
zpci_fmb_reenable_device().

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 71 ++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 13 deletions(-)

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
index 39bd2adfc240..9bc38e041130 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,6 +164,24 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 	return cc;
 }
 
+static void zpci_fmb_clear_iommu_ctrs(struct zpci_dev *zdev)
+{
+	struct zpci_iommu_ctrs *ctrs;
+	unsigned long flags = 0;
+
+	/* reset software counters */
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	ctrs = zpci_get_iommu_ctrs(zdev);
+	if (ctrs) {
+		atomic64_set(&ctrs->mapped_pages, 0);
+		atomic64_set(&ctrs->unmapped_pages, 0);
+		atomic64_set(&ctrs->global_rpcits, 0);
+		atomic64_set(&ctrs->sync_map_rpcits, 0);
+		atomic64_set(&ctrs->sync_rpcits, 0);
+	}
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
+
 /* Modify PCI: Set PCI function measurement parameters */
 int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
@@ -181,18 +199,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		return -ENOMEM;
 	WARN_ON((u64) zdev->fmb & 0xf);
 
-	/* reset software counters */
-	spin_lock_irqsave(&zdev->dom_lock, flags);
-	ctrs = zpci_get_iommu_ctrs(zdev);
-	if (ctrs) {
-		atomic64_set(&ctrs->mapped_pages, 0);
-		atomic64_set(&ctrs->unmapped_pages, 0);
-		atomic64_set(&ctrs->global_rpcits, 0);
-		atomic64_set(&ctrs->sync_map_rpcits, 0);
-		atomic64_set(&ctrs->sync_rpcits, 0);
-	}
-	spin_unlock_irqrestore(&zdev->dom_lock, flags);
-
+	zpci_fmb_clear_iommu_ctrs(zdev);
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
@@ -227,6 +234,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	}
 	return cc ? -EIO : 0;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
+
+int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_iommu_ctrs *ctrs;
+	struct zpci_fib fib = {0};
+	unsigned long flags;
+	u8 cc, status;
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
+	fib.fmb_addr = virt_to_phys(zdev->fmb);
+	cc = zpci_mod_fc(req, &fib, &status); /* Re-enable function measurement */
+	if (cc) {
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+		return -EIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -729,9 +771,12 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
 
+	zpci_fmb_reenable_device(zdev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_reenable_device);
-- 
2.52.0

