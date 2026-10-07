Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3474756BA;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373362; cv=none; b=CzTQDxoVcAZSImAOM3aHo+PiXt5yalUuMdypVaTRqlGi95JBnCf7xjhBdEVDjVKhXvXhuTM98murlz0f4QaPOekPuyvLB3X+ySNxMF3rqnkuh0qaCnXVlpSND1tLsQ1r869aD4YE/sXSiBlXIyf85sZpoDGg8ijkqmJIPV1Exvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373362; c=relaxed/simple;
	bh=9dB8EQVxZAxKL6sfmxuS2R9B+iKSFUZ86WAaBSCIyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXVJft+cX04c+xJKSHNB3p3ekUFnkIWF59rfZtExSHc7oFVWsfErJmM+aZs8mnQ996Yv2TPB8ovv4z4XS2+MGAlx4VUtpQiaGrkrcOX8dGfehaUXLoqcNsnZo4FlNy4t6yq86fLb657/mwhn7vnHY6gKwwU0JajSeJ0E6+kSetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aiofx5qo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aiofx5qo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZw5A597177;
	Wed, 7 Oct 2026 11:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BGlSJ8UAj69g7RekU
	k3plznFRs6QLevUCBvX/7/LmYU=; b=aiofx5qo9FnFPWWaGxG+NJ7ZJHOXzYDBW
	dIzYjjqnZJworMjUb4MXjSWHjBOyzvZZXNpYl2TzIyBRIdQ1jeGhmAuFRus/IPLG
	6FTNGW+iyoQnRsWsBDFGjBF49xBPOP7a+17+wHShCuYX6xJCyT6xATLFtp2vPY7b
	E9uLQYjP7KGFY7gt0w97YfT9FqXB/d2Vbk1Q8MuGhSdJJ7CJ3R1bakRFiIv1ib2L
	qSmT4dogDp2r//rIvFiT+vZKHlVg5v2c69wMiN1ILdBsCpHrf3OSDs2l3GaetWMd
	mCmGe1YOzJLxcVXCLu+zEd0dDiu2668+OeUOEQsTl1Wu9NwBFRFDQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn5m7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69782Ucr1562431;
	Wed, 7 Oct 2026 11:42:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxfh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxTx45220258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107BA2005A;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47082004D;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8010816091B; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 03/15] mm: use hw_pte_t for generic PTE table storage
Date: Wed,  7 Oct 2026 13:41:46 +0200
Message-ID: <9b168d4b1aa81c2488a413665cc388e6a3ca084e.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX2o8gLjRseyVV
 VDNQeyin44WpoZy3MnLwdMsAY0oetBuKCGIvAfYMCUpu/dVZm3oPLymwChh+4prWdL9yL4aoPWV
 LBOeSDMxM15iSxXXXBay0hPG8QK/fO0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX2lBRr06ojFWF
 xNgMVHJPbxs24wMP31YA3L0bteBTQA1n7vw9t0ulMnpx6yRMALwVd6bEnHRoVEnr7+xFNUzj8fH
 vY8x/Os2V63E+kbAuMMA4igX5qdlKGmN1n1SnI4gu6Dod2A7BnNDuYI2VEDq5iiTYkLbEill7K2
 RtmXoZUr7JO4ob45UQrj6Lmus5y7dFdgI2oJ0eLZSEWR+y7HFC+HdF5lPV+SY/To6kYtqJPP76/
 +OUHsXjVGqW2DLPgxyVElm/O4Br1nGAMSgX0zbDInSMr2xF4Q5FEpuG3lDFbZJWQe9yCaFa+SSS
 /uXlEEBOVhZOSHl1XhtyVQX9gXWZsKtwXra/xMX7Bj3kvGM3O16DL0F1xcyYLAyJw4+koCTUx3I
 5u1FDE0rcpZX0bJKIm3MpH/8Hc/Xe5JmH62gyGrjSb8KAzLC/3nWcqz7KT93kcAZ/i7JxXi6fLc
 l+8Bp0Gic4cwntx581A==
X-Proofpoint-GUID: CnzkyZ3fzy5sD4mKUsSRESpN4ZilnEza
X-Proofpoint-ORIG-GUID: gOa5nfl3u4ulnkJQoZdW8RUaVy3HZCzH
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac6300e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8 a=3AT-l84HVnZZECcmh6sA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

Generic page-table interfaces use pte_t * for both pointers to PTE table
storage and pointers to software PTE values. Convert the generic
declarations and their MM, fs, and kernel users together so parameters,
return types, callbacks, and local pointers that designate table storage
use hw_pte_t *.

Include linux/pgtable_types.h from headers that expose the converted
interfaces. It continues to provide pgprot_t to vmalloc.h through
asm/page.h.

Keep software PTE values as pte_t and retain pte_t * for value interfaces=
.

No architecture selects ARCH_HAS_HW_PTE_T at this point, so hw_pte_t
remains an alias of pte_t and this changes the interface vocabulary witho=
ut
changing representation or behavior.

Most of this mechanical conversion was generated with the Coccinelle scri=
pt
included in the cover letter. The script deliberately ignores pte_t *
pointers named ptentp because they designate software PTE values. The
result was then audited, and sites the script could not convert were
updated by hand.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 fs/hugetlbfs/inode.c             |  3 +-
 fs/proc/task_mmu.c               | 33 ++++++-------
 include/asm-generic/hugetlb.h    | 15 +++---
 include/asm-generic/pgalloc.h    |  6 +--
 include/asm-generic/tlb.h        |  5 +-
 include/linux/hugetlb.h          | 50 +++++++++++---------
 include/linux/mm.h               | 26 +++++------
 include/linux/page_table_check.h | 10 ++--
 include/linux/pagewalk.h         |  8 ++--
 include/linux/pgtable.h          | 79 +++++++++++++++++---------------
 include/linux/rmap.h             |  2 +-
 include/linux/swapops.h          |  6 ++-
 include/linux/vmalloc.h          |  4 +-
 include/trace/events/xen.h       | 10 ++--
 kernel/bpf/arena.c               |  9 ++--
 kernel/events/core.c             |  3 +-
 mm/damon/ops-common.c            |  2 +-
 mm/damon/ops-common.h            |  2 +-
 mm/damon/vaddr.c                 | 20 ++++----
 mm/debug_vm_pgtable.c            |  2 +-
 mm/filemap.c                     |  4 +-
 mm/gup.c                         |  9 ++--
 mm/highmem.c                     | 15 +++---
 mm/hmm.c                         |  6 +--
 mm/huge_memory.c                 |  4 +-
 mm/hugetlb.c                     | 60 ++++++++++++------------
 mm/hugetlb_vmemmap.c             | 13 +++---
 mm/internal.h                    | 16 +++----
 mm/kasan/init.c                  | 12 ++---
 mm/kasan/shadow.c                |  6 +--
 mm/khugepaged.c                  | 50 ++++++++++++--------
 mm/ksm.c                         |  7 +--
 mm/madvise.c                     | 14 +++---
 mm/mapping_dirty_helpers.c       |  4 +-
 mm/memory-failure.c              |  6 +--
 mm/memory.c                      | 78 ++++++++++++++++---------------
 mm/mempolicy.c                   |  4 +-
 mm/migrate.c                     |  4 +-
 mm/migrate_device.c              |  4 +-
 mm/mincore.c                     |  4 +-
 mm/mlock.c                       |  4 +-
 mm/mprotect.c                    | 19 ++++----
 mm/mremap.c                      |  4 +-
 mm/page_table_check.c            |  4 +-
 mm/pagewalk.c                    |  9 ++--
 mm/percpu.c                      |  2 +-
 mm/pgtable-generic.c             | 20 ++++----
 mm/ptdump.c                      |  2 +-
 mm/rmap.c                        |  6 +--
 mm/sparse-vmemmap.c              | 22 ++++-----
 mm/swap_state.c                  |  3 +-
 mm/swapfile.c                    |  5 +-
 mm/userfaultfd.c                 | 32 +++++++------
 mm/util.c                        |  2 +-
 mm/vmalloc.c                     | 11 +++--
 mm/vmscan.c                      |  6 +--
 56 files changed, 410 insertions(+), 356 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7611a8470ea2..ddaab714c3e0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -328,7 +328,8 @@ static void hugetlb_delete_from_page_cache(struct fol=
io *folio)
 static bool hugetlb_vma_maps_pfn(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long pfn)
 {
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	ptep =3D hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
 	if (!ptep)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..2b5af72bbe45 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1046,7 +1046,7 @@ static void smaps_pte_hole_lookup(unsigned long add=
r, struct mm_walk *walk)
 #endif
 }
=20
-static void smaps_pte_entry(pte_t *pte, unsigned long addr,
+static void smaps_pte_entry(hw_pte_t *pte, unsigned long addr,
 		struct mm_walk *walk)
 {
 	struct mem_size_stats *mss =3D walk->private;
@@ -1140,7 +1140,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
 			   struct mm_walk *walk)
 {
 	struct vm_area_struct *vma =3D walk->vma;
-	pte_t *pte;
+	hw_pte_t *pte;
 	spinlock_t *ptl;
=20
 	ptl =3D pmd_trans_huge_lock(pmd, vma);
@@ -1263,7 +1263,7 @@ static void show_smap_vma_flags(struct seq_file *m,=
 struct vm_area_struct *vma)
 }
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
+static int smaps_hugetlb_range(hw_pte_t *pte, unsigned long hmask,
 				 unsigned long addr, unsigned long end,
 				 struct mm_walk *walk)
 {
@@ -1704,7 +1704,7 @@ static inline bool pte_is_pinned(struct vm_area_str=
uct *vma, unsigned long addr,
 }
=20
 static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+		unsigned long addr, hw_pte_t *pte)
 {
 	if (!pgtable_supports_soft_dirty())
 		return;
@@ -1772,7 +1772,8 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigne=
d long addr,
 {
 	struct clear_refs_private *cp =3D walk->private;
 	struct vm_area_struct *vma =3D walk->vma;
-	pte_t *pte, ptent;
+	hw_pte_t *pte;
+	pte_t ptent;
 	spinlock_t *ptl;
 	struct folio *folio;
=20
@@ -2172,7 +2173,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned =
long addr, unsigned long end,
 	struct vm_area_struct *vma =3D walk->vma;
 	struct pagemapread *pm =3D walk->private;
 	spinlock_t *ptl;
-	pte_t *pte, *orig_pte;
+	hw_pte_t *pte, *orig_pte;
 	int err =3D 0;
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -2210,7 +2211,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned =
long addr, unsigned long end,
=20
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
-static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
+static int pagemap_hugetlb_range(hw_pte_t *ptep, unsigned long hmask,
 				 unsigned long addr, unsigned long end,
 				 struct mm_walk *walk)
 {
@@ -2501,7 +2502,7 @@ static unsigned long pagemap_page_category(struct p=
agemap_scan_private *p,
 }
=20
 static void make_uffd_wp_pte(struct vm_area_struct *vma,
-			     unsigned long addr, pte_t *pte, pte_t ptent)
+			     unsigned long addr, hw_pte_t *pte, pte_t ptent)
 {
 	if (pte_present(ptent)) {
 		pte_t old_pte;
@@ -2634,7 +2635,7 @@ static unsigned long pagemap_hugetlb_category(struc=
t vm_area_struct *vma,
 }
=20
 static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
-				  unsigned long addr, pte_t *ptep,
+				  unsigned long addr, hw_pte_t *ptep,
 				  pte_t ptent)
 {
 	const unsigned long psize =3D huge_page_size(hstate_vma(vma));
@@ -2868,7 +2869,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
 	struct pagemap_scan_private *p =3D walk->private;
 	struct vm_area_struct *vma =3D walk->vma;
 	unsigned long addr, flush_end =3D 0;
-	pte_t *pte, *start_pte;
+	hw_pte_t *pte, *start_pte;
 	spinlock_t *ptl;
 	int ret;
=20
@@ -2962,7 +2963,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
 }
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
+static int pagemap_scan_hugetlb_entry(hw_pte_t *ptep, unsigned long hmas=
k,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
 {
@@ -3043,7 +3044,7 @@ static int pagemap_scan_hugetlb_hole_wp(struct vm_a=
rea_struct *vma,
 	unsigned long psize =3D huge_page_size(h);
 	struct mm_struct *mm =3D vma->vm_mm;
 	spinlock_t *ptl;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t pte;
=20
 	for (addr =3D ALIGN_DOWN(addr, psize); addr < end; addr +=3D psize) {
@@ -3427,8 +3428,8 @@ static int gather_pte_stats(pmd_t *pmd, unsigned lo=
ng addr,
 	struct numa_maps *md =3D walk->private;
 	struct vm_area_struct *vma =3D walk->vma;
 	spinlock_t *ptl;
-	pte_t *orig_pte;
-	pte_t *pte;
+	hw_pte_t *orig_pte;
+	hw_pte_t *pte;
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl =3D pmd_trans_huge_lock(pmd, vma);
@@ -3461,7 +3462,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned lo=
ng addr,
 	return 0;
 }
 #ifdef CONFIG_HUGETLB_PAGE
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
+static int gather_hugetlb_stats(hw_pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
 	pte_t huge_pte;
@@ -3484,7 +3485,7 @@ static int gather_hugetlb_stats(pte_t *pte, unsigne=
d long hmask,
 }
=20
 #else
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
+static int gather_hugetlb_stats(hw_pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
 	return 0;
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.=
h
index 635c41cc3479..3bfad4a99b64 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -60,7 +60,7 @@ static inline int huge_pte_uffd(pte_t pte)
=20
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
-		    pte_t *ptep, unsigned long sz)
+		    hw_pte_t *ptep, unsigned long sz)
 {
 	pte_clear(mm, addr, ptep);
 }
@@ -68,7 +68,7 @@ static inline void huge_pte_clear(struct mm_struct *mm,=
 unsigned long addr,
=20
 #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long a=
ddr,
-		pte_t *ptep, pte_t pte, unsigned long sz)
+		hw_pte_t *ptep, pte_t pte, unsigned long sz)
 {
 	set_pte_at(mm, addr, ptep, pte);
 }
@@ -76,7 +76,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm=
, unsigned long addr,
=20
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep, unsigned long sz)
+		unsigned long addr, hw_pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
@@ -84,7 +84,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_s=
truct *mm,
=20
 #ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, hw_pte_t *ptep)
 {
 	return ptep_clear_flush(vma, addr, ptep);
 }
@@ -99,7 +99,7 @@ static inline int huge_pte_none(pte_t pte)
=20
 #ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, hw_pte_t *ptep)
 {
 	ptep_set_wrprotect(mm, addr, ptep);
 }
@@ -107,7 +107,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_=
struct *mm,
=20
 #ifndef __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep,
+		unsigned long addr, hw_pte_t *ptep,
 		pte_t pte, int dirty)
 {
 	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
@@ -115,7 +115,8 @@ static inline int huge_ptep_set_access_flags(struct v=
m_area_struct *vma,
 #endif
=20
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long ad=
dr, pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long ad=
dr,
+		hw_pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.=
h
index 051aa1331051..b35e5a2158ad 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -16,7 +16,7 @@
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
+static inline hw_pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *=
mm)
 {
 	struct ptdesc *ptdesc =3D pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0)=
;
=20
@@ -40,7 +40,7 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(stru=
ct mm_struct *mm)
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-static inline pte_t *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
+static inline hw_pte_t *pte_alloc_one_kernel_noprof(struct mm_struct *mm=
)
 {
 	return __pte_alloc_one_kernel_noprof(mm);
 }
@@ -52,7 +52,7 @@ static inline pte_t *pte_alloc_one_kernel_noprof(struct=
 mm_struct *mm)
  * @mm: the mm_struct of the current context
  * @pte: pointer to the memory containing the page table
  */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, hw_pte_t *pte)
 {
 	pagetable_dtor_free(virt_to_ptdesc(pte));
 }
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index bdcc2778ac64..2c3517800a9a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -644,7 +644,8 @@ static inline void tlb_flush_p4d_range(struct mmu_gat=
her *tlb,
 }
=20
 #ifndef __tlb_remove_tlb_entry
-static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t =
*ptep, unsigned long address)
+static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb,
+		hw_pte_t *ptep, unsigned long address)
 {
 }
 #endif
@@ -670,7 +671,7 @@ static inline void __tlb_remove_tlb_entry(struct mmu_=
gather *tlb, pte_t *ptep, u
  * consecutive ptes instead of only a single one.
  */
 static inline void tlb_remove_tlb_entries(struct mmu_gather *tlb,
-		pte_t *ptep, unsigned int nr, unsigned long address)
+		hw_pte_t *ptep, unsigned int nr, unsigned long address)
 {
 	tlb_flush_pte_range(tlb, address, PAGE_SIZE * nr);
 	for (;;) {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 16c4c4caa126..bc0b9c65aa1d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -141,7 +141,7 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(hw_pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -161,7 +161,7 @@ void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)=
;
=20
-pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 		      unsigned long addr, pud_t *pud);
 bool hugetlbfs_pagecache_present(struct hstate *h,
 				 struct vm_area_struct *vma,
@@ -186,22 +186,22 @@ void hugetlb_bootmem_set_nodes(void);
  * which may go down to the lowest PTE level in their huge_pte_offset() =
and
  * huge_pte_alloc(): to avoid reliance on pte_offset_map() without pte_u=
nmap().
  */
-static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
+static inline hw_pte_t *pte_offset_huge(pmd_t *pmd, unsigned long addres=
s)
 {
 	return pte_offset_kernel(pmd, address);
 }
-static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
+static inline hw_pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 				    unsigned long address)
 {
 	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
 }
 #endif
=20
-pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 			unsigned long addr, unsigned long sz);
 /*
  * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
- * Returns the pte_t* if found, or NULL if the address is not mapped.
+ * Returns the hw_pte_t* if found, or NULL if the address is not mapped.
  *
  * IMPORTANT: we should normally not directly call this function, instea=
d
  * this is only a common interface to implement arch-specific
@@ -236,11 +236,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct =
vm_area_struct *vma,
  * a concurrent pmd unshare, but it makes sure the pgtable page is safe =
to
  * access.
  */
-pte_t *huge_pte_offset(struct mm_struct *mm,
+hw_pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
 int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep);
+		unsigned long addr, hw_pte_t *ptep);
 void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struc=
t *vma);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
@@ -302,7 +302,8 @@ static inline struct address_space *hugetlb_folio_map=
ping_lock_write(
 }
=20
 static inline int huge_pmd_unshare(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+		struct vm_area_struct *vma, unsigned long addr,
+		hw_pte_t *ptep)
 {
 	return 0;
 }
@@ -394,7 +395,7 @@ static inline int is_hugepage_only_range(struct mm_st=
ruct *mm,
 }
=20
 #ifdef CONFIG_USERFAULTFD
-static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
+static inline int hugetlb_mfill_atomic_pte(hw_pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
@@ -406,7 +407,7 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst=
_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
=20
-static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long=
 addr,
+static inline hw_pte_t *huge_pte_offset(struct mm_struct *mm, unsigned l=
ong addr,
 					unsigned long sz)
 {
 	return NULL;
@@ -989,7 +990,8 @@ static inline bool htlb_allow_alloc_fallback(enum mig=
rate_reason reason)
 }
=20
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
-					   struct mm_struct *mm, pte_t *pte)
+					   struct mm_struct *mm,
+					   hw_pte_t *pte)
 {
 	const unsigned long size =3D huge_page_size(h);
=20
@@ -1053,7 +1055,8 @@ static inline void hugetlb_count_sub(long l, struct=
 mm_struct *mm)
 #ifndef huge_ptep_modify_prot_start
 #define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *v=
ma,
-						unsigned long addr, pte_t *ptep)
+						unsigned long addr,
+						hw_pte_t *ptep)
 {
 	unsigned long psize =3D huge_page_size(hstate_vma(vma));
=20
@@ -1064,7 +1067,8 @@ static inline pte_t huge_ptep_modify_prot_start(str=
uct vm_area_struct *vma,
 #ifndef huge_ptep_modify_prot_commit
 #define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
 static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *v=
ma,
-						unsigned long addr, pte_t *ptep,
+						unsigned long addr,
+						hw_pte_t *ptep,
 						pte_t old_pte, pte_t pte)
 {
 	unsigned long psize =3D huge_page_size(hstate_vma(vma));
@@ -1252,7 +1256,8 @@ static inline bool htlb_allow_alloc_fallback(enum m=
igrate_reason reason)
 }
=20
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
-					   struct mm_struct *mm, pte_t *pte)
+					   struct mm_struct *mm,
+					   hw_pte_t *pte)
 {
 	return &mm->page_table_lock;
 }
