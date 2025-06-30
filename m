Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AF8460;
	Mon, 30 Jun 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302076; cv=none; b=g8aPd1d0O1IY1hq4UwTBTRXGJr5EhrSfD+SL4nEHG5O+bNAXPN9Mw3IF5YyIZgLXKAGpCC8tireVmpSht7JNCr+WgDueOovcqBztXvh2BHu5eFc767pzciA0EZvnGl7vUyeWMZtPeKkEnnLOZhem8ywZY14+dGcG6+FY2UQK4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302076; c=relaxed/simple;
	bh=rsfOEOJugX34XA+jCFmt6YE10O4CFvj6rkIm5zunCpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JacmMgIgZQisktcrzl3yUDzUOVURPHzH03rLPaCKix8M1Z0gt2ikdzHAGsLIZRT5aR2aQzMTcDDglUXdHiBi7DxQxPzVwBo30f7Qrh9d6gn12QgihDvp4zI/9trvRhXPIqGmB+Zd+Qedf67U+yPob8Ze5JeJxJi1Gq9CsVRetPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FIyFedhA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FIyFedhA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UBD7Hb023854;
	Mon, 30 Jun 2025 16:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AufIWocE5AuvJtPV1wlgowl9nYF3OzzI2gj6BnaMb
	ts=; b=FIyFedhA/dGopM8gjgfb77ELLHTz2d+5DUgWSOfJIb3tEQIaAuXjH9w0r
	wQIJBZgDc1JjfTOo6mDTLaJzfVoLPWnVIDg0HdM2PrBPvEmRyC7Kx/WqX70GJuCD
	48dc1bHa8cihoN3DcaCKSFm5Wru+yGC78IDA7G4F9SmUYz+NGqDN3nOumoTXN2eq
	EJ5PDw3FuZYOT3/z6v1WCQEA4YHZxEVpM6EEbbDyuCGRwhybT7RHC+49nY4Buog+
	3iTLlEMNoMryGaZiJVYBL04Uz8sBZvqJxF0/SMG67Ir0tJ0I6xjK4A8ScUZPyJI2
	lIJ53RHhxYlAqz2M2Q7vpCs91/0xw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1jmpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 16:47:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE6N6f021945;
	Mon, 30 Jun 2025 16:47:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpepwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 16:47:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UGlYeJ51053014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:47:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8009420040;
	Mon, 30 Jun 2025 16:47:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BFA2004B;
	Mon, 30 Jun 2025 16:47:34 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 16:47:34 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: [PATCH] mm/debug_vm_pgtable: Use a swp_entry_t input value for swap tests
Date: Mon, 30 Jun 2025 18:47:25 +0200
Message-ID: <20250630164726.930405-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ry2V18RJOMmtSxE0l4oahA2WZlmSjeeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzOCBTYWx0ZWRfX0kvpwDntTdUg 0+0ZeQMZlFBp3uT7tL5Qx9+tPHwjJD05c1iCfNbFF1YIeLEepNS3COO91oyyuYKsX/SvbOElP4r LycnGSTdSapD/Rw+KRYXz/Ye04S2eiggr+xuQlABM8sin22fUiRUajjlZGmfbmWAZlYWzdwg3h8
 y3Hz6sCImfOlz66E/6nabSYgEp2Dg5amWOcDogZiQi/IeGJzq8jX8AIZ0GZ2OyAfgYJejMB9tG2 KF/hBedYQWBH3ChJe9Yvs9qEGXxDEVt9IT1GwjP4eQj/eMgWEMby3nD5BYFCizEQcQRJ+KA4cW8 S5ysEgCknJnY39XQzMJf4j2fi3V6Wg2TlvWPPk7aX3cThwrlLSm4e2+d6dREUi38Y2TCcN0OK3+
 YAYen7p/bTPTyFPV7ovOFQphAbGzESj9/lt9bn65yKLGLPrJUudKDzZNwJ1CFYWXJOP3A2lv
X-Proofpoint-GUID: ry2V18RJOMmtSxE0l4oahA2WZlmSjeeJ
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6862bfa9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ZTx8QE4AkKJnx8U2w1UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300138

The various __pte/pmd_to_swp_entry and __swp_entry_to_pte/pmd helper
functions are expected to operate on swap PTE/PMD entries, not on
present and mapped entries.

Reflect this in the swap tests by using a swp_entry_t as input value,
and convert it to a swap PTE/PMD for testing, similar to how it is already
done in pte_swap_exclusive_tests(). Move the swap entry creation from
there to init_args() and store it in args, so it can also be used in other
functions.

The pte/pmd_swap_tests() are also changed to compare entries instead of
pfn values, again similar to pte_swap_exclusive_tests(). pte/pmd_pfn()
helpers are also not expected to operate on swap PTE/PMD entries at all.

Also update documentation, to reflect that the helpers operate on swap
PTE/PMD entries and not present and mapped entries, and use correct names,
i.e. __swp_to_pte/pmd_entry -> __swp_entry_to_pte/pmd.

