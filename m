Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BA225793;
	Fri, 24 Jan 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749931; cv=none; b=RvDvBIG8ddOj1K6omLerYzKWiIz3dXpi7GYaRWEbEJ4tzooc60R/c4avJRJ3UbtVBUWkfbi5L1UwK2skJe7I5Ek/s1oZovGOlx/f7SJILUkagvRMGByzpI6XGe8s7RoJyGMrFE2I6/gUhVt9XCyeHVmMpuqbC9xzSt5xIDGIYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749931; c=relaxed/simple;
	bh=spUQLLo/b0lIzu/+AIm/mnkNz0GvVqHrVQFtA+5jfnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO6f3eGxPj2lrtRmLzGs8GCGqD9Y350byB5oZeoKbJRFlW+J6p21oBi5vzM4lK2XCvJ1Uft+k4aDEbSYYmcx/zAWAPrG8un0V09yF1KPqEfzp+de8UUH3jxcvwWoY0YMIFw/8CPJZK+/Qs0L0rAEk7Kt1lFCUNeUQwyUA8piH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WQGY+AWv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WQGY+AWv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OCxZS7014626;
	Fri, 24 Jan 2025 20:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MSjV3J/DHiwx9kRTq
	HZzY4V9/1n16syH8C6WsDILufI=; b=WQGY+AWvd7h2VCvBmE0tlTXCc8Z/RMgnF
	ZOv/jX18/Ux5bU8ipNUhCfprbNTRFMHMmY72NjdG69N+sNP5yJgCrt7nk1dpYAKi
	nyzJQIyc5Ztx1LHIWxrShYg76EPlJ8xe+poQWvby9cWzfiStfc0gGI9Ipo/mwflG
	6Ch148ei/Mlf9fm7s82hxW8Xxo8M3EKdJpHeVFLhLsHOOuFe9FEs6VjqBXwUEoiR
	dHeFOPAtMS8zLcum4q7Lhfvhw/HW7USlQlOTeysSWS+566cQH1xngFFtFCcsH7uV
	dlwRjP6Psp+5w+cH61e4b/OXSFGi88ir8WK0s4/amj7ehEV2rAWIA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c4p7vp2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJoHaf022449;
	Fri, 24 Jan 2025 20:18:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kn5n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKIY9T31851106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E8095805C;
	Fri, 24 Jan 2025 20:18:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49A0B58051;
	Fri, 24 Jan 2025 20:18:33 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:33 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 5/6] iommu/s390: support map/unmap for additional table regions
Date: Fri, 24 Jan 2025 15:18:25 -0500
Message-ID: <20250124201826.348848-6-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124201826.348848-1-mjrosato@linux.ibm.com>
References: <20250124201826.348848-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1WObz9QmdeNU-vhA8X_i6aUUxlYLnNLa
X-Proofpoint-ORIG-GUID: 1WObz9QmdeNU-vhA8X_i6aUUxlYLnNLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

Map and unmap ops use the shared dma_walk_cpu_trans routine, update
this using the origin_type of the dma_table to determine how many
table levels must be walked.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 131 ++++++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 88adc4efc53f..4924fe9faccb 100644
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
@@ -286,6 +316,60 @@ static unsigned long *dma_alloc_page_table(gfp_t gfp)
 	return table;
 }
 
+static unsigned long *dma_get_rs_table_origin(unsigned long *rfep, gfp_t gfp)
+{
+	unsigned long old_rfe, rfe;
+	unsigned long *rso;
+
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
+	return rso;
+}
+
+static unsigned long *dma_get_rt_table_origin(unsigned long *rsep, gfp_t gfp)
+{
+	unsigned long old_rse, rse;
+	unsigned long *rto;
+
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
 static unsigned long *dma_get_seg_table_origin(unsigned long *rtep, gfp_t gfp)
 {
 	unsigned long old_rte, rte;
@@ -339,11 +423,45 @@ static unsigned long *dma_get_page_table_origin(unsigned long *step, gfp_t gfp)
 	return pto;
 }
 
-static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr, gfp_t gfp)
+static unsigned long *dma_walk_region_tables(struct s390_domain *domain,
+					     dma_addr_t dma_addr, gfp_t gfp)
+{
+	unsigned long *rfo, *rso;
+	unsigned int rfx, rsx;
+
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		rfo = domain->dma_table;
+		goto walk_rf;
+	case ZPCI_TABLE_TYPE_RSX:
+		rso = domain->dma_table;
+		goto walk_rs;
+	case ZPCI_TABLE_TYPE_RTX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+
+walk_rf:
+	rfx = calc_rfx(dma_addr);
+	rso = dma_get_rs_table_origin(&rfo[rfx], gfp);
+	if (!rso)
+		return NULL;
+walk_rs:
+	rsx = calc_rsx(dma_addr);
+	return dma_get_rt_table_origin(&rso[rsx], gfp);
+}
+
+static unsigned long *dma_walk_cpu_trans(struct s390_domain *domain,
+					 dma_addr_t dma_addr, gfp_t gfp)
 {
-	unsigned long *sto, *pto;
+	unsigned long *rto, *sto, *pto;
 	unsigned int rtx, sx, px;
 
+	rto = dma_walk_region_tables(domain, dma_addr, gfp);
+	if (!rto)
+		return NULL;
+
 	rtx = calc_rtx(dma_addr);
 	sto = dma_get_seg_table_origin(&rto[rtx], gfp);
 	if (!sto)
@@ -635,8 +753,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 	int rc;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (unlikely(!entry)) {
 			rc = -ENOMEM;
 			goto undo_cpu_trans;
@@ -651,8 +768,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 undo_cpu_trans:
 	while (i-- > 0) {
 		dma_addr -= PAGE_SIZE;
-		entry = dma_walk_cpu_trans(s390_domain->dma_table,
-					   dma_addr, gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (!entry)
 			break;
 		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
@@ -669,8 +785,7 @@ static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
 	int rc = 0;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   GFP_ATOMIC);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, GFP_ATOMIC);
 		if (unlikely(!entry)) {
 			rc = -EINVAL;
 			break;
-- 
2.48.1

