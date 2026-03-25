Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2D37BE83;
	Wed, 25 Mar 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424505; cv=none; b=IW4GksE2xJ5IlCDDn04UUyB3U0qBUB2SlcvlbHqURWG+ypvAT1+OIiawgKLlOLzFLT7PanRinTqoZXWO/Zb8iKwS2n3WvkyBTH/4rLXKRnbFIbCVbvdfZAEb5cSS+p45sFlN5kSKv1XPMwd9Nqhc3iAMgjk+PXmKKjuXRku5qzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424505; c=relaxed/simple;
	bh=fyb4Jy/HIo9Cl2MKh2+o5ompy0L/aNLFFZcRLrIQBkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD9VD4TVBHj5uuyKAEcsdGb7rzDFQE++yFMLjc+M860TZNc6FgfkmXvlQGGgnSY+RVO1rwwlq75DBaZTfQtdOXLMEcjIa7RPFuQO1prV5HNXX3xYZKnlPSiF9LXOE2qmGFnOtBItEI8Ycl4+KpBy6G4aGz+QHwG2CoczM3hBViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UNwO9MX+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UNwO9MX+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHK4nO408523;
	Wed, 25 Mar 2026 07:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TK1KUjBxZePRMesNH
	5fJMr1oNU1xWQahPqFoZL5uICg=; b=UNwO9MX+9qSdd6pDOz8NjyTVpefWVDz1m
	QBK4QYO7tW5axX4bPYqKuPr8qIiysgUNljV9WA2xyCG2mFhfpyW2Qep2/ILHgdqC
	YBkMHol/878swhWjJhwi+g9nEUlcYMr8dJhpovCoHP0qwPh5C2lb5KHOwNCmCEV6
	hYh2t642ae3K+uEN/ik6VLP7RaHNf3taK46MhEi2NMpgWR4yoAy8SxCjxZo2ZnHk
	58IbukyKGUPRNpNClGyF6i9wq2bhhPtu0uqgLqwoyaq24rts7CHLWUjQCJFy+xRK
	QkJ9d8t8REa9bpelAt0/EC55I17y/mj4lK/TEK54jIwtXw3Z/j1vQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqfcb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P6KGnN026685;
	Wed, 25 Mar 2026 07:41:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kwfv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P7fJUK48496970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 07:41:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B974020063;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8528D2004F;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 6A593E0729; Wed, 25 Mar 2026 08:41:19 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Date: Wed, 25 Mar 2026 08:41:18 +0100
Message-ID: <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774420056.git.agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UVQSml50OM5oEmPcf2wBR7RS9PgSKyOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1MCBTYWx0ZWRfX96JprihSJwQ4
 Q0yKisYiCsu78IYv7XTZr3ySae8gMiFGk/JaPP/g0KkL+Lh9wWgAVWCa9uchfVX4kZFk26o05dH
 yg2zthG3/eQQSHBLavYOf5syAbljM4+ZNTRIudTvqEFxbEKe+YKa4Qz7hw7l5XbdCSaiPPsMhNa
 I0k5bVK3+vDo+wiPZFa1WntuCmMevianRbRfBHvtlFWpmFwsOYyY1aqtBj29XLc2KsSxPPonWSz
 jDlwuY24ZwBnraQHJy4Y/5xV3vBoqVh0pxJaYCnfIKjSWJ6eNN8rCt6RMrfimEvXjVQxiHsExUM
 CN9jMYZL2Xw1EFrwveB6qGnCpuLlVEv0hHcQA44EacNalkRB4t/j2rUGGDKh3RW1N3HKQ6SMGXx
 lhjOt21GDFiImk/QTo3blW4nfKhNZHvMOcbApau+DKr7qc+e99N8gn04pJprutDLljFIsG1njR3
 dckM4bxp7jlS9RC9kZA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c391a5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=a3xt0snR_0cr3N4ExM8A:9
X-Proofpoint-GUID: UVQSml50OM5oEmPcf2wBR7RS9PgSKyOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250050

Lazy MMU mode is assumed to be context-independent, in the sense
that it does not need any additional information while operating.
However, the s390 architecture benefits from knowing the exact
page table entries being modified.

Introduce lazy_mmu_mode_enable_pte(), which is provided with the
process address space and the page table being operated on. This
information is required to enable s390-specific optimizations.

The function takes parameters that are typically passed to page-
table level walkers, which implies that the span of PTE entries
never crosses a page table boundary.

Architectures that do not require such information simply do not
need to define the arch_enter_lazy_mmu_mode_pte() callback.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 fs/proc/task_mmu.c      |  2 +-
 include/linux/pgtable.h | 42 +++++++++++++++++++++++++++++++++++++++++
 mm/madvise.c            |  8 ++++----
 mm/memory.c             |  8 ++++----
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 mm/vmalloc.c            |  6 +++---
 7 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..4e3b1987874a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2752,7 +2752,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
 		return 0;
 	}
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(vma->vm_mm, start, end, start_pte);
=20
 	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
 		/* Fast path for performing exclusive WP */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a50df42a893f..481b45954800 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -271,6 +271,44 @@ static inline void lazy_mmu_mode_enable(void)
 		arch_enter_lazy_mmu_mode();
 }
