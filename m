Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E53497396;
	Wed,  7 Oct 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373366; cv=none; b=XVs2wp9Of74wvbfI5MFbcIFJyyBCjHVd6rompECMDYGqOi81s+rKFaWNFsWktdWmhYkQ2g9JX19s5QbCotknTXjyu5O3qXwwuOo4uiB7iWUc1Jh7A5qT/+AyYWyZZo6qjDyrInzF3S8eyT2LfRBcHUEFUJrheX7prDhProAh2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373366; c=relaxed/simple;
	bh=1NmVEsJrjG+Ap6PNHNPvn6hvopCgEpRgf3JKnlSN7P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXLc2W60aHviCCXUjTiIdPsmL9dWDioXUfmqVoYHVVeRCdQCF6hhEfsLNL4Q0pQ+EA564I7wDmlXoXpk+PBL49+/67WOy+FkHTaBGqTefptHa3Zczqs1RMeDcv7IsaS47MqoZAqkPS3g//LNnQRtATlZyHeCl9ekxWwc1VPDkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fex8FHBz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fex8FHBz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZrlb1186168;
	Wed, 7 Oct 2026 11:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KMCQypq5k4L3tBe4C
	rqZnK6SPYW6oqce88vDR+liiw0=; b=fex8FHBziJVMhU7z//o8vV2TmKm59AZxy
	mhRaoKqlqJkujA8AykryxEfhaMCQgbK7LRS6aV2bHPGgBOM6Y3tIDrqIv+vnuLwB
	JHg105sQu+62GwVHUUafb2WwJuOUTajKM3ZqMegUaHwBzHTbeeffcRHWHH6CvUrX
	EXi+tow4stbZf/Xjh53fq5N60ytlfsy6nybrIuq0Cc1KXpE6RyL3GBjacEqbILcB
	IKdnBgSNb0/3jQrcSeUBSOcfudLYLnwxJex7y9cs3CPORaItWjG/uv39CmzCpXE0
	jHsylWYQjKPPVwdAcioiKfSW+2NB0w+3qaTtLrI5qaIxozidodIUg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g4cms-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWcXa1810422;
	Wed, 7 Oct 2026 11:42:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek2ka2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfx8035127772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED9D20043;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A4E2004B;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 906DB160AEE; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 11/15] s390: Distinguish hardware and software PTEs
Date: Wed,  7 Oct 2026 13:41:54 +0200
Message-ID: <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac6300e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vpKxU8pLMe8mG6GKF9sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+9PTprLT7myn
 w/b1Alp9NwM0ADqcd3Oc4EZFNNgPG8kkIgSNQ9KpHR9+dCNE4oKnmAA2icMAsbTDJRXDJjqnBt6
 H3YSvXen/ObILCVdlWsSeFYfb3QAatRPqA6tG94q3Gvajsycq4LSR1QkmD3pDW+Oi73FjsTqtAC
 sep7zaIQDRt05g+nW3I65BuUqcKn3TtBCY31+PLHUbRN/zghTBrzuUm4tihg7ZJRfMqjCEicL3w
 QHByZHDkeHglgRetGS7Cprrcxlv7BhTXm5/bnHlxfymkN0mMtDeID/2CvRolfH9gc0iasHIrNx2
 THDVyIzChb5/EV//clqJ05sB/HNW6iyIu6i490EnNlqXQv3SIR4jXHZMVeLLXnS7o4gwpIIc19V
 Kji9i1YpCkRp+2mF1xuU+vCO94lrd8XZbKXJUsTKDyeuaGMC091Ddt9cOq6NNzPhHgGmEsmMAuA
 FE61Vt3b4L8sRsEbc7g==
X-Proofpoint-GUID: tnMqqoqIespJzdFsY6lRxdzGex7_eauW
X-Proofpoint-ORIG-GUID: AkCVFdLNgNKLcDj9_Pm2WSefqoavAh_f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXyBNgQt6lihob
 W0zlhRn+nRL+WCDCLTc1OHq/Cf660hWeD8TP67PZY2YZm8C6f1yvwo16dWSOvKvhEqqCpBMuooI
 cT4lPTukJ1GEfISb3FbTWWoBMg/uVN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

