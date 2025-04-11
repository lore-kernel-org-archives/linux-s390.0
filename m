Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D12900BA;
	Fri, 11 Apr 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403099; cv=none; b=knkTopsO5ZlDlDNcZhH9aXaPnegGlZotbtIe04mqrF2rR641xZrd/ub05nYS/SOpknzfC7YB/KcOWm+IZKHqOr21KFQgtkO+lxTkW/q23sR+AEtAEi1QhntGViwxaJPT5wm07etUFC4r3WPs9/tuR4P9pK2QiZltsiY9/2lJOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403099; c=relaxed/simple;
	bh=78FVZaz/ifJxU5ZlGxgMG855kHor4oDTQVhQw0ARKm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzRnY1CYes4RvwgpNhAsa7B+MX79+1jFcvqOI9jdXpAeTXmsGKRLSIm7Hz2w1RQkpvgEYQ41QmW8cWUurk1DpYua3Vi4jJ0Gb2YY+wChS3ow7FDb7OY0YRbRfAE1jG88zInxq95T64KSWKmECZk2Is/pGmsS4nXOX0TtA/+Nd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lf3Cj2AM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lf3Cj2AM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII4Wp015152;
	Fri, 11 Apr 2025 20:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0s2nYaP83mLmgojgx
	Ynn4A70gTj6tK12R3u0RycbEto=; b=Lf3Cj2AMJcGjbPc2K1HL7Qn51LKLKsyqa
	HB0dT1VYrxAQUOYkf012nzJs/1x+wXWgmNrd0M3prkCHpdDzIGU5yzY2HrdoK1l7
	fEpD76jVZtYs6msdvAS3BFHLkh8dbf9lBC7snYPiehkPepyUdielBjKdHCGu3JGM
	cfyRE3/HvtTAb6M4CDVh95EQZkMngh7OH+HgjhbvqxLKVy5GYtOQBnOhgsLMgphQ
	6UIHCPV4vE8sEld/SQ7aK5CwckCcRcbqUwbpPIhpSDqJI5WorurNxwgOM3gKK3qa
	oB4thECQp4luQEIrbKwOIo0ebDrssf0czAylncV2Prg0zLRpjC/Ag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y4gqhu2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIZb2N014473;
	Fri, 11 Apr 2025 20:24:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup4p61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOdxI25100912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C615805C;
	Fri, 11 Apr 2025 20:24:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9EA5805A;
	Fri, 11 Apr 2025 20:24:38 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:38 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 4/5] iommu/s390: support map/unmap for additional table regions
Date: Fri, 11 Apr 2025 16:24:32 -0400
Message-ID: <20250411202433.181683-5-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411202433.181683-1-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fdWa-tmXObFFuDPuLkpwUrcWHG4kJ-bg
X-Proofpoint-ORIG-GUID: fdWa-tmXObFFuDPuLkpwUrcWHG4kJ-bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110127

Map and unmap ops use the shared dma_walk_cpu_trans routine, update
this using the origin_type of the dma_table to determine how many
table levels must be walked.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 127 ++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 338a7381e918..46f45b136993 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -67,6 +67,20 @@ static inline void set_pt_pfaa(unsigned long *entry, phys_addr_t pfaa)
 	*entry |= (pfaa & ZPCI_PTE_ADDR_MASK);
 }
 
+static inline void set_rf_rso(unsigned long *entry, phys_addr_t rso)
+{
+	*entry &= ZPCI_RTE_FLAG_MASK;
+	*entry |= (rso & ZPCI_RTE_ADDR_MASK);
+	*entry |= ZPCI_TABLE_TYPE_RFX;
+}
+
+static inline void set_rs_rto(unsigned long *entry, phys_addr_t rto)
+{
+	*entry &= ZPCI_RTE_FLAG_MASK;
+	*entry |= (rto & ZPCI_RTE_ADDR_MASK);
+	*entry |= ZPCI_TABLE_TYPE_RSX;
+}
+
 static inline void set_rt_sto(unsigned long *entry, phys_addr_t sto)
 {
 	*entry &= ZPCI_RTE_FLAG_MASK;
@@ -81,6 +95,22 @@ static inline void set_st_pto(unsigned long *entry, phys_addr_t pto)
 	*entry |= ZPCI_TABLE_TYPE_SX;
 }
 
+static inline void validate_rf_entry(unsigned long *entry)
+{
+	*entry &= ~ZPCI_TABLE_VALID_MASK;
+	*entry &= ~ZPCI_TABLE_OFFSET_MASK;
+	*entry |= ZPCI_TABLE_VALID;
+	*entry |= ZPCI_TABLE_LEN_RFX;
+}
+
+static inline void validate_rs_entry(unsigned long *entry)
+{
+	*entry &= ~ZPCI_TABLE_VALID_MASK;
+	*entry &= ~ZPCI_TABLE_OFFSET_MASK;
+	*entry |= ZPCI_TABLE_VALID;
+	*entry |= ZPCI_TABLE_LEN_RSX;
+}
+
 static inline void validate_rt_entry(unsigned long *entry)
 {
 	*entry &= ~ZPCI_TABLE_VALID_MASK;
@@ -286,6 +316,70 @@ static unsigned long *dma_alloc_page_table(gfp_t gfp)
 	return table;
 }
 
