Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9321ADC6;
	Mon, 31 Mar 2025 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452541; cv=none; b=NY7fq+Vo6cOr4hOMicRASaNF5VDfUVUm0lt6uFMhXQcMfgi/0WxMjXNAhBdT+kxUjnmYkBcASUV5ZnyLhxzPICyu/XbRVA10RNEZ5BzoBffv5B3B4tr/jZ5bTXwAF+cZems20RQdGO6+B/ZJPuqy7BrHMg/H+1ddLdHzdUXoDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452541; c=relaxed/simple;
	bh=ZZnyG3zya5Po2F1xc2XCG4pomT8ljt2l/zbVN/JYOUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2ujNKHEP02ANnvV7K5v2npG/8okX72wytzQxs2svwOMTNKICuE9KlHHJqKI+1xTzo6wNGQZjvfF0jlYxq7DMcAfyiPN7XeGSehQm7tARjUTuJjY5/2eW3E4OIrEUt6kMNUU5KEq0QV0gHM7ToYol2fmdxiOqoKT4KGJyFQ/0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVaiXGjE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVaiXGjE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VKKuR4027589;
	Mon, 31 Mar 2025 20:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BW2kWj1vzqNrV9mFj
	OjgpQ3BIDfQoxjiOkdFVgVgRuw=; b=LVaiXGjEtQgmojrCFKsjwezFahI12JO2e
	IW3YcJv49d0yPMtr80CKNuUQ0rxOoVEkVQDnA9DU55yf0jBhPFwAKF7VmCu1ZTgH
	oG8mBN5oVDeATCLJyN0x4dCrzjoEsHCXZAjxlvQB9Zuqj6ZxvrA9qgbjUMFm/eWo
	KtEXVWU9hyrwqGjdsgr4SREXeoGuB/+XMrSNT6OugtcQFLQKTGQuMj2MJShuEfOe
	l3canWrn4+AkOxZ+l7QCQWAevm//mpP3xkG4bvwNUuECNk2uQHFjApDTnDP0BgBc
	TO4T0Kt3U5WlqK5EBk8Hk1o/qduPRmvpz3F8Pzn6JQ5ix31/cyjVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qu32a8tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VJMdlN006601;
	Mon, 31 Mar 2025 20:22:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pwdk76mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM6MI21103160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF9158043;
	Mon, 31 Mar 2025 20:22:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1854158053;
	Mon, 31 Mar 2025 20:22:05 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:22:04 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 3/5] iommu/s390: support iova_to_phys for additional table regions
Date: Mon, 31 Mar 2025 16:21:57 -0400
Message-ID: <20250331202159.85956-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: DsfY1ruidDBzOzPsS0zJBNv7l4QhQG3h
X-Proofpoint-ORIG-GUID: DsfY1ruidDBzOzPsS0zJBNv7l4QhQG3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=853 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310138

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