This is s390 version of ARM64 commit XXXXXXXXXXXX ("arm64:
distinguish HW PTE pointers from SW PTE value pointers").

It distinguishes hardware and software PTEs, introduces hw_pte_t
type for hardware PTEs, while software PTEs still use pte_t type
and enables ARCH_HAS_HW_PTE_T configuration for s390.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/Kconfig                    |  1 +
 arch/s390/boot/startup.c             |  2 +-
 arch/s390/boot/vmem.c                | 17 ++++-----
 arch/s390/include/asm/gmap_helpers.h |  2 +-
 arch/s390/include/asm/hugetlb.h      | 18 +++++-----
 arch/s390/include/asm/maccess.h      |  2 +-
 arch/s390/include/asm/page.h         |  3 +-
 arch/s390/include/asm/pgalloc.h      |  6 ++--
 arch/s390/include/asm/pgtable.h      | 54 +++++++++++++++-------------
 arch/s390/kernel/uv.c                |  4 +--
 arch/s390/kvm/s390/pv.c              |  2 +-
 arch/s390/mm/gmap_helpers.c          | 18 +++++-----
 arch/s390/mm/hugetlbpage.c           | 20 +++++------
 arch/s390/mm/maccess.c               |  2 +-
 arch/s390/mm/pageattr.c              | 10 +++---
 arch/s390/mm/pgtable.c               | 26 +++++++-------
 arch/s390/mm/vmem.c                  | 26 +++++++-------
 17 files changed, 112 insertions(+), 101 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..b9bc0e5e7d7d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -100,6 +100,7 @@ config S390
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_HW_PTE_T
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index c1dcf8b1b579..d8732b416161 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -30,7 +30,7 @@
 struct vm_layout __bootdata_preserved(vm_layout);
 unsigned long __bootdata_preserved(__abs_lowcore);
 unsigned long __bootdata_preserved(__memcpy_real_area);
-pte_t *__bootdata_preserved(memcpy_real_ptep);
+hw_pte_t *__bootdata_preserved(memcpy_real_ptep);
 unsigned long __bootdata_preserved(VMALLOC_START);
 unsigned long __bootdata_preserved(VMALLOC_END);
 struct page *__bootdata_preserved(vmemmap);
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index ff6d58a476ba..cc619cc85d37 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -75,7 +75,7 @@ static void pgtable_populate(unsigned long addr, unsign=
ed long end, enum populat
 #ifdef CONFIG_KASAN
=20
 #define kasan_early_shadow_page	vmlinux.kasan_early_shadow_page_off
-#define kasan_early_shadow_pte	((pte_t *)vmlinux.kasan_early_shadow_pte_=
off)
+#define kasan_early_shadow_pte	((hw_pte_t *)vmlinux.kasan_early_shadow_p=
te_off)
 #define kasan_early_shadow_pmd	((pmd_t *)vmlinux.kasan_early_shadow_pmd_=
off)
 #define kasan_early_shadow_pud	((pud_t *)vmlinux.kasan_early_shadow_pud_=
off)
 #define kasan_early_shadow_p4d	((p4d_t *)vmlinux.kasan_early_shadow_p4d_=
off)
@@ -178,7 +178,7 @@ static bool kasan_pmd_populate_zero_shadow(pmd_t *pmd=
, unsigned long addr,
 	return false;
 }
