Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822A1A08B8;
	Mon,  9 Dec 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772370; cv=none; b=maq2j6jFcJkzq077aAUHEquJ2dm4brnRfKVjY0dMUP1AAB3onHixW6viy8T5Y7mxADZzLriVLmGgCJKR3oBxLbGtXaUbsnrK47jeQmbf7Wer5KDJ2KkKwPuJ7lqoegISs5bUDVHGaT2prdXygQkH1HT9eqmBIlHs6PLYgdqUN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772370; c=relaxed/simple;
	bh=Xsl7jgulT0Qc/ccSP55Jhb1h2cHHRcXWbVUjesDs0A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5SyEcmx7kQofTEiysQ/g2j1ManjuhY3nDHRmh6ORjhwmQPdYtccU32KpPWjucqbkQq+aK3v9/MpLTM+aTMzREwv5ei4e14it3yX/L1+vBdxcTI9JdJ3m3viL8KSppDq017j97nAXzQw2qufFrCb8wVgO7Na50DA0BqjQP1drMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RiJ55d90; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RiJ55d90"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Cc4V2028746;
	Mon, 9 Dec 2024 19:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rq7OInXWI/6WeBhhk
	RkFfWl6kqqoaATPpRAXFBbuZL4=; b=RiJ55d90NJVGkvtD/5gx72MxKQKNDJsv8
	neYpPzZYhBusejIvzeMONhGqCOEqwUECnVNJXDGE7ECEb/ttZfxJ2ARwqFoU78EB
	yZmPFS5q4xQzNTMdMkia+qatsgNLoNlcTY4UzCGZn21Ej89p5kH/YieMBnkJlO5d
	tOl3D5KjLlqVN0fBLJjY2G5ZI6o9Hq/j0lBVFQ2ywthJWyG4nmjKQIeHQTqDP8jU
	OLW6lMwpQOgdDaKnJ2rwMW2zR5Dk6J8ITr3Ic0Os+auUjuEMc6XSSLR1zSwVBdWh
	zjVYfnUrCTwIT/LONG+cmXyVkMhcZWWwHMwX5HHDhPPn+gLueb8ew==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjab5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GIuud017397;
	Mon, 9 Dec 2024 19:25:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1fqwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPufE29557452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3131658055;
	Mon,  9 Dec 2024 19:25:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D40158043;
	Mon,  9 Dec 2024 19:25:55 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:55 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 4/7] iommu/s390: support cleanup of additional table regions
Date: Mon,  9 Dec 2024 14:25:46 -0500
Message-ID: <20241209192549.107226-5-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192549.107226-1-mjrosato@linux.ibm.com>
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SgIUkq00ML8tXOVDSKuXO5W8JLKyUqD1
X-Proofpoint-ORIG-GUID: SgIUkq00ML8tXOVDSKuXO5W8JLKyUqD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090147

Extend the existing dma_cleanup_tables to also handle region second and
region first tables.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fcebc7415fb3..5782f329cae9 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -248,18 +248,59 @@ static void dma_free_seg_table(unsigned long entry)
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
@@ -415,7 +456,7 @@ static void s390_iommu_rcu_free_domain(struct rcu_head *head)
 {
 	struct s390_domain *s390_domain = container_of(head, struct s390_domain, rcu);
 
-	dma_cleanup_tables(s390_domain->dma_table);
+	dma_cleanup_tables(s390_domain);
 	kfree(s390_domain);
 }
 
-- 
2.47.0

