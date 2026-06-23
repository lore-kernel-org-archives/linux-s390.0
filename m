Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCC37B41A;
	Tue, 23 Jun 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196032; cv=none; b=phlLKn11MJLyhBcJ28O4BQboGlG4+anWvAyavlnlnkCaRFMzLcf8tORUhbKPrU1jNW/lX8wAu31NsKEAviW9wQQUFpIT/5cYnnGg8HEEfg0UvBzp0/s/KrVegX2sBGAAfeOca24N3/7UQKWxbVL2xSUUKQXZSSvsVHu0pAcnmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196032; c=relaxed/simple;
	bh=2BCm/8qi0wegq2UyBJz/fHmNf9U1oh10/dSV1aJS86c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcFXXf13qkBGvJpUWhFBpZoOLw0aPJAwb1jDOmxj8szsLKQqLFv5XJIKd9uYzXYTA03oaQ+oRoq/t4ZPwTAkS+qGIrXJChu/RqRw5/P0otL7oT0AFHIi902iDNLstz1+EMY1Q3Ldg4LPHf4AMFkmR0JY3gS8W+AVEw/++l6gqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMKlGQ9Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMKlGQ9Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0o0IQ348193;
	Tue, 23 Jun 2026 06:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wsa5c8
	Gp6pgW1vQTnTSqP+Uah99A+SQqdXDL4qoizYw=; b=FMKlGQ9Za13dGTzXHN8kKp
	u0bUFevGvCzbR+v6CwmydyQKXhu++cJsjklt5Ge9p4Rh/QC0ecYQrut5mbfJx86a
	VGV7wDHFKAtBvr0ADlk45ibNtSugBpgk5qeMMjzJNf0nYu9WgJZx/a7ZNJStIKko
	XHYHk4WnWndGs59vBwRx79iLSTWjeXQCpdZYay8X6Bzdbos//77qbXE0FyvF15IH
	uIalXI6sC5YzLpSHDuV5EVlavOoJMmFcxRmJu0YYsHPSNBWjEsUoYkM8392lSjcZ
	NcgkxgLIckFLTedrQ8ZR7Uthoc7BdtKzPA1F2t+LX3ZUAhyBuOW0JJkQWr0Eclaw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gcyqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:27:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N6Jc1e022750;
	Tue, 23 Jun 2026 06:27:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwa098-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:27:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N6R4r550463016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 06:27:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BC2C20043;
	Tue, 23 Jun 2026 06:27:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3591820040;
	Tue, 23 Jun 2026 06:27:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 06:27:04 +0000 (GMT)
Date: Tue, 23 Jun 2026 08:27:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH -next v4 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260623062703.269982B28-agordeev@linux.ibm.com>
References: <cover.1781789772.git.agordeev@linux.ibm.com>
 <e50680152fc7d99215d53758fab4b87280d25c20.1781789772.git.agordeev@linux.ibm.com>
 <20260618151048.063661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618151048.063661F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IqwR7pYETvuc7zTQRgI99LBRmHSgmQeh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX7yLwNGCsPBNy
 WZr8edLp9YpMS5kYXCImkjdK08liP5QASrvX9YEt/LiAoRdcwEuavnSP5wKKZXO5zDvEbpXFjhb
 vMLkfmMe5HtabyTZ4ogN9oQAFOTHSlQ=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a273d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=XhNGLxucu5zez_Ri8nIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX3TvZPGQvakGD
 EKFpH3DL2nbL6ZXBtpFaVIK+0quuyM1xw4XkZrWC01jJm1Xq1rIlAMz3OJT7v8AuJ/mECeMZQEh
 riWT3jqXIz0S0D9DPoTkT/++KUq+xdtCEhPv4G7HhrAIksUsKpJEFJTbzMQaPBCvTHQqHDk3YFR
 yPCMhEArZlBucahN4XBXyJnj3pDoT83oM05EN4fZs3UUu2EK/1O1fvVs3SzmZyWQZiB02OFE1Xz
 U1bouNslbmkC3VEPZHkh/QYsm12HDABOxDwB0hHCBDO9eag9h+P2ZQR3JhK2iorB2ryy+k/VtVO
 ucebCMGNp4yuV7QZ3LxvvIzW/Kgn1okyoRCx9oqry5FvkXsfceE3aKCyEn/yGf6/r0c5z5dpdOQ
 TjQkrFVuwR51gSkUl3g70GyBnOrZIpnw2H4WzZaBEQ7qMxlEoaES0wNewDOVVLTC8hY3+4CMlq3
 xChDngFU7adRjCKvYSQ==
