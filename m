Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669835B64E;
	Mon, 23 Feb 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847616; cv=none; b=bxn0nza/3oT+6LNkfPG2HGOIMXa6p+R+rvFcDWk/4E4bmc9EwU2XnspSRVOTEXQ+U7a0sYiP7isCpDH5aSrXOCyre1+W4eTeo6SRMLxu6OiY4+kAlJHIFZGGQ1dXRoUi5lWe/OmNOzcRLTFSi3J0IUVUaAoIPP3ThaSEWPnYWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847616; c=relaxed/simple;
	bh=oPbZF9SvTCkQ2pYuHCeSX/fUYvbMotNUwoKkH++fmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtLfYwLUvPDPF3xT/d3AdH0VzI2DDewuiOknTu25LuEs3y/B7Ts8uxoyu/X8KHo7Vpvp0AD2Hf35w5Lufcxdn3IBSoRVJww+vwHb1+BAZz11pLo6SxPqLmnidGf8TM5DY+qdzEx4+Q6XQZG2Ho59Rc7bDBWl4iBc3KwhMpWAVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLTpGLjX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLTpGLjX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MKtQnQ2466391;
	Mon, 23 Feb 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nWjwnS5nyC5gSG8Uu
	tEgk3IzL8z2OXssI39FR/MoAKU=; b=tLTpGLjXfHeQ9VhsQJOz6Swx+T2j7lI3l
	ejzXMx7VxaUcALuEKourvGVFKVCQGCPvXCYEjDh3bA9jaYlQu+pJ+MW2rpN+VUi3
	cFM3cTa8sBkT0Rwp6kc/vFsV3aCHklymtxLq+y83hKjyRZ6OLdgLeipaqcoeAhUk
	aXJIRhb96s0iWEJKL9b9EXtZR3TVnaTOi/RUT25P4jMHqyQPpWY4AhEhyPXiH9F1
	bQ5p0P0Ts2ewq955MtrJaNfBfArOoF9etO4HL9Q/SiyI1+HLoVIciQwG2VDtDB8s
	+6ljT8VG73J77l+jhG5+mde/OSgh6bu3D33xOiOuYTzKU0Sta8+bw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e36xd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61N9uCYD015970;
	Mon, 23 Feb 2026 11:53:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1scq12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBrG1322086076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:53:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF6D2004E;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E6F2004B;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 457A5E0B74; Mon, 23 Feb 2026 12:53:16 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH 3/4] s390/pgtable: Add s390 support for page table check
Date: Mon, 23 Feb 2026 12:53:15 +0100
Message-ID: <37fac4caa57e4509ea2f0aaecf1e2140db0b6cec.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1771845678.git.agordeev@linux.ibm.com>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=699c3faf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=lBuVlAIgDHgG38O_heoA:9
X-Proofpoint-GUID: spHIFTylbS-xflTQGj1X6_zvqoMmN6is
X-Proofpoint-ORIG-GUID: spHIFTylbS-xflTQGj1X6_zvqoMmN6is
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX11ji3mvfr+dr
 1WOThvYWtKMCeV7WQxJ19tU2zRTf2vFWKqcoNcOSlBLGBrNKRQNKMIoGeThg2rRvSillpKq6LWi
 vmWKbmf8LQuDqah8yWT4p3IkOTAD6/48lG2xSilgr6necM3XGkmtGHfEJhzk8dLLgZY+rHXx+RK
 iU+EMRup8Bi8vs5VI66urd3kWlZ2y/6cbngcgcaVGmvYfgGY4vWFPVB0x7+1tQlV66LFTUC7S7W
 AFFef/lMTJj3yzmlMLEvkXH7khR03NJ9OtYlHtFOP1JNTcpp1xNuorS2HzEJexwyHol4CA+uRHE
 woYKbTysohZtqw+qdGmxla1PfO40ldbDnTb4q806DDDbhI03tVS51hLIJoxcQlIDYaZ769eQDLr
 qQmiW0hVhnr8ZF/qyXRBAsYT5rf/KK2cQSLGkMfHMBLMNh8PLZfZm0XVMPXrsxkze3DNio4EIX5
 l0e1oGf3sGBSjDD9ifw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099

From: Tobias Huschle <huschle@linux.ibm.com>

Add page table check hooks into routines that modify user page
tables.

Unlike other architectures s390 does not have means to distinguish
between kernel and user page table entries. Rely on the fact the
page table check infrastructure itself operates on non-init_mm
memory spaces only.

Use the provided mm_struct to verify that the memory space is not
init_mm (aka not the kernel memory space) indeed. That check is
supposed to be succeeded already (on some code paths even twice).

If the passed memory space by contrast is init_mm that would be an
unexpected semantical change in generic code, so do VM_BUG_ON() in
such case.

Unset _SEGMENT_ENTRY_READ bit to indicate that pmdp_invalidate()
was applied against a huge PMD and is going to be updated by
set_pmd_at() shortly. The hook pmd_user_accessible_page() should
skip such entries until that, otherwise the page table accounting
falls apart and BUG_ON() gets hit as result.

The invalidated huge PMD entry should not be confused with a PROT_NONE
entry as reported by pmd_protnone(), though the entry characteristics
exactly match: _SEGMENT_ENTRY_LARGE is set while _SEGMENT_ENTRY_READ is
unset. Since pmd_protnone() implementation depends on NUMA_BALANCING
configuration option, it should not be used in pmd_user_accessible_page()
check, which is expected to be CONFIG_NUMA_BALANCING-agnostic.

