Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AA3F4DC3;
	Mon, 17 Aug 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966395; cv=none; b=evo+VusYEFkcOf0VUKAqRyo6ucOchIjeGTLPubcZ+pBCIUfxA/u4EtGeerWDdCbRnk7HnRTK8AztcjmB+gUw3bFx1YtHLb/J/NX6RJn/gn35/g8d0kDiMOZRsQ1k7UXH0H6kIqd0KEuzuCvPVOb3F+rWSOkC6rS4nuJ9SBjwIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966395; c=relaxed/simple;
	bh=OYhpnJQjet6ciiON4XHbrIGiNbV1QZK1bV4puh2Og30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caWE0TRUHGyMIf+nZUFUai6pCc3VRF8Msqs6U3XZ/KF4I8NNx7EsRGX01ZKPMjdsICLMl4iR3+uGQLNDFRabOAA0x+RYyxAf5RuYmtRb7J6WJTiP7pFlmukqBbtXiRM0eYWRI7/Sh77XbhvodzHarsIoZX0AjP813SUxGTxL4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Foq1uI4N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Foq1uI4N"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H9qLFE3727949;
	Mon, 17 Aug 2026 11:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mJwL6JP2vCyeQf6Dw
	udqtBk64GFr5Du4cvK0t/JQQrY=; b=Foq1uI4NVJ3qiKBJeXydvEvZny1thzcud
	aLjERjwTsKz/zVSRGfaI0nTg4vxBHxg3Lnp9Axk+0Dd2vpcysb77tcdVnlmWCcJq
	vbkF0hfkYRIj++tQhC8bzWAxS8FgvbsW+cbfd9WDkh/r2kJNWlk3iKTdIhVXATgL
	rdB+QQeTCoCTybBFC7VIzdLygHEs2D5T++A8pNeILG4/KTRmv3gcrfkEA+hxNi3/
	SFncExWIT+834Rknxwb6yUA1uowyFk5WMhDZafijWoP43+xyHf694zMUjwjzR06H
	Ju8OMo0T2o8ikwz9oFun9JToXvLc4YPhV+HkPYQH1q2bzB3IkFAag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hyvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 11:33:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBQMrF007554;
	Mon, 17 Aug 2026 11:33:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epx01b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 11:33:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HBX2WL26542542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 11:33:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF4820043;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58ABF20040;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 3EF1C1612F1; Mon, 17 Aug 2026 13:33:02 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Date: Mon, 17 Aug 2026 13:33:00 +0200
Message-ID: <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786956464.git.agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 69zM09s9i1vGLiV9dcjcZbcvVULaBRzf
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82f173 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=C-ONzq7a6YYeur7YfcQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX5sKepB5+/xP0
 W97irfU32buFgK4yENNqgJLKbjv/fopLlBlPYoq1ty/7x07ct8YRogg9gv/9FRiD3i2rkD/sWVG
 rnnE9YmcI4MJfnDogV0NukYXh1N1F4M=
