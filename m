Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9D35F5ED;
	Mon, 22 Jun 2026 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111080; cv=none; b=Leby1rckmDUwohUMOVcFfJihCfA+wUYL/DLCADrrwGi97OWGmqwirWcDaCXdVliljSHOQYtSisyK19ZejcparFDrPxjYAK3Ruds61c0qpWBtLcEgV6IaQlvs6cEEisuQSH8ab32IskND5e1h+4T6L79SoMXT7U0Tkj47c3aKYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111080; c=relaxed/simple;
	bh=WdKIPWUN5WH8CRR2edf/Lv5w6x60rstgnvn7o1XFCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwQHWnMZNpI/FJuJeWgAyK7eyazK5NaUKxy95WWu90kFNEVF9ChzbXw031pqdJC+7LafF9ia92KdEaUDnt77ZPUSVfsVoiFmineDoiAEAGxf+p/8dnrO88qYhCMoTVmztwxQJXI9P2dgcELJYJAcnQvYyDtnQTK/av6JVhFBpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/3rKbRo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/3rKbRo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5IkQw1814109;
	Mon, 22 Jun 2026 06:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3Arr7j
	1cZAT9UK56N9PTA4oMJbqdE3ovVJvN1eD+loQ=; b=P/3rKbRoMM2QXROZeDbG9a
	yrWBMS6zMcka8nWmYRkgVMI88czRJVRDxWgRl5AvFLZdvg6YCK+j/SmLwosUbUBx
	Lh+NEVq70E479R9eUvlel1WeEhR2dfiUX4P0V24uelWnZ9+i98P+Qd8B5MXF+Rsy
	dLvSaqd6qOuAbPnXFNcWaOB7KInpuTJiwChTFBxF/fGAcTaL6F/v2ZGxsqFQV6FY
	2XQLGcTDdBn9CzOh6dDLvOTYO6ww+fVnXh0OjuHXvq8o+zcqRAf+dm60hHvoDbly
	jgB246su3ERjcSHubZqnvWuNdtWVXNLRFmirljooTF27E0do78/5sHpphjdOss3Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqfkre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 06:51:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M6nkoj008671;
	Mon, 22 Jun 2026 06:51:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw4ytx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 06:51:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M6pDsA27656676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 06:51:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B7720040;
	Mon, 22 Jun 2026 06:51:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B191720043;
	Mon, 22 Jun 2026 06:51:12 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.88.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 06:51:12 +0000 (GMT)
Date: Mon, 22 Jun 2026 08:51:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH -next v4 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <6c4e313a-d4da-485e-b264-47a56f6b35b8-agordeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a38db66 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=dQFjYt8AhRNDjyuOKYEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA2NSBTYWx0ZWRfX+CvEtxWwx19S
 rTgOk5aF13Lisgj+TPdFBnR9tVexcQXmzKSm4z/mM1mQC3xP1adfSHQoU+5n/DSh8Bw28naenBH
 c14D8UHBLXenVpNxidwN/EoL1HfmBmerETuWD1YZGIykbS9UhyyGgVTxOEC9y0M8BZBwNQNev0p
 oaWVTNcZRdV1obgzfsBE3o69omAjP7q2RTFnW8jtH0M2h65uqBSYGQ6KnQgZnSpAhnwcLdYUkwI
 m8l1Z8xW8Xc9jcKUIhsaIwBdufYbPnaSrGq3lRv6kKbU33+ae1txxZerQOoJa3oSRRR97MK8BgZ
 IO3Ov3uJe3/WCK3eaXVF57aaf8SbhylQVWWIwLOaByt6SJL+HLUd7tiFzXyi1hD5CNU8k0s1gZX
 72t3nwmUio6Y62zk7yULGHHD4Yo2KvPE6tg1FJy89hn8UIwKeg7bgllybM8ugbnGbW44/Tc++k+
 GmiNsTzsg1Eg/KkttbQ==
