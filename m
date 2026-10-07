Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347423914FE;
	Wed,  7 Oct 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373367; cv=none; b=NhSO0G3z39NIPc4AwwTHNaHsZuOgkpM8cZobtYyul1mchg8THQqBMXsdNPY/lvmcHyDlrbifkj1LaVzcShpFpPSx1gublWhTEgsrZdJ088tUUEeXTZjqlAHkkMWsswRo7pvmhjys3FPRhLUty0opz/4daKKXJNIpzU4f2mQHsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373367; c=relaxed/simple;
	bh=5xgyTe6jEuW47eVObP0SAE8zAWG3atb2LSGaeorSozA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcfsQu/5jKtdm64NVsm+jbuLkl9QcedSs3BkATz9N+Mn+Y3T8JnKTmLEz6upheZS0nSaR79oQhiRRJ2OwTI+fczFqhex+SMmN/TO1IVVpuUrAHG0JP4yKu/KkwWRf3XE6/VDKXnbgzIIT2d9eqRPruNyKYp60IewEGQJ0Cn8opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qeM4vd8X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qeM4vd8X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZMvp2462970;
	Wed, 7 Oct 2026 11:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8Jl5T02Ro2aNnUlwN
	CRckZLXZG8i8OP4zkXd5EBwhzs=; b=qeM4vd8XzkZaIISIT2kVUO4LyXN2oL5ZL
	4+sQil1aTAMyOUjxyS9lnaJYbgr5BpCg+M8ugmSqMnVnHJT+qVEUqOStPwck8kqN
	yCADxBXf8ansAI33KmypTh9LiRpQmfqBYnuqvBfPAyD/Ola6ERgprAtXNqMALnxS
	tgRChgzmzZ/cMVhPevkdpPz7ggGMxIrCGB7SkSesVAsvz3HZxZgcPo3/N5Scpsei
	hb6nDaKKH5krnQG7XIIK/6h0zPl5+qdSlpEE+mfhWNc0KAIaR67l50brR9TloEm8
	/F6WzE0MjzNG1qdovHnJWwjgFyAbOI3fBUw5Kxyh6RnH7HpdDv1SQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w8c8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX76e1852628;
	Wed, 7 Oct 2026 11:42:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxaug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxSQ45154634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E9C20043;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD562004B;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 94D7B160B3D; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 13/15] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed,  7 Oct 2026 13:41:56 +0200
Message-ID: <277e24d315e55592c367ac0c347d44cac5e429f4.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ma9NJhW9jfMMdMclT6fKa__9aJBrC4fR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX4d+8YeAvVeiv
 b66p9Q2xPPOHFmS65xVCYDdnj4GzL1434mqGbGVWTPUs2dp9ReG1yjyQzbdR48wFOHJ+Q1/A0Tg
 Qylbq255SsGzBfNNEuofJr0kEbbt9gk=
X-Proofpoint-GUID: ovfD8tBShJU2-nxIXnuLa2Hp2t5EE8TM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX49DRnFpe3m0E
 oZqkNk3Io2tuqKlp1NZujOoVkbv1/bC9FSI+4epOF25pAd79bsv/+/Yneb/8pTNzNXDavyum840
 CK5WG2rrSMf87XeX16H/91MHSjwacdDJb5pZVgT1bDtAER3qcjH8Yt14kOCQAJv6j70TKzNm2Xl
 zIGwQxwQLrPjMkiPxLx4JwIYxPx2kUzMZDs+kHMXY4WaU7cCCS+hMRJ8PKgwWmZDaibiSyGgW4v
 gng4Ep3xKgSV/ExkfJuf2aB53wDsbs+Cj+xaGI8wFwqXWVOvXDbnX8OugYwfZblyukSv9WKGfjO
 GsNv/M9vK19Z+FkbetODxVq7drCSa/3pzFhosEQDdC8LyuL3OUnFnyob477GXipNl/StmGtZ4ym
 CBKjuoIYq4S2KZQ5pFZQixdQ0NwyylgrK4VSyruyFLY8hjC8kjwI3ytsHN7UzX7tWauz6frQuUt
 gvDqSdbakVvBNIClbag==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6300d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=AyY4689rd8yq8cz3YkUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

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

    lazy_mmu_mode_enable_with_ptes()
    ...
    <update PTEs>		// up to PTRS_PER_PTE single-IPTEs
    ...
    lazy_mmu_mode_disable()

