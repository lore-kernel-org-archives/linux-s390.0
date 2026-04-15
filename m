Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02D3A75B7;
	Wed, 15 Apr 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265307; cv=none; b=Mg0cdYqbpsfHKfW37W+wGWJN4vTZUBURT2aWtYvCgEu8Su1rPyaOcJ7AIEnjRF8LJzPPENJwrvoVGZ8xMS1RvAqMp6MKVfbuADYgStvnwUYEbRD8fVo3mdGp943AAdXHvtSncmAn/pzYV0R5dyxJIwgWNMyybTmvKtG6MfXSNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265307; c=relaxed/simple;
	bh=Ukf0eIY3cM6qy660CYQYhIOAx14lSRuBNlkYdYTA35g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7PcBiMFyu+R/KxztjCH0ICGAHKK7M7AxP2nj1seBEb2WTZ8ur7lLIjhZyOdaueg7K4WzSF4KWkiSb3TEhO0FkKQ+a88cidLi+2pn9six+FSWd1BlQwF/4InGZR+0e4ZOPmzfvEmsmq+3QQUtfTodhlEo3kkYT2Iih50+AC29xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pI8bw5KS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pI8bw5KS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F3oHSp1859944;
	Wed, 15 Apr 2026 15:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0A/zWOGsz+Jbonuhb
	TvyKjrAayqkhv17VTlA1Cr86ME=; b=pI8bw5KS6EMB/pzMP6QCpqPd7F5ziy5SV
	0DfVqypQLUBRCAkhsBprDSeDj6wwm5ptF2F5u4MXs3tlGu13Kg+e6PrxDFzhexH0
	Lu36Xidz5rTrELC8nbtMRYXi+I14cICp0r1FC+9CPkCBu483pkIclrNyl5AV9XRz
	TFNXmbU5rurwwQibhYfjeTRj6t+Hj+Es5QuxzB3ZbEWyAaBiDCg45cLb9seJoRbe
	5/VLm71pF2lo/hNFgOkEib2KJGtEBxnAKeSruI6MgEF5c88gh8PoDnIl5WgNgtVl
	7/D8wo7omIfuWv6bWNAfroweYb48NfDdz3Ap3e8Dn1qBOsvoSZwBw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pg6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FC0FpU031854;
	Wed, 15 Apr 2026 15:01:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yetww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FF1P0r61800732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:01:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65D2720043;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288872004D;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D9996E0813; Wed, 15 Apr 2026 17:01:24 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed, 15 Apr 2026 17:01:23 +0200
Message-ID: <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776264097.git.agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0WBwJzt9pQdQk0Iviwvf_2DMgSGZjB1g
X-Proofpoint-ORIG-GUID: 0WBwJzt9pQdQk0Iviwvf_2DMgSGZjB1g
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69dfa849 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=8Wx4H7anEUyLK17-blQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzNyBTYWx0ZWRfX9pkkmPZRArYH
 KM8yoWtugEzA+m2NCTUxwAP7gSUYiin1C2CIIFGzddbi3MQpNPP1iTRePXFaXqMuTBVQZmWPn3B
 +dI2bsiU5t6BgXamEVmXhitGoAOhyzlZiN6QfgZkSzWIlr3vbaiEqwOHTuTC/5rVCo60qWkeOc9
 8BHX0OA6IEWgwJny50CGQex3b28AF7iuf/Gm7rPd5uiF2pBC37a533pIHdmco2WTzwRbRaMaXVT
 zQrbOb3iPnXvbtalRypj2PeAQBE3X9Laz4jCEzf3yU7oLUgv/VTKf3RDYu90sAbvqLGM3bKZo0I
 zDpc10l4sxfCIWYZj0lHeOyGsPY8D17jk0R2OjnToPNdKu8gdGGCJrrHcJiIlVwRH1QWmNu4+SE
 FyFo+g+qE69RhH46pzZgHGK3eMX+gRSlgDuFx9AB/b4hmpF6spFkzPBNoPzR0x7dLNP3P7ekuN2
 VioVF4pIk8WheJX2XsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150137

Make use of the IPTE instruction's "Additional Entries" field to
invalidate multiple PTEs in one go while in lazy MMU mode. This
is the mode in which many memory-management system calls (like
mremap(), mprotect(), etc.) update memory attributes.

To achieve that, the set_pte() and ptep_get() primitives use a
per-CPU cache to store and retrieve PTE values and apply the
cached values to the real page table once lazy MMU mode is left.

