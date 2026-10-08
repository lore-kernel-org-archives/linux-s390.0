Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5531716D;
	Thu,  8 Oct 2026 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441163; cv=none; b=YPS2O0P4elD3boxXYx0si+cVaNhCV+r0r4QTnZ+6eubf1zoWExubUplzfAQV2WtiktrCu/CjP7nLFIWJFmxep6WYNYNCNsVXrApxblLUunu4AVjOYRDvC7hY3k9qzjJ3sUmUk7DmA4pBSgmTpsEmzAHSBd3Wa+DPT+ffD2EYCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441163; c=relaxed/simple;
	bh=0NjCLXTdlPnhoQoGYvJGSJ2FzBCP1WT1ZxJ0+4u61NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZwoO5RKC95v1hrJyFRcXCjngii75CU+tfoHe8c684H6Q896mljeA2LxC4F6c3DgVtdeHaEofqHCcllubxCkwy7nV0Kc6HnwDPPWC925WFSJ8fs4hn+d++aS72i6oy40/+lpUMdKHF+7lyv1NPc0lnoelCCM2s1WmVAS1XbmaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YDmvtW1U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YDmvtW1U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984ZaJe2735836;
	Thu, 8 Oct 2026 06:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TcuQwF
	DZVHkOUkuLCPkPZfifCMg8DTmlZ6vjcFU1y3k=; b=YDmvtW1U8bSPOhBtoabU1V
	FWMchk6ENMR6rdX4COToR7Fco13B4nFv4qPpJL/1W68K/Vep40Y0n1l+ktUjT/h/
	2NwmMdNZIodous9AV9OIqSMuepEN5D91SAwcrBtNsMGle4yC/NogbFtAmEwMDNqN
	N6rCyqkyjFXHs4gh65esa215E9nwMofk3T4rroPR3St5p8P49QM6vc3Br0/yCkTr
	/N8ffv5EBYGZAaYedpfFvvZDReJzuCKCy63ZJb5pw6OiNja/bn5wxBXtiKjzKtYx
	l+8pdGA7ifwjsM0cVkO5xHrWBqfaEQkAAqlhzQKvoU56+Bo46VcE4N48D6JnuPug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw1vek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 06:32:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6984Hbq21678354;
	Thu, 8 Oct 2026 06:32:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tvyp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 06:32:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6986WaEl15532324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 06:32:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D51220043;
	Thu,  8 Oct 2026 06:32:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C1A20040;
	Thu,  8 Oct 2026 06:32:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.91.179])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Oct 2026 06:32:36 +0000 (GMT)
Date: Thu, 8 Oct 2026 08:32:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v8 13/15] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <b5f6ff94-d5a8-41a7-b52a-538a031114e2-agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <277e24d315e55592c367ac0c347d44cac5e429f4.1791365932.git.agordeev@linux.ibm.com>
 <sashiko-outbox-162972@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162972@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UiAZAdX681ajix1KNBs3cM86_GEjhXF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX374bHZJk5XAs
 B8MR/Xu41MGrAaOQ6fgJnA4tINDgtKApdyhOE2uTlkX7EZ1+Pk7wYlegcDhcgS2XPd/BG/HJl9R
 chqjYzh/AxVmBLX1I3/wclQJemWcTQvRp3orn2+yUt5fe9rS6kfn9WuiEKu/o8Ea8KXclco8W1I
 zxZLi7vMENPzpoA0rmyDZwBPayqTeedv7aJJTjZZ17d1ffXmPTTjaWRwnwhfkL9feOj45Vcm+0c
 yVBsdRXkwraD82R75tVzqi/o93o9nXVBrQJpUbqtTT75bKVj9GWaUAYd3/0LaXhWyJ00EJqLwem
 NopNmN+46C6agNiWT47yE4ZjwoF40pVC0C7kbPjPVlYrujJwA8OT0n9h0qWh9jUswpfVaMOvhTO
 RkdYPuCUtRCcPATXzeIMEHOHgX/zGN/sal0C5LMckA75AHPZ0Kpw8nKJQG+OF+HHb1IbGSeysfq
 DX7h8I3JKFbZeHp+pvQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac73909 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=bE1xJabK_bL7nDv_O4YA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX/5HObzbrZcbc
 xSCQjwArpDKWZ0Pq4dmHe2P4ckwHCKBC64z2ixakhTZ4PMcBEbw8TnFkfUr1//8AiI7A7zXtiYe
 80kZl0F7BSqYF+RTmYW0UKtT0U4C68Y=