@@ -1269,11 +1274,11 @@ static inline void hugetlb_count_sub(long l, stru=
ct mm_struct *mm)
 {
 }
=20
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *pte=
p);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, hw_pte_t *=
ptep);
 unsigned long huge_pte_dirty(pte_t pte);
=20
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-					  unsigned long addr, pte_t *ptep)
+					  unsigned long addr, hw_pte_t *ptep)
 {
 #ifdef CONFIG_MMU
 	return ptep_get(ptep);
@@ -1283,7 +1288,8 @@ static inline pte_t huge_ptep_clear_flush(struct vm=
_area_struct *vma,
 }
=20
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long a=
ddr,
-				   pte_t *ptep, pte_t pte, unsigned long sz)
+				   hw_pte_t *ptep, pte_t pte,
+				   unsigned long sz)
 {
 }
=20
@@ -1311,7 +1317,7 @@ static inline void hugetlb_bootmem_struct_page_init=
(void)
 #endif	/* CONFIG_HUGETLB_PAGE */
=20
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
-					struct mm_struct *mm, pte_t *pte)
+					struct mm_struct *mm, hw_pte_t *pte)
 {
 	spinlock_t *ptl;
=20
@@ -1329,12 +1335,12 @@ static inline __init void hugetlb_cma_reserve(voi=
d)
 #endif
=20
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
-static inline bool hugetlb_pmd_shared(pte_t *pte)
+static inline bool hugetlb_pmd_shared(hw_pte_t *pte)
 {
 	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
 }
 #else
-static inline bool hugetlb_pmd_shared(pte_t *pte)
+static inline bool hugetlb_pmd_shared(hw_pte_t *pte)
 {
 	return false;
 }
@@ -1361,7 +1367,7 @@ bool __vma_private_lock(struct vm_area_struct *vma)=
;
  * Safe version of huge_pte_offset() to check the locks.  See comments
  * above huge_pte_offset().
  */
-static inline pte_t *
+static inline hw_pte_t *
 hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned lo=
ng sz)
 {
 #if defined(CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING) && defined(CONFIG_LOC=
KDEP)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..b7b2848fdf41 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -779,7 +779,7 @@ struct vm_fault {
 					 * VM_FAULT_ERROR).
 					 */
 	/* These three entries are valid only while holding ptl lock */
-	pte_t *pte;			/* Pointer to pte entry matching
+	hw_pte_t *pte;			/* Pointer to pte entry matching
 					 * the 'address'. NULL if the page
 					 * table hasn't been allocated.
 					 */
@@ -3249,7 +3249,7 @@ struct follow_pfnmap_args {
 	 * The caller shouldn't touch any of these.
 	 */
 	spinlock_t *lock;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	/**
 	 * Outputs:
 	 *
@@ -3586,7 +3586,7 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
=20
-extern pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+extern hw_pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr=
,
 			     spinlock_t **ptl);
=20
 #ifdef __PAGETABLE_P4D_FOLDED
@@ -3864,7 +3864,7 @@ static inline spinlock_t *pte_lockptr(struct mm_str=
uct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
=20
-static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, hw_pte_t *p=
te)
 {
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
 	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
@@ -3895,7 +3895,7 @@ static inline spinlock_t *pte_lockptr(struct mm_str=
uct *mm, pmd_t *pmd)
 {
 	return &mm->page_table_lock;
 }
-static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, hw_pte_t *p=
te)
 {
 	return &mm->page_table_lock;
 }
@@ -3936,19 +3936,19 @@ static inline bool pagetable_pte_ctor(struct mm_s=
truct *mm,
 	return true;
 }
=20
-pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
+hw_pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdval=
p);
=20
-static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
+static inline hw_pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
 {
 	return __pte_offset_map(pmd, addr, NULL);
 }
=20
-pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			   unsigned long addr, spinlock_t **ptlp);
=20
-pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp);
-pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, pmd_t *pmdvalp,
 				spinlock_t **ptlp);
=20
@@ -4898,7 +4898,7 @@ static inline bool gup_can_follow_protnone(const st=
ruct vm_area_struct *vma,
 	return !vma_is_accessible(vma);
 }
=20
-typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
+typedef int (*pte_fn_t)(hw_pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long addre=
ss,
 			       unsigned long size, pte_fn_t fn, void *data);
 extern int apply_to_existing_page_range(struct mm_struct *mm,
@@ -5148,7 +5148,7 @@ void *vmemmap_alloc_block(unsigned long size, int n=
ode);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
 			      struct vmem_altmap *altmap);
-void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
+void vmemmap_verify(hw_pte_t *, int, unsigned long, unsigned long);
 void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 		     unsigned long addr, unsigned long next);
 int vmemmap_check_pmd(pmd_t *pmd, int node,
@@ -5516,7 +5516,7 @@ static inline bool snapshot_page_is_faithful(const =
struct page_snapshot *ps)
=20
 void snapshot_page(struct page_snapshot *ps, const struct page *page);
=20
-void map_anon_folio_pte_nopf(struct folio *folio, pte_t *pte,
+void map_anon_folio_pte_nopf(struct folio *folio, hw_pte_t *pte,
 		struct vm_area_struct *vma, unsigned long addr,
 		bool uffd_wp);
=20
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_=
check.h
index 12268a32e8be..933c1028c223 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -7,6 +7,8 @@
 #ifndef __LINUX_PAGE_TABLE_CHECK_H
 #define __LINUX_PAGE_TABLE_CHECK_H
=20
+#include <linux/pgtable_types.h>
+
 #ifdef CONFIG_PAGE_TABLE_CHECK
 #include <linux/jump_label.h>
=20
@@ -21,7 +23,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm,=
 unsigned long addr,
 void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long ad=
dr,
 				  pud_t pud);
 void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long add=
r,
-		pte_t *ptep, pte_t pte, unsigned int nr);
+		hw_pte_t *ptep, pte_t pte, unsigned int nr);
 void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long add=
r,
 		pmd_t *pmdp, pmd_t pmd, unsigned int nr);
 void __page_table_check_puds_set(struct mm_struct *mm, unsigned long add=
r,
@@ -74,7 +76,8 @@ static inline void page_table_check_pud_clear(struct mm=
_struct *mm,
 }
=20
 static inline void page_table_check_ptes_set(struct mm_struct *mm,
-					     unsigned long addr, pte_t *ptep,
+					     unsigned long addr,
+					     hw_pte_t *ptep,
 					     pte_t pte, unsigned int nr)
 {
 	if (static_branch_likely(&page_table_check_disabled))
@@ -137,7 +140,8 @@ static inline void page_table_check_pud_clear(struct =
mm_struct *mm,
 }
=20
 static inline void page_table_check_ptes_set(struct mm_struct *mm,
-					     unsigned long addr, pte_t *ptep,
+					     unsigned long addr,
+					     hw_pte_t *ptep,
 					     pte_t pte, unsigned int nr)
 {
 }
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index c34d826c5e4a..7ab2eb39e02c 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -38,7 +38,7 @@ enum page_walk_lock {
  *			not trigger for any populated ranges.
  * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
  *			function is called with the vma lock held, in order to
- *			protect against a concurrent freeing of the pte_t* or
+ *			protect against a concurrent freeing of the hw_pte_t* or
  *			the ptl. In some cases, the hook function needs to drop
  *			and retake the vma lock in order to avoid deadlocks
  *			while calling other functions. In such cases the hook
@@ -76,11 +76,11 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
-	int (*pte_entry)(pte_t *pte, unsigned long addr,
+	int (*pte_entry)(hw_pte_t *pte, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_hole)(unsigned long addr, unsigned long next,
 			int depth, struct mm_walk *walk);
-	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
+	int (*hugetlb_entry)(hw_pte_t *pte, unsigned long hmask,
 			     unsigned long addr, unsigned long next,
 			     struct mm_walk *walk);
 	int (*test_walk)(unsigned long addr, unsigned long next,
@@ -173,7 +173,7 @@ struct folio_walk {
 	struct page *page;
 	enum folio_walk_level level;
 	union {
-		pte_t *ptep;
+		hw_pte_t *ptep;
 		pud_t *pudp;
 		pmd_t *pmdp;
 	};
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..dad80d264aac 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -4,6 +4,7 @@
=20
 #include <linux/pfn.h>
 #include <asm/pgtable.h>
+#include <linux/pgtable_types.h>
=20
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
@@ -93,26 +94,26 @@ static inline void pud_init(void *addr)
 #endif
=20
 #ifndef pte_offset_kernel
-static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address=
)
+static inline hw_pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long addr=
ess)
 {
-	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
+	return (hw_pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
 }
 #define pte_offset_kernel pte_offset_kernel
 #endif
=20
 #ifdef CONFIG_HIGHPTE
 #define __pte_map(pmd, address) \
-	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
+	((hw_pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
 #define pte_unmap(pte)	do {	\
 	kunmap_local((pte));	\
 	rcu_read_unlock();	\
 } while (0)
 #else
-static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
+static inline hw_pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 {
 	return pte_offset_kernel(pmd, address);
 }
-static inline void pte_unmap(pte_t *pte)
+static inline void pte_unmap(hw_pte_t *pte)
 {
 	rcu_read_unlock();
 }
@@ -172,7 +173,7 @@ static inline pmd_t *pmd_off_k(unsigned long va)
 	return pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), va), va)=
;
 }
=20
-static inline pte_t *virt_to_kpte(unsigned long vaddr)
+static inline hw_pte_t *virt_to_kpte(unsigned long vaddr)
 {
 	pmd_t *pmd =3D pmd_off_k(vaddr);
=20
@@ -407,7 +408,7 @@ static inline void lazy_mmu_mode_resume(void) {}
  *
  * May be overridden by the architecture, else pte_batch_hint is always =
1.
  */
-static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
+static inline unsigned int pte_batch_hint(hw_pte_t *ptep, pte_t pte)
 {
 	return 1;
 }
@@ -442,7 +443,7 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsign=
ed long nr)
  * to the same folio.  The PTEs are all in the same PMD.
  */
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
+		hw_pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
=20
@@ -459,7 +460,7 @@ static inline void set_ptes(struct mm_struct *mm, uns=
igned long addr,
=20
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
-				 unsigned long address, pte_t *ptep,
+				 unsigned long address, hw_pte_t *ptep,
 				 pte_t entry, int dirty);
 #endif