X-Proofpoint-GUID: 7_rVYTzKrFWI7mbEBaHed7oPAhOBHwuk
X-Proofpoint-ORIG-GUID: 7_rVYTzKrFWI7mbEBaHed7oPAhOBHwuk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA2NSBTYWx0ZWRfXzhoml7KU4oho
 IL6kGszrqBDfk5JtqFS0CH9tUO15fgMSWZs1p7ZQAO99EiX+c4kWdaR1GorIHK/5jPN4xjmivcH
 XlDp0y4nG7sT3OtbHyPN+Rt4PISGfZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220065

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
> 
> > @@ -1289,10 +1405,15 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> >  static inline void ptep_set_wrprotect(struct mm_struct *mm,
> >  				      unsigned long addr, pte_t *ptep)
> >  {
> > -	pte_t pte = ptep_get(ptep);
> > +	pte_t pte;
> >  
> > -	if (pte_write(pte))
> > -		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
> > +	if (!lazy_mmu_ptep_set_wrprotect(addr, ptep)) {
> 
> [Severity: Critical]
> Can intercepting the write-protect operation here break synchronization with
> lockless page table walkers like GUP-fast?
> 
> During fork(), copy_pte_range() calls lazy_mmu_mode_enable_with_ptes().
> When copy_present_pte() attempts to write-protect the parent's PTE by
> calling ptep_set_wrprotect(), the lazy MMU mode intercepts the call via
> __lazy_mmu_ptep_set_wrprotect() in arch/s390/mm/lazy_mmu.c:
> 
> bool __lazy_mmu_ptep_set_wrprotect(...)
> {
> 	...
> 	pte = __ipte_range_ptep_get(range, ptep);
> 	if (pte_write(pte)) {
> 		pte = pte_wrprotect(pte);
> 		__ipte_range_set_pte(range, ptep, pte);
> 	}
> 	return true;
> }
> 
> This updates the per-CPU cache but leaves the physical PTE completely valid
> and writable until the cache is flushed at the end of the PMD range. Because
> GUP-fast operates locklessly, a concurrent thread in the parent process can
> read the physical PTE, observe that it is still writable, and successfully
> take a FOLL_WRITE pin on the page.
> 
> Meanwhile, fork() proceeds, sees no pins, and shares the page with the
> child. Does this create a regression where the parent retains a writable
> GUP pin to a page shared with the child, allowing writes to corrupt the
> child's memory and break COW isolation?

If this problem existed, it would be a generic problem for all architectures
that exercise the lazy mmu mode, not just for this implementation. Yet, the
described scenario is avoided by using mm_struct::write_protect_seq.

mm/memory.c::copy_page_range()

	if (is_cow) {
		...
		raw_write_seqcount_begin(&src_mm->write_protect_seq);
	}
	...
	/* copy the range */
	...
	if (is_cow) {
		raw_write_seqcount_end(&src_mm->write_protect_seq);
		...
	}

mm/gup.c::gup_fast()

	if (gup_flags & FOLL_PIN) {
		if (!raw_seqcount_try_begin(&current->mm->write_protect_seq, seq))
			return 0;
	}
	...
	local_irq_save(flags);
	gup_fast_pgd_range(start, end, gup_flags, pages, &nr_pinned);
	local_irq_restore(flags);

	/*
	 * When pinning pages for DMA there could be a concurrent write protect 
	 * from fork() via copy_page_range(), in this case always fail GUP-fast.
	 */
	if (gup_flags & FOLL_PIN) {
		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
			gup_fast_unpin_user_pages(pages, nr_pinned);
			return 0;
		} else {
		...
	}

Thus, the suggested flaw is a false positive.

> > +		pte = __ptep_get(ptep);
> > +		if (pte_write(pte)) {
> > +			pte = pte_wrprotect(pte);
> > +			ptep_xchg_lazy(mm, addr, ptep, pte);
> > +		}
> > +	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1781789772.git.agordeev@linux.ibm.com?part=2

Thanks!