X-Proofpoint-ORIG-GUID: Tt-r7c6LnIzfGlhhgGHmEOxlaYKQlXGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfXzR+2WA8B6Ka8
 +4SaMVQ7T6Np154JNwUlFpvGJocNDJkLc/GwoTvRSEDWSgZm6DFiDCYtj8aBJnvAvzIlpBg8Vaw
 GXUlk+WFgCksH9k6qqRodCYFLxKZe/HvaHRwQARO33v8mPuYxaYm48PNbNwOT58uiHHqoPNclM2
 3g7Wjuzl0Du01rGQo62iNXpfUHfEjnmJCAoxy+VkdFWMPzalFJg03e0DLLgsSIlfAHPEft3MJ5n
 mjIAYawphpOQzYgZalWVQtVmWLM0hVDaCfxRmrfz0UtwVXaxbjU0CsqLiMaRibVb6kyYfUt6MXM
 Rb14yDJSdd44Z6P4ycvx9U9C0UFER8KC01Nhn0lY4XlfaIWKiFPhrj5NQCnPS7o4PmCjgQN9Ng9
 tyKUNI0Rta3CGBnAff8GI5YxPFj61em8MzQWc6pDnkVyKVz71sfiPpqOhFy8mUNCFNUlo3QM6uu
 OUfiDhqse+uxYzl/saw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170087

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
 arch/s390/Kconfig                |   1 +
 arch/s390/include/asm/lazy_mmu.h |   9 +
 arch/s390/include/asm/lowcore.h  |   2 +-
 arch/s390/include/asm/pgtable.h  | 151 ++++++++++--
 arch/s390/kernel/setup.c         |   2 +
 arch/s390/kernel/smp.c           |   7 +
 arch/s390/mm/Makefile            |   1 +
 arch/s390/mm/lazy_mmu.c          | 399 +++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c           |   8 +-
 9 files changed, 557 insertions(+), 23 deletions(-)
 create mode 100644 arch/s390/include/asm/lazy_mmu.h
 create mode 100644 arch/s390/mm/lazy_mmu.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..7846332dcd0a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -97,6 +97,7 @@ config S390
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_LAZY_MMU_MODE
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/s390/include/asm/lazy_mmu.h b/arch/s390/include/asm/laz=
y_mmu.h
new file mode 100644
index 000000000000..98366e9de9bc
--- /dev/null
+++ b/arch/s390/include/asm/lazy_mmu.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LAZY_MMU_H
+#define __LAZY_MMU_H
+
+void lazy_mmu_online_boot_cpu(void);
+int lazy_mmu_online_cpu(gfp_t gfp, unsigned int cpu);
+void lazy_mmu_offline_cpu(unsigned int cpu);
+
+#endif /* __LAZY_MMU_H */
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowc=
ore.h
index 3b3ecc647993..dba236664da9 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -163,7 +163,7 @@ struct lowcore {
 	__s32	preempt_count;			/* 0x03a8 */
 	__u32	spinlock_lockval;		/* 0x03ac */
 	__u32	spinlock_index;			/* 0x03b0 */
-	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
+	__s32	lazy_mmu_count;			/* 0x03b4 */
 	__u64	percpu_offset;			/* 0x03b8 */
 	__u8	percpu_register;		/* 0x03c0 */
 	__u8	pad_0x03c1[0x0400-0x03c1];	/* 0x03c1 */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 859ce7c7d454..bf54202a0630 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -39,6 +39,64 @@ enum {
=20
 extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
=20
+bool __lazy_mmu_ptep_test_and_clear_young(unsigned long addr, pte_t *pte=
p, int *res);
+bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_=
t *res);
+bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, =
pte_t *res);
+bool __lazy_mmu_ptep_modify_prot_commit(unsigned long addr, pte_t *ptep,=
 pte_t old_pte, pte_t pte);
+bool __lazy_mmu_ptep_set_wrprotect(unsigned long addr, pte_t *ptep);
+bool __lazy_mmu_set_pte(pte_t *ptep, pte_t pte);
+bool __lazy_mmu_ptep_get(pte_t *ptep, pte_t *res);
+
+static __always_inline bool is_lazy_mmu_active(void)
+{
+	if (__is_defined(__DECOMPRESSOR))
+		return false;
+	if (!get_lowcore()->lazy_mmu_count)
+		return false;
+	return true;
+}
+
+static inline
+bool lazy_mmu_ptep_test_and_clear_young(unsigned long addr, pte_t *ptep,=
 int *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_test_and_clear_young(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_t =
*res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, pt=
e_t *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_modify_prot_start(addr, ptep, res);
+}
+
+static inline
+bool lazy_mmu_ptep_modify_prot_commit(unsigned long addr, pte_t *ptep,
+				      pte_t old_pte, pte_t pte)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_modify_prot_commit(addr, ptep, old_pte, pte);
+}
+
+static inline
+bool lazy_mmu_ptep_set_wrprotect(unsigned long addr, pte_t *ptep)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_set_wrprotect(addr, ptep);
+}
+
 static inline void update_page_count(int level, long count)
 {
 	if (IS_ENABLED(CONFIG_PROC_FS))
@@ -978,17 +1036,32 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	WRITE_ONCE(*pmdp, pmd);
 }
=20
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void __set_pte(pte_t *ptep, pte_t pte)
 {
 	if (pte_present(pte))
 		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
 	WRITE_ONCE(*ptep, pte);
 }
=20
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	if (!is_lazy_mmu_active() || !__lazy_mmu_set_pte(ptep, pte))
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
+	if (!is_lazy_mmu_active() || !__lazy_mmu_ptep_get(ptep, &res))
+		res =3D __ptep_get(ptep);
+	return res;
 }