=20
-static bool kasan_pte_populate_zero_shadow(pte_t *pte, enum populate_mod=
e mode)
+static bool kasan_pte_populate_zero_shadow(hw_pte_t *pte, enum populate_=
mode mode)
 {
 	if (mode =3D=3D POPULATE_KASAN_ZERO_SHADOW) {
 		set_pte(pte, pte_z);
@@ -216,7 +216,7 @@ static inline bool kasan_pmd_populate_zero_shadow(pmd=
_t *pmd, unsigned long addr
 	return false;
 }
=20
-static bool kasan_pte_populate_zero_shadow(pte_t *pte, enum populate_mod=
e mode)
+static bool kasan_pte_populate_zero_shadow(hw_pte_t *pte, enum populate_=
mode mode)
 {
 	return false;
 }
@@ -226,7 +226,7 @@ static bool kasan_pte_populate_zero_shadow(pte_t *pte=
, enum populate_mode mode)
 /*
  * Mimic virt_to_kpte() in lack of init_mm symbol. Skip pmd NULL check t=
hough.
  */
-static inline pte_t *__virt_to_kpte(unsigned long va)
+static inline hw_pte_t *__virt_to_kpte(unsigned long va)
 {
 	return pte_offset_kernel(pmd_offset(pud_offset(p4d_offset(pgd_offset_k(=
va), va), va), va), va);
 }
@@ -242,9 +242,9 @@ static void *boot_crst_alloc(unsigned long val)
 	return table;
 }
=20
-static pte_t *boot_pte_alloc(void)
+static hw_pte_t *boot_pte_alloc(void)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	pte =3D (void *)physmem_alloc_or_die(RR_VMEM, PAGE_SIZE, PAGE_SIZE);
 	__arch_set_page_dat(pte, 1);
@@ -334,7 +334,8 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned=
 long addr, unsigned long e
 				 enum populate_mode mode)
 {
 	unsigned long pages =3D 0;
-	pte_t *pte, entry;
+	hw_pte_t *pte;
+	pte_t entry;
=20
 	pte =3D pte_offset_kernel(pmd, addr);
 	for (; addr < end; addr +=3D PAGE_SIZE, pte++) {
@@ -356,7 +357,7 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned=
 long addr, unsigned long e
 {
 	unsigned long pa, next, pages =3D 0;
 	pmd_t *pmd, entry, large_entry;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	pmd =3D pmd_offset(pud, addr);
 	for (; addr < end; addr =3D next, pmd++) {
diff --git a/arch/s390/include/asm/gmap_helpers.h b/arch/s390/include/asm=
/gmap_helpers.h
index d2b616604a46..d23907ed78f3 100644
--- a/arch/s390/include/asm/gmap_helpers.h
+++ b/arch/s390/include/asm/gmap_helpers.h
@@ -12,6 +12,6 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, uns=
igned long vmaddr);
 void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, uns=
igned long end);
 int gmap_helper_disable_cow_sharing(void);
 void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long =
vmaddr);
-pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long addr, spin=
lock_t **ptl);
+hw_pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long addr, s=
pinlock_t **ptl);
=20
 #endif /* _ASM_S390_GMAP_HELPERS_H */
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/huge=
tlb.h
index aea754b67c89..7c1cf08725c5 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -19,19 +19,19 @@
=20
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte, unsigned long sz);
+		     hw_pte_t *ptep, pte_t pte, unsigned long sz);
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		       pte_t *ptep, pte_t pte);
+		       hw_pte_t *ptep, pte_t pte);
=20
 #define __HAVE_ARCH_HUGE_PTEP_GET
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *pte=
p);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, hw_pte_t *=
ptep);
=20
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr=
,
-				pte_t *ptep);
+				hw_pte_t *ptep);
=20
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep,
+					    unsigned long addr, hw_pte_t *ptep,
 					    unsigned long sz)
 {
 	return __huge_ptep_get_and_clear(mm, addr, ptep);
@@ -39,7 +39,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_s=
truct *mm,
=20
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
-				  pte_t *ptep, unsigned long sz)
+				  hw_pte_t *ptep, unsigned long sz)
 {
 	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_=
ENTRY_TYPE_R3)
 		set_pud((pud_t *)ptep, __pud(_REGION3_ENTRY_EMPTY));
@@ -49,14 +49,14 @@ static inline void huge_pte_clear(struct mm_struct *m=
m, unsigned long addr,
=20
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-					  unsigned long address, pte_t *ptep)
+					  unsigned long address, hw_pte_t *ptep)
 {
 	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
=20
 #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-					     unsigned long addr, pte_t *ptep,
+					     unsigned long addr, hw_pte_t *ptep,
 					     pte_t pte, int dirty)
 {
 	int changed =3D !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
@@ -70,7 +70,7 @@ static inline int huge_ptep_set_access_flags(struct vm_=
area_struct *vma,
=20
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
+					   unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t pte =3D __huge_ptep_get_and_clear(mm, addr, ptep);
=20
diff --git a/arch/s390/include/asm/maccess.h b/arch/s390/include/asm/macc=
ess.h
index 50225940d971..dafd9fe290ce 100644
--- a/arch/s390/include/asm/maccess.h
+++ b/arch/s390/include/asm/maccess.h
@@ -10,7 +10,7 @@
 struct iov_iter;
=20
 extern unsigned long __memcpy_real_area;
-extern pte_t *memcpy_real_ptep;
+extern hw_pte_t *memcpy_real_ptep;
 size_t memcpy_real_iter(struct iov_iter *iter, unsigned long src, size_t=
 count);
 int memcpy_real(void *dest, unsigned long src, size_t count);
 #ifdef CONFIG_CRASH_DUMP
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 56da819a79e6..42b4fecd2de3 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -113,7 +113,8 @@ DEFINE_PGVAL_FUNC(pud)
 DEFINE_PGVAL_FUNC(p4d)
 DEFINE_PGVAL_FUNC(pgd)
=20
-typedef pte_t *pgtable_t;
+struct __hw_pte_t;
+typedef struct __hw_pte_t *pgtable_t;
=20
 #define __pgprot(x)	((pgprot_t) { (x) } )
 #define __pte(x)        ((pte_t) { (x) } )
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgal=
loc.h
index a5de9e61ea9e..83a732898819 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -159,8 +159,8 @@ static inline void pmd_populate(struct mm_struct *mm,
 /*
  * page table entry allocation/free routines.
  */
-#define pte_alloc_one_kernel(mm) ((pte_t *)page_table_alloc(mm))
-#define pte_alloc_one(mm) ((pte_t *)page_table_alloc(mm))
+#define pte_alloc_one_kernel(mm) ((hw_pte_t *)page_table_alloc(mm))
+#define pte_alloc_one(mm) ((hw_pte_t *)page_table_alloc(mm))
=20
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) p=
te)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
@@ -171,7 +171,7 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t p=
gtable);
=20
 void vmem_map_init(void);
 void *vmem_crst_alloc(unsigned long val);
