Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421793;
	b=j7CohmxOPwUcN2NeIbduO5fpDa35zV/qVj/i1CbHi/D+hVoBL5trtUjwlEQ2dEDeX5Gh
	 PauZDRN588r4Ti3a0LVZ0y8W/TN9XpccHEPhLxzru7Brut1BAxAF+dCQBnmtFlunjs87O
	 YozYienuCmnNxLKBGFfaxz2cPVKVYA4t30HZVdSrbstsRBESVcebAlpP9rnEuygeWFDyI
	 vAuNtkIo5ISCboIappoOnFlcvS57iQJmH/qSruv9AU8bmSaWdbGaCPtgWFt++5u65eQqi
	 1Zy56zQV6fZL+nK6hT8+4OoPPRr45prEJMRTyVUkuA/NJZMzxTBwcrVeWxhpTUGFqnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421793;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=whkXE159NFXuCDBKrTzassqGWizFoNtcnowXj59EeQA=;
	b=XHaiqrVtGY9PiEZUalNa7Rc6AStVha10rOAOjQpEOJr59rfGdVoW7PA62OFqNNg9F0fB
	 FJeeGNqt4gpIK9FWuT6HQKqviFJwfZf5+gWtyQ9eueLjlyLZJdrledHY08sdEEL/aVa8+
	 gHPZEigTnje/N7DbpQXuMgsNkVdujzbI0Z8O0KTN96tbZxu43cEEUbwZXmSbOPCuhycPt
	 4UaYV330z/WS8GalHt65sZ7sIR/VmCnb8mjxvklceIPZBbl0pWPF7A7rclnu9NqujT0LX
	 cmXF5ig0FKxtPmgEPdMvKh9qoQA1zl/wYWBPd8VhbW2kX3GJeNevC/AWZEkB5lTQ3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YxqstEst;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B3606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F8B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YxqstEst
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIEG3c1766955
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=whkXE159NFXuCDBKrTzassqGWizFoNtcnowXj59Ee
	QA=; b=YxqstEstSM9u7IIZtp5k9D4/T7/cOAMG7/2psh0vO3duWDRWamsVU0c1Y
	8cTG0Dp01EU2zBg00PsKSPnJGPqaOmL5vwYE0eS2Rl/UMz+TdQfJur2gccYvFsqM
	+ke/UX033TC57i8TnT8FpwLUsDgHiU4i8sn1FrYWNI5GJiNx3TNyTKAb3Yl4iQ3Z
	uaozy0fX572FCJh3Pxa7Y3ercFqFt10hr17QnPL+qR97FbP294zOqgz/BA/MUUXr
	pnFzZ5EnHOsrYQ8Zt3Yr6xH2TRFOAsk6lrtNflYOw/dHi3+Nz7IquGWPeeddWpp/
	QiO9R/9jpmXA5opNVTKcwkFWKyFmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkun5v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:29:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABI4uOw3693696
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:29:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309nnsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:29:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABITkMp39780730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 18:29:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB48920040;
	Wed, 11 Nov 2026 18:29:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF2002004D;
	Wed, 11 Nov 2026 18:29:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 18:29:46 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] s390/mm: Allow hugepage migration for s390
Date: Wed, 11 Nov 2026 19:29:44 +0100
Message-ID: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4b41f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dqShpuBjQzf0R5tXLcIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX2QEs4aLZfMhP
 2V2H1+Ke/DLLwVEHVUi3lc7oPUzifszE2FqsKsIUmQTMZuhb3lLAHRquirUqi+/29iFawHMy9JH
 L4wCYLAdyKtTDfUZ+LGqlCOhV7HWiykY6PaMAuU8VGZdI/hvnKs1GwQUzEjXGl6uUxnFdBXfaLN
 9DEiBmE7nfoidTWPDaiL+yRCHSulFAXw/IqRRk34ddIZXALjLZ7+wuzmMLQrZhHTzKknLehkozz
 edWGLeI4/6WbqeP79uEINTc7W4xI8m8EIQROnZWwG9oLGOD/BF46n+H7SMAXXPJP4HH5C84iCcj
 vXc8DnGiRdc3gfMCaX9VFQT1OOzjNphMi9gxEhTuCR5yL0fObd6PzmHnXoqNV66p0MKIp/tTlGp
 8YzW0ppaK4tXLlX/Plawmewduocit74LfAjrqAlpE6+Hs1UnWmABSDrVbGBrzOHQnr8MJOmRQMy
 tyOGdO8AdNwQUWxOcjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX7P5X+BfGnuh/
 CXlHK6ShhRyrlY7ulHgS0VElUhFi1ahV4onIVljrTk+aQjRcHGdbrGJwkVpBtRQavO65BRpS2TH
 y47TAmL5ks2djec89eBB91s6kuf6coY=
X-Proofpoint-ORIG-GUID: c1-Qo5Ufn5fZHsZAFsybsxxYneB1mbcP
X-Proofpoint-GUID: c1-Qo5Ufn5fZHsZAFsybsxxYneB1mbcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110072

After hugetlbfs PTE_MARKER support for s390 introduced region-third
and segment table swap entries, it is possible to also allow hugepage
migration for s390.

This fixes the problem that hugetlbfs pages could not be allocated
from ZONE_MOVABLE memory, which is often used in combination with
memory hotplug. Therefore, without support for hugepage migration,
a large portion of system memory could be unavailable for hugetlbfs
page allocations.

Besides selecting ARCH_ENABLE_HUGEPAGE_MIGRATION, this only requires
definition of arch_hugetlb_migration_supported(), which can make use
of the existing arch_hugetlb_valid_size() function, similar to other
architectures.

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/hugetlb.h |  5 +++++
 arch/s390/mm/hugetlbpage.c      | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

---
Changes in v2:
- Use "#if IS_ENABLED()" instead of "#ifdef" in
  arch/s390/mm/hugetlbpage.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 612885228824..e3a704f423f3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,6 +83,7 @@ config S390
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_PMD_SOFTLEAVES if TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index aea754b67c89..356a18a75d99 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -17,6 +17,11 @@
 
 #define hugepages_supported()	cpu_has_edat1()
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+bool arch_hugetlb_migration_supported(struct hstate *h);
+#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+#endif
+
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned long sz);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index f84aa9265430..2c6e94888bd0 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *) pmdp;
 }
 
-bool __init arch_hugetlb_valid_size(unsigned long size)
+static bool __hugetlb_valid_size(unsigned long size)
 {
 	if (cpu_has_edat1() && size == PMD_SIZE)
 		return true;
@@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
 
 	return 0;
 }
+
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	return __hugetlb_valid_size(size);
+}
+
+#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	return __hugetlb_valid_size(huge_page_size(h));
+}
+#endif
-- 
2.53.0