X-Proofpoint-ORIG-GUID: IqwR7pYETvuc7zTQRgI99LBRmHSgmQeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048

On Thu, Jun 18, 2026 at 03:10:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Deferred PTE updates to a per-CPU cache break synchronization with lockless page table walkers like GUP-fast, allowing them to pin pages being concurrently write-protected for COW.
> - [High] The lazy MMU cache bypasses the `full=1` TLB flush optimization during process teardown, causing an O(N) IPTE storm.
> --
> 
> commit 38614c455538c6b6144011b070bbbf41513506e6
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> s390/mm: Batch PTE updates in lazy MMU mode
> 
> This commit introduces a per-CPU cache to batch PTE updates while in lazy
> MMU mode. By caching PTE changes and applying them simultaneously with the
> IPTE instruction's "Additional Entries" feature, it reduces overall IPTE
> traffic.
> 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> 
> [ ... ]
> 
> > @@ -1259,11 +1373,13 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> >  {
> >  	pte_t res;
> >  
> > -	if (full) {
> > -		res = ptep_get(ptep);
> > -		set_pte(ptep, __pte(_PAGE_INVALID));
> > -	} else {
> > -		res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> > +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {
> 
> [Severity: High]
> Does checking lazy_mmu_ptep_get_and_clear() before the 'full' flag bypass
> the teardown optimization and cause an IPTE storm?
> 
> During process teardown, exit_mmap() and zap_pte_range() use
> ptep_get_and_clear_full(..., full=1) to clear PTEs without issuing individual
> TLB invalidations, deferring the flush to a global teardown at the end.
> If lazy_mmu_mode_enable_with_ptes() is active, this intercepts the call,
> writes _PAGE_INVALID to the cache, and bypasses the if (full) path.
> 
> Later, when lazy_mmu_mode_disable() flushes the cache, it calls
> __invalidate_pte_range() in arch/s390/mm/lazy_mmu.c:
> 
> static void __invalidate_pte_range(...)
> {
> 	...
> 	if (cpu_has_tlb_lc() && ...)
> 		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_LOCAL);
> 	else
> 		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_GLOBAL);
> 	...
> }
> 
> This unconditionally executes batched IPTE instructions for all cached PTEs.
> For multi-threaded processes, does this turn an O(1) TLB flush operation
> into an O(N) global IPTE broadcast, causing a regression in system
> performance during process termination?
> 
> > +		if (full) {
> > +			res = __ptep_get(ptep);
> > +			__set_pte(ptep, __pte(_PAGE_INVALID));
> > +		} else {
> > +			res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> > +		}
> >  	}
> >  	page_table_check_pte_clear(mm, addr, res);
> 
> [ ... ]

This is a valid concern and a solution could look like the fixup below.
Yet, there is no real difference with the current version observed and
therefore I want to stick with it.

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index a93e7e7864571..8f4e4a95ee182 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -41,6 +41,7 @@ extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
 
 bool __lazy_mmu_ptep_test_and_clear_young(unsigned long addr, pte_t *ptep, int *res);
 bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_t *res);