The same is done for memory-management platform callbacks that
would otherwise cause intense per-PTE IPTE traffic, reducing the
number of IPTE instructions from up to PTRS_PER_PTE to a single
instruction in the best case. The average reduction is of course
smaller.

Since all existing page table iterators called in lazy MMU mode
handle one table at a time, the per-CPU cache does not need to be
larger than PTRS_PER_PTE entries. That also naturally aligns with
the IPTE instruction, which must not cross a page table boundary.

Before this change, the system calls did:

	lazy_mmu_mode_enable_pte()
	...
	<update PTEs>		// up to PTRS_PER_PTE single-IPTEs
	...
	lazy_mmu_mode_disable()

With this change, the system calls do:

    lazy_mmu_mode_enable_pte()
    ...
    <store new PTE values in the per-CPU cache>
    ...
    lazy_mmu_mode_disable()	// apply cache with one multi-IPTE

When applied to large memory ranges, some system calls show
significant speedups:

    mprotect()    ~15x
    munmap()      ~3x
    mremap()      ~28x

At the same time, fork() shows a measurable slowdown of ~1.5x.

The overall results depend on memory size and access patterns,
but the change generally does not degrade performance.

In addition to a process-wide impact, the rework affects the
whole Central Electronics Complex (CEC). Each (global) IPTE
instruction initiates a quiesce state in a CEC, so reducing
the number of IPTE calls relieves CEC-wide quiesce traffic.

In an extreme case of mprotect() contiguously triggering the
quiesce state on four LPARs in parallel, measurements show
~25x fewer quiesce events.

Assisted-by: gemini:gemini-3.1-pro-preview
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/Kconfig               |  11 +
 arch/s390/include/asm/pgtable.h | 169 ++++++++++++--
 arch/s390/mm/Makefile           |   1 +
 arch/s390/mm/ipte_batch.c       | 378 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |   8 +-
 5 files changed, 545 insertions(+), 22 deletions(-)
 create mode 100644 arch/s390/mm/ipte_batch.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7828fbe0fc42..deffc819268e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -732,6 +732,17 @@ config MAX_PHYSMEM_BITS
 	  Increasing the number of bits also increases the kernel image size.
 	  By default 46 bits (64TB) are supported.
=20
+config IPTE_BATCH
+	def_bool y
+	prompt "Enables Additional Entries for IPTE instruction"
+	select ARCH_HAS_LAZY_MMU_MODE
+	help
+	  This option enables using of "Additional Entries" field of the IPTE
+	  instruction, which capitalizes on the lazy MMU mode infrastructure.
+	  As result, multiple PTEs are invalidated in one go. That improves
+	  performance of many memory-management system calls (like mremap(),
+	  mprotect(), etc.) and decreases CEC-wide quiesce traffic.
+
 endmenu
=20
 menu "I/O subsystem"
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 010a33fec867..39c5d672cf09 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -39,6 +39,71 @@ enum {
=20
 extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
=20
+#if !defined(CONFIG_IPTE_BATCH) || defined(__DECOMPRESSOR)
+static inline
+bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  int *res)
+{
+	return false;
+}
+
+static inline
+bool ipte_batch_ptep_get_and_clear(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	return false;
+}
+
+static inline
+bool ipte_batch_ptep_modify_prot_start(struct vm_area_struct *vma,
+				       unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	return false;
+}
+
+static inline
+bool ipte_batch_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep,
+					pte_t old_pte, pte_t pte)
+{
+	return false;
+}
+
+static inline
+bool ipte_batch_ptep_set_wrprotect(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep)
+{
+	return false;
+}
+
+static inline bool ipte_batch_set_pte(pte_t *ptep, pte_t pte)
+{
+	return false;
+}
+
+static inline bool ipte_batch_ptep_get(pte_t *ptep, pte_t *res)
+{
+	return false;
+}
+#else
+bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  int *res);
+bool ipte_batch_ptep_get_and_clear(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep, pte_t *res);
+bool ipte_batch_ptep_modify_prot_start(struct vm_area_struct *vma,
+				       unsigned long addr, pte_t *ptep, pte_t *res);
+bool ipte_batch_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep,
+					pte_t old_pte, pte_t pte);
+
+bool ipte_batch_ptep_set_wrprotect(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep);
+bool ipte_batch_set_pte(pte_t *ptep, pte_t pte);
+bool ipte_batch_ptep_get(pte_t *ptep, pte_t *res);
+#endif
+
 static inline void update_page_count(int level, long count)
 {
 	if (IS_ENABLED(CONFIG_PROC_FS))
@@ -978,15 +1043,30 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	WRITE_ONCE(*pmdp, pmd);
 }