=20
+#ifndef arch_enter_lazy_mmu_mode_pte
+static inline void arch_enter_lazy_mmu_mode_pte(struct mm_struct *mm,
+						unsigned long addr,
+						unsigned long end,
+						pte_t *ptep)
+{
+	arch_enter_lazy_mmu_mode();
+}
+#endif
+
+/**
+ * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
+ *
+ * Enters a new lazy MMU mode section; if the mode was not already enabl=
ed,
+ * enables it and calls arch_enter_lazy_mmu_mode_pte().
+ *
+ * Must be paired with a call to lazy_mmu_mode_disable().
+ *
+ * Has no effect if called:
+ * - While paused - see lazy_mmu_mode_pause()
+ * - In interrupt context
+ */
+static inline void lazy_mmu_mode_enable_pte(struct mm_struct *mm,
+					    unsigned long addr,
+					    unsigned long end,
+					    pte_t *ptep)
+{
+	struct lazy_mmu_state *state =3D &current->lazy_mmu_state;
+
+	if (in_interrupt() || state->pause_count > 0)
+		return;
+
+	VM_WARN_ON_ONCE(state->enable_count =3D=3D U8_MAX);
+
+	if (state->enable_count++ =3D=3D 0)
+		arch_enter_lazy_mmu_mode_pte(mm, addr, end, ptep);
+}
+
 /**
  * lazy_mmu_mode_disable() - Disable the lazy MMU mode.
  *
@@ -353,6 +391,10 @@ static inline void lazy_mmu_mode_resume(void)
 }
 #else
 static inline void lazy_mmu_mode_enable(void) {}
+static inline void lazy_mmu_mode_enable_pte(struct mm_struct *mm,
+					    unsigned long addr,
+					    unsigned long end,
+					    pte_t *ptep) {}
 static inline void lazy_mmu_mode_disable(void) {}
 static inline void lazy_mmu_mode_pause(void) {}
 static inline void lazy_mmu_mode_resume(void) {}
diff --git a/mm/madvise.c b/mm/madvise.c
index dbb69400786d..02edc80f678b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -451,7 +451,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
 	if (!start_pte)
 		return 0;
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, addr, end, start_pte);
 	for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
 		nr =3D 1;
 		ptent =3D ptep_get(pte);
@@ -506,7 +506,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
 				if (!start_pte)
 					break;
 				flush_tlb_batched_pending(mm);
-				lazy_mmu_mode_enable();
+				lazy_mmu_mode_enable_pte(mm, addr, end, start_pte);
 				if (!err)
 					nr =3D 0;
 				continue;
@@ -673,7 +673,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
 	if (!start_pte)
 		return 0;
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, addr, end, start_pte);
 	for (; addr !=3D end; pte +=3D nr, addr +=3D PAGE_SIZE * nr) {
 		nr =3D 1;
 		ptent =3D ptep_get(pte);
@@ -733,7 +733,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
 				if (!start_pte)
 					break;
 				flush_tlb_batched_pending(mm);
-				lazy_mmu_mode_enable();
+				lazy_mmu_mode_enable_pte(mm, addr, end, pte);
 				if (!err)
 					nr =3D 0;
 				continue;
diff --git a/mm/memory.c b/mm/memory.c
index 2f815a34d924..43fa9965fb5f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1269,7 +1269,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, stru=
ct vm_area_struct *src_vma,
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 	orig_src_pte =3D src_pte;
 	orig_dst_pte =3D dst_pte;
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(src_mm, addr, end, src_pte);
=20
 	do {
 		nr =3D 1;
@@ -1917,7 +1917,7 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
 		return addr;
=20
 	flush_tlb_batched_pending(mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, addr, end, start_pte);
 	do {
 		bool any_skipped =3D false;
=20
@@ -2875,7 +2875,7 @@ static int remap_pte_range(struct mm_struct *mm, pm=
d_t *pmd,
 	mapped_pte =3D pte =3D pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, addr, end, mapped_pte);
 	do {
 		BUG_ON(!pte_none(ptep_get(pte)));
 		if (!pfn_modify_allowed(pfn, prot)) {
@@ -3235,7 +3235,7 @@ static int apply_to_pte_range(struct mm_struct *mm,=
 pmd_t *pmd,
 			return -EINVAL;
 	}
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, addr, end, mapped_pte);
=20
 	if (fn) {
 		do {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c0571445bef7..43a2a65b8caf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -233,7 +233,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 		is_private_single_threaded =3D vma_is_single_threaded_private(vma);
=20
 	flush_tlb_batched_pending(vma->vm_mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(vma->vm_mm, addr, end, pte);
 	do {
 		nr_ptes =3D 1;
 		oldpte =3D ptep_get(pte);
diff --git a/mm/mremap.c b/mm/mremap.c
index 2be876a70cc0..ac7f649f3aad 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -260,7 +260,7 @@ static int move_ptes(struct pagetable_move_control *p=
mc,
 	if (new_ptl !=3D old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 	flush_tlb_batched_pending(vma->vm_mm);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(mm, old_addr, old_end, old_ptep);
=20
 	for (; old_addr < old_end; old_ptep +=3D nr_ptes, old_addr +=3D nr_ptes=
 * PAGE_SIZE,
 		new_ptep +=3D nr_ptes, new_addr +=3D nr_ptes * PAGE_SIZE) {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61caa55a4402..5e702bcf03fd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -108,7 +108,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long a=
ddr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(&init_mm, addr, end, pte);
=20
 	do {
 		if (unlikely(!pte_none(ptep_get(pte)))) {
@@ -371,7 +371,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
 	unsigned long size =3D PAGE_SIZE;
=20
 	pte =3D pte_offset_kernel(pmd, addr);
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(&init_mm, addr, end, pte);
=20
 	do {
 #ifdef CONFIG_HUGETLB_PAGE
@@ -538,7 +538,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned =
long addr,
 	if (!pte)
 		return -ENOMEM;
=20
-	lazy_mmu_mode_enable();
+	lazy_mmu_mode_enable_pte(&init_mm, addr, end, pte);
=20
 	do {
 		struct page *page =3D pages[*nr];
--=20
2.51.0

