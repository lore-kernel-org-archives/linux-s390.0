Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2B225404;
	Fri, 24 Jan 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749926; cv=none; b=ZOoW6UnoimPljlMUz64Kw7PL7l4pqBwLilY5Q3q++l7dcnizCPEA285yeGIfHludwjAw2dfsPkY/09ZYqRvWgXPCJpW4yu5X6TQpn1Sn2iX5oComkpNXbTVeEkpsMGeLzWj4ZgCeQEVZm5SaojQWN+LB1junXL7hI9rL5iYmEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749926; c=relaxed/simple;
	bh=VE3J1qYxygN5NqmC7J2Q3Rd5fW013kBKF9K1qwgoVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+ds0ZS92VwKUmlSJSdUotYfOxk3g1weoytooOWkCRYes9vyMis0OxPseuEBq4jLfZmmwSAyghQYhB9l2BHqUIZ91b95x/YYoi0b46g9HLtHY11wBtBfvzsRWfBZ/VlNomJU8OXcz1QDIBKr5XvJLUKPA1XDGKu621YiYQJyzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lR/MKtGo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lR/MKtGo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFdVmH013414;
	Fri, 24 Jan 2025 20:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1PXToSejdwMJ2Amf4
	jcNnC+jyWBjEmkr2SE2zrvyRG8=; b=lR/MKtGoyBtzxTGlrC57Wr2o0Jcf6e2QY
	/QIBwJmUxfuYemIpuKyOQMbUDPKioOJr9pQd/1pRfet+RfRjB617LRPf9GYbqeZi
	hWwOtyWMy9Jng/iMtwKXfqavsC99rehvxHoQQFh52BPCe+je/ujp2OpaDYm3zO9v
	8ZHI0ZRckWn78ZSq2Jw4Nf5rOkjBCrWUXIbNNX6n/dpyut/NQnvSyN3RCtB8nU+D
	dvLMsYoUfN+L54QuK0/prYjpJ+7e9r75bQCKEuLj18orCs7H7dI4N+KQ6maBX4Rh
	hnSkr3NcqPwe8Fm5TS4uBOYFjg7WVI8eAz+CcU73ofV6e/IggXapw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cdptsaua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OHFS9D021012;
	Fri, 24 Jan 2025 20:18:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1vwsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:32 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKIWfK10748506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7A45805C;
	Fri, 24 Jan 2025 20:18:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278395805A;
	Fri, 24 Jan 2025 20:18:31 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:31 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 3/6] iommu/s390: support cleanup of additional table regions
Date: Fri, 24 Jan 2025 15:18:23 -0500
Message-ID: <20250124201826.348848-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CHby4ew6z2MLYC2kdTWof3nIlN-ZKYQe
X-Proofpoint-GUID: CHby4ew6z2MLYC2kdTWof3nIlN-ZKYQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=970 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240137

Extend the existing dma_cleanup_tables to also handle region second and
region first tables.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f6c27b6ab4c6..73e0bb251bc1 100644
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
@@ -359,7 +416,7 @@ static void s390_iommu_rcu_free_domain(struct rcu_head *head)
 {
 	struct s390_domain *s390_domain = container_of(head, struct s390_domain, rcu);
 
-	dma_cleanup_tables(s390_domain->dma_table);
+	dma_cleanup_tables(s390_domain);
 	kfree(s390_domain);
 }
 
-- 
2.48.1