-pte_t *vmem_pte_alloc(void);
+hw_pte_t *vmem_pte_alloc(void);
=20
 unsigned long base_asce_alloc(unsigned long addr, unsigned long num_page=
s);
 void base_asce_free(unsigned long asce);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index e882663a58e7..c47264f3abf2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -978,17 +978,19 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	WRITE_ONCE(*pmdp, pmd);
 }
=20
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte(hw_pte_t *ptep, pte_t pte)
 {
+	hw_pte_t hwpte =3D (hw_pte_t) { (pte) };
+
 	if (pte_present(pte))
 		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
-	WRITE_ONCE(*ptep, pte);
+	WRITE_ONCE(*ptep, hwpte);
 }
=20
 #define ptep_get ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return __pte_from_hw(READ_ONCE(*ptep));
 }
=20
 #define pmdp_get pmdp_get
@@ -1015,7 +1017,7 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 	return READ_ONCE(*pgdp);
 }
=20
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr, p=
te_t *ptep)
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, h=
w_pte_t *ptep)
 {
 	set_pte(ptep, __pte(_PAGE_INVALID));
 }
@@ -1133,7 +1135,7 @@ static inline unsigned long sske_frame(unsigned lon=
g addr, unsigned char skey)
 #define IPTE_NODAT	0x400
 #define IPTE_GUEST_ASCE	0x800
=20
-static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep, =
int local)
+static __always_inline void __ptep_rdp(unsigned long addr, hw_pte_t *pte=
p, int local)
 {
 	unsigned long pto;
=20
@@ -1144,7 +1146,7 @@ static __always_inline void __ptep_rdp(unsigned lon=
g addr, pte_t *ptep, int loca
 		       [m4] "i" (local));
 }
=20
-static __always_inline void __ptep_ipte(unsigned long address, pte_t *pt=
ep,
+static __always_inline void __ptep_ipte(unsigned long address, hw_pte_t =
*ptep,
 					unsigned long opt, unsigned long asce,
 					int local)
 {
@@ -1168,7 +1170,7 @@ static __always_inline void __ptep_ipte(unsigned lo=
ng address, pte_t *ptep,
 }
=20
 static __always_inline void __ptep_ipte_range(unsigned long address, int=
 nr,
-					      pte_t *ptep, int local)
+					      hw_pte_t *ptep, int local)
 {
 	unsigned long pto =3D __pa(ptep);
=20
@@ -1194,12 +1196,12 @@ static __always_inline void __ptep_ipte_range(uns=
igned long address, int nr,
  * have ptep_get_and_clear do the tlb flush. In exchange flush_tlb_range
  * is a nop.
  */
-pte_t ptep_xchg_direct(struct mm_struct *, unsigned long, pte_t *, pte_t=
);
-pte_t ptep_xchg_lazy(struct mm_struct *, unsigned long, pte_t *, pte_t);
+pte_t ptep_xchg_direct(struct mm_struct *, unsigned long, hw_pte_t *, pt=
e_t);
+pte_t ptep_xchg_lazy(struct mm_struct *, unsigned long, hw_pte_t *, pte_=
t);
=20
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t pte =3D ptep_get(ptep);
=20
@@ -1209,14 +1211,14 @@ static inline bool ptep_test_and_clear_young(stru=
ct vm_area_struct *vma,
=20
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep)
+		unsigned long address, hw_pte_t *ptep)
 {
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
=20
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long addr, pte_t *ptep)
+				       unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t res;
=20
@@ -1229,13 +1231,13 @@ static inline pte_t ptep_get_and_clear(struct mm_=
struct *mm,
 }
=20
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte=
_t *);
+pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, hw_=
pte_t *);
 void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