With this change, the system calls do:

    lazy_mmu_mode_enable_with_ptes()
    ...
    <store new PTE values in the per-CPU cache>
    ...
    lazy_mmu_mode_disable()	// apply cache with one multi-IPTE

When applied to large memory ranges, some system calls show
significant speedups:

    mprotect()    ~15x
    munmap()      ~3x
    mremap()      ~28x

The overall results depend on memory size and access patterns,
but the change generally does not degrade performance.

In addition to a process-wide impact, the rework affects the
whole Central Electronics Complex (CEC). Each (global) IPTE
instruction initiates a quiesce state in a CEC, so reducing
the number of IPTE calls relieves CEC-wide quiesce traffic.

In an extreme case of mprotect() contiguously triggering the
quiesce state on four LPARs in parallel, measurements show
~25x fewer quiesce events.

If an interrupt arrives in the middle of enter_ipte_range() or
leave_ipte_range() the state of the per-cpu struct ipte_range
may be inconsistent. That could lead to crashes if the interrupt
handler tries to access a PTE. e.g:

handle_softirqs()->...->free_percpu()->pcpu_chunk_addr_search()->
pcpu_addr_to_page()->vmalloc_to_page()->ptep_get()

To avoid that disable bottom halves on the lazy mmu mode entering
or leaving.