X-Proofpoint-ORIG-GUID: UiAZAdX681ajix1KNBs3cM86_GEjhXF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080024

On Wed, Oct 07, 2026 at 12:06:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] s390/mm: NULL pointer deref on CPU hotplug lazy MMU rollback failure
> - [High] s390/mm: Hardirq torn read of ipte_range bounds causes OOB memory write
> - [High] s390/mm: ptep_get_and_clear_full() bypasses fullmm optimization in lazy MMU mode
> - [Medium] s390/mm: ptep_get_and_clear_full() bypasses fullmm TLB optimization
> --
> 
> commit 93b412133f9ff3548a7d0d31445ca8ff8b51da29
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> s390/mm: Batch PTE updates in lazy MMU mode
> 
> This patch introduces a per-CPU cache to batch PTE updates (via the IPTE
> instruction) during lazy MMU mode. This reduces CEC-wide quiesce traffic
> for memory-management system calls like mprotect(), munmap(), and mremap(),
> yielding significant performance improvements.
> 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index c47264f3abf21..decce76fac743 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> [ ... ]
> > @@ -1263,11 +1383,13 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
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
> Does intercepting the clear operation via lazy_mmu_ptep_get_and_clear() before
> checking the full parameter bypass the fullmm optimization?
> 
> During process teardown (e.g. exit_mmap()), fullmm is set to 1 to skip
> individual IPTE (TLB flush) instructions because a full MM TLB flush will be
> performed at the end. By unconditionally caching the clear operation in the
> lazy MMU cache here, leave_ipte_range() will later issue batch IPTE
> instructions for these entries when lazy MMU mode is disabled. This appears
> to degrade the O(1) TLB teardown into O(N) CEC-wide synchronizing IPTE
> instructions.

We can not keep the full = 1 optimization in lazy mode, since nothing
prevents other primitives from access a ranged PTE in cache before/after
ptep_get_and_clear_full(..., full = 1) updated the PTE directly.

The good news in practice exit() would normally get called after threads
on other CPUs have already been shut down, so the final IPTEs going to be
local to the executing CPU rather than global.

> [ ... ]
> > diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
> > new file mode 100644
> > index 0000000000000..8c1a62f237362
> > --- /dev/null
> > +++ b/arch/s390/mm/lazy_mmu.c
> [ ... ]
> > +static void enter_ipte_range(struct mm_struct *mm,
> > +			     unsigned long addr, unsigned long end, hw_pte_t *pte)
> > +{
> > +	struct ipte_range *range;
> > +
> > +	if (!static_branch_likely(&lazy_mmu_enabled))
> > +		return;
> > +
> > +	range = get_cpu_var(ipte_range);
> 
> [Severity: High]
> If lazy_mmu_alloc() fails during CPU hotplug, could this retrieve a NULL
> ipte_range pointer?
> 
> When a lazy_mmu_alloc() failure triggers a CPU hotplug rollback,
> lazy_mmu_cpu_offline() frees the memory but does not disable the globally
> active lazy_mmu_enabled static branch. Subsequent lazy MMU entries on that
> CPU would bypass the static branch check above, retrieve a NULL ipte_range,
> and dereference it below.

There will be no subsequent lazy MMU mode entries on a CPU that
failed lazy_mmu_alloc(), since such CPU will never get onlined.

> > +	local_bh_disable();
> > +	get_lowcore()->lazy_mmu_count++;
> > +
> > +	if (mm_is_protected(mm)) {
> > +		local_bh_enable();
> > +		return;
> > +	}
> > +
> > +	range->mm = mm;
> > +	range->base_addr = addr;
> > +	range->base_end = end;
> 
> [Severity: High]
> Can a hardirq observe a torn state here?
> 
> The base_addr and base_end fields are updated sequentially. If a hardirq or
> NMI strikes after base_addr is set but while base_end is still 0, a
> concurrent execution of this_ipte_range() would observe base_end == 0.

The contract is a hardirq handler is not allowed to access the ranged
PTEs while in the lazy MMU mode. That is what this_ipte_range() ->
VM_BUG_ON(in_hardirq()) check is for.

Should this contract is ever get changed, enter_ipte_*range() and
leave_ipte_range() will have to disable the top halves as well.

> This would cause the calculation:
> nr_ptes = (range->base_end - range->base_addr) / PAGE_SIZE;
> 
> to underflow to a massive value, bypassing the bounds validation and allowing
> an out-of-bounds memory write to range->cache[idx].
> 
> > +	range->base_pte = pte;
> > +
> > +	local_bh_enable();
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1791365932.git.agordeev@linux.ibm.com?part=13
