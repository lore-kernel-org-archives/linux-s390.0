Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE3437853;
	Wed, 15 Jul 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114537; cv=none; b=mfX3zvuHIsvCQlPMCCfpqAnrCdYKcBQMgasI3os7yfWXzI7R9AQ91Sw2enf2FcsYEgMiDxEMl+X8DsMWysByrwTP9Oc/lkUN+TtiKpHlTVQ8S+3H5Mw1puvO4APE5zSuyBEO25oLkBDTVW0ZoBqDwbZQPdQobF1+TGjJXA4TmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114537; c=relaxed/simple;
	bh=5cf9QqW0v5yshwkuyiXsQMRysV/flql/NOc80Ucbp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RItC/X+/lS5d6LeqKjuT5r+7EPBVXKso1flHdnFB80yNCfyQKMwxgSNXfZJeGNw3xZqLXgfnE5uVJMNFMFRPj3fgvHa+bF4k+3cHj8YgCAyJ8MtqOnlhLzY+MyLwugxeqIYo7xhNroT7KFnJA0jxTdV8+K1UDiD9K9mMSRHBce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AGTEr1Xy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AGTEr1Xy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBBc4Y008004;
	Wed, 15 Jul 2026 11:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N8KRA9
	VOjQ7d/2R2/PWUzqd5Xp2TYJqZo//E22d/op4=; b=AGTEr1XyLhg1PRoS0oqtgB
	aMIkd1ltTvh7I4AJV9G/5cGBEiQ2RtYUHXInUj5c31rolvKRqKYGiBADoutsR369
	fUew2XoIMEix1akTfY7PrWx72tdxXZvI56wH9kAjrK3U9tBhEysGjavwWuEwlYLZ
	t3/CDKKpnzrM9gQ1kqfpcgcP7mT2hiArKmLA4Y/LPgC0F3GD8XZfV93n1QiwzBRB
	Sep0XJ+RBI177nVFL0ne5D++SI/0JjeFvW5D7I+J/5JYRe74g9097vRpOOw1OfH8
	wXb+X+S5/L6NeBpq0uLXQf3zoiRcphQsSVVcFjYpCLqXrf7EK9YXpFs+KzmWXKfg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtb8yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 11:22:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FBJwdv029332;
	Wed, 15 Jul 2026 11:22:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgfgax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 11:22:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FBMAC630671144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 11:22:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9776A2004E;
	Wed, 15 Jul 2026 11:22:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B43B20049;
	Wed, 15 Jul 2026 11:22:10 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jul 2026 11:22:10 +0000 (GMT)
Date: Wed, 15 Jul 2026 13:22:09 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <fa2e2c24-7520-4dd3-8bfa-641e92bbb740-agordeev@linux.ibm.com>
References: <cover.1783945507.git.agordeev@linux.ibm.com>
 <227ed305e14b04b97be34716426e369860efc99c.1783945507.git.agordeev@linux.ibm.com>
 <20260713143346.EE61F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713143346.EE61F1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _kaTNYmcPZAF0G-LMPvP5TNocVk1EA8f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExMCBTYWx0ZWRfXwjGUrcUnud85
 z3muErlnvaPHyJBas//BifMXWF5eC0wP+sDAVD3yzIAqREog0Oe6mvMvSksuVbSc1NkRAUayupW
 9aqTbwNcMh50k5X7MwbsQqs4dDC3V34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExMCBTYWx0ZWRfX7Jv5WJvOcUtm
 9ru+GFAnuCoseyxwfgwXfcFB+I2gsY78Rl4K1fZgEeqWxRfdmAMbi3Obh+l1eS7zhqYa12fwCeD
 TzHFzXdZ3kUI/8veaPLwG9SUtM7QuueEUTyuBMUO0T8wTWMFT/IH1Fc1gFBy8FiQ6woeX/K6bOr
 6BcmzMLTA1WD1wakd7mcYTJWBhTLhXQ9/2ZVJjw5IrM6R11NmRHhKvp80YiaTgI0umHqz08nfpq
 ZIdVzGiMlMqwZppEeqaKWGT6RPYECCM1/kcY/P0c3m9xiTQophHyU6fAdYquFtQ1mcpFsvyOoH+
 IizFs02Xnyv+qJBfjq+NSP8EqkqUTZ50RrbDOA+ygVVGaWa/rMJFGHZ+vGd78IV8rZSp0PmgGU1
 qpvMDbn7QI38VMN9w9HltHyq8rz7QgVwIz0Q3gssyyNWcj7xRIuT28yBZuT+Z1lgXfSQkLdQdF8
 bire+be6SFAx+iJxImg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a576d67 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=Q8D4QgsuzZdEiK83EjAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: _kaTNYmcPZAF0G-LMPvP5TNocVk1EA8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150110