-			     pte_t *, pte_t, pte_t);
+			     hw_pte_t *, pte_t, pte_t);
=20
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
-				     unsigned long addr, pte_t *ptep)
+				     unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t res;
=20
@@ -1257,7 +1259,7 @@ static inline pte_t ptep_clear_flush(struct vm_area=
_struct *vma,
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 					    unsigned long addr,
-					    pte_t *ptep, int full)
+					    hw_pte_t *ptep, int full)
 {
 	pte_t res;
=20
@@ -1289,7 +1291,7 @@ static inline pte_t ptep_get_and_clear_full(struct =
mm_struct *mm,
=20
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long addr, pte_t *ptep)
+				      unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t pte =3D ptep_get(ptep);
=20
@@ -1315,7 +1317,7 @@ static inline int pte_allow_rdp(pte_t old, pte_t ne=
w)
=20
 static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *v=
ma,
 						unsigned long address,
-						pte_t *ptep)
+						hw_pte_t *ptep)
 {
 	/*
 	 * RDP might not have propagated the PTE protection reset to all CPUs,
@@ -1332,17 +1334,19 @@ static inline void flush_tlb_fix_spurious_fault(s=
truct vm_area_struct *vma,
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
=20
-void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t=
 *ptep,
+void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, hw_pt=
e_t *ptep,
 			 pte_t new);
=20
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 static inline int ptep_set_access_flags(struct vm_area_struct *vma,
-					unsigned long addr, pte_t *ptep,
+					unsigned long addr, hw_pte_t *ptep,
 					pte_t entry, int dirty)
 {
-	if (pte_same(*ptep, entry))
+	pte_t pte =3D ptep_get(ptep);
+
+	if (pte_same(pte, entry))
 		return 0;
-	if (cpu_has_rdp() && pte_allow_rdp(*ptep, entry))
+	if (cpu_has_rdp() && pte_allow_rdp(pte, entry))
 		ptep_reset_dat_prot(vma->vm_mm, addr, ptep, entry);
 	else
 		ptep_xchg_direct(vma->vm_mm, addr, ptep, entry);
@@ -1359,7 +1363,7 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
  * are within the same folio, PMD and VMA.
  */
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t entry, unsigned int nr)
+		hw_pte_t *ptep, pte_t entry, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, addr, ptep, entry, nr);
 	for (;;) {
@@ -1997,7 +2001,7 @@ extern void vmem_remove_mapping(unsigned long start=
, unsigned long size);
 extern int __vmem_map_4k_page(unsigned long addr, unsigned long phys, pg=
prot_t prot, bool alloc);
 extern int vmem_map_4k_page(unsigned long addr, unsigned long phys, pgpr=
ot_t prot);
 extern void vmem_unmap_4k_page(unsigned long addr);
-extern pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc);
+extern hw_pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc);
=20
 /* s390 has a private copy of get unmapped area to deal with cache synon=
yms */
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 8ea9dd7704ff..f81c47db421e 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -210,7 +210,7 @@ int uv_convert_from_secure_pte(pte_t pte)
 	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
 }
=20
-static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
+static int uv_free_range_cb(hw_pte_t *ptep, unsigned long addr, void *da=
ta)
 {
 	pte_t pte =3D ptep_get(ptep);
=20
@@ -242,7 +242,7 @@ void uv_free_stor_var(void *stor_var)
 }
 EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
=20
-static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data=
)
+static int uv_alloc_range_cb(hw_pte_t *ptep, unsigned long addr, void *d=
ata)
 {
 	struct page *page;
 	pte_t pte;
diff --git a/arch/s390/kvm/s390/pv.c b/arch/s390/kvm/s390/pv.c
index b18abd0e29ef..bec85e434514 100644
--- a/arch/s390/kvm/s390/pv.c
+++ b/arch/s390/kvm/s390/pv.c
@@ -106,7 +106,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fau=
lt *f)
 	struct pv_make_secure *priv =3D f->priv;
 	struct folio *folio;
 	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	folio =3D pfn_folio(f->pfn);
 	priv->rc =3D -EAGAIN;
diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index ff63ffb1dbd2..b39f939b308e 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -39,14 +39,14 @@
  * * the pointer to the pte corresponding to @addr in @mm, if it can be =
reached
  *   and locked.
  */
-pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, sp=
inlock_t **ptl)
+hw_pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr,=
 spinlock_t **ptl)
 __context_unsafe(/* Returns nonnull if lock taken or not taken */)
 {
 	pmd_t *pmdp, pmd, pmdval;
 	pud_t *pudp, pud;
 	p4d_t *p4dp, p4d;
 	pgd_t *pgdp, pgd;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	pgdp =3D pgd_offset(mm, vmaddr);
 	pgd =3D pgdp_get(pgdp);
@@ -96,7 +96,7 @@ __context_unsafe(/* pte_unmap_unlock() not instrumented=
 */)
 	struct vm_area_struct *vma;
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
 	softleaf_t sl;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	mmap_assert_locked(mm);
=20
@@ -109,8 +109,8 @@ __context_unsafe(/* pte_unmap_unlock() not instrument=
ed */)
 	ptep =3D try_get_locked_pte(mm, vmaddr, &ptl);
 	if (IS_ERR_OR_NULL(ptep))
 		return;
-	sl =3D softleaf_from_pte(*ptep);
-	if (pte_swap(*ptep) && softleaf_is_swap(sl)) {
+	sl =3D softleaf_from_pte(ptep_get(ptep));
+	if (pte_swap(ptep_get(ptep)) && softleaf_is_swap(sl)) {
 		dec_mm_counter(mm, MM_SWAPENTS);
 		swap_put_entries_direct(sl, 1);
 		pte_clear(mm, vmaddr, ptep);
@@ -166,7 +166,7 @@ void gmap_helper_try_set_pte_unused(struct mm_struct =
*mm, unsigned long vmaddr)
 __context_unsafe(/* pte_unmap_unlock() not instrumented */)
 {
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	/*
 	 * Several paths exists that takes the ptl lock and then call the
@@ -184,19 +184,19 @@ __context_unsafe(/* pte_unmap_unlock() not instrume=
nted */)
 	if (IS_ERR_OR_NULL(ptep))
 		return;
=20
-	if (pte_present(*ptep))
+	if (pte_present(ptep_get(ptep)))
 		__atomic64_or(_PAGE_UNUSED, (long *)ptep);
 	pte_unmap_unlock(ptep, ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_helper_try_set_pte_unused);
=20
-static int find_zeropage_pte_entry(pte_t *pte, unsigned long addr,
+static int find_zeropage_pte_entry(hw_pte_t *pte, unsigned long addr,
 				   unsigned long end, struct mm_walk *walk)
 {
 	unsigned long *found_addr =3D walk->private;
=20
 	/* Return 1 of the page is a zeropage. */
-	if (is_zero_pfn(pte_pfn(*pte))) {
+	if (is_zero_pfn(pte_pfn(ptep_get(pte)))) {
 		/*
 		 * Shared zeropage in e.g., a FS DAX mapping? We cannot do the
 		 * right thing and likely don't care: FAULT_FLAG_UNSHARE
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index f84aa9265430..35b7ae166fe6 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -136,7 +136,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 }
=20
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte)
+		     hw_pte_t *ptep, pte_t pte)
 {
 	unsigned long rste;
=20
@@ -156,18 +156,18 @@ void __set_huge_pte_at(struct mm_struct *mm, unsign=
ed long addr,
 }
=20
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte, unsigned long sz)
+		     hw_pte_t *ptep, pte_t pte, unsigned long sz)
 {
 	__set_huge_pte_at(mm, addr, ptep, pte);
 }
=20
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *pte=
p)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, hw_pte_t *=
ptep)
 {
 	return __rste_to_pte(pte_val(ptep_get(ptep)));
 }
=20
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep)
+				unsigned long addr, hw_pte_t *ptep)
 {
 	pte_t pte =3D huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp =3D (pmd_t *) ptep;
@@ -180,7 +180,7 @@ pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
=20
-pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+hw_pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vm=
a,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
@@ -194,15 +194,15 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct =
vm_area_struct *vma,
 		pudp =3D pud_alloc(mm, p4dp, addr);
 		if (pudp) {
 			if (sz =3D=3D PUD_SIZE)
-				return (pte_t *) pudp;
+				return (hw_pte_t *) pudp;
 			else if (sz =3D=3D PMD_SIZE)
 				pmdp =3D pmd_alloc(mm, pudp, addr);
 		}
 	}
-	return (pte_t *) pmdp;
+	return (hw_pte_t *) pmdp;
 }
=20
-pte_t *huge_pte_offset(struct mm_struct *mm,
+hw_pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
@@ -216,12 +216,12 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		if (p4d_present(p4dp_get(p4dp))) {
 			pudp =3D pud_offset(p4dp, addr);
 			if (sz =3D=3D PUD_SIZE)
-				return (pte_t *)pudp;
+				return (hw_pte_t *)pudp;
 			if (pud_present(pudp_get(pudp)))
 				pmdp =3D pmd_offset(pudp, addr);
 		}
 	}
-	return (pte_t *) pmdp;
+	return (hw_pte_t *) pmdp;
 }
=20
 bool __init arch_hugetlb_valid_size(unsigned long size)
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index f39968dd8063..9026d6a3e657 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -22,7 +22,7 @@
 #include <asm/ctlreg.h>
=20
 unsigned long __bootdata_preserved(__memcpy_real_area);
-pte_t *__bootdata_preserved(memcpy_real_ptep);
+hw_pte_t *__bootdata_preserved(memcpy_real_ptep);
 static DEFINE_MUTEX(memcpy_real_mutex);
=20
 static notrace long s390_kernel_write_odd(void *dst, const void *src, si=
ze_t size)
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 1e202e3d08e7..b5a055791611 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -79,7 +79,8 @@ static void pgt_set(unsigned long *old, unsigned long n=
ew, unsigned long addr,
 static int walk_pte_level(pmd_t *pmdp, unsigned long addr, unsigned long=
 end,
 			  unsigned long flags)
 {
-	pte_t *ptep, new;
+	hw_pte_t *ptep;
+	pte_t new;
=20
 	if (flags =3D=3D SET_MEMORY_4K)
 		return 0;
@@ -112,7 +113,7 @@ static int walk_pte_level(pmd_t *pmdp, unsigned long =
addr, unsigned long end,
 static int split_pmd_page(pmd_t *pmdp, unsigned long addr)
 {
 	unsigned long pte_addr, prot;
-	pte_t *pt_dir, *ptep;
+	hw_pte_t *pt_dir, *ptep;
 	pmd_t new, pmd;
 	int i, ro, nx;
=20
@@ -421,7 +422,7 @@ bool kernel_page_present(struct page *page)
=20
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
=20
-static void ipte_range(pte_t *pte, unsigned long address, int nr)
+static void ipte_range(hw_pte_t *pte, unsigned long address, int nr)
 {
 	int i;
=20
@@ -439,7 +440,8 @@ static void ipte_range(pte_t *pte, unsigned long addr=
ess, int nr)
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	unsigned long address;
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
 	int nr, i, j;
=20
 	for (i =3D 0; i < numpages;) {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index da076928b63b..b5eca8bfb539 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -37,7 +37,7 @@ pgprot_t pgprot_writecombine(pgprot_t prot)
 EXPORT_SYMBOL_GPL(pgprot_writecombine);
=20
 static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long a=
ddr,
-				   pte_t *ptep, int nodat)
+				   hw_pte_t *ptep, int nodat)
 {
 	unsigned long opt, asce;
=20
@@ -57,7 +57,7 @@ static inline void ptep_ipte_local(struct mm_struct *mm=
, unsigned long addr,
 }
=20
 static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long =
addr,
-				    pte_t *ptep, int nodat)
+				    hw_pte_t *ptep, int nodat)
 {
 	unsigned long opt, asce;
=20
@@ -77,12 +77,12 @@ static inline void ptep_ipte_global(struct mm_struct =
*mm, unsigned long addr,
 }
=20
 static inline pte_t ptep_flush_direct(struct mm_struct *mm,
-				      unsigned long addr, pte_t *ptep,
+				      unsigned long addr, hw_pte_t *ptep,
 				      int nodat)
 {
 	pte_t old;
=20
-	old =3D *ptep;
+	old =3D ptep_get(ptep);
 	if (unlikely(pte_val(old) & _PAGE_INVALID))
 		return old;
 	atomic_inc(&mm->context.flush_count);
@@ -96,12 +96,12 @@ static inline pte_t ptep_flush_direct(struct mm_struc=
t *mm,
 }
=20
 static inline pte_t ptep_flush_lazy(struct mm_struct *mm,
-				    unsigned long addr, pte_t *ptep,
+				    unsigned long addr, hw_pte_t *ptep,
 				    int nodat)
 {
 	pte_t old;
=20
-	old =3D *ptep;
+	old =3D ptep_get(ptep);
 	if (unlikely(pte_val(old) & _PAGE_INVALID))
 		return old;
 	atomic_inc(&mm->context.flush_count);
@@ -116,7 +116,7 @@ static inline pte_t ptep_flush_lazy(struct mm_struct =
*mm,
 }
=20
 pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
-		       pte_t *ptep, pte_t new)
+		       hw_pte_t *ptep, pte_t new)
 {
 	pte_t old;
=20
@@ -132,7 +132,7 @@ EXPORT_SYMBOL(ptep_xchg_direct);
  * Caller must check that new PTE only differs in _PAGE_PROTECT HW bit, =
so that
  * RDP can be used instead of IPTE. See also comments at pte_allow_rdp()=
.
  */
-void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t=
 *ptep,
+void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, hw_pt=
e_t *ptep,
 			 pte_t new)
 {
 	preempt_disable();
@@ -154,7 +154,7 @@ void ptep_reset_dat_prot(struct mm_struct *mm, unsign=
ed long addr, pte_t *ptep,
 EXPORT_SYMBOL(ptep_reset_dat_prot);
=20
 pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t new)
+		     hw_pte_t *ptep, pte_t new)
 {
 	pte_t old;
=20
@@ -167,13 +167,13 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned=
 long addr,
 EXPORT_SYMBOL(ptep_xchg_lazy);
=20
 pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     pte_t *ptep)
+			     hw_pte_t *ptep)
 {
 	return ptep_flush_lazy(vma->vm_mm, addr, ptep, 1);
 }
=20
 void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     pte_t *ptep, pte_t old_pte, pte_t pte)
+			     hw_pte_t *ptep, pte_t old_pte, pte_t pte)
 {
 	set_pte(ptep, pte);
 }
@@ -333,7 +333,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struc=
t *mm, pmd_t *pmdp)
 {
 	struct list_head *lh;
 	pgtable_t pgtable;
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
=20
@@ -346,7 +346,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struc=
t *mm, pmd_t *pmdp)
 		pmd_huge_pte(mm, pmdp) =3D (pgtable_t) lh->next;
 		list_del(lh);
 	}
-	ptep =3D (pte_t *) pgtable;
+	ptep =3D (hw_pte_t *) pgtable;
 	set_pte(ptep, __pte(_PAGE_INVALID));
 	ptep++;
 	set_pte(ptep, __pte(_PAGE_INVALID));
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index d2879ce860a1..22737319a4c8 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -66,14 +66,14 @@ void *vmem_crst_alloc(unsigned long val)
 	return table;
 }