=20
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void __set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
 }
=20
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	if (!ipte_batch_set_pte(ptep, pte))
+		__set_pte(ptep, pte);
+}
+
+static inline pte_t __ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
 #define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	pte_t res;
+
+	if (!ipte_batch_ptep_get(ptep, &res))
+		res =3D __ptep_get(ptep);
+	return res;
 }
=20
 #define pmdp_get pmdp_get
@@ -1179,6 +1259,20 @@ static __always_inline void __ptep_ipte_range(unsi=
gned long address, int nr,
 	} while (nr !=3D 255);
 }
=20
+#ifdef CONFIG_IPTE_BATCH
+void arch_enter_lazy_mmu_mode_for_pte_range(struct mm_struct *mm,
+					    unsigned long addr, unsigned long end,
+					    pte_t *pte);
+#define arch_enter_lazy_mmu_mode_for_pte_range arch_enter_lazy_mmu_mode_=
for_pte_range
+
+static inline void arch_enter_lazy_mmu_mode(void)
+{
+}
+
+void arch_leave_lazy_mmu_mode(void);
+void arch_flush_lazy_mmu_mode(void);
+#endif
+
 /*
  * This is hard to understand. ptep_get_and_clear and ptep_clear_flush
  * both clear the TLB for the unmapped pte. The reason is that
@@ -1199,10 +1293,16 @@ pte_t ptep_xchg_lazy(struct mm_struct *, unsigned=
 long, pte_t *, pte_t);
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
 {
-	pte_t pte =3D ptep_get(ptep);
+	pte_t pte;
+	int res;
=20
-	pte =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return pte_young(pte);
+	if (!ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, &res)) {
+		pte =3D __ptep_get(ptep);
+		pte =3D pte_mkold(pte);
+		pte =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, pte);
+		res =3D pte_young(pte);
+	}
+	return res;
 }
=20
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
@@ -1218,7 +1318,8 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
ruct *mm,
 {
 	pte_t res;
=20
-	res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	if (!ipte_batch_ptep_get_and_clear(mm, addr, ptep, &res))
+		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
@@ -1227,9 +1328,34 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
 }
=20
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte=
_t *);
-void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
-			     pte_t *, pte_t, pte_t);
+pte_t ___ptep_modify_prot_start(struct vm_area_struct *, unsigned long, =
pte_t *);
+void ___ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
+				pte_t *, pte_t, pte_t);
+
+static inline
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
+			     unsigned long addr, pte_t *ptep)
+{
+	pte_t res;
+
+	if (!ipte_batch_ptep_modify_prot_start(vma, addr, ptep, &res))
+		res =3D ___ptep_modify_prot_start(vma, addr, ptep);
+	return res;
+}
+
+static inline
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
+			     pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+	if (!ipte_batch_ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte))
+		___ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte);
+}
+
+bool ipte_batch_ptep_modify_prot_start(struct vm_area_struct *vma,
+				       unsigned long addr, pte_t *ptep, pte_t *res);
+bool ipte_batch_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep,
+					pte_t old_pte, pte_t pte);
=20
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
@@ -1259,11 +1385,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 {
 	pte_t res;
=20
-	if (full) {
-		res =3D ptep_get(ptep);
-		set_pte(ptep, __pte(_PAGE_INVALID));
-	} else {
-		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	if (!ipte_batch_ptep_get_and_clear(mm, addr, ptep, &res)) {
+		if (full) {
+			res =3D __ptep_get(ptep);
+			__set_pte(ptep, __pte(_PAGE_INVALID));
+		} else {
+			res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+		}
 	}
 	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
@@ -1289,10 +1417,15 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
-	pte_t pte =3D ptep_get(ptep);
+	pte_t pte;
=20
-	if (pte_write(pte))
-		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
+	if (!ipte_batch_ptep_set_wrprotect(mm, addr, ptep)) {
+		pte =3D __ptep_get(ptep);
+		if (pte_write(pte)) {
+			pte =3D pte_wrprotect(pte);
+			ptep_xchg_lazy(mm, addr, ptep, pte);
+		}
+	}
 }
=20
 /*
@@ -1325,7 +1458,7 @@ static inline void flush_tlb_fix_spurious_fault(str=
uct vm_area_struct *vma,
 	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
 	 * A local RDP can be used to do the flush.
 	 */
