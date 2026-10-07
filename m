Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E14349A0;
	Wed,  7 Oct 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373364; cv=none; b=XmBBBcdOrr3HiY6kwCZTxTbitqUv6kpFfJzyerixQw7YWfiGw9UvOagQBm1kcBJuvZ7wJOuQwd7wxYO29MuQ2PiipZT8o5cD76p6OLhFVcUZGzdGGN/el09QRbe+SKSmgZ6+W0MxhK7fXgljwfCUB50zcmTKjoAraetppmHBnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373364; c=relaxed/simple;
	bh=AZioKnL3C/H0n3PsN8cvHGtgg67A/MakyL4+lU/Vblk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP4YALk98j/biU1P+7yRIKX4uCYF+/Eg5bDdU1XsI6yWVpQI9c6XXtabFuVTJBLx8zwmYck8tvUr3ssJCvhQiCJUwGzOLBdgYsBpRfP1sn99MBVUVwDe1U5PmwpYoHttOi8hRBMuiww2Gsrv+7M58YdwICESqBwN+zhlF3EG8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j6DTbbDY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j6DTbbDY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BaBJA597602;
	Wed, 7 Oct 2026 11:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I8VPEZS8Gbj1n0xd6
	hdZbSRznW/0HD/bcZqxSwMDDN4=; b=j6DTbbDYLe61BbViYVwh8a7dAUXO2WXUv
	0xjQFpMrumlFWoKAv1vwD8BAavi6edZWXt/gO6RTboNy9GKTGcteXXHbF2UzKbeX
	+AwMmb6Hrp8zuJV25qBrV5npki9NO+3YyjEmhltFlmEEYeSYbRTOGxDgzvoXnXXD
	ZUMoS5bVc187RlPggDKjrfexIblhh1/B8xq7u1QNt2wBOCdSxR12oxjGHbjGqsY/
	ZypWs1RKaIIHNRQGESMi4/2sXjPJSUgEyMv8KgOTAlKC10Q4wi36QFMFdzI3dKVA
	CzL7E0hf9Y7DVPfMe2BZZMie2hMjcmGSAwBbmSHtlOiiNJCv9UvAA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn5kt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWiEY1789962;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5jmhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfxbn30343856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795482004E;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 220FE2005A;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 9283C160B2E; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 12/15] mm: Make lazy MMU mode context-aware
Date: Wed,  7 Oct 2026 13:41:55 +0200
Message-ID: <c82c8f523790d431c5eb46f8fda49609458d05dd.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+l/wPkjB3gIW
 ohWHtFMFCgZWjP8FuLjXBeJ8FOh5u8FyORei1N26b04LOxYMMtN063eBfXW9mU1VV4YYaL8ez2B
 Gj08nhzUSw/Pej4Hx44Uff3ppj6JG5c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+jRPTUyg9fwL
 S8BP3dS9+sf0larAZiDJQWKZUQ1vODtrlc5JXYGNi/6XLdDkI+tmlX2AmTsT3QNwh8/7llKzeFx
 hVOgYbrDnHSfke0KGxGH7dKB+XIjc+IKbS61gpBfS2TdEroUsSa5PuhXgkGnEOxv+OgT6yKut6B
 0rRAtY6ss+JZ374R64D33A5P9RppcIxpWEtG7sSlWatfZFptJ3yo5Rm2U1Lki7MevlK/PR/uvMt
 8nvL+a1QL3kzU0URU70F1mfoYTDKtu+EpC4pOJTTSADfpMaPjTDw2XMSC9i05sxzQJFbYKU8TF3
 PrCrsXGe18yKHQOxN4GVOBVDJ4dgUnNkgm6j5aXB9HDllho8FBp7sRrOFWTIEOyiQYZS84j7QhI
 b/i+2Fhmu18ZjCP+xSROdwgYQy18DovRVmJA/1WkggDZc00BaBmGqvPxsZWSmDj8b/vxrrSSROP
 JqAY+3Iesb0P4kLl7Iw==