=20
@@ -490,7 +491,7 @@ static inline int pudp_set_access_flags(struct vm_are=
a_struct *vma,
 #endif
=20
 #ifndef ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(hw_pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
@@ -526,7 +527,7 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
=20
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep)
+		unsigned long address, hw_pte_t *ptep)
 {
 	pte_t pte =3D ptep_get(ptep);
 	bool young =3D true;
@@ -565,7 +566,7 @@ static inline bool pmdp_test_and_clear_young(struct v=
m_area_struct *vma,
=20
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 bool ptep_clear_flush_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep);
+		unsigned long address, hw_pte_t *ptep);
 #endif
=20
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
@@ -644,7 +645,7 @@ static inline void arch_check_zapped_pud(struct vm_ar=
ea_struct *vma, pud_t pud)
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
-				       pte_t *ptep)
+				       hw_pte_t *ptep)
 {
 	pte_t pte =3D ptep_get(ptep);
 	pte_clear(mm, address, ptep);
@@ -673,7 +674,7 @@ static inline pte_t ptep_get_and_clear(struct mm_stru=
ct *mm,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
-					  unsigned long addr, pte_t *ptep,
+					  unsigned long addr, hw_pte_t *ptep,
 					  unsigned int nr, cydp_t flags)
 {
 	pte_t pte;
@@ -698,7 +699,7 @@ static inline void clear_young_dirty_ptes(struct vm_a=
rea_struct *vma,
 #endif
=20
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      hw_pte_t *ptep)
 {
 	pte_t pte =3D ptep_get(ptep);
=20
@@ -739,7 +740,7 @@ static inline void ptep_clear(struct mm_struct *mm, u=
nsigned long addr,
  * present bit set *unless* it is 'l'. Because get_user_pages_fast() onl=
y
  * operates on present ptes we're safe.
  */
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(hw_pte_t *ptep)
 {
 	pte_t pte;
=20
@@ -777,7 +778,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
  * We require that the PTE can be read atomically.
  */
 #ifndef ptep_get_lockless
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(hw_pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
@@ -844,7 +845,8 @@ static inline pud_t pudp_huge_get_and_clear_full(stru=
ct vm_area_struct *vma,
=20
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
-					    unsigned long address, pte_t *ptep,
+					    unsigned long address,
+					    hw_pte_t *ptep,
 					    int full)
 {
 	return ptep_get_and_clear(mm, address, ptep);
@@ -872,7 +874,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm=
_struct *mm,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr, int full)
 {
 	pte_t pte, tmp_pte;
=20
@@ -908,7 +910,7 @@ static inline pte_t get_and_clear_full_ptes(struct mm=
_struct *mm,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline pte_t get_and_clear_ptes(struct mm_struct *mm, unsigned lo=
ng addr,
-		pte_t *ptep, unsigned int nr)
+		hw_pte_t *ptep, unsigned int nr)
 {
 	return get_and_clear_full_ptes(mm, addr, ptep, nr, 0);
 }
@@ -933,7 +935,7 @@ static inline pte_t get_and_clear_ptes(struct mm_stru=
ct *mm, unsigned long addr,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline void clear_full_ptes(struct mm_struct *mm, unsigned long a=
ddr,
-		pte_t *ptep, unsigned int nr, int full)
+		hw_pte_t *ptep, unsigned int nr, int full)
 {
 	for (;;) {
 		ptep_get_and_clear_full(mm, addr, ptep, full);
@@ -962,7 +964,7 @@ static inline void clear_full_ptes(struct mm_struct *=
mm, unsigned long addr,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline void clear_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, unsigned int nr)
+		hw_pte_t *ptep, unsigned int nr)
 {
 	clear_full_ptes(mm, addr, ptep, nr, 0);
 }
@@ -977,13 +979,14 @@ static inline void clear_ptes(struct mm_struct *mm,=
 unsigned long addr,
  */
 #ifndef update_mmu_tlb_range
 static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
-				unsigned long address, pte_t *ptep, unsigned int nr)
+				unsigned long address, hw_pte_t *ptep,
+				unsigned int nr)
 {
 }
 #endif
=20
 static inline void update_mmu_tlb(struct vm_area_struct *vma,
-				unsigned long address, pte_t *ptep)
+				unsigned long address, hw_pte_t *ptep)
 {
 	update_mmu_tlb_range(vma, address, ptep, 1);
 }
@@ -1000,7 +1003,7 @@ static inline void update_mmu_tlb(struct vm_area_st=
ruct *vma,
  * The PTEs are all in the same PMD.
  */
 static inline void clear_nonpresent_ptes(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	(void)addr;
=20
@@ -1016,7 +1019,7 @@ static inline void clear_nonpresent_ptes(struct mm_=
struct *mm,
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
 			      unsigned long address,
-			      pte_t *ptep);
+			      hw_pte_t *ptep);
 #endif
=20
 #ifndef __HAVE_ARCH_PMDP_HUGE_CLEAR_FLUSH
@@ -1044,7 +1047,8 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd, struct v=
m_area_struct *vma)
=20
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned lon=
g address, pte_t *ptep)
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned lon=
g address,
+				      hw_pte_t *ptep)
 {
 	pte_t old_pte =3D ptep_get(ptep);
 	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
@@ -1070,7 +1074,7 @@ static inline void ptep_set_wrprotect(struct mm_str=
uct *mm, unsigned long addres
  * ptep_try_set as an identity macro. The generic stub returns false, wh=
ich is
  * correct for callers that fall through to oops on failure.
  */
-static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
+static inline bool ptep_try_set(hw_pte_t *ptep, pte_t new_pte)
 {
 	return false;
 }
@@ -1113,7 +1117,7 @@ static inline void flush_tlb_before_set(unsigned lo=
ng addr)
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long ad=
dr,
-		pte_t *ptep, unsigned int nr)
+		hw_pte_t *ptep, unsigned int nr)
 {
 	for (;;) {
 		ptep_set_wrprotect(mm, addr, ptep);
@@ -1144,7 +1148,7 @@ static inline void wrprotect_ptes(struct mm_struct =
*mm, unsigned long addr,
  * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
  */
 static inline bool clear_flush_young_ptes(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	bool young =3D false;
=20
@@ -1181,7 +1185,7 @@ static inline bool clear_flush_young_ptes(struct vm=
_area_struct *vma,
  * Returns: whether any PTE was young.
  */
 static inline bool test_and_clear_young_ptes(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	bool young =3D false;
=20
@@ -1585,7 +1589,7 @@ static inline int pmd_none_or_clear_bad(pmd_t *pmd)
=20
 static inline pte_t __ptep_modify_prot_start(struct vm_area_struct *vma,
 					     unsigned long addr,
-					     pte_t *ptep)
+					     hw_pte_t *ptep)
 {
 	/*
 	 * Get the current pte state, but zero it out to make it
@@ -1597,7 +1601,7 @@ static inline pte_t __ptep_modify_prot_start(struct=
 vm_area_struct *vma,
=20
 static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
 					     unsigned long addr,
-					     pte_t *ptep, pte_t pte)
+					     hw_pte_t *ptep, pte_t pte)
 {
 	/*
 	 * The pte is non-present, so there's no hardware state to
@@ -1623,7 +1627,7 @@ static inline void __ptep_modify_prot_commit(struct=
 vm_area_struct *vma,
  */
 static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 					   unsigned long addr,
-					   pte_t *ptep)
+					   hw_pte_t *ptep)
 {
 	return __ptep_modify_prot_start(vma, addr, ptep);
 }
@@ -1636,7 +1640,8 @@ static inline pte_t ptep_modify_prot_start(struct v=
m_area_struct *vma,
  */
 static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 					   unsigned long addr,
-					   pte_t *ptep, pte_t old_pte, pte_t pte)
+					   hw_pte_t *ptep, pte_t old_pte,
+					   pte_t pte)
 {
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
@@ -1667,7 +1672,7 @@ static inline void ptep_modify_prot_commit(struct v=
m_area_struct *vma,
  */
 #ifndef modify_prot_start_ptes
 static inline pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	pte_t pte, tmp_pte;
=20
@@ -1707,7 +1712,7 @@ static inline pte_t modify_prot_start_ptes(struct v=
m_area_struct *vma,
  */
 #ifndef modify_prot_commit_ptes
 static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, u=
nsigned long addr,
-		pte_t *ptep, pte_t old_pte, pte_t pte, unsigned int nr)
+		hw_pte_t *ptep, pte_t old_pte, pte_t pte, unsigned int nr)
 {
 	int i;
=20
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0b332770abee..d28a7fb6f2c0 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -868,7 +868,7 @@ struct page_vma_mapped_walk {
 	struct vm_area_struct *vma;
 	unsigned long address;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
 	spinlock_t *ptl;
 	unsigned int flags;
 	bool pgoff_is_anon : 1;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index e7d0d529f3e0..40d2fd920558 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -216,7 +216,8 @@ static inline swp_entry_t make_migration_entry_dirty(=
swp_entry_t entry)
=20
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsign=
ed long addr, pte_t *pte);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsign=
ed long addr,
+				      hw_pte_t *pte);
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -236,7 +237,8 @@ static inline swp_entry_t make_writable_migration_ent=
ry(pgoff_t offset)
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd=
,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
-					     unsigned long addr, pte_t *pte) { }
+					     unsigned long addr,
+					     hw_pte_t *pte) { }
=20
 static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 {
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index aed121d729b0..666ff2b3741d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -8,7 +8,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/llist.h>
-#include <asm/page.h>		/* pgprot_t */
+#include <linux/pgtable_types.h>	/* pgprot_t, hw_pte_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
=20
@@ -120,7 +120,7 @@ static inline unsigned long arch_vmap_pte_range_map_s=
ize(unsigned long addr, uns
=20
 #ifndef arch_vmap_pte_range_unmap_size
 static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long=
 addr,
-							   pte_t *ptep)
+							   hw_pte_t *ptep)
 {
 	return PAGE_SIZE;
 }
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index ad384969e2cb..1972d50b043a 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -138,10 +138,10 @@ TRACE_EVENT(xen_mc_extend_args,
 TRACE_DEFINE_SIZEOF(pteval_t);
=20
 TRACE_EVENT(xen_mmu_set_pte,
-	    TP_PROTO(pte_t *ptep, pte_t pteval),
+	    TP_PROTO(hw_pte_t *ptep, pte_t pteval),
 	    TP_ARGS(ptep, pteval),
 	    TP_STRUCT__entry(
-		    __field(pte_t *, ptep)
+		    __field(hw_pte_t *, ptep)
 		    __field(pteval_t, pteval)
 		    ),
 	    TP_fast_assign(__entry->ptep =3D ptep;
@@ -207,12 +207,12 @@ TRACE_EVENT(xen_mmu_set_p4d,
=20
 DECLARE_EVENT_CLASS(xen_mmu_ptep_modify_prot,
 	    TP_PROTO(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pteval),
+		     hw_pte_t *ptep, pte_t pteval),
 	    TP_ARGS(mm, addr, ptep, pteval),
 	    TP_STRUCT__entry(
 		    __field(struct mm_struct *, mm)
 		    __field(unsigned long, addr)
-		    __field(pte_t *, ptep)
+		    __field(hw_pte_t *, ptep)
 		    __field(pteval_t, pteval)
 		    ),
 	    TP_fast_assign(__entry->mm =3D mm;
@@ -227,7 +227,7 @@ DECLARE_EVENT_CLASS(xen_mmu_ptep_modify_prot,
 #define DEFINE_XEN_MMU_PTEP_MODIFY_PROT(name)				\
 	DEFINE_EVENT(xen_mmu_ptep_modify_prot, name,			\
 		     TP_PROTO(struct mm_struct *mm, unsigned long addr,	\
-			      pte_t *ptep, pte_t pteval),		\
+			      hw_pte_t *ptep, pte_t pteval),		\
 		     TP_ARGS(mm, addr, ptep, pteval))
=20
 DEFINE_XEN_MMU_PTEP_MODIFY_PROT(xen_mmu_ptep_modify_prot_start);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..62005229b2e9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -155,7 +155,7 @@ struct clear_range_data {
 	struct llist_head *free_pages;
 };
=20
-static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data=
)
+static int apply_range_set_cb(hw_pte_t *pte, unsigned long addr, void *d=
ata)
 {
 	struct apply_range_data *d =3D data;
 	struct page *page;
@@ -207,7 +207,7 @@ static void flush_vmap_cache(unsigned long start, uns=
igned long size)
 	flush_cache_vmap(start, start + size);
 }
=20
-static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *da=
ta)
+static int apply_range_clear_cb(hw_pte_t *pte, unsigned long addr, void =
*data)
 {
 	struct clear_range_data *d =3D data;
 	pte_t old_pte;
@@ -238,7 +238,8 @@ static int apply_range_clear_cb(pte_t *pte, unsigned =
long addr, void *data)
 	return 0;
 }
=20
-static int apply_range_set_scratch_cb(pte_t *pte, unsigned long addr, vo=
id *data)
+static int apply_range_set_scratch_cb(hw_pte_t *pte, unsigned long addr,
+				      void *data)
 {
 	struct page *scratch_page =3D data;
=20
@@ -340,7 +341,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
 	return ERR_PTR(err);
 }
=20
-static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
+static int existing_page_cb(hw_pte_t *ptep, unsigned long addr, void *da=
ta)
 {
 	struct bpf_arena *arena =3D data;
 	struct page *page;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f..0eaa0e745423 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8534,7 +8534,8 @@ static u64 perf_get_pgtable_size(struct mm_struct *=
mm, unsigned long addr)
 	p4d_t *p4dp, p4d;
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	pgdp =3D pgd_offset(mm, addr);
 	pgd =3D pgdp_get(pgdp);
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8fc61d06d358..2c73842dd2aa 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -39,7 +39,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	return folio;
 }
=20
-void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned l=
ong addr)
+void damon_ptep_mkold(hw_pte_t *pte, struct vm_area_struct *vma, unsigne=
d long addr)
 {
 	pte_t pteval =3D ptep_get(pte);
 	struct folio *folio;
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 38d295488fa1..34b7e5715fcf 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -7,7 +7,7 @@
=20
 struct folio *damon_get_folio(unsigned long pfn);
=20
-void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned l=
ong addr);
+void damon_ptep_mkold(hw_pte_t *pte, struct vm_area_struct *vma, unsigne=
d long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned l=
ong addr);
 void damon_folio_mkold(struct folio *folio);
 bool damon_folio_young(struct folio *folio);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 04ee2a2c6a4d..3ce4be80d80d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -268,7 +268,7 @@ static void damon_va_walk_page_range(struct mm_struct=
 *mm, unsigned long start,
 static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	spinlock_t *ptl;
=20
 	ptl =3D pmd_trans_huge_lock(pmd, walk->vma);
@@ -306,7 +306,7 @@ static bool damon_hugetlb_ptep_mkold(pte_t *pte, stru=
ct mm_struct *mm,
 	return true;
 }
=20
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_hugetlb_mkold(hw_pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced =3D false;
@@ -327,7 +327,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm=
_struct *mm,
 	folio_put(folio);
 }
=20
-static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int damon_mkold_hugetlb_entry(hw_pte_t *pte, unsigned long hmask,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
 {
@@ -396,7 +396,7 @@ struct damon_young_walk_private {
 static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	pte_t ptent;
 	spinlock_t *ptl;
 	struct folio *folio;
@@ -440,7 +440,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned=
 long addr,
 }
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int damon_young_hugetlb_entry(hw_pte_t *pte, unsigned long hmask,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
 {
@@ -529,7 +529,7 @@ static unsigned int damon_va_check_accesses(struct da=
mon_ctx *ctx)
=20
 static bool damos_va_filter_young_match(struct damos_filter *filter,
 		struct folio *folio, struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
+		unsigned long addr, hw_pte_t *ptep, pmd_t *pmdp)
 {
 	bool young =3D false;
=20
@@ -551,7 +551,7 @@ static bool damos_va_filter_young_match(struct damos_=
filter *filter,
=20
 static bool damos_va_filter_out(struct damos *scheme, struct folio *foli=
o,
 		struct vm_area_struct *vma, unsigned long addr,
-		pte_t *ptep, pmd_t *pmdp)
+		hw_pte_t *ptep, pmd_t *pmdp)
 {
 	struct damos_filter *filter;
 	bool matched;
@@ -648,7 +648,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
 	struct damos_migrate_dests *dests =3D &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pte_t *start_pte, *pte, ptent;
+	hw_pte_t *start_pte, *pte;
+	pte_t ptent;
 	int nr;
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -808,7 +809,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsign=
ed long addr,
 	struct vm_area_struct *vma =3D walk->vma;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pte_t *start_pte, *pte, ptent;
+	hw_pte_t *start_pte, *pte;
+	pte_t ptent;
 	int nr;
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 2875fd22d7bb..54e194d2a585 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -50,7 +50,7 @@ struct pgtable_debug_args {
 	p4d_t			*p4dp;
 	pud_t			*pudp;
 	pmd_t			*pmdp;
-	pte_t			*ptep;
+	hw_pte_t		*ptep;
=20
 	p4d_t			*start_p4dp;
 	pud_t			*start_pudp;
diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..98f89dcc5560 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3490,7 +3490,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(st=
ruct vm_fault *vmf)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
 	vm_fault_t ret =3D 0;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	/*
 	 * We might have COW'ed a pagecache folio and might now have an mlocked
@@ -3796,7 +3796,7 @@ static vm_fault_t filemap_map_folio_range(struct vm=
_fault *vmf,
 	vm_fault_t ret =3D 0;
 	struct page *page =3D folio_page(folio, start);
 	unsigned int count =3D 0;
-	pte_t *old_ptep =3D vmf->pte;
+	hw_pte_t *old_ptep =3D vmf->pte;
 	unsigned long addr0;
=20
 	/*
diff --git a/mm/gup.c b/mm/gup.c
index eb898ea1ee22..8108e4015d4e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -761,7 +761,7 @@ static struct page *follow_huge_pmd(struct vm_area_st=
ruct *vma,
 #endif	/* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
=20
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long addr=
ess,
-		pte_t *pte, unsigned int flags)
+		hw_pte_t *pte, unsigned int flags)
 {
 	if (flags & FOLL_TOUCH) {
 		pte_t orig_entry =3D ptep_get(pte);
@@ -806,7 +806,8 @@ static struct page *follow_page_pte(struct vm_area_st=
ruct *vma,
 	struct folio *folio;
 	struct page *page;
 	spinlock_t *ptl;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
 	int ret;
=20
 	ptep =3D pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -1035,7 +1036,7 @@ static int get_gate_page(struct mm_struct *mm, unsi=
gned long address,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
 	pte_t entry;
 	int ret =3D -EFAULT;
=20
@@ -2831,7 +2832,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmd=
p, unsigned long addr,
 		int *nr)
 {
 	int ret =3D 0;
-	pte_t *ptep, *ptem;
+	hw_pte_t *ptep, *ptem;
=20
 	ptem =3D ptep =3D pte_offset_map(&pmd, addr);
 	if (!ptep)
diff --git a/mm/highmem.c b/mm/highmem.c
index a33e41183951..87f94cac6106 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(__totalhigh_pages);
 static int pkmap_count[LAST_PKMAP];
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
=20
-pte_t *pkmap_page_table;
+hw_pte_t *pkmap_page_table;
=20
 /*
  * Most architectures have no use for kmap_high_get(), so let's abstract
@@ -532,9 +532,9 @@ static inline bool kmap_high_unmap_local(unsigned lon=
g vaddr)
 	return false;
 }
=20
-static pte_t *__kmap_pte;
+static hw_pte_t *__kmap_pte;
=20
-static pte_t *kmap_get_pte(unsigned long vaddr, int idx)
+static hw_pte_t *kmap_get_pte(unsigned long vaddr, int idx)
 {
 	if (IS_ENABLED(CONFIG_KMAP_LOCAL_NON_LINEAR_PTE_ARRAY))
 		/*
@@ -549,8 +549,9 @@ static pte_t *kmap_get_pte(unsigned long vaddr, int i=
dx)
=20
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
-	pte_t pteval, *kmap_pte;
 	unsigned long vaddr;
+	hw_pte_t *kmap_pte;
+	pte_t pteval;
 	int idx;
=20
 	/*
@@ -597,7 +598,7 @@ EXPORT_SYMBOL(__kmap_local_page_prot);
 void kunmap_local_indexed(const void *vaddr)
 {
 	unsigned long addr =3D (unsigned long) vaddr & PAGE_MASK;
-	pte_t *kmap_pte;
+	hw_pte_t *kmap_pte;
 	int idx;
=20
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
@@ -646,7 +647,7 @@ EXPORT_SYMBOL(kunmap_local_indexed);
 void __kmap_local_sched_out(void)
 {
 	struct task_struct *tsk =3D current;
-	pte_t *kmap_pte;
+	hw_pte_t *kmap_pte;
 	int i;
=20
 	/* Clear kmaps */
@@ -683,7 +684,7 @@ void __kmap_local_sched_out(void)
 void __kmap_local_sched_in(void)
 {
 	struct task_struct *tsk =3D current;
-	pte_t *kmap_pte;
+	hw_pte_t *kmap_pte;
 	int i;
=20
 	/* Restore kmaps */
diff --git a/mm/hmm.c b/mm/hmm.c
index 2f1e98c6b644..0c959611eda0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -240,7 +240,7 @@ static inline unsigned long pte_to_hmm_pfn_flags(stru=
ct hmm_range *range,
 }
=20
 static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
-			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
+			      unsigned long end, pmd_t *pmdp, hw_pte_t *ptep,
 			      unsigned long *hmm_pfn)
 {
 	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
@@ -411,7 +411,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		&range->hmm_pfns[(start - range->start) >> PAGE_SHIFT];
 	unsigned long npages =3D (end - start) >> PAGE_SHIFT;
 	unsigned long addr =3D start;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pmd_t pmd;
=20
 again:
@@ -547,7 +547,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned lon=
g start, unsigned long end,
 #endif
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int hmm_vma_walk_hugetlb_entry(hw_pte_t *pte, unsigned long hmask=
,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a..b70ea24f73fa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3142,7 +3142,7 @@ static void __split_huge_zero_page_pmd(struct vm_ar=
ea_struct *vma,
 	pgtable_t pgtable;
 	pmd_t _pmd, old_pmd;
 	unsigned long addr;
-	pte_t *pte;
+	hw_pte_t *pte;
 	int i;
=20
 	/*
@@ -3192,7 +3192,7 @@ static void __split_huge_pmd_locked(struct vm_area_=
struct *vma, pmd_t *pmd,
 	bool soft_dirty, uffd_wp =3D false, young =3D false, write =3D false;
 	bool anon_exclusive =3D false, dirty =3D false;
 	unsigned long addr;
-	pte_t *pte;
+	hw_pte_t *pte;
 	int i;
=20
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cea25773a6c9..1e5048861b07 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -120,7 +120,7 @@ static void hugetlb_vma_lock_free(struct vm_area_stru=
ct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static int __huge_pmd_unshare(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		struct vm_area_struct *vma, unsigned long addr, hw_pte_t *ptep,
 		bool check_locks);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
@@ -4853,7 +4853,7 @@ static pte_t make_huge_pte(struct vm_area_struct *v=
ma, struct folio *folio,
 }
=20
 static void set_huge_ptep_writable(struct vm_area_struct *vma,
-				   unsigned long address, pte_t *ptep)
+				   unsigned long address, hw_pte_t *ptep)
 {
 	pte_t entry;
=20
@@ -4863,14 +4863,14 @@ static void set_huge_ptep_writable(struct vm_area=
_struct *vma,
 }
=20
 static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+					 unsigned long address, hw_pte_t *ptep)
 {
 	if (vma->vm_flags & VM_WRITE)
 		set_huge_ptep_writable(vma, address, ptep);
 }
=20
 static void
-hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned =
long addr,
+hugetlb_install_folio(struct vm_area_struct *vma, hw_pte_t *ptep, unsign=
ed long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
 {
 	pte_t newpte =3D make_huge_pte(vma, new_folio, true);
@@ -4896,7 +4896,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, =
struct mm_struct *src,
 			    struct vm_area_struct *dst_vma,
 			    struct vm_area_struct *src_vma)
 {
-	pte_t *src_pte, *dst_pte, entry;
+	hw_pte_t *src_pte, *dst_pte;
+	pte_t entry;
 	struct folio *pte_folio;
 	unsigned long addr;
 	bool cow =3D vma_is_cow_mapping(src_vma);
@@ -5088,7 +5089,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, =
struct mm_struct *src,
 }
=20
 static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_=
addr,
-			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
+			  unsigned long new_addr, hw_pte_t *src_pte,
+			  hw_pte_t *dst_pte,
 			  unsigned long sz)
 {
 	bool need_clear_uffd_wp =3D vma_has_uffd_without_event_remap(vma);
@@ -5150,7 +5152,7 @@ int move_hugetlb_page_tables(struct vm_area_struct =
*vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long old_end =3D old_addr + len;
 	unsigned long last_addr_mask;
-	pte_t *src_pte, *dst_pte;
+	hw_pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
=20
@@ -5214,7 +5216,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	const bool folio_provided =3D !!folio;
 	unsigned long address;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t pte;
 	spinlock_t *ptl;
 	struct hstate *h =3D hstate_vma(vma);
@@ -5748,7 +5750,7 @@ static inline vm_fault_t hugetlb_handle_userfault(s=
truct vm_fault *vmf,
  * false if pte changed or is changing.
  */
 static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, u=
nsigned long addr,
-			       pte_t *ptep, pte_t old_pte)
+			       hw_pte_t *ptep, pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
@@ -6273,7 +6275,7 @@ static struct folio *alloc_hugetlb_folio_vma(struct=
 hstate *h,
  * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_ato=
mic_pte
  * with modifications for hugetlb pages.
  */
-int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(hw_pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -6332,7 +6334,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
=20
 		folio =3D alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
-			pte_t *actual_pte =3D hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
+			hw_pte_t *actual_pte =3D hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
 			if (actual_pte) {
 				ret =3D -EEXIST;
 				goto out;
@@ -6500,7 +6502,7 @@ long hugetlb_change_protection(struct vm_area_struc=
t *vma,
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long start =3D address;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t pte;
 	struct hstate *h =3D hstate_vma(vma);
 	long pages =3D 0, psize =3D huge_page_size(h);
@@ -6985,15 +6987,15 @@ void adjust_range_if_pmd_sharing_possible(struct =
vm_area_struct *vma,
  * racing tasks could either miss the sharing (see huge_pte_offset) or s=
elect a
  * bad pmd for sharing.
  */
-pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 		      unsigned long addr, pud_t *pud)
 {
 	struct address_space *mapping =3D vma->vm_file->f_mapping;
 	const pgoff_t idx =3D linear_page_index(vma, addr);
 	struct vm_area_struct *svma;
 	unsigned long saddr;
-	pte_t *spte =3D NULL;
-	pte_t *pte;
+	hw_pte_t *spte =3D NULL;
+	hw_pte_t *pte;
=20
 	i_mmap_lock_read(mapping);
 	mapping_rmap_tree_foreach(svma, mapping, idx, idx) {
@@ -7024,13 +7026,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struc=
t vm_area_struct *vma,
 	}
 	spin_unlock(&mm->page_table_lock);
 out:
-	pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
+	pte =3D (hw_pte_t *)pmd_alloc(mm, pud, addr);
 	i_mmap_unlock_read(mapping);
 	return pte;
 }
=20
 static int __huge_pmd_unshare(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		struct vm_area_struct *vma, unsigned long addr, hw_pte_t *ptep,
 		bool check_locks)
 {
 	unsigned long sz =3D huge_page_size(hstate_vma(vma));
@@ -7071,7 +7073,7 @@ static int __huge_pmd_unshare(struct mmu_gather *tl=
b,
  *	    was not a shared PMD table.
  */
 int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, hw_pte_t *ptep)
 {
 	return __huge_pmd_unshare(tlb, vma, addr, ptep, /*check_locks=3D*/true)=
;
 }
@@ -7101,21 +7103,21 @@ void huge_pmd_unshare_flush(struct mmu_gather *tl=
b, struct vm_area_struct *vma)
=20
 #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
=20
-pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 		      unsigned long addr, pud_t *pud)
 {
 	return NULL;
 }
=20
 static int __huge_pmd_unshare(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		struct vm_area_struct *vma, unsigned long addr, hw_pte_t *ptep,
 		bool check_locks)
 {
 	return 0;
 }
=20
 int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, hw_pte_t *ptep)
 {
 	return 0;
 }
@@ -7136,13 +7138,13 @@ bool want_pmd_share(struct vm_area_struct *vma, u=
nsigned long addr)
 #endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
=20
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
-	pte_t *pte =3D NULL;
+	hw_pte_t *pte =3D NULL;
=20
 	pgd =3D pgd_offset(mm, addr);
 	p4d =3D p4d_alloc(mm, pgd, addr);
@@ -7151,13 +7153,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struc=
t vm_area_struct *vma,
 	pud =3D pud_alloc(mm, p4d, addr);
 	if (pud) {
 		if (sz =3D=3D PUD_SIZE) {
-			pte =3D (pte_t *)pud;
+			pte =3D (hw_pte_t *)pud;
 		} else {
 			BUG_ON(sz !=3D PMD_SIZE);
 			if (want_pmd_share(vma, addr) && pud_none(*pud))
 				pte =3D huge_pmd_share(mm, vma, addr, pud);
 			else
-				pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
+				pte =3D (hw_pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
=20
@@ -7179,7 +7181,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct =
vm_area_struct *vma,
  * size @sz doesn't match the hugepage size at this level of the page
  * table.
  */
-pte_t *huge_pte_offset(struct mm_struct *mm,
+hw_pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
@@ -7197,14 +7199,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	pud =3D pud_offset(p4d, addr);
 	if (sz =3D=3D PUD_SIZE)
 		/* must be pud huge, non-present or none */
-		return (pte_t *)pud;
+		return (hw_pte_t *)pud;
 	if (!pud_present(*pud))
 		return NULL;
 	/* must have a valid entry and size to go further */
=20
 	pmd =3D pmd_offset(pud, addr);
 	/* must be pmd huge, non-present or none */
-	return (pte_t *)pmd;
+	return (hw_pte_t *)pmd;
 }
=20
 /*
@@ -7383,7 +7385,7 @@ static void hugetlb_unshare_pmds(struct vm_area_str=
uct *vma,
 	struct mmu_gather tlb;
 	unsigned long address;
 	spinlock_t *ptl;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 917db0984143..2850c19c4528 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -33,7 +33,7 @@
  *			operations.
  */
 struct vmemmap_remap_walk {
-	void			(*remap_pte)(pte_t *pte, unsigned long addr,
+	void			(*remap_pte)(hw_pte_t *pte, unsigned long addr,
 					     struct vmemmap_remap_walk *walk);
=20
 	unsigned long		nr_walked;
@@ -55,7 +55,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *h=
ead, unsigned long start,
 	pmd_t __pmd;
 	int i;
 	unsigned long addr =3D start;
-	pte_t *pgtable;
+	hw_pte_t *pgtable;
=20
 	pgtable =3D pte_alloc_one_kernel(&init_mm);
 	if (!pgtable)
@@ -64,7 +64,8 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *h=
ead, unsigned long start,
 	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
=20
 	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D PAGE_SIZE) {
-		pte_t entry, *pte;
+		pte_t entry;
+		hw_pte_t *pte;
 		pgprot_t pgprot =3D PAGE_KERNEL;
=20
 		entry =3D mk_pte(head + i, pgprot);
@@ -136,7 +137,7 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned lon=
g addr,
 	return vmemmap_split_pmd(pmd, head, addr & PMD_MASK, vmemmap_walk);
 }
=20
-static int vmemmap_pte_entry(pte_t *pte, unsigned long addr,
+static int vmemmap_pte_entry(hw_pte_t *pte, unsigned long addr,
 			     unsigned long next, struct mm_walk *walk)
 {
 	struct vmemmap_remap_walk *vmemmap_walk =3D walk->private;
@@ -198,7 +199,7 @@ static void free_vmemmap_page_list(struct list_head *=
list)
 		free_vmemmap_page(page);
 }
=20
-static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
+static void vmemmap_remap_pte(hw_pte_t *pte, unsigned long addr,
 			      struct vmemmap_remap_walk *walk)
 {
 	struct page *page =3D pte_page(ptep_get(pte));
@@ -232,7 +233,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned lo=
ng addr,
 	set_pte_at(&init_mm, addr, pte, entry);
 }
=20
-static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
+static void vmemmap_restore_pte(hw_pte_t *pte, unsigned long addr,
 				struct vmemmap_remap_walk *walk)
 {
 	struct page *src =3D pte_page(ptep_get(pte)), *dst;
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..c4a3adc6e586 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -274,7 +274,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_=
desc *unmap);
 #ifdef CONFIG_MMU
=20
 bool cond_install_uffd_wp_ptes(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, pte_t pte,
+		unsigned long addr, hw_pte_t *ptep, pte_t pte,
 		unsigned long nr_ptes);
=20
 static inline void get_anon_vma(struct anon_vma *anon_vma)
@@ -410,7 +410,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t p=
te, fpb_t flags)
  * Return: the number of table entries in the batch.
  */
 static inline unsigned int folio_pte_batch_flags(struct folio *folio,
-		struct vm_area_struct *vma, pte_t *ptep, pte_t *ptentp,
+		struct vm_area_struct *vma, hw_pte_t *ptep, pte_t *ptentp,
 		unsigned int max_nr, fpb_t flags)
 {
 	bool any_writable =3D false, any_young =3D false, any_dirty =3D false;
@@ -464,7 +464,7 @@ static inline unsigned int folio_pte_batch_flags(stru=
ct folio *folio,
 	return min(nr, max_nr);
 }
=20
-unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte=
,
+unsigned int folio_pte_batch(struct folio *folio, hw_pte_t *ptep, pte_t =
pte,
 		unsigned int max_nr);
=20
 /**
@@ -521,11 +521,11 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  *
  * Return: the number of table entries in the batch.
  */
-static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pt=
e)
+static inline int swap_pte_batch(hw_pte_t *start_ptep, int max_nr, pte_t=
 pte)
 {
 	pte_t expected_pte =3D pte_next_swp_offset(pte);
-	const pte_t *end_ptep =3D start_ptep + max_nr;
-	pte_t *ptep =3D start_ptep + 1;
+	const hw_pte_t *end_ptep =3D start_ptep + max_nr;
+	hw_pte_t *ptep =3D start_ptep + 1;
=20
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!softleaf_is_swap(softleaf_from_pte(pte)));
@@ -1563,7 +1563,7 @@ static inline void maybe_rmap_unlock_action(struct =
vm_area_struct *vma,
=20
 #ifdef CONFIG_MMU_NOTIFIER
 static inline bool clear_flush_young_ptes_notify(struct vm_area_struct *=
vma,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	bool young;
=20
@@ -1584,7 +1584,7 @@ static inline bool pmdp_clear_flush_young_notify(st=
ruct vm_area_struct *vma,
 }
=20
 static inline bool test_and_clear_young_ptes_notify(struct vm_area_struc=
t *vma,
-		unsigned long addr, pte_t *ptep, unsigned int nr)
+		unsigned long addr, hw_pte_t *ptep, unsigned int nr)
 {
 	bool young;
=20
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 66a883887987..30c5266eaf37 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -92,7 +92,7 @@ static __init void *early_alloc(size_t size, int node)
 static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
 				unsigned long end)
 {
-	pte_t *pte =3D pte_offset_kernel(pmd, addr);
+	hw_pte_t *pte =3D pte_offset_kernel(pmd, addr);
 	pte_t zero_pte;
=20
 	zero_pte =3D pfn_pte(PFN_DOWN(__pa_symbol(kasan_early_shadow_page)),
@@ -122,7 +122,7 @@ static int __ref zero_pmd_populate(pud_t *pud, unsign=
ed long addr,
 		}
=20
 		if (pmd_none(*pmd)) {
-			pte_t *p;
+			hw_pte_t *p;
=20
 			if (slab_is_available())
 				p =3D pte_alloc_one_kernel(&init_mm);
@@ -281,9 +281,9 @@ int __ref kasan_populate_early_shadow(const void *sha=
dow_start,
 	return 0;
 }
=20
-static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
+static void kasan_free_pte(hw_pte_t *pte_start, pmd_t *pmd)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	int i;
=20
 	for (i =3D 0; i < PTRS_PER_PTE; i++) {
@@ -341,7 +341,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *p=
gd)
 	pgd_clear(pgd);
 }
=20
-static void kasan_remove_pte_table(pte_t *pte, unsigned long addr,
+static void kasan_remove_pte_table(hw_pte_t *pte, unsigned long addr,
 				unsigned long end)
 {
 	unsigned long next;
@@ -369,7 +369,7 @@ static void kasan_remove_pmd_table(pmd_t *pmd, unsign=
ed long addr,
 	unsigned long next;
=20
 	for (; addr < end; addr =3D next, pmd++) {
-		pte_t *pte;
+		hw_pte_t *pte;
=20
 		next =3D pmd_addr_end(addr, end);
=20
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d286e0a04543..86fc7ed45dcd 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -189,7 +189,7 @@ static bool shadow_mapped(unsigned long addr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	if (pgd_none(*pgd))
 		return false;
@@ -297,7 +297,7 @@ struct vmalloc_populate_data {
 	struct page **pages;
 };
=20
-static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
+static int kasan_populate_vmalloc_pte(hw_pte_t *ptep, unsigned long addr=
,
 				      void *_data)
 {
 	struct vmalloc_populate_data *data =3D _data;
@@ -465,7 +465,7 @@ int __kasan_populate_vmalloc(unsigned long addr, unsi=
gned long size, gfp_t gfp_m
 	return 0;
 }
=20
-static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
+static int kasan_depopulate_vmalloc_pte(hw_pte_t *ptep, unsigned long ad=
dr,
 					void *unused)
 {
 	pte_t pte;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 75639298efc2..b1b042547970 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -639,8 +639,8 @@ static void release_pte_folio(struct folio *folio)
 	folio_putback_lru(folio);
 }
=20
-static void release_pte_pages(pte_t *pte, pte_t *_pte,
-		struct list_head *compound_pagelist)
+static void release_pte_pages(hw_pte_t *pte, hw_pte_t *_pte,
+			      struct list_head *compound_pagelist)
 {
 	struct folio *folio, *tmp;
=20
@@ -685,7 +685,8 @@ static void count_collapse_event(unsigned int order, =
enum vm_event_item vm_event
 }
=20
 static enum scan_result __collapse_huge_page_isolate(struct vm_area_stru=
ct *vma,
-		unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
+		unsigned long start_addr, hw_pte_t *pte,
+		struct collapse_control *cc,
 		unsigned int order, struct list_head *compound_pagelist)
 {
 	const unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, vma, or=
der);
@@ -694,7 +695,7 @@ static enum scan_result __collapse_huge_page_isolate(=
struct vm_area_struct *vma,
 	struct page *page =3D NULL;
 	struct folio *folio =3D NULL;
 	unsigned long addr =3D start_addr;
-	pte_t *_pte;
+	hw_pte_t *_pte;
 	int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
 	enum scan_result result =3D SCAN_FAIL;
=20
@@ -840,16 +841,18 @@ static enum scan_result __collapse_huge_page_isolat=
e(struct vm_area_struct *vma,
 	return result;
 }
=20
-static void __collapse_huge_page_copy_succeeded(pte_t *pte,
-		struct vm_area_struct *vma, unsigned long address,
-		spinlock_t *ptl, unsigned int order,
-		struct list_head *compound_pagelist)
+static void __collapse_huge_page_copy_succeeded(hw_pte_t *pte,
+						struct vm_area_struct *vma,
+						unsigned long address,
+						spinlock_t *ptl,
+						unsigned int order,
+						struct list_head *compound_pagelist)
 {
 	const unsigned long nr_pages =3D 1UL << order;
 	unsigned long end =3D address + (PAGE_SIZE * nr_pages);
 	struct folio *src, *tmp;
 	pte_t pteval;
-	pte_t *_pte;
+	hw_pte_t *_pte;
 	unsigned int nr_ptes;
=20
 	for (_pte =3D pte; _pte < pte + nr_pages; _pte +=3D nr_ptes,
@@ -904,9 +907,11 @@ static void __collapse_huge_page_copy_succeeded(pte_=
t *pte,
 	}
 }
=20
-static void __collapse_huge_page_copy_failed(pte_t *pte,
-		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
-		unsigned int order, struct list_head *compound_pagelist)
+static void __collapse_huge_page_copy_failed(hw_pte_t *pte,
+					     pmd_t *pmd, pmd_t orig_pmd,
+					     struct vm_area_struct *vma,
+					     unsigned int order,
+					     struct list_head *compound_pagelist)
 {
 	const unsigned long nr_pages =3D 1UL << order;
 	spinlock_t *pmd_ptl;
@@ -942,10 +947,14 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
  * @ptl: lock on raw pages' PTEs
  * @compound_pagelist: list that stores compound pages
  */
-static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct fol=
io *folio,
-		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
-		unsigned long address, spinlock_t *ptl, unsigned int order,
-		struct list_head *compound_pagelist)
+static enum scan_result __collapse_huge_page_copy(hw_pte_t *pte,
+						  struct folio *folio,
+						  pmd_t *pmd, pmd_t orig_pmd,
+						  struct vm_area_struct *vma,
+						  unsigned long address,
+						  spinlock_t *ptl,
+						  unsigned int order,
+						  struct list_head *compound_pagelist)
 {
 	const unsigned long nr_pages =3D 1UL << order;
 	unsigned int i;
@@ -1164,7 +1173,7 @@ static enum scan_result __collapse_huge_page_swapin=
(struct mm_struct *mm,
 	vm_fault_t ret =3D 0;
 	unsigned long addr, end =3D start_addr + (PAGE_SIZE << order);
 	enum scan_result result;
-	pte_t *pte =3D NULL;
+	hw_pte_t *pte =3D NULL;
 	spinlock_t *ptl;
=20
 	for (addr =3D start_addr; addr < end; addr +=3D PAGE_SIZE) {
@@ -1292,7 +1301,7 @@ static enum scan_result collapse_huge_page(struct m=
m_struct *mm, unsigned long s
 	const unsigned long end_addr =3D start_addr + (PAGE_SIZE << order);
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
-	pte_t *pte =3D NULL;
+	hw_pte_t *pte =3D NULL;
 	pgtable_t pgtable;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
@@ -1606,7 +1615,8 @@ static enum scan_result collapse_scan_pmd(struct mm=
_struct *mm,
 	unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, vma, HPAGE_PM=
D_ORDER);
 	enum tva_type tva_flags =3D cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FO=
RCED_COLLAPSE;
 	pmd_t *pmd;
-	pte_t *pte, *_pte, pteval;
+	hw_pte_t *pte, *_pte;
+	pte_t pteval;
 	int i;
 	int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
 	enum scan_result result =3D SCAN_FAIL;
@@ -1860,7 +1870,7 @@ static enum scan_result try_collapse_pte_mapped_thp=
(struct mm_struct *mm, unsign
 	unsigned long end =3D haddr + HPAGE_PMD_SIZE;
 	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct folio *folio;
-	pte_t *start_pte, *pte;
+	hw_pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
 	spinlock_t *pml =3D NULL, *ptl;
 	int i;
diff --git a/mm/ksm.c b/mm/ksm.c
index 892bf4a0d6e4..e78708651498 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -618,7 +618,7 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned =
long addr, unsigned long en
 {
 	unsigned long *found_addr =3D (unsigned long *) walk->private;
 	struct mm_struct *mm =3D walk->mm;
-	pte_t *start_ptep, *ptep;
+	hw_pte_t *start_ptep, *ptep;
 	spinlock_t *ptl;
 	int found =3D 0;
=20
@@ -1398,7 +1398,7 @@ static int replace_page(struct vm_area_struct *vma,=
 struct page *page,
 	struct folio *folio =3D page_folio(page);
 	pmd_t *pmd;
 	pmd_t pmde;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t newpte;
 	spinlock_t *ptl;
 	unsigned long addr;
@@ -2529,7 +2529,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, uns=
igned long addr, unsigned lon
 {
 	struct ksm_next_page_arg *private =3D walk->private;
 	struct vm_area_struct *vma =3D walk->vma;
-	pte_t *start_ptep =3D NULL, *ptep, pte;
+	hw_pte_t *start_ptep =3D NULL, *ptep;
+	pte_t pte;
 	struct mm_struct *mm =3D walk->mm;
 	struct folio *folio;
 	struct page *page;
diff --git a/mm/madvise.c b/mm/madvise.c
index c2133b36b24a..40ce0d5940ef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -198,7 +198,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned=
 long start,
 {
 	struct vm_area_struct *vma =3D walk->private;
 	struct swap_io_ctx ctx =3D {};
-	pte_t *ptep =3D NULL;
+	hw_pte_t *ptep =3D NULL;
 	spinlock_t *ptl;
 	unsigned long addr;
=20
@@ -350,7 +350,7 @@ static inline bool can_do_file_pageout(struct vm_area=
_struct *vma)
 }
=20
 static inline int madvise_folio_pte_batch(unsigned long addr, unsigned l=
ong end,
-					  struct folio *folio, pte_t *ptep,
+					  struct folio *folio, hw_pte_t *ptep,
 					  pte_t *ptentp)
 {
 	int max_nr =3D (end - addr) / PAGE_SIZE;
@@ -368,7 +368,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
 	bool pageout =3D private->pageout;
 	struct mm_struct *mm =3D tlb->mm;
 	struct vm_area_struct *vma =3D walk->vma;
-	pte_t *start_pte, *pte, ptent;
+	hw_pte_t *start_pte, *pte;
+	pte_t ptent;
 	spinlock_t *ptl;
 	struct folio *folio =3D NULL;
 	LIST_HEAD(folio_list);
@@ -667,7 +668,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
 	struct mm_struct *mm =3D tlb->mm;
 	struct vm_area_struct *vma =3D walk->vma;
 	spinlock_t *ptl;
-	pte_t *start_pte, *pte, ptent;
+	hw_pte_t *start_pte, *pte;
+	pte_t ptent;
 	struct folio *folio;
 	int nr_swap =3D 0;
 	unsigned long next;
@@ -1092,7 +1094,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsi=
gned long addr,
 	return pmd_trans_huge(pmdval);
 }
=20
-static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
+static int guard_install_pte_entry(hw_pte_t *pte, unsigned long addr,
 				   unsigned long next, struct mm_walk *walk)
 {
 	pte_t pteval =3D ptep_get(pte);
@@ -1235,7 +1237,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsig=
ned long addr,
 	return 0;
 }
=20
-static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
+static int guard_remove_pte_entry(hw_pte_t *pte, unsigned long addr,
 				  unsigned long next, struct mm_walk *walk)
 {
 	pte_t ptent =3D ptep_get(pte);
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index e0efa36e0a07..dcbd39912f81 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -31,7 +31,7 @@ struct wp_walk {
  * The function write-protects a pte and records the range in
  * virtual address space of touched ptes for efficient range TLB flushes=
.
  */
-static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
+static int wp_pte(hw_pte_t *pte, unsigned long addr, unsigned long end,
 		  struct mm_walk *walk)
 {
 	struct wp_walk *wpwalk =3D walk->private;
@@ -86,7 +86,7 @@ struct clean_walk {
  * in the address_space, as well as the first and last of the bits
  * touched.
  */
-static int clean_record_pte(pte_t *pte, unsigned long addr,
+static int clean_record_pte(hw_pte_t *pte, unsigned long addr,
 			    unsigned long end, struct mm_walk *walk)
 {
 	struct wp_walk *wpwalk =3D walk->private;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba..a89f3fde47a5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -342,7 +342,7 @@ static unsigned long dev_pagemap_mapping_shift(struct=
 vm_area_struct *vma,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
 	pte_t ptent;
=20
 	VM_BUG_ON_VMA(address =3D=3D -EFAULT, vma);
@@ -742,7 +742,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned l=
ong addr,
 {
 	struct hwpoison_walk *hwp =3D walk->private;
 	int ret =3D 0;
-	pte_t *ptep, *mapped_pte;
+	hw_pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
=20
 	ptl =3D pmd_trans_huge_lock(pmdp, walk->vma);
@@ -770,7 +770,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned l=
ong addr,
 }
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
+static int hwpoison_hugetlb_range(hw_pte_t *ptep, unsigned long hmask,
 			    unsigned long addr, unsigned long end,
 			    struct mm_walk *walk)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 8b0c2c735d3d..48d6ca89b0fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -462,7 +462,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
=20
 int __pte_alloc_kernel(pmd_t *pmd)
 {
-	pte_t *new =3D pte_alloc_one_kernel(&init_mm);
+	hw_pte_t *new =3D pte_alloc_one_kernel(&init_mm);
 	if (!new)
 		return -ENOMEM;
=20
@@ -946,7 +946,7 @@ struct page *vm_normal_page_pud(struct vm_area_struct=
 *vma,
  */
 static void restore_exclusive_pte(struct vm_area_struct *vma,
 		struct folio *folio, struct page *page, unsigned long address,
-		pte_t *ptep, pte_t orig_pte)
+		hw_pte_t *ptep, pte_t orig_pte)
 {
 	pte_t pte;
=20
@@ -983,7 +983,7 @@ static void restore_exclusive_pte(struct vm_area_stru=
ct *vma,
  * sleeping.
  */
 static int try_restore_exclusive_pte(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, pte_t orig_pte)
+		unsigned long addr, hw_pte_t *ptep, pte_t orig_pte)
 {
 	const softleaf_t entry =3D softleaf_from_pte(orig_pte);
 	struct page *page =3D softleaf_to_page(entry);
@@ -1006,7 +1006,7 @@ static int try_restore_exclusive_pte(struct vm_area=
_struct *vma,
=20
 static unsigned long
 copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
+		hw_pte_t *dst_pte, hw_pte_t *src_pte, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
 	pte_t orig_pte =3D ptep_get(src_pte);
@@ -1120,7 +1120,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struc=
t mm_struct *src_mm,
  */
 static inline int
 copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct =
*src_vma,
-		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
+		  hw_pte_t *dst_pte, hw_pte_t *src_pte, unsigned long addr, int *rss,
 		  struct folio **prealloc, struct page *page)
 {
 	struct folio *new_folio;
@@ -1159,7 +1159,7 @@ copy_present_page(struct vm_area_struct *dst_vma, s=
truct vm_area_struct *src_vma
 }
=20
 static __always_inline void __copy_present_ptes(struct vm_area_struct *d=
st_vma,
-		struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
+		struct vm_area_struct *src_vma, hw_pte_t *dst_pte, hw_pte_t *src_pte,
 		pte_t pte, unsigned long addr, int nr)
 {
 	struct mm_struct *src_mm =3D src_vma->vm_mm;
@@ -1209,7 +1209,7 @@ static __always_inline void __copy_present_ptes(str=
uct vm_area_struct *dst_vma,
  */
 static inline int
 copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct =
*src_vma,
-		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
+		 hw_pte_t *dst_pte, hw_pte_t *src_pte, pte_t pte, unsigned long addr,
 		 int max_nr, int *rss, struct folio **prealloc)
 {
 	fpb_t flags =3D FPB_MERGE_WRITE;
@@ -1309,8 +1309,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, stru=
ct vm_area_struct *src_vma,
 {
 	struct mm_struct *dst_mm =3D dst_vma->vm_mm;
 	struct mm_struct *src_mm =3D src_vma->vm_mm;
-	pte_t *orig_src_pte, *orig_dst_pte;
-	pte_t *src_pte, *dst_pte;
+	hw_pte_t *orig_src_pte, *orig_dst_pte;
+	hw_pte_t *src_pte, *dst_pte;
 	pmd_t dummy_pmdval;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1703,7 +1703,7 @@ static inline bool zap_drop_markers(struct zap_deta=
ils *details)
  * Returns true if uffd-wp PTEs were installed, false otherwise.
  */
 bool cond_install_uffd_wp_ptes(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep, pte_t pte,
+		unsigned long addr, hw_pte_t *ptep, pte_t pte,
 		unsigned long nr_ptes)
 {
 	bool arm_uffd_pte =3D false;
@@ -1757,7 +1757,7 @@ bool cond_install_uffd_wp_ptes(struct vm_area_struc=
t *vma,
  */
 static inline bool
 zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
-			      unsigned long addr, pte_t *pte, int nr,
+			      unsigned long addr, hw_pte_t *pte, int nr,
 			      struct zap_details *details, pte_t pteval)
 {
 	if (zap_drop_markers(details))
@@ -1768,7 +1768,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct=
 *vma,
=20
 static __always_inline void zap_present_folio_ptes(struct mmu_gather *tl=
b,
 		struct vm_area_struct *vma, struct folio *folio,
-		struct page *page, pte_t *pte, pte_t ptent, unsigned int nr,
+		struct page *page, hw_pte_t *pte, pte_t ptent, unsigned int nr,
 		unsigned long addr, struct zap_details *details, int *rss,
 		bool *force_flush, bool *force_break, bool *any_skipped)
 {
@@ -1818,7 +1818,7 @@ static __always_inline void zap_present_folio_ptes(=
struct mmu_gather *tlb,
  * Returns the number of processed (skipped or zapped) PTEs (at least 1)=
.
  */
 static inline int zap_present_ptes(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
+		struct vm_area_struct *vma, hw_pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *force_flush,
 		bool *force_break, bool *any_skipped)
@@ -1864,7 +1864,7 @@ static inline int zap_present_ptes(struct mmu_gathe=
r *tlb,
 }
=20
 static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
+		struct vm_area_struct *vma, hw_pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *any_skipped)
 {
@@ -1935,7 +1935,7 @@ static inline int zap_nonpresent_ptes(struct mmu_ga=
ther *tlb,
 }
=20
 static inline int do_zap_pte_range(struct mmu_gather *tlb,
-				   struct vm_area_struct *vma, pte_t *pte,
+				   struct vm_area_struct *vma, hw_pte_t *pte,
 				   unsigned long addr, unsigned long end,
 				   struct zap_details *details, int *rss,
 				   bool *force_flush, bool *force_break,
@@ -1998,7 +1998,7 @@ static bool zap_pte_table_if_empty(struct mm_struct=
 *mm, pmd_t *pmd,
 		unsigned long addr, pmd_t *pmdval)
 {
 	spinlock_t *pml, *ptl =3D NULL;
-	pte_t *start_pte, *pte;
+	hw_pte_t *start_pte, *pte;
 	int i;
=20
 	pml =3D pmd_lock(mm, pmd);
@@ -2038,8 +2038,8 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
 	struct mm_struct *mm =3D tlb->mm;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
-	pte_t *start_pte;
-	pte_t *pte;
+	hw_pte_t *start_pte;
+	hw_pte_t *pte;
 	pmd_t pmdval;
 	unsigned long start =3D addr;
 	bool direct_reclaim =3D true;
@@ -2421,7 +2421,7 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, uns=
igned long addr)
 	return pmd;
 }
=20
-pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+hw_pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 		      spinlock_t **ptl)
 {
 	pmd_t *pmd =3D walk_to_pmd(mm, addr);
@@ -2479,7 +2479,7 @@ static int validate_page_before_insert(struct vm_ar=
ea_struct *vma,
 	return 0;
 }
=20
-static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t=
 *pte,
+static int insert_page_into_pte_locked(struct vm_area_struct *vma, hw_pt=
e_t *pte,
 				unsigned long addr, struct page *page,
 				pgprot_t prot, bool mkwrite)
 {
@@ -2524,7 +2524,7 @@ static int insert_page(struct vm_area_struct *vma, =
unsigned long addr,
 			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
-	pte_t *pte;
+	hw_pte_t *pte;
 	spinlock_t *ptl;
=20
 	retval =3D validate_page_before_insert(vma, page);
@@ -2541,7 +2541,7 @@ static int insert_page(struct vm_area_struct *vma, =
unsigned long addr,
 	return retval;
 }
=20
-static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t=
 *pte,
+static int insert_page_in_batch_locked(struct vm_area_struct *vma, hw_pt=
e_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	int err;
@@ -2559,7 +2559,7 @@ static int insert_pages(struct vm_area_struct *vma,=
 unsigned long addr,
 			struct page **pages, unsigned long *num, pgprot_t prot)
 {
 	pmd_t *pmd =3D NULL;
-	pte_t *start_pte, *pte;
+	hw_pte_t *start_pte, *pte;
 	spinlock_t *pte_lock;
 	struct mm_struct *const mm =3D vma->vm_mm;
 	unsigned long curr_page_idx =3D 0;
@@ -2802,7 +2802,8 @@ static vm_fault_t insert_pfn(struct vm_area_struct =
*vma, unsigned long addr,
 			unsigned long pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	pte_t *pte, entry;
+	hw_pte_t *pte;
+	pte_t entry;
 	spinlock_t *ptl;
=20
 	pte =3D get_locked_pte(mm, addr, &ptl);
@@ -3043,7 +3044,7 @@ static int remap_pte_range(struct mm_struct *mm, pm=
d_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
-	pte_t *pte, *mapped_pte;
+	hw_pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err =3D 0;
=20
@@ -3444,7 +3445,7 @@ static int apply_to_pte_range(struct mm_struct *mm,=
 pmd_t *pmd,
 				     pte_fn_t fn, void *data, bool create,
 				     pgtbl_mod_mask *mask)
 {
-	pte_t *pte, *mapped_pte;
+	hw_pte_t *pte, *mapped_pte;
 	int err =3D 0;
 	spinlock_t *ptl;
=20
@@ -4747,7 +4748,7 @@ static vm_fault_t handle_pte_marker(struct vm_fault=
 *vmf)
 /*
  * Check if the PTEs within a range are contiguous swap entries.
  */
-static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pag=
es)
+static bool can_swapin_thp(struct vm_fault *vmf, hw_pte_t *ptep, int nr_=
pages)
 {
 	unsigned long addr;
 	int idx;
@@ -4799,7 +4800,7 @@ static unsigned long thp_swapin_suitable_orders(str=
uct vm_fault *vmf)
 	unsigned long addr;
 	softleaf_t entry;
 	spinlock_t *ptl;
-	pte_t *pte;
+	hw_pte_t *pte;
 	int order;
=20
 	/*
@@ -4893,7 +4894,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	int nr_pages;
 	unsigned long page_idx;
 	unsigned long address;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -5056,7 +5057,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		unsigned long idx =3D folio_page_idx(folio, page);
 		unsigned long folio_start =3D address - idx * PAGE_SIZE;
 		unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
-		pte_t *folio_ptep;
+		hw_pte_t *folio_ptep;
 		pte_t folio_pte;
=20
 		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
@@ -5286,7 +5287,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	return ret;
 }
=20
-static bool pte_range_none(pte_t *pte, int nr_pages)
+static bool pte_range_none(hw_pte_t *pte, int nr_pages)
 {
 	int i;
=20
@@ -5305,7 +5306,7 @@ static struct folio *alloc_anon_folio(struct vm_fau=
lt *vmf)
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
-	pte_t *pte;
+	hw_pte_t *pte;
 	gfp_t gfp;
 	int order;
=20
@@ -5387,7 +5388,7 @@ static struct folio *alloc_anon_folio(struct vm_fau=
lt *vmf)
 	return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
 }
=20
-void map_anon_folio_pte_nopf(struct folio *folio, pte_t *pte,
+void map_anon_folio_pte_nopf(struct folio *folio, hw_pte_t *pte,
 		struct vm_area_struct *vma, unsigned long addr,
 		bool uffd_wp)
 {
@@ -5408,7 +5409,7 @@ void map_anon_folio_pte_nopf(struct folio *folio, p=
te_t *pte,
 	update_mmu_cache_range(NULL, vma, addr, pte, nr_pages);
 }
=20
-static void map_anon_folio_pte_pf(struct folio *folio, pte_t *pte,
+static void map_anon_folio_pte_pf(struct folio *folio, hw_pte_t *pte,
 		struct vm_area_struct *vma, unsigned long addr, bool uffd_wp)
 {
 	const unsigned int order =3D folio_order(folio);
@@ -6193,7 +6194,7 @@ int numa_migrate_check(struct folio *folio, struct =
vm_fault *vmf,
 }
=20
 static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_=
area_struct *vma,
-					unsigned long fault_addr, pte_t *fault_pte,
+					unsigned long fault_addr, hw_pte_t *fault_pte,
 					bool writable)
 {
 	pte_t pte, old_pte;
@@ -6215,7 +6216,7 @@ static void numa_rebuild_large_mapping(struct vm_fa=
ult *vmf, struct vm_area_stru
 	unsigned long start, end, addr =3D vmf->address;
 	unsigned long addr_start =3D addr - (nr << PAGE_SHIFT);
 	unsigned long pt_start =3D ALIGN_DOWN(addr, PMD_SIZE);
-	pte_t *start_ptep;
+	hw_pte_t *start_ptep;
=20
 	/* Stay within the VMA and within the page table. */
 	start =3D max3(addr_start, pt_start, vma->vm_start);
@@ -6977,7 +6978,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, u=
nsigned long address)
 #endif /* __PAGETABLE_PMD_FOLDED */
=20
 static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
-				     spinlock_t *lock, pte_t *ptep,
+				     spinlock_t *lock, hw_pte_t *ptep,
 				     pgprot_t pgprot, unsigned long pfn_base,
 				     unsigned long addr_mask, bool writable,
 				     bool special)
@@ -7046,7 +7047,8 @@ int follow_pfnmap_start(struct follow_pfnmap_args *=
args)
 	p4d_t *p4dp, p4d;
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	pfnmap_lockdep_assert(vma);
=20
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd..21f3b3b3507c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -691,7 +691,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigne=
d long addr,
 	struct folio *folio;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long flags =3D qp->flags;
-	pte_t *pte, *mapped_pte;
+	hw_pte_t *pte, *mapped_pte;
 	pte_t ptent;
 	spinlock_t *ptl;
 	int max_nr, nr;
@@ -771,7 +771,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigne=
d long addr,
 	return 0;
 }
=20
-static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
+static int queue_folios_hugetlb(hw_pte_t *pte, unsigned long hmask,
 			       unsigned long addr, unsigned long end,
 			       struct mm_walk *walk)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 15b45832bcfa..1786ab5e941c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -494,7 +494,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t=
 *pmd,
 			  unsigned long address)
 {
 	spinlock_t *ptl;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t pte;
 	softleaf_t entry;
=20
@@ -525,7 +525,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t=
 *pmd,
  *
  * This function will release the vma lock before returning.
  */
-void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long=
 addr, pte_t *ptep)
+void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long=
 addr, hw_pte_t *ptep)
 {
 	spinlock_t *ptl =3D huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep)=
;
 	softleaf_t entry;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 009bfa8b212d..6138833fa902 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -254,7 +254,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	spinlock_t *ptl;
 	struct folio *fault_folio =3D migrate->fault_page ?
 		page_folio(migrate->fault_page) : NULL;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 again:
 	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
@@ -989,7 +989,7 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
 	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	pte_t orig_pte;
=20
 	/* Only allow populating anonymous memory */
diff --git a/mm/mincore.c b/mm/mincore.c
index ff4ac8281768..15454ced345a 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -24,7 +24,7 @@
 #include "swap.h"
 #include "internal.h"
=20
-static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned lon=
g addr,
+static int mincore_hugetlb(hw_pte_t *pte, unsigned long hmask, unsigned =
long addr,
 			unsigned long end, struct mm_walk *walk)
 {
 #ifdef CONFIG_HUGETLB_PAGE
@@ -164,7 +164,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
 {
 	spinlock_t *ptl;
 	struct vm_area_struct *vma =3D walk->vma;
-	pte_t *ptep;
+	hw_pte_t *ptep;
 	unsigned char *vec =3D walk->private;
 	int nr =3D (end - addr) >> PAGE_SHIFT;
 	int step, i;
diff --git a/mm/mlock.c b/mm/mlock.c
index 39215a3eab1f..cc6c24e46348 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -305,7 +305,7 @@ void munlock_folio(struct folio *folio)
 }
=20
 static inline unsigned int folio_mlock_step(struct folio *folio,
-		pte_t *pte, unsigned long addr, unsigned long end)
+		hw_pte_t *pte, unsigned long addr, unsigned long end)
 {
 	unsigned int count =3D (end - addr) >> PAGE_SHIFT;
 	pte_t ptent =3D ptep_get(pte);
@@ -353,7 +353,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long =
addr,
 {
 	struct vm_area_struct *vma =3D walk->vma;
 	spinlock_t *ptl;
-	pte_t *start_pte, *pte;
+	hw_pte_t *start_pte, *pte;
 	pte_t ptent;
 	struct folio *folio;
 	unsigned int step =3D 1;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2888ee638d87..1d23475e0bb7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -103,7 +103,7 @@ bool can_change_pte_writable(struct vm_area_struct *v=
ma, unsigned long addr,
 	return can_change_shared_pte_writable(vma, pte);
 }
=20
-static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
+static int mprotect_folio_pte_batch(struct folio *folio, hw_pte_t *ptep,
 				    pte_t pte, int max_nr_ptes, fpb_t flags)
 {
 	/* No underlying folio, so cannot batch */
@@ -118,7 +118,7 @@ static int mprotect_folio_pte_batch(struct folio *fol=
io, pte_t *ptep,
=20
 /* Set nr_ptes number of ptes, starting from idx */
 static __always_inline void prot_commit_flush_ptes(struct vm_area_struct=
 *vma,
-		unsigned long addr, pte_t *ptep, pte_t oldpte, pte_t ptent,
+		unsigned long addr, hw_pte_t *ptep, pte_t oldpte, pte_t ptent,
 		int nr_ptes, int idx, bool set_write, struct mmu_gather *tlb)
 {
 	/*
@@ -170,7 +170,7 @@ static __always_inline int page_anon_exclusive_batch(=
int start_idx, int max_len,
  * retrieve sub-batches.
  */
 static __always_inline void commit_anon_folio_batch(struct vm_area_struc=
t *vma,
-		struct folio *folio, struct page *first_page, unsigned long addr, pte_=
t *ptep,
+		struct folio *folio, struct page *first_page, unsigned long addr, hw_p=
te_t *ptep,
 		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
 {
 	bool expected_anon_exclusive;
@@ -189,7 +189,7 @@ static __always_inline void commit_anon_folio_batch(s=
truct vm_area_struct *vma,
 }
=20
 static __always_inline void set_write_prot_commit_flush_ptes(struct vm_a=
rea_struct *vma,
-		struct folio *folio, struct page *page, unsigned long addr, pte_t *pte=
p,
+		struct folio *folio, struct page *page, unsigned long addr, hw_pte_t *=
ptep,
 		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
 {
 	bool set_write;
@@ -212,7 +212,7 @@ static __always_inline void set_write_prot_commit_flu=
sh_ptes(struct vm_area_stru
 }
=20
 static long change_softleaf_pte(struct vm_area_struct *vma,
-	unsigned long addr, pte_t *pte, pte_t oldpte, unsigned long cp_flags)
+	unsigned long addr, hw_pte_t *pte, pte_t oldpte, unsigned long cp_flags=
)
 {
 	const bool uffd_prot =3D cp_flags & (MM_CP_UFFD_WP | MM_CP_UFFD_RWP);
 	const bool uffd_prot_resolve =3D cp_flags &
@@ -279,7 +279,7 @@ static long change_softleaf_pte(struct vm_area_struct=
 *vma,
 }
=20
 static __always_inline void change_present_ptes(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		struct vm_area_struct *vma, unsigned long addr, hw_pte_t *ptep,
 		int nr_ptes, unsigned long end, pgprot_t newprot,
 		struct folio *folio, struct page *page, unsigned long cp_flags)
 {
@@ -332,7 +332,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
-	pte_t *pte, oldpte;
+	hw_pte_t *pte;
+	pte_t oldpte;
 	spinlock_t *ptl;
 	long pages =3D 0;
 	bool is_private_single_threaded;
@@ -727,7 +728,7 @@ long change_protection(struct mmu_gather *tlb,
 	return pages;
 }
=20
-static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
+static int prot_none_pte_entry(hw_pte_t *pte, unsigned long addr,
 			       unsigned long next, struct mm_walk *walk)
 {
 	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
@@ -736,7 +737,7 @@ static int prot_none_pte_entry(pte_t *pte, unsigned l=
ong addr,
 }
=20
 #ifdef CONFIG_HUGETLB_PAGE
-static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int prot_none_hugetlb_entry(hw_pte_t *pte, unsigned long hmask,
 				   unsigned long addr, unsigned long next,
 				   struct mm_walk *walk)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index 7c368440fafe..5272cea12f80 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -176,7 +176,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 }
=20
 static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned l=
ong addr,
-		pte_t *ptep, pte_t pte, int max_nr)
+		hw_pte_t *ptep, pte_t pte, int max_nr)
 {
 	struct folio *folio;
=20
@@ -200,7 +200,7 @@ static int move_ptes(struct pagetable_move_control *p=
mc,
 	struct vm_area_struct *vma =3D pmc->old;
 	bool need_clear_uffd_wp =3D vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm =3D vma->vm_mm;
-	pte_t *old_ptep, *new_ptep;
+	hw_pte_t *old_ptep, *new_ptep;
 	pte_t old_pte, pte;
 	pmd_t dummy_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 6ffc536359cd..70984b4e3cde 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -208,7 +208,7 @@ static void page_table_check_pte_flags(pte_t pte)
 }
=20
 void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long add=
r,
-				 pte_t *ptep, pte_t pte, unsigned int nr)
+				 hw_pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	unsigned int i;
=20
@@ -279,7 +279,7 @@ void __page_table_check_pte_clear_range(struct mm_str=
uct *mm,
 		return;
=20
 	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
-		pte_t *ptep =3D pte_offset_map(&pmd, addr);
+		hw_pte_t *ptep =3D pte_offset_map(&pmd, addr);
 		unsigned long i;
=20
 		if (WARN_ON(!ptep))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cc07fcf50e87..71157ec0b305 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -26,7 +26,7 @@ static int real_depth(int depth)
 	return depth;
 }
=20
-static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
+static int walk_pte_range_inner(hw_pte_t *pte, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
 	const struct mm_walk_ops *ops =3D walk->ops;
@@ -61,7 +61,7 @@ static int walk_pte_range_inner(pte_t *pte, unsigned lo=
ng addr,
 static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long =
end,
 			  struct mm_walk *walk)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	int err =3D 0;
 	spinlock_t *ptl;
=20
@@ -341,7 +341,7 @@ static int walk_hugetlb_range(unsigned long addr, uns=
igned long end,
 	unsigned long next;
 	unsigned long hmask =3D huge_page_mask(h);
 	unsigned long sz =3D huge_page_size(h);
-	pte_t *pte;
+	hw_pte_t *pte;
 	const struct mm_walk_ops *ops =3D walk->ops;
 	int err =3D 0;
=20
@@ -907,7 +907,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 	struct page *page;
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
 	spinlock_t *ptl;
 	pgd_t *pgdp;
 	p4d_t *p4dp;
diff --git a/mm/percpu.c b/mm/percpu.c
index a802d72c116f..fa79a1295c5b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3176,7 +3176,7 @@ void __init __weak pcpu_populate_pte(unsigned long =
addr)
=20
 	pmd =3D pmd_offset(pud, addr);
 	if (!pmd_present(*pmd)) {
-		pte_t *new;
+		hw_pte_t *new;
=20
 		new =3D memblock_alloc_or_panic(PTE_TABLE_SIZE, PTE_TABLE_SIZE);
 		pmd_populate_kernel(&init_mm, pmd, new);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..52f286da3eec 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -68,7 +68,7 @@ void pmd_clear_bad(pmd_t *pmd)
  * force that call on sun4c so we changed this macro slightly
  */
 int ptep_set_access_flags(struct vm_area_struct *vma,
-			  unsigned long address, pte_t *ptep,
+			  unsigned long address, hw_pte_t *ptep,
 			  pte_t entry, int dirty)
 {
 	int changed =3D !pte_same(ptep_get(ptep), entry);
@@ -82,7 +82,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
=20
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 bool ptep_clear_flush_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep)
+		unsigned long address, hw_pte_t *ptep)
 {
 	bool young;
=20
@@ -95,7 +95,7 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
=20
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address=
,
-		       pte_t *ptep)
+		       hw_pte_t *ptep)
 {
 	struct mm_struct *mm =3D (vma)->vm_mm;
 	pte_t pte;
@@ -282,7 +282,7 @@ static unsigned long pmdp_get_lockless_start(void) { =
return 0; }
 static void pmdp_get_lockless_end(unsigned long irqflags) { }
 #endif
=20
-pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
+hw_pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdval=
p)
 {
 	unsigned long irqflags;
 	pmd_t pmdval;
@@ -308,11 +308,11 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long a=
ddr, pmd_t *pmdvalp)
 	return NULL;
 }
=20
-pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp)
 {
 	pmd_t pmdval;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	pte =3D __pte_offset_map(pmd, addr, &pmdval);
 	if (likely(pte))
@@ -320,11 +320,11 @@ pte_t *pte_offset_map_ro_nolock(struct mm_struct *m=
m, pmd_t *pmd,
 	return pte;
 }
=20
-pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, pmd_t *pmdvalp,
 				spinlock_t **ptlp)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	VM_WARN_ON_ONCE(!pmdvalp);
 	pte =3D __pte_offset_map(pmd, addr, pmdvalp);
@@ -390,12 +390,12 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *m=
m, pmd_t *pmd,
  * table, and may not use RCU at all: "outsiders" like khugepaged should=
 avoid
  * pte_offset_map() and co once the vma is detached from mm or mm_users =
is zero.
  */
-pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+hw_pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			   unsigned long addr, spinlock_t **ptlp)
 {
 	spinlock_t *ptl;
 	pmd_t pmdval;
-	pte_t *pte;
+	hw_pte_t *pte;
 again:
 	pte =3D __pte_offset_map(pmd, addr, &pmdval);
 	if (unlikely(!pte))
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 5851096e6f65..376880071ca2 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -117,7 +117,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long=
 addr,
 	return 0;
 }
=20
-static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
+static int ptdump_pte_entry(hw_pte_t *pte, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st =3D walk->private;
diff --git a/mm/rmap.c b/mm/rmap.c
index f3b21aaa34ee..aafcd6b52893 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1128,7 +1128,7 @@ static int page_vma_mkclean_one(struct page_vma_map=
ped_walk *pvmw)
=20
 		address =3D pvmw->address;
 		if (pvmw->pte) {
-			pte_t *pte =3D pvmw->pte;
+			hw_pte_t *pte =3D pvmw->pte;
 			pte_t entry =3D ptep_get(pte);
=20
 			/*
@@ -2145,7 +2145,7 @@ static pte_t swp_pte_prepare(swp_entry_t entry, pte=
_t old_pte,
=20
 static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
 		struct folio *folio, struct page *page, unsigned long address,
-		pte_t *ptep, pte_t pteval)
+		hw_pte_t *ptep, pte_t pteval)
 {
 	const bool anon_exclusive =3D folio_test_anon(folio) &&
 				    PageAnonExclusive(page);
@@ -2180,7 +2180,7 @@ static bool ttu_anon_swapbacked_folio(struct vm_are=
a_struct *vma,
 }
=20
 static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *fol=
io,
-		struct page *page, unsigned long address, pte_t *ptep,
+		struct page *page, unsigned long address, hw_pte_t *ptep,
 		pte_t pteval, unsigned long nr_pages)
 {
 	/*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5a2469fb1838..1d7a56884905 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -137,7 +137,7 @@ static void * __meminit altmap_alloc_block_buf(unsign=
ed long size,
 	return __va(__pfn_to_phys(pfn));
 }
=20
-void __meminit vmemmap_verify(pte_t *pte, int node,
+void __meminit vmemmap_verify(hw_pte_t *pte, int node,
 				unsigned long start, unsigned long end)
 {
 	unsigned long pfn =3D pte_pfn(ptep_get(pte));
@@ -148,11 +148,11 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
=20
-static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long =
addr, int node,
+static hw_pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned lo=
ng addr, int node,
 				       struct vmem_altmap *altmap,
 				       unsigned long ptpfn, unsigned long flags)
 {
-	pte_t *pte =3D pte_offset_kernel(pmd, addr);
+	hw_pte_t *pte =3D pte_offset_kernel(pmd, addr);
 	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
 		void *p;
@@ -243,7 +243,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigne=
d long addr, int node)
 	return pgd;
 }
=20
-static pte_t * __meminit vmemmap_populate_address(unsigned long addr, in=
t node,
+static hw_pte_t * __meminit vmemmap_populate_address(unsigned long addr,=
 int node,
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn,
 					      unsigned long flags)
@@ -252,7 +252,7 @@ static pte_t * __meminit vmemmap_populate_address(uns=
igned long addr, int node,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	pgd =3D vmemmap_pgd_populate(addr, node);
 	if (!pgd)
@@ -281,7 +281,7 @@ static int __meminit vmemmap_populate_range(unsigned =
long start,
 					    unsigned long flags)
 {
 	unsigned long addr =3D start;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	for (; addr < end; addr +=3D PAGE_SIZE) {
 		pte =3D vmemmap_populate_address(addr, node, altmap,
@@ -314,7 +314,7 @@ void vmemmap_wrprotect_hvo(unsigned long addr, unsign=
ed long end,
 				    int node, unsigned long headsize)
 {
 	unsigned long maddr;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	for (maddr =3D addr + headsize; maddr < end; maddr +=3D PAGE_SIZE) {
 		pte =3D virt_to_kpte(maddr);
@@ -396,7 +396,7 @@ int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, in=
t node,
 {
 	if (!pmd_leaf(pmdp_get(pmd)))
 		return 0;
-	vmemmap_verify((pte_t *)pmd, node, addr, next);
+	vmemmap_verify((hw_pte_t *)pmd, node, addr, next);
=20
 	return 1;
 }
@@ -474,9 +474,9 @@ static bool __meminit reuse_compound_section(unsigned=
 long start_pfn,
 	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION=
;
 }
=20
-static pte_t * __meminit compound_section_tail_page(unsigned long addr)
+static hw_pte_t * __meminit compound_section_tail_page(unsigned long add=
r)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	addr -=3D PAGE_SIZE;
=20
@@ -497,7 +497,7 @@ static int __meminit vmemmap_populate_compound_pages(=
unsigned long start_pfn,
 						     struct dev_pagemap *pgmap)
 {
 	unsigned long size, addr;
-	pte_t *pte;
+	hw_pte_t *pte;
 	int rc;
=20
 	if (reuse_compound_section(start_pfn, pgmap)) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3961fdd857d..865eb5422c2e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -918,7 +918,8 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
 	struct swap_io_ctx ctx =3D {};
 	struct blk_plug plug;
 	struct folio *folio;
-	pte_t *pte =3D NULL, pentry;
+	hw_pte_t *pte =3D NULL;
+	pte_t pentry;
 	int win;
 	unsigned long start, end, addr;
 	pgoff_t ilx =3D targ_ilx;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 601979b97f95..6adeee9c95ec 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2422,7 +2422,8 @@ static int unuse_pte(struct vm_area_struct *vma, pm=
d_t *pmd,
 	struct page *page;
 	struct folio *swapcache;
 	spinlock_t *ptl;
-	pte_t *pte, new_pte, old_pte;
+	hw_pte_t *pte;
+	pte_t new_pte, old_pte;
 	bool hwpoisoned =3D false;
 	int ret =3D 1;
=20
@@ -2533,7 +2534,7 @@ static int unuse_pte_range(struct vm_area_struct *v=
ma, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned int type)
 {
-	pte_t *pte =3D NULL;
+	hw_pte_t *pte =3D NULL;
=20
 	do {
 		struct folio *folio;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74f04c323c50..8fa3c960fb1a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -361,13 +361,13 @@ static int mfill_atomic_install_pte(pmd_t *dst_pmd,
 {
 	int ret;
 	struct mm_struct *dst_mm =3D dst_vma->vm_mm;
-	pte_t _dst_pte, *dst_pte;
+	hw_pte_t *dst_pte;
 	bool writable =3D dst_vma->vm_flags & VM_WRITE;
 	bool vm_shared =3D dst_vma->vm_flags & VM_SHARED;
 	spinlock_t *ptl;
 	struct folio *folio =3D page_folio(page);
 	bool page_in_cache =3D folio_mapping(folio);
-	pte_t dst_ptep;
+	pte_t _dst_pte, dst_ptep;
=20
 	_dst_pte =3D mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte =3D pte_mkdirty(_dst_pte);
@@ -656,7 +656,8 @@ static int mfill_atomic_pte_zeropage(struct mfill_sta=
te *state)
 	struct vm_area_struct *dst_vma =3D state->vma;
 	unsigned long dst_addr =3D state->dst_addr;
 	pmd_t *dst_pmd =3D state->pmd;
-	pte_t _dst_pte, *dst_pte;
+	hw_pte_t *dst_pte;
+	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret;
=20
@@ -737,7 +738,8 @@ static int mfill_atomic_pte_poison(struct mfill_state=
 *state)
 	struct mm_struct *dst_mm =3D dst_vma->vm_mm;
 	unsigned long dst_addr =3D state->dst_addr;
 	pmd_t *dst_pmd =3D state->pmd;
-	pte_t _dst_pte, *dst_pte;
+	hw_pte_t *dst_pte;
+	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret;
=20
@@ -784,7 +786,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 {
 	struct mm_struct *dst_mm =3D dst_vma->vm_mm;
 	ssize_t err;
-	pte_t *dst_pte;
+	hw_pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct folio *folio;
@@ -1261,7 +1263,7 @@ void double_pt_unlock(spinlock_t *ptl1,
 		__release(ptl2);
 }
=20
-static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
+static inline bool is_pte_pages_stable(hw_pte_t *dst_pte, hw_pte_t *src_=
pte,
 				       pte_t orig_dst_pte, pte_t orig_src_pte,
 				       pmd_t *dst_pmd, pmd_t dst_pmdval)
 {
@@ -1279,7 +1281,8 @@ static inline bool is_pte_pages_stable(pte_t *dst_p=
te, pte_t *src_pte,
  */
 static struct folio *check_ptes_for_batched_move(struct vm_area_struct *=
src_vma,
 						 unsigned long src_addr,
-						 pte_t *src_pte, pte_t *dst_pte)
+						 hw_pte_t *src_pte,
+						 hw_pte_t *dst_pte)
 {
 	pte_t orig_dst_pte, orig_src_pte;
 	struct folio *folio;
@@ -1310,7 +1313,7 @@ static long move_present_ptes(struct mm_struct *mm,
 			      struct vm_area_struct *dst_vma,
 			      struct vm_area_struct *src_vma,
 			      unsigned long dst_addr, unsigned long src_addr,
-			      pte_t *dst_pte, pte_t *src_pte,
+			      hw_pte_t *dst_pte, hw_pte_t *src_pte,
 			      pte_t orig_dst_pte, pte_t orig_src_pte,
 			      pmd_t *dst_pmd, pmd_t dst_pmdval,
 			      spinlock_t *dst_ptl, spinlock_t *src_ptl,
@@ -1397,7 +1400,7 @@ static long move_present_ptes(struct mm_struct *mm,
=20
 static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *ds=
t_vma,
 			 unsigned long dst_addr, unsigned long src_addr,
-			 pte_t *dst_pte, pte_t *src_pte,
+			 hw_pte_t *dst_pte, hw_pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
@@ -1462,7 +1465,7 @@ static int move_zeropage_pte(struct mm_struct *mm,
 			     struct vm_area_struct *dst_vma,
 			     struct vm_area_struct *src_vma,
 			     unsigned long dst_addr, unsigned long src_addr,
-			     pte_t *dst_pte, pte_t *src_pte,
+			     hw_pte_t *dst_pte, hw_pte_t *src_pte,
 			     pte_t orig_dst_pte, pte_t orig_src_pte,
 			     pmd_t *dst_pmd, pmd_t dst_pmdval,
 			     spinlock_t *dst_ptl, spinlock_t *src_ptl)
@@ -1508,8 +1511,8 @@ static long move_pages_ptes(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
 	spinlock_t *src_ptl, *dst_ptl;
-	pte_t *src_pte =3D NULL;
-	pte_t *dst_pte =3D NULL;
+	hw_pte_t *src_pte =3D NULL;
+	hw_pte_t *dst_pte =3D NULL;
 	pmd_t dummy_pmdval;
 	pmd_t dst_pmdval;
 	struct folio *src_folio =3D NULL;
@@ -2650,7 +2653,8 @@ static inline bool userfaultfd_huge_must_wait(struc=
t userfaultfd_ctx *ctx,
 					      unsigned long reason)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	assert_fault_locked(vmf);
=20
@@ -2723,7 +2727,7 @@ static inline bool userfaultfd_must_wait(struct use=
rfaultfd_ctx *ctx,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd, _pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
 	pte_t ptent;
 	bool ret;
=20
diff --git a/mm/util.c b/mm/util.c
index bf0513d1d3d0..cc253050f689 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1564,7 +1564,7 @@ EXPORT_SYMBOL(mmap_action_complete);
  *
  * Return: the number of table entries in the batch.
  */
-unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte=
,
+unsigned int folio_pte_batch(struct folio *folio, hw_pte_t *ptep, pte_t =
pte,
 		unsigned int max_nr)
 {
 	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr, 0);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bea9f76ed7e7..4f97f99c340e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -97,7 +97,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long add=
r, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift, pgtbl_mod_mask *mask)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	u64 pfn;
 	struct page *page;
 	unsigned long size =3D PAGE_SIZE;
@@ -389,7 +389,7 @@ int ioremap_page_range(unsigned long addr, unsigned l=
ong end,
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned lo=
ng end,
 			     pgtbl_mod_mask *mask)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	pte_t ptent;
 	unsigned long size =3D PAGE_SIZE;
=20
@@ -550,7 +550,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned =
long addr,
 		pgtbl_mod_mask *mask)
 {
 	int err =3D 0;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	/*
 	 * nr is a running index into the array which helps higher level
@@ -827,7 +827,8 @@ struct page *vmalloc_to_page(const void *vmalloc_addr=
)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	/*
 	 * XXX we might need to change this if we add VIRTUAL_BUG_ON for
@@ -3605,7 +3606,7 @@ struct vmap_pfn_data {
 	unsigned int	idx;
 };
=20
-static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
+static int vmap_pfn_apply(hw_pte_t *pte, unsigned long addr, void *priva=
te)
 {
 	struct vmap_pfn_data *data =3D private;
 	unsigned long pfn =3D data->pfns[data->idx];
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..acc77c673a95 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3540,7 +3540,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned lon=
g start, unsigned long end,
 {
 	int i;
 	bool dirty;
-	pte_t *pte;
+	hw_pte_t *pte;
 	spinlock_t *ptl;
 	unsigned long addr;
 	int total =3D 0;
@@ -3573,7 +3573,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned lon=
g start, unsigned long end,
 	for (i =3D pte_index(start), addr =3D start; addr !=3D end; i +=3D nr, =
addr +=3D nr * PAGE_SIZE) {
 		unsigned long pfn;
 		struct folio *folio;
-		pte_t *cur_pte =3D pte + i;
+		hw_pte_t *cur_pte =3D pte + i;
 		pte_t ptent =3D ptep_get(cur_pte);
=20
 		nr =3D 1;
@@ -4262,7 +4262,7 @@ bool lru_gen_look_around(struct page_vma_mapped_wal=
k *pvmw, unsigned int nr)
 	struct lru_gen_mm_walk *walk;
 	struct folio *last =3D NULL;
 	int young =3D nr;
-	pte_t *pte =3D pvmw->pte;
+	hw_pte_t *pte =3D pvmw->pte;
 	unsigned long addr =3D pvmw->address;
 	struct vm_area_struct *vma =3D pvmw->vma;
 	struct folio *folio =3D pfn_folio(pvmw->pfn);
--=20
2.53.0

