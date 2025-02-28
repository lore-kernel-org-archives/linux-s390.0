Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B51DE2A6;
	Fri, 28 Feb 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779118; cv=none; b=Bow23/i8cFWP9c4/46obT/Co2YhfacSkb0O+En+ITqRAS+kubxtmI52MtiA21jBu2U1NS6L6AtoEdOcZPp8Y33BuHT6SvNEmRrYMmU3uLo8BvrUprRXnMhrnhltfOCzEwaXt7HXBKiRTD85AWMOipUukodWVF0d9Gw9n8jCTsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779118; c=relaxed/simple;
	bh=YDtiCUGZ1DFYLtYEiORCXS2kC8zK5HeIvGBDnG+gFDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q99MP01uoso9bN172FlgMxGtUp/S5RDNI96yxqMSRP5vUIjr2dUaW5himvRwbZcrg66PaPAFZvxoG0aFC33dm9/nUC8xE3rbTaI0m5fAG7OAFQH8cOb8gZB7EE1urrBUtfyj28NFGRtTzE6JhhPOXEOiqhN6jzJLidVes2EZ8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EIhBeVVN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EIhBeVVN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFDfBh000335;
	Fri, 28 Feb 2025 21:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vswh/IjtE8TvCm3EG
	J0tv2ygyjQEfZ0TZgCEoSbKmgg=; b=EIhBeVVN6EkApv+VZs3QK8xSxFbGjB+Fj
	plBNE/K5AzBJLUQtj7cuM1WOz0ZuluXYZvEgvdTpYWC1nAdBSMHW7ZX6wLoa9Qb5
	oWNo2RRL7bgQF1IW1s3TDZJ1pGWm8BUeBTRA4jqw+IHFpv1YIitFc+l4lfNVL2kU
	VNROZz0J6njvzFWtcjhppBK5dSGVeKOlKttUqgiIConWPR8agyYlAkkTa7LSdJtm
	TqolUGa8o4zNeaZNqAlDYdF4MDKvV2vWYMapLYZbYC1XhQ0pD8RRg+A7demH7kXF
	n1Z/jbUqFmJEJ6PBkGNylZGT6zwKisTfZ5f31Kn2KDqpa2vWVjj8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4536y8crw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJoW35012565;
	Fri, 28 Feb 2025 21:45:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt91ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SLj3U515860410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:45:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E7158056;
	Fri, 28 Feb 2025 21:45:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3795B58054;
	Fri, 28 Feb 2025 21:45:02 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.46.135])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 21:45:02 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 2/5] iommu/s390: support cleanup of additional table regions
Date: Fri, 28 Feb 2025 16:44:53 -0500
Message-ID: <20250228214456.440641-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228214456.440641-1-mjrosato@linux.ibm.com>
References: <20250228214456.440641-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kb8s9064ZKgY2_cmdDrwk_OHtluvxduE
X-Proofpoint-ORIG-GUID: kb8s9064ZKgY2_cmdDrwk_OHtluvxduE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxlogscore=968 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280156

Extend the existing dma_cleanup_tables to also handle region second and
region first tables.

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
2.48.1

