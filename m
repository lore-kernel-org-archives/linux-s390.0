Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E4218E97;
	Mon, 31 Mar 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452541; cv=none; b=txW5+bAvq5hQEjHbk7CqVjtYUvr14kTDIBc8rwYBHQsKi1ToYgYv76osjkg4aIT9dnqCAP1wHu+qKQuUB38Bx2QAvY708NHLhFPSBp4QUc6Qc7NW0DIteNsDxSH6SRfaUyRABnI3V0G0N5KNxe3837xY6mplT/0C9GyOnROl9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452541; c=relaxed/simple;
	bh=2qKsH5kv0ncdsyHod9k9bno1V2Ucw112xluXhuZPimk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd8e0XD2lw3jFqe7jbd0b0MHWFi9gR1J/Rfdm3d3cH6rqqV4CY1FeaB0rxGP+pkhv2RZZeq3cOIoA9PXg5IgqEGFA9c+J+e9scFf9lQhRvXlBxxU8SsXON5SPH9AE0j0NwCk/2JbcraeupFdNV2+oMFBQ1iJxjgkNEniDtTRtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VdASBkhu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VdASBkhu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHC3bq029000;
	Mon, 31 Mar 2025 20:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c39HqofJWxJJ4EWgu
	mfYfcuMArfFUHDA2BWbZqfDm44=; b=VdASBkhuiOelxpog44Tr6J7tMyFl46Wo9
	zqU0XcCnLP3emAhOOYpMCtW0QykRAgi41wp7j2rqZ9ccWLja43T/tLtOyPAEKR57
	TDhPKfmXukJ1ZzfZU7y3DWv8WUI+RKi/WYKdsUJMxziNycs66DYMRh8s2bYDYuQl
	t3U+RtG7ToLiAa8DoPEjEOxhiMAN3q4uK2NQOMSj2P9jg49MLD9lxcG/aolm/7wM
	8FgGy6leNe5V8BFiLFSAFPuwkQGVyEdvktWzUH3n4Ez1BcEAvGdY3Gcl2At0ZxwU
	/j6O/SvyNRrcZ50oM27r5u46olqZbU+bVg2SxGcJ60pwDuZ5ybilQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qy7x8tf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHb6VF019405;
	Mon, 31 Mar 2025 20:22:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6symsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM3dN25494120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23F858043;
	Mon, 31 Mar 2025 20:22:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 739E25805D;
	Mon, 31 Mar 2025 20:22:03 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:22:03 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 2/5] iommu/s390: support cleanup of additional table regions
Date: Mon, 31 Mar 2025 16:21:56 -0400
Message-ID: <20250331202159.85956-3-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hdqMQTEgj-xxIamRuDlm7ny0sOUtC5FM
X-Proofpoint-GUID: hdqMQTEgj-xxIamRuDlm7ny0sOUtC5FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxlogscore=974 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310138

Extend the existing dma_cleanup_tables to also handle region second and
region first tables.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cad032d4c9a6..f2cda0ce0fe9 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -121,6 +121,22 @@ static inline int pt_entry_isvalid(unsigned long entry)
 	return (entry & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID;
 }
 
+static inline unsigned long *get_rf_rso(unsigned long entry)
+{
+	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RFX)
+		return phys_to_virt(entry & ZPCI_RTE_ADDR_MASK);
+	else
+		return NULL;
+}
+
+static inline unsigned long *get_rs_rto(unsigned long entry)
+{
+	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RSX)
+		return phys_to_virt(entry & ZPCI_RTE_ADDR_MASK);
+	else
+		return NULL;
+}
+
 static inline unsigned long *get_rt_sto(unsigned long entry)
 {
 	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RTX)
@@ -192,18 +208,59 @@ static void dma_free_seg_table(unsigned long entry)
 	dma_free_cpu_table(sto);
 }
 
-static void dma_cleanup_tables(unsigned long *table)
+static void dma_free_rt_table(unsigned long entry)
 {
+	unsigned long *rto = get_rs_rto(entry);
 	int rtx;
 
-	if (!table)
+	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+		if (reg_entry_isvalid(rto[rtx]))
+			dma_free_seg_table(rto[rtx]);
+
+	dma_free_cpu_table(rto);
+}
+
+static void dma_free_rs_table(unsigned long entry)
+{
+	unsigned long *rso = get_rf_rso(entry);
+	int rsx;
+
+	for (rsx = 0; rsx < ZPCI_TABLE_ENTRIES; rsx++)
+		if (reg_entry_isvalid(rso[rsx]))
+			dma_free_rt_table(rso[rsx]);
+
+	dma_free_cpu_table(rso);
+}
+
+static void dma_cleanup_tables(struct s390_domain *domain)
+{
+	int rtx, rsx, rfx;
+
+	if (!domain->dma_table)
 		return;
 
-	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
-		if (reg_entry_isvalid(table[rtx]))
-			dma_free_seg_table(table[rtx]);
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		for (rfx = 0; rfx < ZPCI_TABLE_ENTRIES; rfx++)
+			if (reg_entry_isvalid(domain->dma_table[rfx]))
+				dma_free_rs_table(domain->dma_table[rfx]);
+		break;
+	case ZPCI_TABLE_TYPE_RSX:
+		for (rsx = 0; rsx < ZPCI_TABLE_ENTRIES; rsx++)
+			if (reg_entry_isvalid(domain->dma_table[rsx]))
+				dma_free_rt_table(domain->dma_table[rsx]);
+		break;
+	case ZPCI_TABLE_TYPE_RTX:
+		for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+			if (reg_entry_isvalid(domain->dma_table[rtx]))
+				dma_free_seg_table(domain->dma_table[rtx]);
+		break;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", domain->origin_type);
+		return;
+	}
 
-	dma_free_cpu_table(table);
+	dma_free_cpu_table(domain->dma_table);
 }
 
 static unsigned long *dma_alloc_page_table(gfp_t gfp)
@@ -358,7 +415,7 @@ static void s390_iommu_rcu_free_domain(struct rcu_head *head)
 {
 	struct s390_domain *s390_domain = container_of(head, struct s390_domain, rcu);
 
-	dma_cleanup_tables(s390_domain->dma_table);
+	dma_cleanup_tables(s390_domain);
 	kfree(s390_domain);
 }
 
-- 
2.49.0