X-Proofpoint-GUID: CU20SDHePfJsawMGZjUhkg1AcFMwDHLp
X-Proofpoint-ORIG-GUID: BDwgPoLQv2ssjy7sBLT0DXf_aAapUuIJ
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Yo8-fGXS6AlSV94Q614A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

Lazy MMU mode is assumed to be context-independent, in the sense
that it does not need any additional information while operating.
However, the s390 architecture benefits from knowing the exact
page table entries being modified.

Introduce lazy_mmu_mode_enable_with_ptes(), which is provided with
the process address space and the page table being operated on.
This information is required to enable s390-specific optimizations.

The function takes parameters that are typically passed to page-
table level walkers, which implies that the span of PTE entries
never crosses a page table boundary.

Architectures that do not require such information simply do not
need to define the lazy_mmu_mode_enable_with_ptes() callback.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 fs/proc/task_mmu.c      |  2 +-
 include/linux/pgtable.h | 46 +++++++++++++++++++++++++++++++++++++++++
 mm/madvise.c            |  8 +++----
 mm/memory.c             |  8 +++----
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 mm/vmalloc.c            |  6 +++---
 7 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2b5af72bbe45..3ae43f4e78b2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2884,7 +2884,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
 		return 0;
 	}
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(vma->vm_mm, start, end, start_pte);
=20
 	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
 		/* Fast path for performing exclusive WP */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1768421755a9..1e6240269d4f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -272,6 +272,50 @@ static inline void lazy_mmu_mode_enable(void)
 		arch_enter_lazy_mmu_mode();
 }