+bool __lazy_mmu_ptep_get_and_clear_full(unsigned long addr, pte_t *ptep, pte_t *res);
 bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, pte_t *res);
 bool __lazy_mmu_ptep_modify_prot_commit(unsigned long addr, pte_t *ptep, pte_t old_pte, pte_t pte);
 bool __lazy_mmu_ptep_set_wrprotect(unsigned long addr, pte_t *ptep);
@@ -72,6 +73,14 @@ bool lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_t *res)
 	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);
 }
 
+static inline
+bool lazy_mmu_ptep_get_and_clear_full(unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	if (!is_lazy_mmu_active())
+		return false;
+	return __lazy_mmu_ptep_get_and_clear_full(addr, ptep, res);
+}
+
 static inline
 bool lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, pte_t *res)
 {
@@ -1379,13 +1388,14 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 {
 	pte_t res;
 
-	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {
-		if (full) {
+	if (full) {
+		if (!lazy_mmu_ptep_get_and_clear_full(addr, ptep, &res)) {
 			res = __ptep_get(ptep);
 			__set_pte(ptep, __pte(_PAGE_INVALID));
-		} else {
-			res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 		}
+	} else {
+		if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res))
+			res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	}
 	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
index ee2385897bc72..076c9cc492954 100644
--- a/arch/s390/mm/lazy_mmu.c
+++ b/arch/s390/mm/lazy_mmu.c
@@ -115,23 +115,15 @@ static void enter_ipte_range(struct mm_struct *mm,
 	kasan_poison_pte(range->base_pte, nr_ptes);
 }
 
-static void leave_ipte_range(void)
+static void flush_cache(struct ipte_range *range)
 {
 	pte_t *ptep, *start, *start_cache, *cache;
 	unsigned long start_addr, addr;
-	struct ipte_range *range;
-	unsigned int nr_ptes;
 	int start_idx;
 
-	if (!test_facility(13))
-		return;
-
 	lockdep_assert_preemption_disabled();
-	range = this_cpu_read(ipte_range);
-	if (!range->mm)
-		goto norange;
 	if (!range->start_pte)
-		goto done;
+		return;
 
 	start = range->start_pte;
 	start_idx = range->start_pte - range->base_pte;
@@ -155,8 +147,23 @@ static void leave_ipte_range(void)
 
 	range->start_pte = NULL;
 	range->end_pte = NULL;
+}
+
+static void leave_ipte_range(void)
+{
+	struct ipte_range *range;
+	unsigned int nr_ptes;
+
+	if (!test_facility(13))
+		return;
+
+	lockdep_assert_preemption_disabled();
+	range = this_cpu_read(ipte_range);
+	if (!range->mm)
+		goto norange;
+
+	flush_cache(range);
 
-done:
 	nr_ptes = (range->base_end - range->base_addr) / PAGE_SIZE;
 	kasan_unpoison_pte(range->base_pte, nr_ptes);
 
@@ -328,6 +335,31 @@ bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_t *res)
 	return true;
 }
 
+bool __lazy_mmu_ptep_get_and_clear_full(unsigned long addr, pte_t *ptep, pte_t *res)
+{
+	struct ipte_range *range;
+	unsigned int idx;
+	pte_t old;
+
+	range = this_ipte_range(ptep);
+	if (!range)
+		return false;
+
+	lockdep_assert_preemption_disabled();
+	idx = ptep - range->base_pte;
+	old = range->cache[idx];
+	if (pte_val(old) != PTE_POISON)
+		range->cache[idx] = __pte(_PAGE_INVALID);
+
+	flush_cache(range);
+
+	if (pte_val(old) == PTE_POISON)
+		return false;
+	*res = old;
+
+	return true;
+}
+
 bool __lazy_mmu_ptep_modify_prot_start(unsigned long addr, pte_t *ptep, pte_t *res)
 {
 	return __lazy_mmu_ptep_get_and_clear(addr, ptep, res);

> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1781789772.git.agordeev@linux.ibm.com?part=2

Thanks!
