Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C441A0734;
	Mon,  9 Dec 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772369; cv=none; b=IES7fuOK2gCJhvEiep733J1fXNzUjCf5Rg7bRaoJG3rlq2p2wYsnfA0oMyR592BevgK8wCTow6KY4DBr90v7nyO3qXsTF2NQKla56xal+uEGYUnWZocomQzzZljG+HID0TBJ4rq+0a8vI5708rmiuA8dUF5J9NjUjdTgR6ATbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772369; c=relaxed/simple;
	bh=rbhZbY3Dd+rBvt4S/xtnNlWvk1H17uwGeAcBkneHPPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8sd8BoF2sLNtP7sr9gIcQwEFhAUPtxY/2lTdPmANuLE6tmSXljzIcaQFX5Z58ZMjPtdonyOh6sOsX1rI0XEsVw6jkL2gns+GmdSlhwG1b5WTjI554Fn5hFag7PE8MEFrIhdsNzoga0wSKqfw5sU3sOoluID6cMiZk1XYIE5L/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEYBo5km; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEYBo5km"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AAF5g019995;
	Mon, 9 Dec 2024 19:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0JLfkf9VdKGccRSC0
	m8J4tuXh7p7tr7AFE7LLyjKoNI=; b=aEYBo5kmI1cnyAupxck+nvqNGJGONRkeN
	v6xMK3OlCi91/LJqCU7q+ZApUJjq6gFyyrY4eDJTGVY7CaWkBUw+EiLD58IJwzeI
	bdF5l8ATMX6/jqF4hZ92l4u6tomDJOrBKIgTDwlE8Fj41dlB2kZJ2rhe4aPDSx+8
	4K91PSd1qW3dc2yjB22mJambEC/b02U9UDrYfyjGWxNSL/v+OurITgHZG26TDAdK
	0BpyUE5Q4Yp8vJHahKu+uPD+UsVizelBCZEgHhWWP5RjJI8acjFpF70Ux/WiGW6s
	/IwtvVPa4wpbsNhhXfNvLLls9OskWxLCZJ55Pq7uwjsl67MKB16cw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38k5tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IWKb2032575;
	Mon, 9 Dec 2024 19:25:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn02k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPtCm11469370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24CA58055;
	Mon,  9 Dec 2024 19:25:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D163558043;
	Mon,  9 Dec 2024 19:25:53 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:53 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/7] iommu/s390: add basic routines for region 1st and 2nd tables
Date: Mon,  9 Dec 2024 14:25:45 -0500
Message-ID: <20241209192549.107226-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: 4su4skLim7CwGtxiLS4zlBSghCNm6QLq
X-Proofpoint-ORIG-GUID: 4su4skLim7CwGtxiLS4zlBSghCNm6QLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

Add common routines for region first and region second tables, similar
to what already exists for region third tables.  Routines added are
for determining an index value based on address, getting and setting
origin flags, and validating entries.
These routines are not yet used, but will be in subsequent commits.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  2 ++
 drivers/iommu/s390-iommu.c      | 56 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index f6c27b6ab4c6..fcebc7415fb3 100644
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
@@ -57,6 +67,20 @@ static inline void set_pt_pfaa(unsigned long *entry, phys_addr_t pfaa)
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
@@ -71,6 +95,22 @@ static inline void set_st_pto(unsigned long *entry, phys_addr_t pto)
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
@@ -121,6 +161,22 @@ static inline int pt_entry_isvalid(unsigned long entry)
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
-- 
2.47.0