Though unexpected nothing prevents a top half from accessing a PTE
that belongs to an active lazy mmu mode range. In that case do
VM_BUG_ON() and consider disabling the interrupts altogether if it
ever hits.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/Kconfig               |   1 +
 arch/s390/include/asm/lowcore.h |   3 +-
 arch/s390/include/asm/pgtable.h | 163 ++++++++++--
 arch/s390/mm/Makefile           |   2 +-
 arch/s390/mm/lazy_mmu.c         | 430 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |   8 +-
 6 files changed, 583 insertions(+), 24 deletions(-)
 create mode 100644 arch/s390/mm/lazy_mmu.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b9bc0e5e7d7d..65482c3c8588 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -102,6 +102,7 @@ config S390
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_HW_PTE_T
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_LAZY_MMU_MODE
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowc=
ore.h
index 5cef215d30e7..6ec815e7feed 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -175,7 +175,8 @@ struct lowcore {
=20
 	__u32	return_lpswe;			/* 0x0400 */
 	__u32	return_mcck_lpswe;		/* 0x0404 */
-	__u8	pad_0x040a[0x0e00-0x0408];	/* 0x0408 */
+	__u8	lazy_mmu_count;			/* 0x0408 */
+	__u8	pad_0x0409[0x0e00-0x0409];	/* 0x0409 */
=20
 	/*
 	 * 0xe00 contains the address of the IPL Parameter Information
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index c47264f3abf2..decce76fac74 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -39,6 +39,76 @@ enum {
=20
 extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
=20
+bool __lazy_mmu_ptep_test_and_clear_young(unsigned long addr, hw_pte_t *=
ptep, int *res);
+bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, hw_pte_t *ptep, p=
te_t *res);
+bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, hw_pte_t *pte=
p, pte_t *res);
+bool __lazy_mmu_ptep_modify_prot_commit(unsigned long addr, hw_pte_t *pt=
ep, pte_t old_pte, pte_t pte);
+bool __lazy_mmu_ptep_set_wrprotect(unsigned long addr, hw_pte_t *ptep);
+bool __lazy_mmu_set_pte(hw_pte_t *ptep, pte_t pte);
+bool __lazy_mmu_ptep_get(hw_pte_t *ptep, pte_t *res);
+
+static __always_inline bool is_lazy_mmu_active(void)
+{
+	unsigned long lc_lazy_mmu_count;
+	int cc;
+
+	if (__is_defined(__DECOMPRESSOR))
+		return false;
+	lc_lazy_mmu_count =3D offsetof(struct lowcore, lazy_mmu_count);
+	asm_inline(
+		ALTERNATIVE("	cliy	%[offzero](%%r0),0\n",
+			    "	cliy	%[offalt](%%r0),0\n",
+			    ALT_FEATURE(MFEATURE_LOWCORE))
+		CC_IPM(cc)
+		: CC_OUT(cc, cc)
+		: [offzero] "i" (lc_lazy_mmu_count),
+		  [offalt] "i" (lc_lazy_mmu_count + LOWCORE_ALT_ADDRESS),
+		  "m" (((struct lowcore *)0)->lazy_mmu_count)
+		: CC_CLOBBER);
+	return CC_TRANSFORM(cc);
+}
+
+static inline
+bool lazy_mmu_ptep_test_and_clear_young(unsigned long addr, hw_pte_t *pt=
ep, int *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_test_and_clear_young(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_get_and_clear(unsigned long addr, hw_pte_t *ptep, pte=
_t *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_modify_prot_start(unsigned long addr, hw_pte_t *ptep,=
 pte_t *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_modify_prot_start(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_modify_prot_commit(unsigned long addr, hw_pte_t *ptep=
,
+				      pte_t old_pte, pte_t pte)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_modify_prot_commit(addr, ptep, old_pte, pte);
+}
+
+static inline
+bool lazy_mmu_ptep_set_wrprotect(unsigned long addr, hw_pte_t *ptep)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_set_wrprotect(addr, ptep);
+}
+
 static inline void update_page_count(int level, long count)
 {
 	if (IS_ENABLED(CONFIG_PROC_FS))
@@ -978,7 +1048,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	WRITE_ONCE(*pmdp, pmd);
 }
=20
-static inline void set_pte(hw_pte_t *ptep, pte_t pte)
+static inline void __set_pte(hw_pte_t *ptep, pte_t pte)
 {
 	hw_pte_t hwpte =3D (hw_pte_t) { (pte) };
=20
@@ -987,10 +1057,25 @@ static inline void set_pte(hw_pte_t *ptep, pte_t p=
te)
 	WRITE_ONCE(*ptep, hwpte);
 }
=20
+static inline void set_pte(hw_pte_t *ptep, pte_t pte)
+{
+	if (!is_lazy_mmu_active() || !__lazy_mmu_set_pte(ptep, pte))
+		__set_pte(ptep, pte);
+}
+
+static inline pte_t __ptep_get(hw_pte_t *ptep)
+{
+	return __pte_from_hw(READ_ONCE(*ptep));
+}
+
 #define ptep_get ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return __pte_from_hw(READ_ONCE(*ptep));
+	pte_t res;
+
+	if (!is_lazy_mmu_active() || !__lazy_mmu_ptep_get(ptep, &res))
+		res =3D __ptep_get(ptep);
+	return res;
 }
=20
 #define pmdp_get pmdp_get
@@ -1183,6 +1268,15 @@ static __always_inline void __ptep_ipte_range(unsi=
gned long address, int nr,
 	} while (nr !=3D 255);
 }
=20
+void arch_enter_lazy_mmu_mode_with_ptes(struct mm_struct *mm,
+					unsigned long addr, unsigned long end,
+					hw_pte_t *pte);
+#define arch_enter_lazy_mmu_mode_with_ptes arch_enter_lazy_mmu_mode_with=
_ptes
+
+void arch_enter_lazy_mmu_mode(void);
+void arch_leave_lazy_mmu_mode(void);
+void arch_flush_lazy_mmu_mode(void);
+
 /*
  * This is hard to understand. ptep_get_and_clear and ptep_clear_flush
  * both clear the TLB for the unmapped pte. The reason is that
@@ -1203,10 +1297,16 @@ pte_t ptep_xchg_lazy(struct mm_struct *, unsigned=
 long, hw_pte_t *, pte_t);
 static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long addr, hw_pte_t *ptep)
 {
-	pte_t pte =3D ptep_get(ptep);
+	pte_t pte;
+	int res;
=20
-	pte =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return pte_young(pte);
+	if (!lazy_mmu_ptep_test_and_clear_young(addr, ptep, &res)) {
+		pte =3D __ptep_get(ptep);
+		pte =3D pte_mkold(pte);
+		pte =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, pte);
+		res =3D pte_young(pte);
+	}
+	return res;
 }
=20
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
@@ -1222,7 +1322,8 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
ruct *mm,
 {
 	pte_t res;
=20
-	res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res))
+		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
@@ -1231,9 +1332,28 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
 }
=20
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, hw_=
pte_t *);
-void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
-			     hw_pte_t *, pte_t, pte_t);
+pte_t ___ptep_modify_prot_start(struct vm_area_struct *, unsigned long, =
hw_pte_t *);
+void ___ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
+				hw_pte_t *, pte_t, pte_t);
+
+static inline
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
+			     unsigned long addr, hw_pte_t *ptep)
+{
+	pte_t res;
+
+	if (!lazy_mmu_ptep_modify_prot_start(addr, ptep, &res))
+		res =3D ___ptep_modify_prot_start(vma, addr, ptep);
+	return res;
+}
+
+static inline
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
+			     hw_pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+	if (!lazy_mmu_ptep_modify_prot_commit(addr, ptep, old_pte, pte))
+		___ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte);
+}
=20
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
@@ -1263,11 +1383,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 {
 	pte_t res;
=20
-	if (full) {
-		res =3D ptep_get(ptep);
-		set_pte(ptep, __pte(_PAGE_INVALID));
-	} else {
-		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {
+		if (full) {
+			res =3D __ptep_get(ptep);
+			__set_pte(ptep, __pte(_PAGE_INVALID));
+		} else {
+			res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+		}
 	}
 	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
@@ -1293,10 +1415,15 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, hw_pte_t *ptep)
 {
-	pte_t pte =3D ptep_get(ptep);
+	pte_t pte;
=20
-	if (pte_write(pte))
-		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
+	if (!lazy_mmu_ptep_set_wrprotect(addr, ptep)) {
+		pte =3D __ptep_get(ptep);
+		if (pte_write(pte)) {
+			pte =3D pte_wrprotect(pte);
+			ptep_xchg_lazy(mm, addr, ptep, pte);
+		}
+	}
 }
=20
 /*
@@ -1329,7 +1456,7 @@ static inline void flush_tlb_fix_spurious_fault(str=
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
index 7dea37a5ad3b..6a9f856a94c1 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -5,7 +5,7 @@
=20
 CONTEXT_ANALYSIS :=3D y
=20
-obj-y		:=3D init.o fault.o extmem.o mmap.o vmem.o maccess.o
+obj-y		:=3D init.o fault.o extmem.o mmap.o vmem.o maccess.o lazy_mmu.o
 obj-y		+=3D page-states.o pageattr.o pgtable.o pgalloc.o extable.o
=20
 obj-$(CONFIG_CMM)		+=3D cmm.o
diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
new file mode 100644
index 000000000000..8c1a62f23736
--- /dev/null
+++ b/arch/s390/mm/lazy_mmu.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pgtable.h>
+#include <linux/kasan.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <asm/facility.h>
+#include <kunit/visibility.h>
+
+#define PTE_POISON	_PAGE_LARGE
+
+struct ipte_range {
+	struct mm_struct *mm;
+	unsigned long base_addr;
+	unsigned long base_end;
+	hw_pte_t *base_pte;
+	hw_pte_t *start_pte;
+	hw_pte_t *end_pte;
+	pte_t cache[PTRS_PER_PTE];
+};
+
+static DEFINE_PER_CPU(struct ipte_range *, ipte_range);
+static DEFINE_STATIC_KEY_FALSE(lazy_mmu_enabled);
+
+static int count_contiguous(hw_pte_t *start, hw_pte_t *end, bool *valid)
+{
+	unsigned long page_invalid_bit;
+	hw_pte_t *ptep;
+	pte_t pte;
+
+	pte =3D __ptep_get(start);
+	page_invalid_bit =3D pte_val(pte) & _PAGE_INVALID;
+
+	for (ptep =3D start + 1; ptep < end; ptep++) {
+		pte =3D __ptep_get(ptep);
+		if ((pte_val(pte) & _PAGE_INVALID) !=3D page_invalid_bit)
+			break;
+	}
+
+	*valid =3D !(page_invalid_bit);
+	return ptep - start;
+}
+
+static void __invalidate_pte_range(struct mm_struct *mm, unsigned long a=
ddr,
+				   int nr_ptes, hw_pte_t *ptep)
+{
+	atomic_inc(&mm->context.flush_count);
+	if (cpu_has_tlb_lc() && cpumask_equal(mm_cpumask(mm), cpumask_of(smp_pr=
ocessor_id())))
+		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_LOCAL);
+	else
+		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_GLOBAL);
+	atomic_dec(&mm->context.flush_count);
+}
+
+static int invalidate_pte_range(struct mm_struct *mm, unsigned long addr=
,
+				hw_pte_t *start, hw_pte_t *end)
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
+			  hw_pte_t *ptep, hw_pte_t *end, pte_t *cache)
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
+static void enter_ipte_norange(void)
+{
+	struct ipte_range __maybe_unused *range;
+
+	if (!static_branch_likely(&lazy_mmu_enabled))
+		return;
+
+	range =3D get_cpu_var(ipte_range);
+	local_bh_disable();
+	get_lowcore()->lazy_mmu_count++;
+	local_bh_enable();
+}
+
+static void enter_ipte_range(struct mm_struct *mm,
+			     unsigned long addr, unsigned long end, hw_pte_t *pte)
+{
+	struct ipte_range *range;
+
+	if (!static_branch_likely(&lazy_mmu_enabled))
+		return;
+
+	range =3D get_cpu_var(ipte_range);
+	local_bh_disable();
+	get_lowcore()->lazy_mmu_count++;
+
+	if (mm_is_protected(mm)) {
+		local_bh_enable();
+		return;
+	}
+
+	range->mm =3D mm;
+	range->base_addr =3D addr;
+	range->base_end =3D end;
+	range->base_pte =3D pte;
+
+	local_bh_enable();
+}
+
+static void leave_ipte_range(void)
+{
+	unsigned long start_addr, addr;
+	pte_t *start_cache, *cache;
+	hw_pte_t *ptep, *start;
+	struct ipte_range *range;
+	int start_idx;
+
+	if (!static_branch_likely(&lazy_mmu_enabled))
+		return;
+
+	lockdep_assert_preemption_disabled();
+	range =3D this_cpu_read(ipte_range);
+	local_bh_disable();
+
+	if (!range->mm)
+		goto norange;
+	if (!range->start_pte)
+		goto done;
+
+	start =3D range->start_pte;
+	start_idx =3D range->start_pte - range->base_pte;
+	start_addr =3D range->base_addr + start_idx * PAGE_SIZE;
+	addr =3D start_addr;
+	start_cache =3D &range->cache[start_idx];
+	cache =3D start_cache;
+	for (ptep =3D start; ptep < range->end_pte; ptep++, cache++, addr +=3D =
PAGE_SIZE) {
+		if (pte_val(*cache) =3D=3D PTE_POISON) {
+			if (start) {
+				set_pte_range(range->mm, start_addr, start, ptep, start_cache);
+				start =3D NULL;
+			}
+		} else if (!start) {
+			start =3D ptep;
+			start_addr =3D addr;
+			start_cache =3D cache;
+		}
+	}
+	set_pte_range(range->mm, start_addr, start, ptep, start_cache);
+
+	range->start_pte =3D NULL;
+	range->end_pte =3D NULL;
+
+done:
+	range->mm =3D NULL;
+	range->base_addr =3D 0;
+	range->base_end =3D 0;
+	range->base_pte =3D NULL;
+
+norange:
+	get_lowcore()->lazy_mmu_count--;
+	local_bh_enable();
+
+	put_cpu_var(ipte_range);
+}
+
+static void flush_lazy_mmu_mode(void)
+{
+	unsigned long addr, end;
+	struct ipte_range *range;
+	struct mm_struct *mm;
+	hw_pte_t *pte;
+
+	if (!static_branch_likely(&lazy_mmu_enabled))
+		return;
+
+	range =3D get_cpu_var(ipte_range);
+	if (range->mm) {
+		mm =3D range->mm;
+		addr =3D range->base_addr;
+		end =3D range->base_end;
+		pte =3D range->base_pte;
+
+		leave_ipte_range();
+		enter_ipte_range(mm, addr, end, pte);
+	}
+	put_cpu_var(ipte_range);
+}
+
+void arch_enter_lazy_mmu_mode(void)
+{
+	enter_ipte_norange();
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode);
+
+void arch_enter_lazy_mmu_mode_with_ptes(struct mm_struct *mm,
+					unsigned long addr, unsigned long end,
+					hw_pte_t *pte)
+{
+	enter_ipte_range(mm, addr, end, pte);
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode_with_ptes);
+
+void arch_leave_lazy_mmu_mode(void)
+{
+	leave_ipte_range();
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_leave_lazy_mmu_mode);
+
+void arch_flush_lazy_mmu_mode(void)
+{
+	flush_lazy_mmu_mode();
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_flush_lazy_mmu_mode);
+
+static void __ipte_range_set_pte(struct ipte_range *range, hw_pte_t *pte=
p, pte_t pte)
+{
+	unsigned int idx =3D ptep - range->base_pte;
+
+	lockdep_assert_preemption_disabled();
+	range->cache[idx] =3D pte;
+
+	if (!range->start_pte) {
+		range->start_pte =3D ptep;
+		range->end_pte =3D ptep + 1;
+	} else if (ptep < range->start_pte) {
+		range->start_pte =3D ptep;
+	} else if (ptep + 1 > range->end_pte) {
+		range->end_pte =3D ptep + 1;
+	}
+}
+
+static pte_t __ipte_range_ptep_get(struct ipte_range *range, hw_pte_t *p=
tep)
+{
+	unsigned int idx =3D ptep - range->base_pte;
+
+	lockdep_assert_preemption_disabled();
+	if (pte_val(range->cache[idx]) =3D=3D PTE_POISON)
+		return __ptep_get(ptep);
+	return range->cache[idx];
+}
+
+static struct ipte_range *this_ipte_range(hw_pte_t *ptep)
+{
+	struct ipte_range *range;
+	unsigned int nr_ptes;
+
+	range =3D this_cpu_read(ipte_range);
+	if (ptep < range->base_pte)
+		return NULL;
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	if (ptep >=3D range->base_pte + nr_ptes)
+		return NULL;
+
+	/*
+	 * The user pages are not expected to get accessed from a
+	 * hardware interrupt handler. Should such a code exist,
+	 * not only bottom, but also top halves must be disabled.
+	 */
+	VM_BUG_ON(in_hardirq());
+
+	return range;
+}
+
+bool __lazy_mmu_set_pte(hw_pte_t *ptep, pte_t pte)
+{
+	struct ipte_range *range;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	__ipte_range_set_pte(range, ptep, pte);
+
+	return true;
+}
+
+bool __lazy_mmu_ptep_get(hw_pte_t *ptep, pte_t *res)
+{
+	struct ipte_range *range;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	*res =3D __ipte_range_ptep_get(range, ptep);
+
+	return true;
+}
+
+bool __lazy_mmu_ptep_test_and_clear_young(unsigned long addr, hw_pte_t *=
ptep, int *res)
+{
+	struct ipte_range *range;
+	pte_t pte, old;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	old =3D __ipte_range_ptep_get(range, ptep);
+	pte =3D pte_mkold(old);
+	__ipte_range_set_pte(range, ptep, pte);
+	*res =3D pte_young(old);
+
+	return true;
+}
+
+bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, hw_pte_t *ptep, p=
te_t *res)
+{
+	struct ipte_range *range;
+	pte_t pte, old;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	old =3D __ipte_range_ptep_get(range, ptep);
+	pte =3D __pte(_PAGE_INVALID);
+	__ipte_range_set_pte(range, ptep, pte);
+	*res =3D old;
+
+	return true;
+}
+
+bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, hw_pte_t *pte=
p, pte_t *res)
+{
+	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);
+}
+
+bool __lazy_mmu_ptep_modify_prot_commit(unsigned long addr, hw_pte_t *pt=
ep,
+					pte_t old_pte, pte_t pte)
+{
+	struct ipte_range *range;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	__ipte_range_set_pte(range, ptep, pte);
+
+	return true;
+}
+
+bool __lazy_mmu_ptep_set_wrprotect(unsigned long addr, hw_pte_t *ptep)
+{
+	struct ipte_range *range;
+	pte_t pte;
+
+	range =3D this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	pte =3D __ipte_range_ptep_get(range, ptep);
+	if (pte_write(pte)) {
+		pte =3D pte_wrprotect(pte);
+		__ipte_range_set_pte(range, ptep, pte);
+	}
+
+	return true;
+}
+
+static int lazy_mmu_alloc(unsigned int cpu)
+{
+	struct ipte_range *range;
+	int i;
+
+	range =3D kzalloc_obj(*range, GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	for (i =3D 0; i < ARRAY_SIZE(range->cache); i++)
+		range->cache[i] =3D __pte(PTE_POISON);
+	per_cpu(ipte_range, cpu) =3D range;
+
+	return 0;
+}
+
+static void lazy_mmu_free(unsigned int cpu)
+{
+	struct ipte_range *range;
+
+	range =3D per_cpu(ipte_range, cpu);
+	per_cpu(ipte_range, cpu) =3D NULL;
+	kfree(range);
+}
+
+static int lazy_mmu_cpu_online(unsigned int cpu)
+{
+	int rc;
+
+	if (!cpu) {
+		rc =3D lazy_mmu_alloc(0);
+		if (rc) {
+			pr_warn("Not enough memory to enable the lazy MMU mode\n");
+			return rc;
+		}
+
+		static_branch_enable_cpuslocked(&lazy_mmu_enabled);
+		return 0;
+	}
+
+	return lazy_mmu_alloc(cpu);
+}
+
+static int lazy_mmu_cpu_offline(unsigned int cpu)
+{
+	lazy_mmu_free(cpu);
+	return 0;
+}
+
+static int __init lazy_mmu_init(void)
+{
+	if (!test_facility(13))
+		return 0;
+
+	return cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "s390/lazy_mmu:online",
+				 lazy_mmu_cpu_online, lazy_mmu_cpu_offline);
+}
+early_initcall(lazy_mmu_init);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index b5eca8bfb539..32aec9cc9a74 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -166,14 +166,14 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned=
 long addr,
 }
 EXPORT_SYMBOL(ptep_xchg_lazy);
=20
-pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     hw_pte_t *ptep)
+pte_t ___ptep_modify_prot_start(struct vm_area_struct *vma, unsigned lon=
g addr,
+				hw_pte_t *ptep)
 {
 	return ptep_flush_lazy(vma->vm_mm, addr, ptep, 1);
 }
=20
-void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
-			     hw_pte_t *ptep, pte_t old_pte, pte_t pte)
+void ___ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned lon=
g addr,
+				hw_pte_t *ptep, pte_t old_pte, pte_t pte)
 {
 	set_pte(ptep, pte);
 }
--=20
2.53.0