+static unsigned long *dma_walk_rs_table(unsigned long *rso,
+					dma_addr_t dma_addr, gfp_t gfp)
+{
+	unsigned int rsx = calc_rsx(dma_addr);
+	unsigned long old_rse, rse;
+	unsigned long *rsep, *rto;
+
+	rsep = &rso[rsx];
+	rse = READ_ONCE(*rsep);
+	if (reg_entry_isvalid(rse)) {
+		rto = get_rs_rto(rse);
+	} else {
+		rto = dma_alloc_cpu_table(gfp);
+		if (!rto)
+			return NULL;
+
+		set_rs_rto(&rse, virt_to_phys(rto));
+		validate_rs_entry(&rse);
+		entry_clr_protected(&rse);
+
+		old_rse = cmpxchg(rsep, ZPCI_TABLE_INVALID, rse);
+		if (old_rse != ZPCI_TABLE_INVALID) {
+			/* Somone else was faster, use theirs */
+			dma_free_cpu_table(rto);
+			rto = get_rs_rto(old_rse);
+		}
+	}
+	return rto;
+}
+
+static unsigned long *dma_walk_rf_table(unsigned long *rfo,
+					dma_addr_t dma_addr, gfp_t gfp)
+{
+	unsigned int rfx = calc_rfx(dma_addr);
+	unsigned long old_rfe, rfe;
+	unsigned long *rfep, *rso;
+
+	rfep = &rfo[rfx];
+	rfe = READ_ONCE(*rfep);
+	if (reg_entry_isvalid(rfe)) {
+		rso = get_rf_rso(rfe);
+	} else {
+		rso = dma_alloc_cpu_table(gfp);
+		if (!rso)
+			return NULL;
+
+		set_rf_rso(&rfe, virt_to_phys(rso));
+		validate_rf_entry(&rfe);
+		entry_clr_protected(&rfe);
+
+		old_rfe = cmpxchg(rfep, ZPCI_TABLE_INVALID, rfe);
+		if (old_rfe != ZPCI_TABLE_INVALID) {
+			/* Somone else was faster, use theirs */
+			dma_free_cpu_table(rso);
+			rso = get_rf_rso(old_rfe);
+		}
+	}
+
+	if (!rso)
+		return NULL;
+
+	return dma_walk_rs_table(rso, dma_addr, gfp);
+}
+
 static unsigned long *dma_get_seg_table_origin(unsigned long *rtep, gfp_t gfp)
 {
 	unsigned long old_rte, rte;
@@ -339,11 +433,31 @@ static unsigned long *dma_get_page_table_origin(unsigned long *step, gfp_t gfp)
 	return pto;
 }
 
-static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr, gfp_t gfp)
+static unsigned long *dma_walk_region_tables(struct s390_domain *domain,
+					     dma_addr_t dma_addr, gfp_t gfp)
 {
-	unsigned long *sto, *pto;
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		return dma_walk_rf_table(domain->dma_table, dma_addr, gfp);
+	case ZPCI_TABLE_TYPE_RSX:
+		return dma_walk_rs_table(domain->dma_table, dma_addr, gfp);
+	case ZPCI_TABLE_TYPE_RTX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+}
+
+static unsigned long *dma_walk_cpu_trans(struct s390_domain *domain,
+					 dma_addr_t dma_addr, gfp_t gfp)
+{
+	unsigned long *rto, *sto, *pto;
 	unsigned int rtx, sx, px;
 
+	rto = dma_walk_region_tables(domain, dma_addr, gfp);
+	if (!rto)
+		return NULL;
+
 	rtx = calc_rtx(dma_addr);
 	sto = dma_get_seg_table_origin(&rto[rtx], gfp);
 	if (!sto)
@@ -690,8 +804,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 	int rc;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (unlikely(!entry)) {
 			rc = -ENOMEM;
 			goto undo_cpu_trans;
@@ -706,8 +819,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 undo_cpu_trans:
 	while (i-- > 0) {
 		dma_addr -= PAGE_SIZE;
-		entry = dma_walk_cpu_trans(s390_domain->dma_table,
-					   dma_addr, gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (!entry)
 			break;
 		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
@@ -724,8 +836,7 @@ static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
 	int rc = 0;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   GFP_ATOMIC);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, GFP_ATOMIC);
 		if (unlikely(!entry)) {
 			rc = -EINVAL;
 			break;
-- 
2.49.0

