Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC321B9E0;
	Mon, 31 Mar 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452544; cv=none; b=vEtMQH4uhBVIrgwOTZ5UaA8QAdDVpINr+V6sqHphxwO74wxO/PIumiXFSway2mJOwv524TJPU73SCS+cSWyRS6sdYZKjvgw4ziA2GqS8WothjB0ITrQJ/pmdkcgfLPBpKuZiGVCxavxHSmZuRCrHMezZshrDH2Sj7TuMFWC3o9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452544; c=relaxed/simple;
	bh=78FVZaz/ifJxU5ZlGxgMG855kHor4oDTQVhQw0ARKm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibIKfUnjLPCZbDrYFCZxF8QlrKnjSJ44k6fJwzYmnEHyma0J16ZVxqY1oXDrQGy0ODYFtA4L6EpwS8Jt2+8v6/tu87KsYZ2PgFZCuv2qhZSKiPDKjiptXjwL0M+YDghDpSGYpYq8dND+XLLNcqoGy7+lp6GRUUfxtkeY4I9Cqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TczRxzR1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TczRxzR1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VE3M4T007988;
	Mon, 31 Mar 2025 20:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0s2nYaP83mLmgojgx
	Ynn4A70gTj6tK12R3u0RycbEto=; b=TczRxzR1TXiqvVj1hh6DEyMZt3KcligXm
	qQHeKLJYbaO7Or3B8z0CFhOhHLwpdw9xXjdiezTQndB9L2A50yao1gse47cNcsCO
	kHf2Vsq/yr9SlxLpig72tMMHqOfkWtQajPWQRKE8BW8wTI6b5Gwsq3J/Dpp0OUk4
	qK50loT/4ZnzxZT+NpvVh/6/mZ7ATGQSoNjmRaqHODV76Y8RB5yNprhNSA/+V2jx
	KgaOv1H0Ns0g2GnbUR4+u6jR6zVKQhEI3Lu5uTvtBeT2pM1p4KhCktaM2uq66S5B
	MfHm10AMj9WhmpbmvepCmxP7YEnTJ29fTeehO2yMZbRoTVwJjMIpA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qvfpsse8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHn7di019410;
	Mon, 31 Mar 2025 20:22:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6symsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM83v27460292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3390558059;
	Mon, 31 Mar 2025 20:22:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7B8558053;
	Mon, 31 Mar 2025 20:22:06 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:22:06 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 4/5] iommu/s390: support map/unmap for additional table regions
Date: Mon, 31 Mar 2025 16:21:58 -0400
Message-ID: <20250331202159.85956-5-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202159.85956-1-mjrosato@linux.ibm.com>
References: <20250331202159.85956-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Wg7s9QUM7LDNGk7DZtY6RfB5D47wSpc
X-Proofpoint-GUID: 3Wg7s9QUM7LDNGk7DZtY6RfB5D47wSpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310135

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

