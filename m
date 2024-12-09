Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A431A08CC;
	Mon,  9 Dec 2024 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772371; cv=none; b=TtkuPngfWCAqK9E+gryVDAAzg6yOQC+3aI2lENpj3Mi83gZJMVmRr2dqXwWYRCZDKlxVfWavTWFp+Bt7bFFjyJMyy+bFoMXUwRC4oMTBxhSb+X8ByFB4GbqbwYYtfHSwH2QbUMVS+6+p6AJK4U7sUWZbwpr3rwGoIL8mayMx5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772371; c=relaxed/simple;
	bh=WIi9XoA9A2uc6JbaovPL4q1ymijAA7WpAaKJ8FZuIpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1VUqf14bCZh1HvbdbEUr/mRHseI7D7IOc70nU/HzMj2/OLxi3mlRuipmy1F2D642lVM6Q7+3uC0v8+jV3yK8m5TIoQegdomrJNl695VvMITYN+7TIzkChPAOgdlWqcqfFSrr9vrZnuZZPBrdvVhBOi1SO0nAsaJTnZHTsiTXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qjw34iwM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qjw34iwM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B4xUG032677;
	Mon, 9 Dec 2024 19:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nSZPheZvpKDOK9A3V
	LIi74XqV9783u/Q0buFMWqezos=; b=Qjw34iwMaWT6hkQhZaYPsSCSnE033wwbw
	fymslt49kYNjw+3HPCl970Gfd0LA8R8oE/hkXD/g6RAO+oF6gypaOPOPDvYQRbHy
	WlVmFLp0ihfmnSkstkVFUc/zj0rDyyZ/jqkN4A1MSnt09Xvf46sYrzIZ7eCb3Ulo
	vDJp8mlbw3ovQHDoXbaMIjNtQpq2ffFhloUfnm7YRPc+scDwVcmJ4gcbGkg3kdBy
	IkeAkgsCX8Je0w1ftNHJSuBlGaTYv2yhGJw9h6jeSawKxSvRwChCzImpf9fGGUdu
	+Vtgy/4m1yyaZuXU8G+xTX9UqdltHl6rsN0x/cTn42Hi/bAAEmWbA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:26:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9J74W5018605;
	Mon, 9 Dec 2024 19:25:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k80hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPwXO15532584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A64858055;
	Mon,  9 Dec 2024 19:25:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A8C58043;
	Mon,  9 Dec 2024 19:25:57 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:57 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 6/7] iommu/s390: support map/unmap for additional table regions
Date: Mon,  9 Dec 2024 14:25:48 -0500
Message-ID: <20241209192549.107226-7-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BCmp2h_SP5dqWOkrgzTFC7HPTzhRqxmR
X-Proofpoint-GUID: BCmp2h_SP5dqWOkrgzTFC7HPTzhRqxmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

Map and unmap ops use the shared dma_walk_cpu_trans routine, update
this using the origin_type of the dma_table to determine how many
table levels must be walked.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 101 ++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cea528bf61db..4924fe9faccb 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -316,6 +316,60 @@ static unsigned long *dma_alloc_page_table(gfp_t gfp)
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
@@ -369,11 +423,45 @@ static unsigned long *dma_get_page_table_origin(unsigned long *step, gfp_t gfp)
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
@@ -665,8 +753,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 	int rc;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (unlikely(!entry)) {
 			rc = -ENOMEM;
 			goto undo_cpu_trans;
@@ -681,8 +768,7 @@ static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
 undo_cpu_trans:
 	while (i-- > 0) {
 		dma_addr -= PAGE_SIZE;
-		entry = dma_walk_cpu_trans(s390_domain->dma_table,
-					   dma_addr, gfp);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
 		if (!entry)
 			break;
 		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
@@ -699,8 +785,7 @@ static int s390_iommu_invalidate_trans(struct s390_domain *s390_domain,
 	int rc = 0;
 
 	for (i = 0; i < nr_pages; i++) {
-		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
-					   GFP_ATOMIC);
+		entry = dma_walk_cpu_trans(s390_domain, dma_addr, GFP_ATOMIC);
 		if (unlikely(!entry)) {
 			rc = -EINVAL;
 			break;
-- 
2.47.0

