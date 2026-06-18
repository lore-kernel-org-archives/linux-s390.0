Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EC1C3BFC
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795449; cv=none; b=hzgJo/I3DXOVLJf/pxYuV1cEkvAuNr59rAygRVMZGNlv4Zcjta5/iHNE9BKKOmM1x7LW5ku35nl0NqtNQF4T6gxHF5HFmH9UA24Ws9BwAqgK/3vuFcZrDBDtlc8XrrFmnk4C/UU6L+aqF4w+QqpRFtNTSzAEs//TzMNkeRtB1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795449; c=relaxed/simple;
	bh=DaMEyzJte5E7wdGtpMpplPaC7uYintnRlwN+wY90eBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPslwSG14BYEMUBRWXcATjMW7RDZPXToqQbhhDJ+VwsBXDToSW9Oshz7UfndeCunfZeVVMuJypyzjpq2iPEwDFOgdtI7f+RVLqSg7lZgNWjpNat3+YKXBq7m5wni3N2TBDJXKtHN17MxYMp3XRVR1megZKZsUiEIJYzSGfy+FzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRV47cGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRV47cGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063661F000E9;
	Thu, 18 Jun 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795448;
	bh=BDfOv6Z9L5c4Wbjuw4xAGcEDmevB0FSlB9lPj1gs270=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRV47cGo2ReNt9TjJZN8bZIK/VbxGLMFRqemR4mDAJtVlo+9OESy+r4fmP/vhZaQI
	 qrMoTJwRxAjJv67H0n6lDM/bBcbXn8WZKKKvqiZslXRdHvdVhGK+SpcR7qqe23Pq+L
	 sj3i6YQst1VeU+lCEVMhsmy/p9YUydYHAIHQhWKR7UKi6oUYtqTO2GZNY50Kt30oEZ
	 4YTQTrXLdcOd8PaHKROBUULu2vI26qnWcZxwoIkvycXSbkLajHALgmuicJoWcSo/Ho
	 lzFCSTNt0UT+P/SNP/VfqBvTAmW5R7SfdBh1u+asi1mLIPRghpPVIQxQUx5TCNJq9i
	 eNlCwElbJkKOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next v4 2/4] s390/mm: Batch PTE updates in lazy MMU
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <e50680152fc7d99215d53758fab4b87280d25c20.1781789772.git.agordeev@linux.ibm.com>
References: <cover.1781789772.git.agordeev@linux.ibm.com>
 <e50680152fc7d99215d53758fab4b87280d25c20.1781789772.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:10:47 +0000
Message-Id: <20260618151048.063661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Deferred PTE updates to a per-CPU cache break synchronization =
with lockless page table walkers like GUP-fast, allowing them to pin pages =
being concurrently write-protected for COW.
- [High] The lazy MMU cache bypasses the `full=3D1` TLB flush optimization =
during process teardown, causing an O(N) IPTE storm.
--

commit 38614c455538c6b6144011b070bbbf41513506e6
Author: Alexander Gordeev <agordeev@linux.ibm.com>

s390/mm: Batch PTE updates in lazy MMU mode

This commit introduces a per-CPU cache to batch PTE updates while in lazy
MMU mode. By caching PTE changes and applying them simultaneously with the
IPTE instruction's "Additional Entries" feature, it reduces overall IPTE
traffic.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h

[ ... ]

> @@ -1259,11 +1373,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
>  {
>  	pte_t res;
> =20
> -	if (full) {
> -		res =3D ptep_get(ptep);
> -		set_pte(ptep, __pte(_PAGE_INVALID));
> -	} else {
> -		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {

[Severity: High]
Does checking lazy_mmu_ptep_get_and_clear() before the 'full' flag bypass
the teardown optimization and cause an IPTE storm?

During process teardown, exit_mmap() and zap_pte_range() use
ptep_get_and_clear_full(..., full=3D1) to clear PTEs without issuing indivi=
dual
TLB invalidations, deferring the flush to a global teardown at the end.
If lazy_mmu_mode_enable_with_ptes() is active, this intercepts the call,
writes _PAGE_INVALID to the cache, and bypasses the if (full) path.

Later, when lazy_mmu_mode_disable() flushes the cache, it calls
__invalidate_pte_range() in arch/s390/mm/lazy_mmu.c:

static void __invalidate_pte_range(...)
{
	...
	if (cpu_has_tlb_lc() && ...)
		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_LOCAL);
	else
		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_GLOBAL);
	...
}

This unconditionally executes batched IPTE instructions for all cached PTEs.
For multi-threaded processes, does this turn an O(1) TLB flush operation
into an O(N) global IPTE broadcast, causing a regression in system
performance during process termination?

> +		if (full) {
> +			res =3D __ptep_get(ptep);
> +			__set_pte(ptep, __pte(_PAGE_INVALID));
> +		} else {
> +			res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +		}
>  	}
>  	page_table_check_pte_clear(mm, addr, res);

[ ... ]

> @@ -1289,10 +1405,15 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> -	pte_t pte =3D ptep_get(ptep);
> +	pte_t pte;
> =20
> -	if (pte_write(pte))
> -		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
> +	if (!lazy_mmu_ptep_set_wrprotect(addr, ptep)) {

[Severity: Critical]
Can intercepting the write-protect operation here break synchronization with
lockless page table walkers like GUP-fast?

During fork(), copy_pte_range() calls lazy_mmu_mode_enable_with_ptes().
When copy_present_pte() attempts to write-protect the parent's PTE by
calling ptep_set_wrprotect(), the lazy MMU mode intercepts the call via
__lazy_mmu_ptep_set_wrprotect() in arch/s390/mm/lazy_mmu.c:

bool __lazy_mmu_ptep_set_wrprotect(...)
{
	...
	pte =3D __ipte_range_ptep_get(range, ptep);
	if (pte_write(pte)) {
		pte =3D pte_wrprotect(pte);
		__ipte_range_set_pte(range, ptep, pte);
	}
	return true;
}

This updates the per-CPU cache but leaves the physical PTE completely valid
and writable until the cache is flushed at the end of the PMD range. Because
GUP-fast operates locklessly, a concurrent thread in the parent process can
read the physical PTE, observe that it is still writable, and successfully
take a FOLL_WRITE pin on the page.

Meanwhile, fork() proceeds, sees no pins, and shares the page with the
child. Does this create a regression where the parent retains a writable
GUP pin to a page shared with the child, allowing writes to corrupt the
child's memory and break COW isolation?

> +		pte =3D __ptep_get(ptep);
> +		if (pte_write(pte)) {
> +			pte =3D pte_wrprotect(pte);
> +			ptep_xchg_lazy(mm, addr, ptep, pte);
> +		}
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781789772.gi=
t.agordeev@linux.ibm.com?part=3D2