=20
+#ifndef arch_enter_lazy_mmu_mode_with_ptes
+static inline void arch_enter_lazy_mmu_mode_with_ptes(struct mm_struct *=
mm,
+		unsigned long addr, unsigned long end, hw_pte_t *ptep)
+{
+	arch_enter_lazy_mmu_mode();
+}
+#endif
+
+/**
+ * lazy_mmu_mode_enable_with_ptes() - Enable the lazy MMU mode with a sp=
eedup hint.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Start address of the range.
+ * @end: End address of the range.
+ * @ptep: Page table pointer for the first entry.
+ *
+ * Enters a new lazy MMU mode section; if the mode was not already enabl=
ed,
+ * enables it and calls arch_enter_lazy_mmu_mode_with_ptes().
+ *
+ * PTEs that fall within the specified range might observe update speedu=
ps.
+ * The PTEs must belong to the specified address space and be in the sam=
e PMD.
+ *
+ * There are no requirements on the order or range completeness of PTE
+ * updates for the specified range.
+ *
+ * Must be paired with a call to lazy_mmu_mode_disable().
+ *
+ * Has no effect if called:
+ * - While paused - see lazy_mmu_mode_pause()
+ * - In interrupt context
+ */
+static inline void lazy_mmu_mode_enable_with_ptes(struct mm_struct *mm,
+		unsigned long addr, unsigned long end, hw_pte_t *ptep)
+{
+	struct lazy_mmu_state *state =3D &current->lazy_mmu_state;
+
+	if (in_interrupt() || state->pause_count > 0)
+		return;
+
+	VM_WARN_ON_ONCE(state->enable_count =3D=3D U8_MAX);
+
+	if (state->enable_count++ =3D=3D 0)
+		arch_enter_lazy_mmu_mode_with_ptes(mm, addr, end, ptep);
+}
+
 /**
  * lazy_mmu_mode_disable() - Disable the lazy MMU mode.
  *
@@ -388,6 +432,8 @@ static inline void lazy_mmu_mode_resume(void)
 }
 #else
 static inline void lazy_mmu_mode_enable(void) {}
+static inline void lazy_mmu_mode_enable_with_ptes(struct mm_struct *mm,
+		unsigned long addr, unsigned long end, hw_pte_t *ptep) {}
 static inline void lazy_mmu_mode_disable(void) {}
 static inline void lazy_mmu_mode_pause(void) {}
 static inline void lazy_mmu_mode_resume(void) {}
diff --git a/mm/madvise.c b/mm/madvise.c
index 40ce0d5940ef..12830d445499 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -462,7 +462,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
 	if (!start_pte)
 		return 0;
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, addr, end, start_pte);
 	for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
 		nr =3D 1;
 		ptent =3D ptep_get(pte);
@@ -517,7 +517,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
 				if (!start_pte)
 					break;
 				flush_tlb_batched_pending(mm);
-				lazy_mmu_mode_enable();
+				lazy_mmu_mode_enable_with_ptes(mm, addr, end, start_pte);
 				if (!err)
 					nr =3D 0;
 				continue;
@@ -685,7 +685,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
 	if (!start_pte)
 		return 0;
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, addr, end, start_pte);
 	for (; addr !=3D end; pte +=3D nr, addr +=3D PAGE_SIZE * nr) {
 		nr =3D 1;
 		ptent =3D ptep_get(pte);
@@ -745,7 +745,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
 				if (!start_pte)
 					break;
 				flush_tlb_batched_pending(mm);
-				lazy_mmu_mode_enable();
+				lazy_mmu_mode_enable_with_ptes(mm, addr, end, start_pte);
 				if (!err)
 					nr =3D 0;
 				continue;
diff --git a/mm/memory.c b/mm/memory.c
index 48d6ca89b0fe..69a81e867083 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1354,7 +1354,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, stru=
ct vm_area_struct *src_vma,
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 	orig_src_pte =3D src_pte;
 	orig_dst_pte =3D dst_pte;
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(src_mm, addr, end, src_pte);
=20
 	do {
 		nr =3D 1;
@@ -2053,7 +2053,7 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
 		return addr;
=20
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, addr, end, start_pte);
 	do {
 		bool any_skipped =3D false;
=20
@@ -3051,7 +3051,7 @@ static int remap_pte_range(struct mm_struct *mm, pm=
d_t *pmd,
 	mapped_pte =3D pte =3D pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, addr, end, mapped_pte);
 	do {
 		BUG_ON(!pte_none(ptep_get(pte)));
 		if (!pfn_modify_allowed(pfn, prot)) {
@@ -3463,7 +3463,7 @@ static int apply_to_pte_range(struct mm_struct *mm,=
 pmd_t *pmd,
 			return -EINVAL;
 	}
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, addr, end, mapped_pte);
=20
 	if (fn) {
 		do {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1d23475e0bb7..6bb112ba1b91 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -351,7 +351,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 		is_private_single_threaded =3D vma_is_single_threaded_private(vma);
=20
 	flush_tlb_batched_pending(vma->vm_mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(vma->vm_mm, addr, end, pte);
 	do {
 		nr_ptes =3D 1;
 		oldpte =3D ptep_get(pte);
diff --git a/mm/mremap.c b/mm/mremap.c
index 5272cea12f80..6a19393759de 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -260,7 +260,7 @@ static int move_ptes(struct pagetable_move_control *p=
mc,
 	if (new_ptl !=3D old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 	flush_tlb_batched_pending(vma->vm_mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(mm, old_addr, old_end, old_ptep);
=20
 	for (; old_addr < old_end; old_ptep +=3D nr_ptes, old_addr +=3D nr_ptes=
 * PAGE_SIZE,
 		new_ptep +=3D nr_ptes, new_addr +=3D nr_ptes * PAGE_SIZE) {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f97f99c340e..978029669cf4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -110,7 +110,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long a=
ddr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(&init_mm, addr, end, pte);
=20
 	do {
 		if (unlikely(!pte_none(ptep_get(pte)))) {
@@ -394,7 +394,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
 	unsigned long size =3D PAGE_SIZE;
=20
 	pte =3D pte_offset_kernel(pmd, addr);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(&init_mm, addr, end, pte);
=20
 	do {
 #ifdef CONFIG_HUGETLB_PAGE
@@ -561,7 +561,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned =
long addr,
 	if (!pte)
 		return -ENOMEM;
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_with_ptes(&init_mm, addr, end, pte);
=20
 	do {
 		struct page *page =3D pages[*nr];
--=20
2.53.0

