Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD243B3FF
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953230; cv=none; b=V2EV5DCwPhpRhBb4wJsZJEqJTWmcvKhX0gZWAynGYCzbqwR8DO7Gcyhhof5RQNMvfvPQuQB3CN+Lp6HQ/Rgn+QA1JDu7GJm4Ys3Uop2MKbF+6jYYMyowbXYKaWMCPzqYsGoVWeMasz69Dzoe6hehFe6XI9qorryFVvCWbSpvR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953230; c=relaxed/simple;
	bh=RAkjcbOnlu3hFTl9mdGeI19EYYiLnJBJzLv/1aCbRwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DCm9kta/vYdLuWtjKiSJ1gvKBM1qw+ftwX0vA/lpNr/TV2SMlbierimCQ/7c7nlN3s5OXZQOx2HqEaFpdmF4qHE3x//8+Yf0OH7L7PzraHubIft9wLzS825LLObCSthzZtqEuep5gGsRIvlUlh3agLcvwC5rh4s/MUHKwqB0ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH1UySgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH1UySgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE61F1F000E9;
	Mon, 13 Jul 2026 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783953227;
	bh=FOIPWvRnPtDACn6p8dktkwJ6Rktu+0Z3VDXWexWxMUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AH1UySgyAraWgsBPNr/BOeMufqZmMHtFfax4UVvLxyai1gqvPSqZoLqnqsZOWrj9S
	 5N6MZdQXtiZylZlLJb1GWvcYUIOBBHl7IukSbq4yiJb3BzuxA1R9uoTxfjQ7iRp7DR
	 r0LP0u7V9r+9FGnuTgow/ZjeWp3SuJNcQ8lglSJzCTNSqnWrTbU/S3U+BEnassQJ+3
	 qbJnvRCmBEjnd0CDZX63IRXSWdgk6I9ETIyI9DbYSkvI6A+WEIIkQmAhZJTTOITgww
	 8+VahKItmAEsgTSmglBx7RW1oLclwAksUQNxx7fR7SPRL5bNF8QN0Q53ZqAOR2ELEx
	 SEV60xp3dIAKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <227ed305e14b04b97be34716426e369860efc99c.1783945507.git.agordeev@linux.ibm.com>
References: <cover.1783945507.git.agordeev@linux.ibm.com>
 <227ed305e14b04b97be34716426e369860efc99c.1783945507.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:33:46 +0000
Message-Id: <20260713143346.EE61F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Violation of Ultravisor architecture constraints by deferring =
PTE invalidation while calling `uv_convert_from_secure_pte()`.
- [High] `ptep_get_and_clear_full()` bypasses the `full` optimization durin=
g process teardown, causing massive redundant IPTE traffic.
- [High] Deferred page table memory updates break lockless page table walke=
rs (like GUP-fast).
- [Low] Dead declarations for IPTE range modify protection functions.
--

--- Patch [2]: [PATCH v5 2/4] s390/mm: Batch PTE updates in lazy MMU mode -=
--
commit dedb613a05cdcf9218ef386e46c14b5cce4aa714
Author: Alexander Gordeev <agordeev@linux.ibm.com>

s390/mm: Batch PTE updates in lazy MMU mode

This commit introduces a per-CPU cache to batch PTE updates while in
lazy MMU mode. It intercepts PTE updates to store them in a software
cache, flushing them to the hardware page tables in a single operation
upon exiting lazy MMU mode.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> [ ... ]
> @@ -1220,7 +1308,8 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
ruct *mm,
>  {
>  	pte_t res;
> =20
> -	res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res))
> +		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
>  	page_table_check_pte_clear(mm, addr, res);
>  	/* At this point the reference through the mapping is still present */
>  	if (mm_is_protected(mm) && pte_present(res))

[Severity: Critical]
Does this sequence violate Ultravisor constraints?

When unmapping secure execution guest memory, this path caches the
invalidation but leaves the hardware page table unmodified. The function
then immediately calls uv_convert_from_secure_pte() while the real PTE in
memory is still present.

Could concurrent hardware walks encounter a secure PTE mapping a now
non-secure page and trigger a hardware fault?

> [ ... ]
> @@ -1229,9 +1318,34 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
> [ ... ]
> +bool ipte_range_ptep_modify_prot_start(struct vm_area_struct *vma,
> +				       unsigned long addr, pte_t *ptep, pte_t *res);
> +bool ipte_range_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +					unsigned long addr, pte_t *ptep,
> +					pte_t old_pte, pte_t pte);

[Severity: Low]
Are these declarations for ipte_range_ptep_modify_prot_start() and
ipte_range_ptep_modify_prot_commit() used anywhere?

It looks like they are declared here but never implemented, as the code
instead provides __lazy_mmu_ptep_modify_prot_start().

> [ ... ]
> @@ -1261,11 +1375,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
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
> +		if (full) {
> +			res =3D __ptep_get(ptep);
> +			__set_pte(ptep, __pte(_PAGE_INVALID));
> +		} else {
> +			res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +		}
>  	}

[Severity: High]
Does this bypass the full optimization during process teardown?

During exit_mmap(), zap_pte_range() passes full=3D1 to skip individual IPTE
flushes since the entire address space is being destroyed.

By unconditionally intercepting the call via lazy_mmu_ptep_get_and_clear(),
this bypasses the full optimization fast path. Will this cause
leave_ipte_range() to subsequently issue redundant IPTE instructions for
every single valid PTE?

> diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
> --- /dev/null
> +++ b/arch/s390/mm/lazy_mmu.c
> [ ... ]
> +bool __lazy_mmu_ptep_get_and_clear(unsigned long addr, pte_t *ptep, pte_=
t *res)
> +{
> +	struct ipte_range *range;
> +	pte_t pte, old;
> +
> +	range =3D this_ipte_range(ptep);
> +	if (!range)
> +		return false;
> +
> +	old =3D __ipte_range_ptep_get(range, ptep);
> +	pte =3D __pte(_PAGE_INVALID);
> +	__ipte_range_set_pte(range, ptep, pte);
> +	*res =3D old;
> +
> +	return true;
> +}

[Severity: High]
Can this deferred page table update cause issues with lockless page table
walkers like get_user_pages_fast()?

When mprotect() uses lazy MMU mode and calls ptep_modify_prot_start(),
this function updates the local software cache to invalid but leaves the
hardware PTE fully valid and writable.

Since lockless walkers read the hardware page tables directly without
taking the page table lock, could they see a present, writable PTE and
successfully pin the page for writing, completely ignoring the ongoing
mprotect()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783945507.gi=
t.agordeev@linux.ibm.com?part=3D2
