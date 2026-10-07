Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F613B9D98
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374774; cv=none; b=RXqtx0g+AmL4ZilUlaIEJjYdwb2ny+q4yjL0z1vDdUhVbZB/8b2HQAaDAmUb7cyAqmfDbBDtZWTKVrNznol7pvM9E+iCF0PxPQyxCsa+bz1M4aLvgwVaa8rgN7GsFCQbDMAmBvMaajVo8qCVfnp0me2E97f9I5qct6q0DUjW2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374774; c=relaxed/simple;
	bh=W7vZvSboSe+OAcTT1X3TTMk0jgOzUdJuGoXjCLW+wOE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YwRY9JJ3b69TCgdwrjRJ6M+re+bbM/LeIvmyijjgsdUewkfgrf+0WnBZFgpWJeUYbV1yrbWoS4FSt5CA2k11FnZavVNkvu24j9yydPMPMS0i05r6Qb5yD1xs+EtMBX7+OOxl5WO99XJUTdunFEsdDt73TTYDyADfdHvw0Xs1hVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqON/6rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqON/6rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF4C1F0089B;
	Wed,  7 Oct 2026 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374764;
	bh=3lxoKVv2s5fslSeryMsdVGXPqhsAnHYvBmbB8dSzpt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqON/6rAKE+xtt9NIKCkhg2t94kG5ss/kokb7ug1aNGMood9ddEESz/0P8ngzGNBc
	 pvlE5KQPTTDAjY9X1WigzIqvMSJblHEqg4ZnptnJxmWdSq1FZo09TXBHmVdn2MfHuB
	 hTbrszQvxM9B0tVR03CtgzkWPzn7LIBI1Np8rhcfJ0YY62/X8MsVXTuoDPfMc25OZA
	 hcSp3aAdHSixAXTL+jHDXEqBBZoLv8ISLlvz+M7eOfA9FUMSwfe5koR4FM0viy9DHG
	 QqDzkCyJTVMZLqZIE6AA280sG2PrhcIQt1T/ocDG+NDsALsqh0NQW1dzRozc/4K9Rc
	 LEANGNzxIJAKQ==
Message-ID: <sashiko-outbox-162972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] s390/mm: Batch PTE updates in lazy MMU mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <277e24d315e55592c367ac0c347d44cac5e429f4.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <277e24d315e55592c367ac0c347d44cac5e429f4.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 12:06:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] s390/mm: NULL pointer deref on CPU hotplug lazy MMU rollback failu=
re
- [High] s390/mm: Hardirq torn read of ipte_range bounds causes OOB memory =
write
- [High] s390/mm: ptep_get_and_clear_full() bypasses fullmm optimization in=
 lazy MMU mode
- [Medium] s390/mm: ptep_get_and_clear_full() bypasses fullmm TLB optimizat=
ion
--

commit 93b412133f9ff3548a7d0d31445ca8ff8b51da29
Author: Alexander Gordeev <agordeev@linux.ibm.com>

s390/mm: Batch PTE updates in lazy MMU mode

This patch introduces a per-CPU cache to batch PTE updates (via the IPTE
instruction) during lazy MMU mode. This reduces CEC-wide quiesce traffic
for memory-management system calls like mprotect(), munmap(), and mremap(),
yielding significant performance improvements.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> index c47264f3abf21..decce76fac743 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
[ ... ]
> @@ -1263,11 +1383,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
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
Does intercepting the clear operation via lazy_mmu_ptep_get_and_clear() bef=
ore
checking the full parameter bypass the fullmm optimization?

During process teardown (e.g. exit_mmap()), fullmm is set to 1 to skip
individual IPTE (TLB flush) instructions because a full MM TLB flush will be
performed at the end. By unconditionally caching the clear operation in the
lazy MMU cache here, leave_ipte_range() will later issue batch IPTE
instructions for these entries when lazy MMU mode is disabled. This appears
to degrade the O(1) TLB teardown into O(N) CEC-wide synchronizing IPTE
instructions.

[ ... ]
> diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
> new file mode 100644
> index 0000000000000..8c1a62f237362
> --- /dev/null
> +++ b/arch/s390/mm/lazy_mmu.c
[ ... ]
> +static void enter_ipte_range(struct mm_struct *mm,
> +			     unsigned long addr, unsigned long end, hw_pte_t *pte)
> +{
> +	struct ipte_range *range;
> +
> +	if (!static_branch_likely(&lazy_mmu_enabled))
> +		return;
> +
> +	range =3D get_cpu_var(ipte_range);

[Severity: High]
If lazy_mmu_alloc() fails during CPU hotplug, could this retrieve a NULL
ipte_range pointer?

When a lazy_mmu_alloc() failure triggers a CPU hotplug rollback,
lazy_mmu_cpu_offline() frees the memory but does not disable the globally
active lazy_mmu_enabled static branch. Subsequent lazy MMU entries on that
CPU would bypass the static branch check above, retrieve a NULL ipte_range,
and dereference it below.

> +	local_bh_disable();
> +	get_lowcore()->lazy_mmu_count++;
> +
> +	if (mm_is_protected(mm)) {
> +		local_bh_enable();
> +		return;
> +	}
> +
> +	range->mm =3D mm;
> +	range->base_addr =3D addr;
> +	range->base_end =3D end;

[Severity: High]
Can a hardirq observe a torn state here?

The base_addr and base_end fields are updated sequentially. If a hardirq or
NMI strikes after base_addr is set but while base_end is still 0, a
concurrent execution of this_ipte_range() would observe base_end =3D=3D 0.

This would cause the calculation:
nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;

to underflow to a massive value, bypassing the bounds validation and allowi=
ng
an out-of-bounds memory write to range->cache[idx].

> +	range->base_pte =3D pte;
> +
> +	local_bh_enable();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D13
