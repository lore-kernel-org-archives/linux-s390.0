Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06031F75A6;
	Sat, 15 Nov 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223741; cv=none; b=EIuOBFI747JexXQCpZcqDtKvDzK6KX/4i2IYWcbj3olNpgUQe4y7fkl+eVWtKin/UAu8OUBkp91cpXVahg8dtC3GrD8LF2RVuDIUIJrltgjuQZIX5DQ+bPbZxFR5NprEJWpZtueAFCXXYEYtly0G3AKvcidtzhvHsVZdO8pQ8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223741; c=relaxed/simple;
	bh=G86wdppQp5/J50EYZyolflihNF+sKrGlgM2oDvIJuQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MuH+Zou/y5Ptb2JSIiVo+0wOdPqW3nMojLHYAAvA+7gNkw0wND9J3+PMnEzzoUm5I5b5DcS2tFJUOSgjke2RuPGy+Ah2ID3AFb0cVXwh8bmjJRIto0MBWKt2pjyzhvqTVJSx8NaxoP0R2GEqr3K3KlgJ9ytkWg1n7GEXyS+nAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gJMg0g6S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gJMg0g6S"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFFov29013385;
	Sat, 15 Nov 2025 16:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=xB9as4xaqkHQ1DctZtpoh8KPvzhFiakiA+xrpJa6YzU=; b=gJMg0g6S
	1biMMqfvSevjEs9V/TAP7/UqGJK+XZcJjya4KrNqpm+nP/eC9bsNKx0ikVsDESjY
	JE6dK+vhPcotJrtM0dQ+bGWHnvOGp3cQRPnJNye/C9ViR+34bVtZ0iaNGwS0MyUF
	WBEDpQe26y4SkAQgDjb7tzsyz5ip3HGBaDY0Vh7faj3oGw7rHWGQqsUEbjtYcNTw
	N2Q36l388w4W0BK2APeR6KCK7c+P8Uh+cFp2kbyfQQv1hhypBAGAJyM4NgTexyib
	pOxbqBz54+sfNxkCjXiVETfWpFZxrKMR/APDRNYHbInbd6AenYlw2kR4DHj4x0KC
	sIvP606Cgei8cg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjth3jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Nov 2025 16:22:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFD3l3Z007313;
	Sat, 15 Nov 2025 16:22:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdk0436-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Nov 2025 16:22:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AFGMDqn25166224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 16:22:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9791420043;
	Sat, 15 Nov 2025 16:22:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4619C20040;
	Sat, 15 Nov 2025 16:22:13 +0000 (GMT)
Received: from osiris (unknown [9.87.135.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 15 Nov 2025 16:22:13 +0000 (GMT)
Date: Sat, 15 Nov 2025 17:22:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.18-rc6
Message-ID: <20251115162211.11983Aa9-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qX_BT2wKH7fElKTpOV1ptuAK-NuYMtcI
X-Proofpoint-ORIG-GUID: qX_BT2wKH7fElKTpOV1ptuAK-NuYMtcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX39zqkFoB0Le9
 flKH4CiwTcV93hABmGMjc8OkTri/ziOrL2kZLVPjQZacCA7hRvSbCNRodp+/7RtUH9e47Brxkrk
 Am/5OBnWNClvunUx14Uwbi5MxPNhOMh0yTu0/nShtqcmAjFVBPhDSOf8SNgnGk/r40fTOregbF6
 iZ++n8hqB+LCeXYZzo887FGLgK+maI1mZF3ILm6k+b3qZwUoxu6DfBO9kdJNv7f38jifw3/MaER
 wzrZNDwa1t8iGGKLbwMA95nDeVa80oLRHgmgLnwkHuvC1TiI8JOUy+EX6Z/fg8DwfGQjYT7YfPF
 clofWUjEeSdjSxmlX5/sD8JzZ01Ud0imgtkK6yNOYJ5nD0pqHtLlFtZU94XPP0ltI7ISeY6/dZd
 AXaXrt2ntuBpa2fJO9OtrtMpBfAPkg==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=6918a8ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EmkpbSNm7JsG3YkcSP0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

Hi Linus,

please pull a single fix for 6.18-rc6.

Thanks,
Heiko

The following changes since commit 64e2f60f355e556337fcffe80b9bcff1b22c9c42:

  s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP (2025-10-30 16:59:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-4

for you to fetch changes up to 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c:

  s390/mm: Fix __ptep_rdp() inline assembly (2025-11-14 15:58:20 +0100)

----------------------------------------------------------------
s390 fixes for 6.18-rc6

- Fix a bug in the __ptep_rdp() inline assembly which may lead to
  missing TLB flushes

----------------------------------------------------------------
Heiko Carstens (1):
      s390/mm: Fix __ptep_rdp() inline assembly

 arch/s390/include/asm/pgtable.h | 12 +++++-------
 arch/s390/mm/pgtable.c          |  4 ++--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b7100c6a4054..6663f1619abb 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1154,17 +1154,15 @@ static inline pte_t pte_mkhuge(pte_t pte)
 #define IPTE_NODAT	0x400
 #define IPTE_GUEST_ASCE	0x800
 
-static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep,
-				       unsigned long opt, unsigned long asce,
-				       int local)
+static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep, int local)
 {
 	unsigned long pto;
 
 	pto = __pa(ptep) & ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
-	asm volatile(".insn rrf,0xb98b0000,%[r1],%[r2],%[asce],%[m4]"
+	asm volatile(".insn	rrf,0xb98b0000,%[r1],%[r2],%%r0,%[m4]"
 		     : "+m" (*ptep)
-		     : [r1] "a" (pto), [r2] "a" ((addr & PAGE_MASK) | opt),
-		       [asce] "a" (asce), [m4] "i" (local));
+		     : [r1] "a" (pto), [r2] "a" (addr & PAGE_MASK),
+		       [m4] "i" (local));
 }
 
 static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep,
@@ -1348,7 +1346,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 	 * A local RDP can be used to do the flush.
 	 */
 	if (cpu_has_rdp() && !(pte_val(*ptep) & _PAGE_PROTECT))
-		__ptep_rdp(address, ptep, 0, 0, 1);
+		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..05974304d622 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -274,9 +274,9 @@ void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	preempt_disable();
 	atomic_inc(&mm->context.flush_count);
 	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
-		__ptep_rdp(addr, ptep, 0, 0, 1);
+		__ptep_rdp(addr, ptep, 1);
 	else
-		__ptep_rdp(addr, ptep, 0, 0, 0);
+		__ptep_rdp(addr, ptep, 0);
 	/*
 	 * PTE is not invalidated by RDP, only _PAGE_PROTECT is cleared. That
 	 * means it is still valid and active, and must not be changed according
