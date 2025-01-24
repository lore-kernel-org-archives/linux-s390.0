Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A877225778;
	Fri, 24 Jan 2025 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749928; cv=none; b=IF8pYWGEagRAhh8c3db7ISUS//7+kiJckyXKrVueGs0vkXPmhqBsfZD81Z7mY0w2zXIYjQMrcaP41AGs0FUWiDFEbN2lqctlr7JRSabFjnRyyMCr7sGT6EFye3eQVc85g9k/BN4NBXHv318P0DPQiujhh+2tNVnJUFA6Nd9dacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749928; c=relaxed/simple;
	bh=Ia48zIiJnFbf+IdDzq851ZzRZTHJYFmhXiFMQUuTcAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GncHP22oZZ1IWmvI7OdjjD34yI/3pFHj4CwaA5G4uCgAvZ55zxiHTWRKRlXvJDEhjiQlHnv00vQEAJNeu3M/pnWsNoqjMcr2I3IGB1QzJ5zbtlVA+K3lKXKvrGaprRdkg2ggIsz2o/dD5oJ6iOLfz4EPtnjJmIL+HdgqMmwxYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RcgrKNFF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RcgrKNFF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIJhvI019083;
	Fri, 24 Jan 2025 20:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VMimhGbcbFXWBupAK
	SoNabpNX9uj544kn/Kj5Rx/cnQ=; b=RcgrKNFFanzSvJ9pI/0GzaRSCmYsjsyB6
	+uC5avIuwCKCrTsj5mYex0iK4VLcuDeHDioPlJ96JB3+JXL6fYYGz0nsRops7oo/
	6DDqTIFP7Bjx3YEdburHK7Q931HABcHhW2yil9InsCv1vXXn1iABMMhs9caGjsxN
	KqSd/OSUIpu6/p/D9+U0dFf0dyss/ZvQw0yZPmAJzI44L8edhz0GCJKXh8g73SN9
	RVYBdU8wbVlOuFo+OUgkWzR09XgK1Ks6De6oVvP0wiFaxRRgFSUUtfQdxGHX/3nN
	/Fwitp0fAp0x7Rwuw2MxDC/KBKIRGlhmWEJSqN0r4znD3QwVjjPyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x9606f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJ0FxY029595;
	Fri, 24 Jan 2025 20:18:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnwa6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKIXTx23527772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F54C5805A;
	Fri, 24 Jan 2025 20:18:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398F05805E;
	Fri, 24 Jan 2025 20:18:32 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:32 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 4/6] iommu/s390: support iova_to_phys for additional table regions
Date: Fri, 24 Jan 2025 15:18:24 -0500
Message-ID: <20250124201826.348848-5-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: zwKO13VZcV0F3zqWWr3ydc53vLg5sxB6
X-Proofpoint-ORIG-GUID: zwKO13VZcV0F3zqWWr3ydc53vLg5sxB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=868 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

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
index 73e0bb251bc1..88adc4efc53f 100644
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
@@ -704,6 +714,43 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
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
@@ -717,10 +764,13 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
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