On Mon, Jul 13, 2026 at 02:33:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Violation of Ultravisor architecture constraints by deferring PTE invalidation while calling `uv_convert_from_secure_pte()`.
> - [High] `ptep_get_and_clear_full()` bypasses the `full` optimization during process teardown, causing massive redundant IPTE traffic.
> - [High] Deferred page table memory updates break lockless page table walkers (like GUP-fast).
> - [Low] Dead declarations for IPTE range modify protection functions.
> --
> 
> --- Patch [2]: [PATCH v5 2/4] s390/mm: Batch PTE updates in lazy MMU mode ---
> commit dedb613a05cdcf9218ef386e46c14b5cce4aa714
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> s390/mm: Batch PTE updates in lazy MMU mode
> 
> This commit introduces a per-CPU cache to batch PTE updates while in
> lazy MMU mode. It intercepts PTE updates to store them in a software
> cache, flushing them to the hardware page tables in a single operation
> upon exiting lazy MMU mode.
> 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > [ ... ]
> > @@ -1220,7 +1308,8 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >  {
> >  	pte_t res;
> >  
> > -	res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> > +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res))
> > +		res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> >  	page_table_check_pte_clear(mm, addr, res);
> >  	/* At this point the reference through the mapping is still present */
> >  	if (mm_is_protected(mm) && pte_present(res))
> 
> [Severity: Critical]
> Does this sequence violate Ultravisor constraints?
> 
> When unmapping secure execution guest memory, this path caches the
> invalidation but leaves the hardware page table unmodified. The function
> then immediately calls uv_convert_from_secure_pte() while the real PTE in
> memory is still present.
> 
> Could concurrent hardware walks encounter a secure PTE mapping a now
> non-secure page and trigger a hardware fault?

Concurrent walks are expected to be protected with a mm semaphore and/or
page table lock. Yet, it makes sense to exclude UV protected MMs from
the IPTE optimization altogether - I will do that in the next version.

> > [ ... ]
> > @@ -1229,9 +1318,34 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> > [ ... ]
> > +bool ipte_range_ptep_modify_prot_start(struct vm_area_struct *vma,
> > +				       unsigned long addr, pte_t *ptep, pte_t *res);
> > +bool ipte_range_ptep_modify_prot_commit(struct vm_area_struct *vma,
> > +					unsigned long addr, pte_t *ptep,
> > +					pte_t old_pte, pte_t pte);
> 
> [Severity: Low]
> Are these declarations for ipte_range_ptep_modify_prot_start() and
> ipte_range_ptep_modify_prot_commit() used anywhere?
> 
> It looks like they are declared here but never implemented, as the code
> instead provides __lazy_mmu_ptep_modify_prot_start().

This is a leftover, will remove it in the next version.

> > [ ... ]
> > @@ -1261,11 +1375,13 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> >  {
> >  	pte_t res;
> >  
> > -	if (full) {
> > -		res = ptep_get(ptep);
> > -		set_pte(ptep, __pte(_PAGE_INVALID));
> > -	} else {
> > -		res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> > +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {
> > +		if (full) {
> > +			res = __ptep_get(ptep);
> > +			__set_pte(ptep, __pte(_PAGE_INVALID));
> > +		} else {
> > +			res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> > +		}
> >  	}
> 
> [Severity: High]
> Does this bypass the full optimization during process teardown?
> 
> During exit_mmap(), zap_pte_range() passes full=1 to skip individual IPTE
> flushes since the entire address space is being destroyed.
> 
> By unconditionally intercepting the call via lazy_mmu_ptep_get_and_clear(),
> this bypasses the full optimization fast path. Will this cause
> leave_ipte_range() to subsequently issue redundant IPTE instructions for
> every single valid PTE?

Yes, but a fix I tried does not bring any performance difference (as described
in the cover letter), but instead makes the code more complicated).

> > diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
> > --- /dev/null
> > +++ b/arch/s390/mm/lazy_mmu.c
> > [ ... ]
> > +bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_t *res)
> > +{
> > +	struct ipte_range *range;
> > +	pte_t pte, old;
> > +
> > +	range = this_ipte_range(ptep);
> > +	if (!range)
> > +		return false;
> > +
> > +	old = __ipte_range_ptep_get(range, ptep);
> > +	pte = __pte(_PAGE_INVALID);
> > +	__ipte_range_set_pte(range, ptep, pte);
> > +	*res = old;
> > +
> > +	return true;
> > +}
> 
> [Severity: High]
> Can this deferred page table update cause issues with lockless page table
> walkers like get_user_pages_fast()?
> 
> When mprotect() uses lazy MMU mode and calls ptep_modify_prot_start(),
> this function updates the local software cache to invalid but leaves the
> hardware PTE fully valid and writable.
> 
> Since lockless walkers read the hardware page tables directly without
> taking the page table lock, could they see a present, writable PTE and
> successfully pin the page for writing, completely ignoring the ongoing
> mprotect()?

This (and any other GUP-fast related concerns) were answered in v4:
https://lore.kernel.org/linux-s390/6c4e313a-d4da-485e-b264-47a56f6b35b8-agordeev@linux.ibm.com/

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783945507.git.agordeev@linux.ibm.com?part=2

Thanks!