For consistency, also change pte/pmd_swap_soft_dirty_tests() to use
args->swp_entry instead of a present and mapped PTE/PMD.

Link: https://lore.kernel.org/all/20250623184321.927418-1-gerald.schaefer@linux.ibm.com
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 Documentation/mm/arch_pgtable_helpers.rst |  8 ++--
 mm/debug_vm_pgtable.c                     | 53 ++++++++++++++---------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index c88c7fa665d6..ba2f658bc241 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -236,13 +236,13 @@ SWAP Page Table Helpers
 ========================
 
 +---------------------------+--------------------------------------------------+
-| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapped PTE |
+| __pte_to_swp_entry        | Creates a swp_entry_t (arch) from a swap PTE     |
 +---------------------------+--------------------------------------------------+
-| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
+| __swp_entry_to_pte        | Creates a swap PTE from a swp_entry_t (arch)     |
 +---------------------------+--------------------------------------------------+
-| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapped PMD |
+| __pmd_to_swp_entry        | Creates a swp_entry_t (arch) from a swap PMD     |
 +---------------------------+--------------------------------------------------+
-| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
+| __swp_entry_to_pmd        | Creates a swap PMD from a swp_entry_t (arch)     |
 +---------------------------+--------------------------------------------------+
 | is_migration_entry        | Tests a migration (read or write) swapped entry  |
 +-------------------------------+----------------------------------------------+
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bd8f9317b025..d19031f275a3 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -72,6 +72,8 @@ struct pgtable_debug_args {
 	unsigned long		fixed_pud_pfn;
 	unsigned long		fixed_pmd_pfn;
 	unsigned long		fixed_pte_pfn;
+
+	swp_entry_t		swp_entry;
 };
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
@@ -698,12 +700,15 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 
 static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
+	pte_t pte;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
 	pr_debug("Validating PTE swap soft dirty\n");
+	pte = swp_entry_to_pte(args->swp_entry);
+	WARN_ON(!is_swap_pte(pte));
+
 	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
 	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
 }
@@ -737,7 +742,9 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
+	pmd = swp_entry_to_pmd(args->swp_entry);
+	WARN_ON(!is_swap_pmd(pmd));
+
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
@@ -748,17 +755,11 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 {
-	unsigned long max_swap_offset;
 	swp_entry_t entry, entry2;
 	pte_t pte;
 
 	pr_debug("Validating PTE swap exclusive\n");
-
-	/* See generic_max_swapfile_size(): probe the maximum offset */
-	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
-
-	/* Create a swp entry with all possible bits set */
-	entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
+	entry = args->swp_entry;
 
 	pte = swp_entry_to_pte(entry);
 	WARN_ON(pte_swp_exclusive(pte));
@@ -782,30 +783,34 @@ static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 
 static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
-	swp_entry_t swp;
-	pte_t pte;
+	swp_entry_t arch_entry;
+	pte_t pte1, pte2;
 
 	pr_debug("Validating PTE swap\n");
-	pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
-	swp = __pte_to_swp_entry(pte);
-	pte = __swp_entry_to_pte(swp);
-	WARN_ON(args->fixed_pte_pfn != pte_pfn(pte));
+	pte1 = swp_entry_to_pte(args->swp_entry);
+	WARN_ON(!is_swap_pte(pte1));
+
+	arch_entry = __pte_to_swp_entry(pte1);
+	pte2 = __swp_entry_to_pte(arch_entry);
+	WARN_ON(memcmp(&pte1, &pte2, sizeof(pte1)));
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 {
-	swp_entry_t swp;
-	pmd_t pmd;
+	swp_entry_t arch_entry;
+	pmd_t pmd1, pmd2;
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
-	swp = __pmd_to_swp_entry(pmd);
-	pmd = __swp_entry_to_pmd(swp);
-	WARN_ON(args->fixed_pmd_pfn != pmd_pfn(pmd));
+	pmd1 = swp_entry_to_pmd(args->swp_entry);
+	WARN_ON(!is_swap_pmd(pmd1));
+
+	arch_entry = __pmd_to_swp_entry(pmd1);
+	pmd2 = __swp_entry_to_pmd(arch_entry);
+	WARN_ON(memcmp(&pmd1, &pmd2, sizeof(pmd1)));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
@@ -1110,6 +1115,7 @@ static void __init init_fixed_pfns(struct pgtable_debug_args *args)
 
 static int __init init_args(struct pgtable_debug_args *args)
 {
+	unsigned long max_swap_offset;
 	struct page *page = NULL;
 	int ret = 0;
 
@@ -1192,6 +1198,11 @@ static int __init init_args(struct pgtable_debug_args *args)
 
 	init_fixed_pfns(args);
 
+	/* See generic_max_swapfile_size(): probe the maximum offset */
+	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
+	/* Create a swp entry with all possible bits set */
+	args->swp_entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
+
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
 	 * the data in the pages. The corresponding tests will be skipped
-- 
2.48.1

