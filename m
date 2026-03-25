Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBE379EDF;
	Wed, 25 Mar 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424501; cv=none; b=DX9XDx0wOi5hfGNpJSVLIoytbWYWhrcTjoo7AFiUOb+zknQ87PFPN5XqALIA6D2Zs4IGqyvGSOMhuAaYzgf+xCME5hNHl2ll8Oy4QPXVeU2dqTRP3CB2jY2GjeL9nnnsaesF2QeNTTp7JvbHtyPfeS7uIbgXCfI8QB1E43yBthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424501; c=relaxed/simple;
	bh=vZ5Op6gX5b3QZt0S4iOJ85uDKvrwwyae+Z/HmlHU/5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1eTMagoipdRAxxJkUneuhKMWCB7ct2eVIz/KFhYlFx81S6wOYxWWU+rjo9RlXl0KavWp+gEtYT4zk4eGjJ0BcH7ZnI44CD6Yv/UtWGgWLBnhXabbcqNjnrL5PS7MQvuhxe/TIUGlteCTXtwY6JacjBel5NA1S6fdWvcVot5ZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pNQ/4u3B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pNQ/4u3B"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGGNeB3893308;
	Wed, 25 Mar 2026 07:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ckm/FcFRukBQ1O64E
	kVj9RpIXX2CRy2+3nXyBotkBao=; b=pNQ/4u3BZMPqHPS0SkeQ0jYj63b1Cp5PS
	UvVXrolL+gaBOS97pG+w/g3p9UXxBWf3INI+WVNxUUH+17YP0gOdCud53kNMsPYl
	T6VtGsN89OGu8KfyyZOknlPFbfQ/gNFXEM21Fz7YYcPo/TxxOjCNqR/JR6LFTKef
	quHYjRzT9XZ5xgk+NMbhp1A5KZNXWJvRn6GSRaNzoCr7zIX9RMWLrSNwyzWAujvQ
	bxCzBCGKmree0Dj5gsr3bIPwIrnlA+QV1NI9UZltX0Yi1G4N0SWH+b2ECc27bE88
	uC5BnlEyyqI/6XDQ5Nm67ywKPIwf+C0fQeKnFe0esksLNwtFKvc4w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuxjnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P2QaTh004398;
	Wed, 25 Mar 2026 07:41:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c25a5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P7fJHd44040476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 07:41:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96B02004D;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831B320040;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 6D7BCE0782; Wed, 25 Mar 2026 08:41:19 +0100 (CET)
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
Subject: [RFC PATCH 2/2] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed, 25 Mar 2026 08:41:19 +0100
Message-ID: <a00e58e3293ead1881e0c5a5fb471edd23ea76aa.1774420057.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: M6Cy7zsO6ZnuTNPAq2O3dr5NcThJ0uLG
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c391a5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QahWx_JG-LKBn9TrOFAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1MCBTYWx0ZWRfXzMEMCK2Nd42a
 q4KEdkzPUV/2E9pQtn4m5qt9/PAOdbl7CtOHTaeJMIvYdFUJAlw6NDZb2nIFSk/ITyo1Ms9ecUx
 eBYZKkx25Aj6MZwDu2RxbLyvqbsmAgez/0AYdPKGCWwW/suvI9aAqigxSudydwA7sQu3YNy9HXT
 yP0AWv1JGbWZZ7YNNlfu5EsPpILpgb0aIyPgD0UmI3Z+kRXljieTvHUdyhIjFzqkK3aFAs0FszV
 C0T5uQRP+Rn2euJVxoBx9T8AMiBHinW6iVuoDs+3u4EYpbJiLN/mDS4+cs8ARxzK1UF4AlkAzo+
 kgOqiTxzqZmCf5Jppzb7sNUxShnJYh/lFUrt5eQ6lDVei2k5SzB+GrlgEUNhKpUslZIWXu0KtCD
 D3kZxc+oQE7KNuYjhbpPDlCIK6gc6/yhg8t6+a+s74n5OZRDvuHbIHoWZhRh30aaPFzLRRdvHve
 vp6pD4rhJ7tPJIh8hag==
X-Proofpoint-GUID: M6Cy7zsO6ZnuTNPAq2O3dr5NcThJ0uLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250050

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

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/Kconfig               |   8 +
 arch/s390/include/asm/pgtable.h | 209 +++++++++++++++--
 arch/s390/mm/Makefile           |   1 +
 arch/s390/mm/ipte_batch.c       | 396 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |   8 +-
 5 files changed, 603 insertions(+), 19 deletions(-)
 create mode 100644 arch/s390/mm/ipte_batch.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7828fbe0fc42..5821d4d42d1d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -732,6 +732,14 @@ config MAX_PHYSMEM_BITS
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
+
 endmenu
=20
 menu "I/O subsystem"
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 67f5df20a57e..fd135e2a1ecf 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -39,6 +39,82 @@ enum {
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
+bool ipte_batch_ptep_get_and_clear_full(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep,
+					int full, pte_t *res)
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
+bool ipte_batch_ptep_get_and_clear_full(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep,
+					int full, pte_t *res);
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
@@ -978,11 +1054,32 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
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
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	pte_t res;
+
+	if (ipte_batch_ptep_get(ptep, &res))
+		return res;
+	return __ptep_get(ptep);
+}
+
 static inline void pgd_clear(pgd_t *pgd)
 {
 	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYPE=
_R1)
@@ -1149,6 +1246,26 @@ static __always_inline void __ptep_ipte_range(unsi=
gned long address, int nr,
 	} while (nr !=3D 255);
 }
