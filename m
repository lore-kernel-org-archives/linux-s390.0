Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6A27E1B0;
	Fri, 11 Apr 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403092; cv=none; b=VZusLKT/kIxAvmbe41c3R/S1zPjl9vmPrjInLbWAhx1kUlMliwzMhTiJO7clfsSUoP2hqbDQQYlV6teNwhfJ8Ls1XKE+IkD3QzpQ3KJrqT1ZxpELH/yuCNObUjC/XNFvHdZXD2Slm3FyHOSvFeh7wuhspapf0OD1Fq1olPzTqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403092; c=relaxed/simple;
	bh=ZZnyG3zya5Po2F1xc2XCG4pomT8ljt2l/zbVN/JYOUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV4aItGfPUDM6wAWYr9276s2l0QCoE6molGVPK8CY+Dqj9HxHJsXhdeHNvTQaasNjM3E5Ydj9DEnsEgF0PLCBpV2TT4o9mh7jZeBjwovges+eh2R7XGCqiapAI5fqy0EOUv7wipOYMaJFHAlsA9lL3IpBqpCZGihj+6C5O5ADAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4XBu6YQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4XBu6YQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII36X022894;
	Fri, 11 Apr 2025 20:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BW2kWj1vzqNrV9mFj
	OjgpQ3BIDfQoxjiOkdFVgVgRuw=; b=W4XBu6YQ4gVo/VlOJTg1BZGml514lKZ4r
	zecgCxfg9iugBEGy7xF/EjcY5StqZEDgvMdC8BLvek0D/XhQVTWJuMTcFpV/WXxM
	KAh8IJwymqMTDikO8dcwqzoNUpZNiYVBvyg7FZ2GdiXNVFp9oTR7/4yZ+gn87wcQ
	J4h2rEAh5Lm4E01pxO1667DBKMplAqFKchd3VGFxy3VixjEO1bU3oI8lBQFHISC2
	azQhRSCSFzke3VlikN8IDKe2zjD1x5Os66aJUlvibiOYyCo0Yqjz84LaWi7v6ZC2
	Ky5ZQ+AylYg9dqjwN+I0wYbp/OLpoA6sf/vIWr7kdYNBvBbH/CHVw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y78x0va3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIw4tO017825;
	Fri, 11 Apr 2025 20:24:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m4hed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOcaK64094584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318C35805E;
	Fri, 11 Apr 2025 20:24:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A59A5805C;
	Fri, 11 Apr 2025 20:24:37 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:37 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 3/5] iommu/s390: support iova_to_phys for additional table regions
Date: Fri, 11 Apr 2025 16:24:31 -0400
Message-ID: <20250411202433.181683-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: yS7iBEvGiNM2UF995yFmR50NIbNDUho2
X-Proofpoint-ORIG-GUID: yS7iBEvGiNM2UF995yFmR50NIbNDUho2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=862 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110127

The origin_type of the dma_table is used to determine how many table
levels must be traversed for the translation.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  2 ++
 drivers/iommu/s390-iommu.c      | 60 ++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

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
index f2cda0ce0fe9..338a7381e918 100644
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
@@ -759,6 +769,51 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
 	return rc;
 }
 
+static unsigned long *get_rso_from_iova(struct s390_domain *domain,
+					dma_addr_t iova)
+{
+	unsigned long *rfo;
+	unsigned long rfe;
+	unsigned int rfx;
+
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		rfo = domain->dma_table;
+		rfx = calc_rfx(iova);
+		rfe = READ_ONCE(rfo[rfx]);
+		if (!reg_entry_isvalid(rfe))
+			return NULL;
+		return get_rf_rso(rfe);
+	case ZPCI_TABLE_TYPE_RSX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+}
+
+static unsigned long *get_rto_from_iova(struct s390_domain *domain,
+					dma_addr_t iova)
+{
+	unsigned long *rso;
+	unsigned long rse;
+	unsigned int rsx;
+
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+	case ZPCI_TABLE_TYPE_RSX:
+		rso = get_rso_from_iova(domain, iova);
+		rsx = calc_rsx(iova);
+		rse = READ_ONCE(rso[rsx]);
+		if (!reg_entry_isvalid(rse))
+			return NULL;
+		return get_rs_rto(rse);
+	case ZPCI_TABLE_TYPE_RTX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+}
+
 static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -772,10 +827,13 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
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
2.49.0