-	if (cpu_has_rdp() && !(pte_val(ptep_get(ptep)) & _PAGE_PROTECT))
+	if (cpu_has_rdp() && !(pte_val(__ptep_get(ptep)) & _PAGE_PROTECT))
 		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index 193899c39ca7..0f6c6de447d4 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_DEBUG_VIRTUAL)	+=3D physaddr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+=3D hugetlbpage.o
 obj-$(CONFIG_PTDUMP)		+=3D dump_pagetables.o
 obj-$(CONFIG_PFAULT)		+=3D pfault.o
+obj-$(CONFIG_IPTE_BATCH)	+=3D ipte_batch.o
=20
 obj-$(subst m,y,$(CONFIG_KVM))	+=3D gmap_helpers.o
diff --git a/arch/s390/mm/ipte_batch.c b/arch/s390/mm/ipte_batch.c
new file mode 100644
index 000000000000..cc4c50347d0f
--- /dev/null
+++ b/arch/s390/mm/ipte_batch.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pgtable.h>
+#include <asm/facility.h>
+#include <kunit/visibility.h>
+
+#define PTE_POISON	0
+
+struct ipte_batch {
+	struct mm_struct *mm;
+	unsigned long base_addr;
+	unsigned long base_end;
+	pte_t *base_pte;
+	pte_t *start_pte;
+	pte_t *end_pte;
+	pte_t cache[PTRS_PER_PTE];
+};
+
+static DEFINE_PER_CPU(struct ipte_batch, ipte_range);
+
+static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
+{
+	pte_t pte =3D __ptep_get(start);
+	pte_t *ptep;
+
+	*valid =3D !(pte_val(pte) & _PAGE_INVALID);
+
+	for (ptep =3D start + 1; ptep < end; ptep++) {
+		pte =3D __ptep_get(ptep);
+		if (*valid) {
+			if (pte_val(pte) & _PAGE_INVALID)
+				break;
+		} else {
+			if (!(pte_val(pte) & _PAGE_INVALID))
+				break;
+		}
+	}
+
+	return ptep - start;
+}
+
+static void __invalidate_pte_range(struct mm_struct *mm, unsigned long a=
ddr,
+				   int nr_ptes, pte_t *ptep)
+{
+	atomic_inc(&mm->context.flush_count);
+	if (cpu_has_tlb_lc() &&
+	    cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
+		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_LOCAL);
+	else
+		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_GLOBAL);
+	atomic_dec(&mm->context.flush_count);
+}
+
+static int invalidate_pte_range(struct mm_struct *mm, unsigned long addr=
,
+				pte_t *start, pte_t *end)
+{
+	int nr_ptes;
+	bool valid;
+
+	nr_ptes =3D count_contiguous(start, end, &valid);
+	if (valid)
+		__invalidate_pte_range(mm, addr, nr_ptes, start);
+
+	return nr_ptes;
+}
+
+static void set_pte_range(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t *end, pte_t *cache)
+{
+	int i, nr_ptes;
+
+	while (ptep < end) {
+		nr_ptes =3D invalidate_pte_range(mm, addr, ptep, end);
+
+		for (i =3D 0; i < nr_ptes; i++, ptep++, cache++) {
+			__set_pte(ptep, *cache);
+			*cache =3D __pte(PTE_POISON);
+		}
+
+		addr +=3D nr_ptes * PAGE_SIZE;
+	}
+}
+
+static void enter_ipte_batch(struct mm_struct *mm,
+			     unsigned long addr, unsigned long end, pte_t *pte)
+{
+	struct ipte_batch *ib;
+
+	ib =3D &get_cpu_var(ipte_range);
+
+	ib->mm =3D mm;
+	ib->base_addr =3D addr;
+	ib->base_end =3D end;
+	ib->base_pte =3D pte;
+}
+
+static void leave_ipte_batch(void)
+{
+	pte_t *ptep, *start, *start_cache, *cache;
+	unsigned long start_addr, addr;
+	struct ipte_batch *ib;
+	int start_idx;
+
+	ib =3D &get_cpu_var(ipte_range);
+	if (!ib->mm) {
+		put_cpu_var(ipte_range);
+		return;
+	}
+	put_cpu_var(ipte_range);
+
+	lockdep_assert_preemption_disabled();
+	if (!ib->start_pte)
+		goto done;
+
+	start =3D ib->start_pte;
+	start_idx =3D ib->start_pte - ib->base_pte;
+	start_addr =3D ib->base_addr + start_idx * PAGE_SIZE;
+	addr =3D start_addr;
+	start_cache =3D &ib->cache[start_idx];
+	cache =3D start_cache;
+	for (ptep =3D start; ptep < ib->end_pte; ptep++, cache++, addr +=3D PAG=
E_SIZE) {
+		if (pte_val(*cache) =3D=3D PTE_POISON) {
+			if (start) {
+				set_pte_range(ib->mm, start_addr, start, ptep, start_cache);
+				start =3D NULL;
+			}
+		} else if (!start) {
+			start =3D ptep;
+			start_addr =3D addr;
+			start_cache =3D cache;
+		}
+	}
+	set_pte_range(ib->mm, start_addr, start, ptep, start_cache);
+
+	ib->start_pte =3D NULL;
+	ib->end_pte =3D NULL;
+
+done:
+	ib->mm =3D NULL;
+	ib->base_addr =3D 0;
+	ib->base_end =3D 0;
+	ib->base_pte =3D NULL;
+
+	put_cpu_var(ipte_range);
+}
+
+static void flush_lazy_mmu_mode(void)
+{
+	unsigned long addr, end;
+	struct ipte_batch *ib;
+	struct mm_struct *mm;
+	pte_t *pte;
+
+	ib =3D &get_cpu_var(ipte_range);
+	if (ib->mm) {
+		mm =3D ib->mm;
+		addr =3D ib->base_addr;
+		end =3D ib->base_end;
+		pte =3D ib->base_pte;
+
+		leave_ipte_batch();
+		enter_ipte_batch(mm, addr, end, pte);
+	}
+	put_cpu_var(ipte_range);
+}
+
+void arch_enter_lazy_mmu_mode_for_pte_range(struct mm_struct *mm,
+					    unsigned long addr, unsigned long end,
+					    pte_t *pte)
+{
+	if (!test_facility(13))
+		return;
+	enter_ipte_batch(mm, addr, end, pte);
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode_for_pte_range);
+
+void arch_leave_lazy_mmu_mode(void)
+{
+	if (!test_facility(13))
+		return;
+	leave_ipte_batch();
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_leave_lazy_mmu_mode);
+
+void arch_flush_lazy_mmu_mode(void)
+{
+	if (!test_facility(13))
+		return;
+	flush_lazy_mmu_mode();
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_flush_lazy_mmu_mode);
+
+static void __ipte_batch_set_pte(struct ipte_batch *ib, pte_t *ptep, pte=
_t pte)
+{
+	unsigned int idx =3D ptep - ib->base_pte;
+
+	lockdep_assert_preemption_disabled();
+	ib->cache[idx] =3D pte;
+
+	if (!ib->start_pte) {
+		ib->start_pte =3D ptep;
+		ib->end_pte =3D ptep + 1;
+	} else if (ptep < ib->start_pte) {
+		ib->start_pte =3D ptep;
+	} else if (ptep + 1 > ib->end_pte) {
+		ib->end_pte =3D ptep + 1;
+	}
+}
+
+static pte_t __ipte_batch_ptep_get(struct ipte_batch *ib, pte_t *ptep)
+{
+	unsigned int idx =3D ptep - ib->base_pte;
+
+	lockdep_assert_preemption_disabled();
+	if (pte_val(ib->cache[idx]) =3D=3D PTE_POISON)
+		return __ptep_get(ptep);
+	return ib->cache[idx];
+}
+
+static bool lazy_mmu_mode(struct ipte_batch *ib, struct mm_struct *mm, p=
te_t *ptep)
+{
+	unsigned int nr_ptes;
+
+	lockdep_assert_preemption_disabled();
+	if (!is_lazy_mmu_mode_active())
+		return false;
+	if (!mm)
+		return false;
+	if (!ib->mm)
+		return false;
+	if (ptep < ib->base_pte)
+		return false;
+	nr_ptes =3D (ib->base_end - ib->base_addr) / PAGE_SIZE;
+	if (ptep >=3D ib->base_pte + nr_ptes)
+		return false;
+	return true;
+}
+
+static struct ipte_batch *get_ipte_batch_nomm(pte_t *ptep)
+{
+	struct ipte_batch *ib;
+
+	ib =3D &get_cpu_var(ipte_range);
+	if (!lazy_mmu_mode(ib, ib->mm, ptep)) {
+		put_cpu_var(ipte_range);
+		return NULL;
+	}
+
+	return ib;
+}
+
+static struct ipte_batch *get_ipte_batch(struct mm_struct *mm, pte_t *pt=
ep)
+{
+	struct ipte_batch *ib;
+
+	ib =3D &get_cpu_var(ipte_range);
+	if (!lazy_mmu_mode(ib, mm, ptep)) {
+		put_cpu_var(ipte_range);
+		return NULL;
+	}
+
+	return ib;
+}
+
+static void put_ipte_batch(struct ipte_batch *ib)
+{
+	put_cpu_var(ipte_range);
+}
+
+bool ipte_batch_set_pte(pte_t *ptep, pte_t pte)
+{
+	struct ipte_batch *ib;
+
+	ib =3D get_ipte_batch_nomm(ptep);
+	if (!ib)
+		return false;
+	__ipte_batch_set_pte(ib, ptep, pte);
+	put_ipte_batch(ib);
+
+	return true;
+}
+
+bool ipte_batch_ptep_get(pte_t *ptep, pte_t *res)
+{
+	struct ipte_batch *ib;
+
+	ib =3D get_ipte_batch_nomm(ptep);
+	if (!ib)
+		return false;
+	*res =3D __ipte_batch_ptep_get(ib, ptep);
+	put_ipte_batch(ib);
+
+	return true;
+}
+
+bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  int *res)
+{
+	struct ipte_batch *ib;
+	pte_t pte, old;
+
+	ib =3D get_ipte_batch(vma->vm_mm, ptep);
+	if (!ib)
+		return false;
+
+	old =3D __ipte_batch_ptep_get(ib, ptep);
+	pte =3D pte_mkold(old);
+	__ipte_batch_set_pte(ib, ptep, pte);
+
+	put_ipte_batch(ib);
+
+	*res =3D pte_young(old);
+
+	return true;
+}
+
+bool ipte_batch_ptep_get_and_clear(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	struct ipte_batch *ib;
+	pte_t pte, old;
+
+	ib =3D get_ipte_batch(mm, ptep);
+	if (!ib)
+		return false;
+
+	old =3D __ipte_batch_ptep_get(ib, ptep);
+	pte =3D __pte(_PAGE_INVALID);
+	__ipte_batch_set_pte(ib, ptep, pte);
+
+	put_ipte_batch(ib);
+
+	*res =3D old;
+
+	return true;
+}
+
+bool ipte_batch_ptep_modify_prot_start(struct vm_area_struct *vma,
+				       unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	return ipte_batch_ptep_get_and_clear(vma->vm_mm, addr, ptep, res);
+}
+
+bool ipte_batch_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep,
+					pte_t old_pte, pte_t pte)
+{
+	struct ipte_batch *ib;
+
+	ib =3D get_ipte_batch(vma->vm_mm, ptep);
+	if (!ib)
+		return false;
+	__ipte_batch_set_pte(ib, ptep, pte);
+	put_ipte_batch(ib);
+
+	return true;
+}
+
+bool ipte_batch_ptep_set_wrprotect(struct mm_struct *mm,
+				   unsigned long addr, pte_t *ptep)
+{
+	struct ipte_batch *ib;
+	pte_t pte;
+
+	ib =3D get_ipte_batch(mm, ptep);
+	if (!ib)
+		return false;
+
+	pte =3D __ipte_batch_ptep_get(ib, ptep);
+	if (pte_write(pte)) {
+		pte =3D pte_wrprotect(pte);
+		__ipte_batch_set_pte(ib, ptep, pte);
+	}
+
+	put_ipte_batch(ib);
+
+	return true;
+}
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4acd8b140c4b..df36523bcbbb 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -166,14 +166,14 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned=
 long addr,
 }
 EXPORT_SYMBOL(ptep_xchg_lazy);
=20
-pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     pte_t *ptep)
+pte_t ___ptep_modify_prot_start(struct vm_area_struct *vma, unsigned lon=
g addr,
+				pte_t *ptep)
 {
 	return ptep_flush_lazy(vma->vm_mm, addr, ptep, 1);
 }
=20
-void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     pte_t *ptep, pte_t old_pte, pte_t pte)
+void ___ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned lon=
g addr,
+				pte_t *ptep, pte_t old_pte, pte_t pte)
 {
 	set_pte(ptep, pte);
 }
--=20
2.51.0