=20
+#ifdef CONFIG_IPTE_BATCH
+void arch_enter_lazy_mmu_mode_pte(struct mm_struct *mm,
+				  unsigned long addr, unsigned long end,
+				  pte_t *pte);
+#define arch_enter_lazy_mmu_mode_pte arch_enter_lazy_mmu_mode_pte
+
+void arch_pause_lazy_mmu_mode(void);
+#define arch_pause_lazy_mmu_mode arch_pause_lazy_mmu_mode
+
+void arch_resume_lazy_mmu_mode(void);
+#define arch_resume_lazy_mmu_mode arch_resume_lazy_mmu_mode
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
@@ -1166,8 +1283,8 @@ pte_t ptep_xchg_direct(struct mm_struct *, unsigned=
 long, pte_t *, pte_t);
 pte_t ptep_xchg_lazy(struct mm_struct *, unsigned long, pte_t *, pte_t);
=20
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma=
,
+					      unsigned long addr, pte_t *ptep)
 {
 	pte_t pte =3D *ptep;
=20
@@ -1175,6 +1292,16 @@ static inline int ptep_test_and_clear_young(struct=
 vm_area_struct *vma,
 	return pte_young(pte);
 }
=20
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep)
+{
+	int res;
+
+	if (ipte_batch_ptep_test_and_clear_young(vma, addr, ptep, &res))
+		return res;
+	return __ptep_test_and_clear_young(vma, addr, ptep);
+}
+
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 					 unsigned long address, pte_t *ptep)
@@ -1183,8 +1310,8 @@ static inline int ptep_clear_flush_young(struct vm_=
area_struct *vma,
 }
=20
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long addr, pte_t *ptep)
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+					 unsigned long addr, pte_t *ptep)
 {
 	pte_t res;
=20
@@ -1192,14 +1319,49 @@ static inline pte_t ptep_get_and_clear(struct mm_=
struct *mm,
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
 		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
+	return res;
+}
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep)
+{
+	pte_t res;
+
+	if (!ipte_batch_ptep_get_and_clear(mm, addr, ptep, &res))
+		res =3D __ptep_get_and_clear(mm, addr, ptep);
 	page_table_check_pte_clear(mm, addr, res);
 	return res;
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
+			       pte_t *, pte_t, pte_t);
+
+static inline
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
+			     unsigned long addr, pte_t *ptep)
+{
+	pte_t res;
+
+	if (ipte_batch_ptep_modify_prot_start(vma, addr, ptep, &res))
+		return res;
+	return ___ptep_modify_prot_start(vma, addr, ptep);
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
@@ -1223,9 +1385,9 @@ static inline pte_t ptep_clear_flush(struct vm_area=
_struct *vma,
  * full=3D=3D1 and a simple pte_clear is enough. See tlb.h.
  */
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
-static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
-					    unsigned long addr,
-					    pte_t *ptep, int full)
+static inline pte_t __ptep_get_and_clear_full(struct mm_struct *mm,
+					      unsigned long addr,
+					      pte_t *ptep, int full)
 {
 	pte_t res;
=20
@@ -1236,8 +1398,6 @@ static inline pte_t ptep_get_and_clear_full(struct =
mm_struct *mm,
 		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	}
=20
-	page_table_check_pte_clear(mm, addr, res);
-
 	/* Nothing to do */
 	if (!mm_is_protected(mm) || !pte_present(res))
 		return res;
@@ -1258,9 +1418,21 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
 	return res;
 }
=20
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
+					    unsigned long addr,
+					    pte_t *ptep, int full)
+{
+	pte_t res;
+
+	if (!ipte_batch_ptep_get_and_clear_full(mm, addr, ptep, full, &res))
+		res =3D __ptep_get_and_clear_full(mm, addr, ptep, full);
+	page_table_check_pte_clear(mm, addr, res);
+	return res;
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long addr, pte_t *ptep)
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep)
 {
 	pte_t pte =3D *ptep;
=20
@@ -1268,6 +1440,13 @@ static inline void ptep_set_wrprotect(struct mm_st=
ruct *mm,
 		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
 }
=20
+static inline void ptep_set_wrprotect(struct mm_struct *mm,
+				      unsigned long addr, pte_t *ptep)
+{
+	if (!ipte_batch_ptep_set_wrprotect(mm, addr, ptep))
+		__ptep_set_wrprotect(mm, addr, ptep);
+}
+
 /*
  * Check if PTEs only differ in _PAGE_PROTECT HW bit, but also allow SW =
PTE
  * bits in the comparison. Those might change e.g. because of dirty and =
young
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
index 000000000000..49b166d499a9
--- /dev/null
+++ b/arch/s390/mm/ipte_batch.c
@@ -0,0 +1,396 @@
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
+	pte_t *ptep;
+
+	*valid =3D !(pte_val(*start) & _PAGE_INVALID);
+
+	for (ptep =3D start + 1; ptep < end; ptep++) {
+		if (*valid) {
+			if (pte_val(*ptep) & _PAGE_INVALID)
+				break;
+		} else {
+			if (!(pte_val(*ptep) & _PAGE_INVALID))
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
+void arch_enter_lazy_mmu_mode_pte(struct mm_struct *mm,
+				  unsigned long addr, unsigned long end,
+				  pte_t *pte)
+{
+	if (!test_facility(13))
+		return;
+	enter_ipte_batch(mm, addr, end, pte);
+}
+EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode_pte);
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
+bool ipte_batch_ptep_get_and_clear_full(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep,
+					int full, pte_t *res)
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
+	pte_t pte, old;
+
+	ib =3D get_ipte_batch(mm, ptep);
+	if (!ib)
+		return false;
+
+	old =3D __ipte_batch_ptep_get(ib, ptep);
+	pte =3D pte_wrprotect(old);
+	__ipte_batch_set_pte(ib, ptep, pte);
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