Nevertheless, an invalidated huge PMD is technically still pmd_protnone()
entry and it should not break other code paths once _SEGMENT_ENTRY_READ
is unset. As of now, all pmd_protnone() checks are done under page table
locks or exercise GUP-fast and HMM code paths, which are expected to be
safe against concurrent page table updates.

Alternative approach would be using the last remaining unused PMD entry
bit 0x800 to indicate that pmdp_invalidate() was called on a PMD. That
would allow avoiding collisions with pmd_protnone() handling code paths,
but saving the bit is more preferable way to go.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
Co-developed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/pgtable.h | 54 ++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index edc927d9e85a..7bda45d30455 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -154,6 +154,7 @@ config S390
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 04ec9fee6498..67f5df20a57e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -16,8 +16,10 @@
 #include <linux/mm_types.h>
 #include <linux/cpufeature.h>
 #include <linux/page-flags.h>
+#include <linux/page_table_check.h>
 #include <linux/radix-tree.h>
 #include <linux/atomic.h>
+#include <linux/mmap_lock.h>
 #include <asm/ctlreg.h>
 #include <asm/bug.h>
 #include <asm/page.h>
@@ -1190,6 +1192,7 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
ruct *mm,
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
 		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
+	page_table_check_pte_clear(mm, addr, res);
 	return res;
 }
=20
@@ -1208,6 +1211,7 @@ static inline pte_t ptep_clear_flush(struct vm_area=
_struct *vma,
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(vma->vm_mm) && pte_present(res))
 		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
+	page_table_check_pte_clear(vma->vm_mm, addr, res);
 	return res;
 }
=20
@@ -1231,6 +1235,9 @@ static inline pte_t ptep_get_and_clear_full(struct =
mm_struct *mm,
 	} else {
 		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	}
+
+	page_table_check_pte_clear(mm, addr, res);
+
 	/* Nothing to do */
 	if (!mm_is_protected(mm) || !pte_present(res))
 		return res;
@@ -1327,6 +1334,7 @@ static inline void set_ptes(struct mm_struct *mm, u=
nsigned long addr,
 {
 	if (pte_present(entry))
 		entry =3D clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
+	page_table_check_ptes_set(mm, addr, ptep, entry, nr);
 	for (;;) {
 		set_pte(ptep, entry);
 		if (--nr =3D=3D 0)
@@ -1703,6 +1711,7 @@ static inline int pmdp_clear_flush_young(struct vm_=
area_struct *vma,
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t entry)
 {
+	page_table_check_pmd_set(mm, addr, pmdp, entry);
 	set_pmd(pmdp, entry);
 }
=20
@@ -1717,7 +1726,11 @@ static inline pmd_t pmd_mkhuge(pmd_t pmd)
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pmd_t *pmdp)
 {
-	return pmdp_xchg_direct(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
+	pmd_t pmd;
+
+	pmd =3D pmdp_xchg_direct(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
+	page_table_check_pmd_clear(mm, addr, pmd);
+	return pmd;
 }
=20
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR_FULL
@@ -1725,12 +1738,17 @@ static inline pmd_t pmdp_huge_get_and_clear_full(=
struct vm_area_struct *vma,
 						 unsigned long addr,
 						 pmd_t *pmdp, int full)
 {
+	pmd_t pmd;
+
 	if (full) {
-		pmd_t pmd =3D *pmdp;
+		pmd =3D *pmdp;
 		set_pmd(pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
+		page_table_check_pmd_clear(vma->vm_mm, addr, pmd);
 		return pmd;
 	}
-	return pmdp_xchg_lazy(vma->vm_mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMPT=
Y));
+	pmd =3D pmdp_xchg_lazy(vma->vm_mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMP=
TY));
+	page_table_check_pmd_clear(vma->vm_mm, addr, pmd);
+	return pmd;
 }
=20
 #define __HAVE_ARCH_PMDP_HUGE_CLEAR_FLUSH
@@ -1748,7 +1766,12 @@ static inline pmd_t pmdp_invalidate(struct vm_area=
_struct *vma,
=20
 	VM_WARN_ON_ONCE(!pmd_present(pmd));
 	pmd =3D set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_INVALID));
-	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
+#ifdef CONFIG_PAGE_TABLE_CHECK
+	pmd =3D clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_READ));
+#endif
+	page_table_check_pmd_set(vma->vm_mm, addr, pmdp, pmd);
+	pmd =3D pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
+	return pmd;
 }
=20
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
@@ -1783,6 +1806,29 @@ static inline int has_transparent_hugepage(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
=20
+#ifdef CONFIG_PAGE_TABLE_CHECK
+static inline bool pte_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pte_t pte)
+{
+	VM_BUG_ON(mm =3D=3D &init_mm);
+
+	return pte_present(pte);
+}
+
+static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pmd_t pmd)
+{
+	VM_BUG_ON(mm =3D=3D &init_mm);
+
+	return pmd_leaf(pmd) && (pmd_val(pmd) & _SEGMENT_ENTRY_READ);
+}
+
+static inline bool pud_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pud_t pud)
+{
+	VM_BUG_ON(mm =3D=3D &init_mm);
+
+	return pud_leaf(pud);
+}
+#endif
+
 /*
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
--=20
2.51.0