=20
-pte_t __ref *vmem_pte_alloc(void)
+hw_pte_t __ref *vmem_pte_alloc(void)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	if (slab_is_available())
-		pte =3D (pte_t *)page_table_alloc(&init_mm);
+		pte =3D (hw_pte_t *)page_table_alloc(&init_mm);
 	else
-		pte =3D (pte_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		pte =3D (hw_pte_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!pte)
 		return NULL;
 	memset64((u64 *)pte, _PAGE_INVALID, PTRS_PER_PTE);
@@ -168,7 +168,8 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigne=
d long addr,
 {
 	unsigned long prot, pages =3D 0;
 	int ret =3D -ENOMEM;
-	pte_t *pte, entry;
+	hw_pte_t *pte;
+	pte_t entry;
=20
 	prot =3D pgprot_val(PAGE_KERNEL);
 	pte =3D pte_offset_kernel(pmd, addr);
@@ -204,7 +205,7 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigne=
d long addr,
=20
 static void try_free_pte_table(pmd_t *pmd, unsigned long start)
 {
-	pte_t *pte;
+	hw_pte_t *pte;
 	int i;
=20
 	/* We can safely assume this is fully in 1:1 mapping & vmemmap area */
@@ -226,7 +227,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigne=
d long addr,
 	int ret =3D -ENOMEM;
 	pmd_t entry;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	prot =3D pgprot_val(SEGMENT_KERNEL);
 	pmd =3D pmd_offset(pud, addr);
@@ -575,16 +576,16 @@ int vmem_add_mapping(unsigned long start, unsigned =
long size)
  * while traversing is an error, since the function is expected to be
  * called against virtual regions reserved for 4KB mappings only.
  */
-pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc)
+hw_pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc)
 {
-	pte_t *ptep =3D NULL;
+	hw_pte_t *ptep =3D NULL;
 	pud_t pud_entry;
 	pmd_t pmd_entry;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	hw_pte_t *pte;
=20
 	pgd =3D pgd_offset_k(addr);
 	if (pgd_none(pgdp_get(pgd))) {
@@ -635,7 +636,8 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool al=
loc)
=20
 int __vmem_map_4k_page(unsigned long addr, unsigned long phys, pgprot_t =
prot, bool alloc)
 {
-	pte_t *ptep, pte;
+	hw_pte_t *ptep;
+	pte_t pte;
=20
 	if (!IS_ALIGNED(addr, PAGE_SIZE))
 		return -EINVAL;
@@ -660,7 +662,7 @@ int vmem_map_4k_page(unsigned long addr, unsigned lon=
g phys, pgprot_t prot)
=20
 void vmem_unmap_4k_page(unsigned long addr)
 {
-	pte_t *ptep;
+	hw_pte_t *ptep;
=20
 	mutex_lock(&vmem_mutex);
 	ptep =3D virt_to_kpte(addr);
--=20
2.53.0

