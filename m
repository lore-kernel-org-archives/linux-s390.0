Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA51DE2CB;
	Fri, 28 Feb 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779119; cv=none; b=o2hNUbx2d2cz1mVuo0mFuXmp1WpERqv7Sdk1BmW2+hnFwyAoPCNcXIMUXUtu3uDTy6q1lq4OUFNF5GvBDWf4HEPzZsatGTrQEQdHF7qLseVuMQBbShGMjYwBgHqn759AV84ov6bMJb6UL7uxecxCaI0fUGqJnIABgNPCThX0bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779119; c=relaxed/simple;
	bh=V7GZhijj57ZhwFbSaeYG05c/mdTNnXhgdbJodLhaU68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMAQQpwqDmMwm09/OhHlqtkoPe7aqJ5Ay9wDu0vgEWlk7VC/zADqheBg6QbFzt8632apUMhIyqo3qY6ezp2PE97hmbTUiEpY0gYlH410njiwYiWRVHKR+y0pTS4wZyJi02wqJYHk7rDFlQEJQ2VOK8q1PGQpjvlxOeD+8yFdBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RCqBHEg6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RCqBHEg6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SL8a1i011425;
	Fri, 28 Feb 2025 21:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sf8yPTiUFqfYHdtRM
	oAs4utjvNFVe3y4KMYZwB0P1Qc=; b=RCqBHEg6qDScryVKLL9JFvCgruCzsqeTL
	Uktchkjxqi/JNYLgmiQhQcmMSz8yhbNS0hJfkewws7di5hICn/W5qGX6+seRISZq
	knbL40TMeyBIN6pmw1oaOmwNzdbnPfuBOlnq4m8OfHH0G+GJoqoI0IWmIJQvTjFA
	CA6VNiL7OSnQwTZBfKvL894weR3/mQwEkoV9dw+XaAM1NHVA2aN9QzO2/xfqGteh
	JUM6VX7bNVEXfLfKrfY5M5HIJuDrvm4ElGEAY0zATpjQvYrZV0y0MNnd0VJHCK/B
	XQyhYS7ObKKq8PfbUjJto3Q28LyusMFKPaBI6AWFtCisk2Vi5JKGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337anqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SKvwOi026965;
	Fri, 28 Feb 2025 21:45:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdm0qaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SLj5ID47251830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:45:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 511F558055;
	Fri, 28 Feb 2025 21:45:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB02A5803F;
	Fri, 28 Feb 2025 21:45:03 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.46.135])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 21:45:03 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 3/5] iommu/s390: support iova_to_phys for additional table regions
Date: Fri, 28 Feb 2025 16:44:54 -0500
Message-ID: <20250228214456.440641-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: FrqhCKmZTdpPC05HPiIXOPWRCzZ5Jnjy
X-Proofpoint-GUID: FrqhCKmZTdpPC05HPiIXOPWRCzZ5Jnjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=862
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280156

The origin_type of the dma_table is used to determine how many table
levels must be traversed for the translation.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  2 ++
 drivers/iommu/s390-iommu.c      | 52 ++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 42d7cc4262ca..8d8962e4fd58 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -55,6 +55,8 @@ enum zpci_ioat_dtype {
 #define ZPCI_PT_BITS			8
 #define ZPCI_ST_SHIFT			(ZPCI_PT_BITS + PAGE_SHIFT)
 #define ZPCI_RT_SHIFT			(ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
+#define ZPCI_RS_SHIFT			(ZPCI_RT_SHIFT + ZPCI_TABLE_BITS)
+#define ZPCI_RF_SHIFT			(ZPCI_RS_SHIFT + ZPCI_TABLE_BITS)
 
 #define ZPCI_RTE_FLAG_MASK		0x3fffUL
 #define ZPCI_RTE_ADDR_MASK		(~ZPCI_RTE_FLAG_MASK)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f2cda0ce0fe9..0a6aad11c327 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -36,6 +36,16 @@ struct s390_domain {
 
 static struct iommu_domain blocking_domain;
 
+static inline unsigned int calc_rfx(dma_addr_t ptr)
+{
+	return ((unsigned long)ptr >> ZPCI_RF_SHIFT) & ZPCI_INDEX_MASK;
+}
+
+static inline unsigned int calc_rsx(dma_addr_t ptr)
+{
+	return ((unsigned long)ptr >> ZPCI_RS_SHIFT) & ZPCI_INDEX_MASK;
+}
+
 static inline unsigned int calc_rtx(dma_addr_t ptr)
 {
 	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
@@ -759,6 +769,43 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
 	return rc;
 }
 
+static unsigned long *get_rto_from_iova(struct s390_domain *domain,
+					dma_addr_t iova)
+{
+	unsigned long *rfo, *rso, *rto;
+	unsigned long rfe, rse;
+	unsigned int rfx, rsx;
+
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		rfo = domain->dma_table;
+		goto itp_rf;
+	case ZPCI_TABLE_TYPE_RSX:
+		rso = domain->dma_table;
+		goto itp_rs;
+	case ZPCI_TABLE_TYPE_RTX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+
+itp_rf:
+	rfx = calc_rfx(iova);
+	rfe = READ_ONCE(rfo[rfx]);
+	if (!reg_entry_isvalid(rfe))
+		return NULL;
+	rso = get_rf_rso(rfe);
+
+itp_rs:
+	rsx = calc_rsx(iova);
+	rse = READ_ONCE(rso[rsx]);
+	if (!reg_entry_isvalid(rse))
+		return NULL;
+	rto = get_rs_rto(rse);
+
+	return rto;
+}
+
 static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -772,10 +819,13 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 	    iova > domain->geometry.aperture_end)
 		return 0;
 
+	rto = get_rto_from_iova(s390_domain, iova);
+	if (!rto)
+		return 0;
+
 	rtx = calc_rtx(iova);
 	sx = calc_sx(iova);
 	px = calc_px(iova);
-	rto = s390_domain->dma_table;
 
 	rte = READ_ONCE(rto[rtx]);
 	if (reg_entry_isvalid(rte)) {
-- 
2.48.1