=20
 #define pmdp_get pmdp_get
@@ -1181,6 +1254,15 @@ static __always_inline void __ptep_ipte_range(unsi=
gned long address, int nr,
 	} while (nr !=3D 255);
 }
=20
+void arch_enter_lazy_mmu_mode_with_ptes(struct mm_struct *mm,
+					unsigned long addr, unsigned long end,
+					pte_t *pte);
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
@@ -1201,10 +1283,16 @@ pte_t ptep_xchg_lazy(struct mm_struct *, unsigned=
 long, pte_t *, pte_t);
 static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
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
@@ -1220,7 +1308,8 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
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
@@ -1229,9 +1318,28 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
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
+	if (!lazy_mmu_ptep_modify_prot_start(addr, ptep, &res))
+		res =3D ___ptep_modify_prot_start(vma, addr, ptep);
+	return res;
+}
+
+static inline
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
+			     pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+	if (!lazy_mmu_ptep_modify_prot_commit(addr, ptep, old_pte, pte))
+		___ptep_modify_prot_commit(vma, addr, ptep, old_pte, pte);
+}
=20
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
@@ -1261,11 +1369,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
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
@@ -1291,10 +1401,15 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
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
@@ -1327,7 +1442,7 @@ static inline void flush_tlb_fix_spurious_fault(str=
uct vm_area_struct *vma,
 	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
 	 * A local RDP can be used to do the flush.
 	 */
-	if (cpu_has_rdp() && !(pte_val(ptep_get(ptep)) & _PAGE_PROTECT))
+	if (cpu_has_rdp() && !(pte_val(__ptep_get(ptep)) & _PAGE_PROTECT))
 		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b60284328fe3..f5a3c9e1b6b8 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -77,6 +77,7 @@
 #include <asm/maccess.h>
 #include <asm/uv.h>
 #include <asm/asm-offsets.h>
+#include <asm/lazy_mmu.h>
 #include "entry.h"
=20
 /*
@@ -1012,5 +1013,6 @@ void __init setup_arch(char **cmdline_p)
=20
 void __init arch_cpu_finalize_init(void)
 {
+	lazy_mmu_online_boot_cpu();
 	sclp_init();
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0ba7f89b8161..0a826bbaf1dd 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -59,6 +59,7 @@
 #include <asm/topology.h>
 #include <asm/vdso.h>
 #include <asm/maccess.h>
+#include <asm/lazy_mmu.h>
 #include "entry.h"
=20
 enum {
@@ -866,6 +867,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *t=
idle)
 	rc =3D pcpu_alloc_lowcore(pcpu, cpu);
 	if (rc)
 		return rc;
+	rc =3D lazy_mmu_online_cpu(GFP_KERNEL, cpu);
+	if (rc) {
+		pcpu_free_lowcore(pcpu, cpu);
+		return rc;
+	}
 	/*
 	 * Make sure global control register contents do not change
 	 * until new CPU has initialized control registers.
@@ -921,6 +927,7 @@ void __cpu_die(unsigned int cpu)
 	pcpu =3D per_cpu_ptr(&pcpu_devices, cpu);
 	while (!pcpu_stopped(pcpu))
 		cpu_relax();
+	lazy_mmu_offline_cpu(cpu);
 	pcpu_free_lowcore(pcpu, cpu);
 	cpumask_clear_cpu(cpu, mm_cpumask(&init_mm));
 	cpumask_clear_cpu(cpu, &init_mm.context.cpu_attach_mask);
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index 193899c39ca7..96cac3e99f51 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -4,6 +4,7 @@
 #
=20
 obj-y		:=3D init.o fault.o extmem.o mmap.o vmem.o maccess.o
+obj-y		:=3D init.o fault.o extmem.o mmap.o vmem.o maccess.o lazy_mmu.o
 obj-y		+=3D page-states.o pageattr.o pgtable.o pgalloc.o extable.o
=20
 obj-$(CONFIG_CMM)		+=3D cmm.o
diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
new file mode 100644
index 000000000000..002ee766b391
--- /dev/null
+++ b/arch/s390/mm/lazy_mmu.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pgtable.h>
+#include <linux/kasan.h>
+#include <linux/slab.h>
+#include <asm/facility.h>
+#include <asm/lazy_mmu.h>
+#include <kunit/visibility.h>
+
+#define PTE_POISON	_PAGE_LARGE
+
+struct ipte_range {
+	struct mm_struct *mm;
+	unsigned long base_addr;
+	unsigned long base_end;
+	pte_t *base_pte;
+	pte_t *start_pte;
+	pte_t *end_pte;
+	pte_t cache[PTRS_PER_PTE];
+};
+
+static DEFINE_PER_CPU(struct ipte_range *, ipte_range);
+
+static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
+{
+	unsigned long page_invalid_bit;
+	pte_t *ptep, pte;
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
+				   int nr_ptes, pte_t *ptep)
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
+static void enter_ipte_norange(void)
+{
+	struct ipte_range __maybe_unused *range;
+
+	if (!test_facility(13))
+		return;
+
+	local_bh_disable();
+
+	range =3D get_cpu_var(ipte_range);
+	get_lowcore()->lazy_mmu_count++;
+
+	local_bh_enable();
+}
+
+static void enter_ipte_range(struct mm_struct *mm,
+			     unsigned long addr, unsigned long end, pte_t *pte)
+{
+	struct ipte_range *range;
+
+	if (!test_facility(13))
+		return;
+
+	local_bh_disable();
+
+	range =3D get_cpu_var(ipte_range);
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
+	pte_t *ptep, *start, *start_cache, *cache;
+	unsigned long start_addr, addr;
+	struct ipte_range *range;
+	int start_idx;
+
+	if (!test_facility(13))
+		return;
+
+	local_bh_disable();
+
+	lockdep_assert_preemption_disabled();
+	range =3D this_cpu_read(ipte_range);
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
+	put_cpu_var(ipte_range);
+
+	local_bh_enable();
+}
+
+static void flush_lazy_mmu_mode(void)
+{
+	unsigned long addr, end;
+	struct ipte_range *range;
+	struct mm_struct *mm;
+	pte_t *pte;
+
+	if (!test_facility(13))
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
+					pte_t *pte)
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
+static void __ipte_range_set_pte(struct ipte_range *range, pte_t *ptep, =
pte_t pte)
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
+static pte_t __ipte_range_ptep_get(struct ipte_range *range, pte_t *ptep=
)
+{
+	unsigned int idx =3D ptep - range->base_pte;
+
+	lockdep_assert_preemption_disabled();
+	if (pte_val(range->cache[idx]) =3D=3D PTE_POISON)
+		return __ptep_get(ptep);
+	return range->cache[idx];
+}
+
+static struct ipte_range *this_ipte_range(pte_t *ptep)
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
+	return range;
+}
+
+bool __lazy_mmu_set_pte(pte_t *ptep, pte_t pte)
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
+bool __lazy_mmu_ptep_get(pte_t *ptep, pte_t *res)
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
+bool __lazy_mmu_ptep_test_and_clear_young(unsigned long addr, pte_t *pte=
p, int *res)
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
+bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_=
t *res)
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
+bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, =
pte_t *res)
+{
+	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);
+}
+
+bool __lazy_mmu_ptep_modify_prot_commit(unsigned long addr, pte_t *ptep,
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
+bool __lazy_mmu_ptep_set_wrprotect(unsigned long addr, pte_t *ptep)
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
+int lazy_mmu_online_cpu(gfp_t gfp, unsigned int cpu)
+{
+	struct ipte_range *range;
+	int i;
+
+	if (!test_facility(13))
+		return 0;
+
+	range =3D kzalloc_obj(*range, gfp);
+	if (!range)
+		return -ENOMEM;
+	for (i =3D 0; i < ARRAY_SIZE(range->cache); i++)
+		range->cache[i] =3D __pte(PTE_POISON);
+	per_cpu(ipte_range, cpu) =3D range;
+
+	return 0;
+}
+
+void lazy_mmu_offline_cpu(unsigned int cpu)
+{
+	struct ipte_range *range;
+
+	if (!test_facility(13))
+		return;
+
+	range =3D per_cpu(ipte_range, cpu);
+	per_cpu(ipte_range, cpu) =3D NULL;
+	kfree(range);
+}
+
+void __init lazy_mmu_online_boot_cpu(void)
+{
+	lazy_mmu_online_cpu(GFP_ATOMIC, 0);
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
2.53.0

