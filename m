Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712706;
	b=RYmQ6fdMJQ0eauxutnNgXhwU9qx+TV0nWTe9niDXmyPA8KrrmXyY66sEN8IzzL1JH89F
	 LmWNUyrKLTTz+6ZKI60nhoXSkrY7wMObLWW6gmvtr80SVcGPfTNSdQIOJv56SZQ/06bnp
	 9Yle469QzyYv9VpC2b7FWIQDNU/Volf713REsqGrGgPHcFnWevaN/ZK8ZiOj1Y+PtZO+s
	 /AGn+LORIM68Ptb0kuITy8t0c1SrbwtzOD23beHM6grbbdiWTZleFnLldyrApdK0W9wAA
	 AHCUWjTwP/iN0fsmPE79zJYeeA8fPyiDacaKUeneCR6mHenSXi6ANwm7bX7MZK2e7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nQy4/KiLdZZPv+GoMlioUJJnOOIyJoyjE4A+4aiPp4o=;
	b=JtiI/xaRqNfu753oc+9iudQMgF8CSW2j5B78kqvLudW8dqhZ0NAZGPG54GFjXBzUtJpX
	 kp1Nm1yQnvMGEj6EgukZq3Her8vuZ2qmOHum/XRo29mayg+bd4JJdO5lbHLE8yjy5myah
	 jgEL0+zEtXeaUfn8d2BOFQU/mN8H7hsxrKg8E+sbMP4rwg0SIh19Fo4FTC0hcJsJti2az
	 1dcnRuApIryJTA1OmT/5qNetNq1ng5zIYFAKbFNjd6vyH3vb6EYJETIVQr/cDPUDN6EEm
	 WrpWBOaNKIPxH0Ox+alZKRazNkzddhgZSXlo4FVL90+vAgERqcJ7VQDGHaWFgNe6U9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8ckjZYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D5606A33C
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8ckjZYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F221F00A16;
	Tue,  3 Nov 2026 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712705;
	bh=nQy4/KiLdZZPv+GoMlioUJJnOOIyJoyjE4A+4aiPp4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8ckjZYk6fxnduGVkh75x/CjvcqQvKgxrG09iO0cSdqipCB/hlH17g149+BdVz4p3
	 UlccnHSw2qO11AflRKeMQ9avaLVCL/gjf3Ax+ksRNF1aZxqDY3I+aVjSG9zLziXDlM
	 b5K3oSq4AVSLY48ixr6kLMM4JPKPlELJWSjGH3bdWSlbKI5GHdoPuRRaW6e6QP6bLD
	 h8soc4qmEl/ThHDVKvk8xW4D4tZAgugSOOMvlGXtvTpLqAUgx+KqnslukBCTydDwZD
	 0dRnRUj7Uv3yU97be5yoM/yFxhWQ54OXgz7N+exEmTsGHabXFHEW/27lEkSIk6QZft
	 GVza9d85UKI5g==
Message-ID: <sashiko-outbox-195355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] ksm: add find_mergeable_vma_locked() to use
 per-VMA locking
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com, "Alexander Gordeev" <agordeev@linux.ibm.com>, akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, byungchul@sk.com, chengming.zhou@linux.dev, david@kernel.org, dev.jain@arm.com, gerald.schaefer@linux.ibm.com, "Vasily
 Gorbik" <gor@linux.ibm.com>, gourry@gourry.net, harry@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, irogers@google.com, james.clark@linaro.org, jannh@google.com, jolsa@kernel.org, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, ljs@kernel.org, mark.rutland@arm.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, mingo@redhat.com, namhyung@kernel.org, nico.pache@linux.dev, oleg@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com, svens@linux.ibm.com, usama.arif@linux.dev, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, xialonglong2025@163.com, "Longlong
 Xia" <xialonglong@kylinos.cn>
In-Reply-To: <20261102133103.302832-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102133103.302832-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:31:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] mm: ksm: race with exit_mmap() in find_mergeable_vma_locked() =
and __ksm_exit()
- [High] mm: ksm: missing FAULT_FLAG_VMA_LOCK in break_ksm() under per-VMA =
read lock
- [Low] mm: ksm: unmarked vma->anon_vma read in find_mergeable_vma_locked()
- [Low] mm: ksm: missing kernel-doc params for find_mergeable_vma_locked()
--

commit 984120154ab3ef7af44dc3dbb32b8522a336aefe
Author: Xu Xin <xu.xin@linux.dev>

ksm: add find_mergeable_vma_locked() to use per-VMA locking

This commit introduces find_mergeable_vma_locked() to look up and read-lock
VM_MERGEABLE VMAs using per-VMA locks instead of mmap_read_lock() across KSM
page-scanning and merging paths. It also updates __ksm_exit() to write-lock
each VMA under mmap_write_lock() to synchronize with in-flight per-VMA read=
ers
when a process exits.

Link: https://lore.kernel.org/all/20260909023507.1408925-1-xialonglong2025@=
163.com/
Link: https://lore.kernel.org/all/91cf8129-d705-4ebd-b420-129bab7ed261@kern=
el.org/
Link: https://lore.kernel.org/all/20260911162242418ODBbr9wspxxIXDS8uvpeZ@zt=
e.com.cn/

> diff --git a/mm/ksm.c b/mm/ksm.c
> index 84d363dabdc8a..64f9e803b99e2 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -669,6 +669,8 @@ enum ksm_walk_lock {
>  	KSM_WALK_MMAP_RDLOCK,
>  	/* walk under mmap_write_lock() */
>  	KSM_WALK_MMAP_WRLOCK,
> +	/* walk with the vma already read-locked (per-VMA locking) */
> +	KSM_WALK_VMA_RDLOCK,
>  };
> =20
>  static enum page_walk_lock ksm_walk_lock_to_pgwalk(enum ksm_walk_lock lo=
ck)
> @@ -676,6 +678,8 @@ static enum page_walk_lock ksm_walk_lock_to_pgwalk(en=
um ksm_walk_lock lock)
>  	switch (lock) {
>  	case KSM_WALK_MMAP_WRLOCK:
>  		return PGWALK_WRLOCK;
> +	case KSM_WALK_VMA_RDLOCK:
> +		return PGWALK_VMA_RDLOCK_VERIFY;
>  	default:
>  		return PGWALK_RDLOCK;
>  	}
> @@ -784,15 +788,36 @@ static bool vma_ksm_compatible(struct vm_area_struc=
t *vma)
>  	return ksm_compatible(vma->vm_file, vma->flags);
>  }
> =20
> -static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
> -		unsigned long addr)
> +/**
> + * find_mergeable_vma_locked() - Find the VMA covering 'address' which is
> + * VM_MERGEABLE and read-lock it by per-VMA locks. Please use vma_end_re=
ad()
> + * to unlock vma after finishing reading the VMA (non-NULL).
> + *
> + * Return: If a VMA exists which spans @address, return that VMA, read-l=
ocked.
> + * If no VMA is mapped there or, very unlikely, a reference count overfl=
ow
> + * occurred, return NULL, and no read-locked.
> + *
> + * IMPORTANT: If a VMA exists but is not VM_MERGEABLE or has no anon_vma,
> + * this function releases the per-VMA read lock before returning NULL.
> + * Callers must NOT call vma_end_read() on a NULL return value.
> + */
> +static struct vm_area_struct *find_mergeable_vma_locked(struct mm_struct=
 *mm,
> +		unsigned long address)

[Severity: Low]
This isn't a bug, but since this comment above find_mergeable_vma_locked() =
in
mm/ksm.c starts with the /** kernel-doc marker, won't scripts/kernel-doc (w=
hen
building with W=3D1) warn about the missing @mm and @address parameter
descriptions?

>  {
>  	struct vm_area_struct *vma;
> +
>  	if (ksm_test_exit(mm))
>  		return NULL;
> -	vma =3D vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
> +
> +	vma =3D vma_start_read_unlocked(mm, address);
> +	if (!vma)
>  		return NULL;
> +
> +	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma) {

[Severity: Low]
In find_mergeable_vma_locked() in mm/ksm.c, replacing !vma_has_anon_rmap(vm=
a)
with a plain !vma->anon_vma read under the per-VMA read lock drops the
data_race() annotation and vma_assert_stabilised() check from
vma_has_anon_rmap() in mm/vma.h:

mm/vma.h:vma_has_anon_rmap() {
	if (vma_is_attached(vma))
		vma_assert_stabilised(vma);
	/* KCSAN gets confused about the optimistic check. Silence it. */
	return data_race(vma->anon_vma);
}

When another thread concurrently faults in the first anonymous page on the
same VMA and initializes vma->anon_vma in __anon_vma_prepare() under
mm->page_table_lock, won't this trigger a KCSAN data-race warning? Should
find_mergeable_vma_locked() continue to use !vma_has_anon_rmap(vma) here?

> +		vma_end_read(vma);
> +		return NULL;
> +	}
> +
>  	return vma;
>  }
> =20
> @@ -818,11 +843,12 @@ static void break_cow(struct ksm_rmap_item *rmap_it=
em)
>  	 */
>  	rmap_item->linear_page_index =3D 0;
> =20
> -	mmap_read_lock(mm);
> -	vma =3D find_mergeable_vma(mm, addr);
> -	if (vma)
> -		break_ksm(vma, addr, addr + PAGE_SIZE, KSM_WALK_MMAP_RDLOCK);
> -	mmap_read_unlock(mm);
> +	vma =3D find_mergeable_vma_locked(mm, addr);
> +	if (!vma)
> +		return;
> +
> +	break_ksm(vma, addr, addr + PAGE_SIZE, KSM_WALK_VMA_RDLOCK);
> +	vma_end_read(vma);
>  }

[Severity: High]
When break_cow() in mm/ksm.c calls break_ksm() with KSM_WALK_VMA_RDLOCK, on=
ly
the per-VMA read lock is held, without mm->mmap_lock. However, break_ksm()
still calls handle_mm_fault() without FAULT_FLAG_VMA_LOCK:

mm/ksm.c:break_ksm() {
	...
	do {
		int ksm_page;

		cond_resched();
		ksm_page =3D walk_page_range_vma(vma, addr, end, &ops, &addr);
		if (ksm_page <=3D 0)
			return ksm_page;
		ret =3D handle_mm_fault(vma, addr,
				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
				      NULL);
	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
}

Because break_ksm_pmd_entry() drops the PTE lock before returning, the PTE =
at
addr can be modified (for example, zapped by concurrent MADV_DONTNEED or
truncation, or turned into a device-private swap entry) before
handle_pte_fault() inspects it.

Without FAULT_FLAG_VMA_LOCK set in vmf->flags, handle_mm_fault() and its
callees assume mm->mmap_lock is held:

1. In mm/memory.c, vmf_can_call_fault() checks !(vmf->flags &
   FAULT_FLAG_VMA_LOCK) and allows do_read_fault() to invoke
   vma->vm_ops->fault() on a ksm_compatible() MAP_PRIVATE file-backed VMA
   without holding mm->mmap_lock.

2. In include/linux/mm.h, assert_fault_locked() checks
   mmap_assert_locked(vmf->vma->vm_mm) when FAULT_FLAG_VMA_LOCK is not set,
   and release_fault_lock() calls mmap_read_unlock() on the unheld
   mm->mmap_lock (e.g. if handle_userfault() or migration entry waiting is
   reached).

3. If FAULT_FLAG_VMA_LOCK were passed, any path returning VM_FAULT_RETRY
   would release the per-VMA read lock via vma_end_read(vma), which neither
   the loop in break_ksm() nor the unconditional vma_end_read(vma) in
   break_cow() accounts for.

Can break_ksm() safely call handle_mm_fault() under only a per-VMA read loc=
k?

[ ... ]

> @@ -3153,7 +3178,20 @@ void __ksm_exit(struct mm_struct *mm)
>  		mm_flags_clear(MMF_VM_MERGEABLE, mm);
>  		mmdrop(mm);
>  	} else if (mm_slot) {
> +		/*
> +		 * ksmd may be walking this mm's page tables under a per-VMA
> +		 * read lock (see find_mergeable_vma_locked()).  A plain
> +		 * mmap_write_lock() does not exclude such readers, so also
> +		 * write-lock every VMA: this blocks until any in-flight ksmd
> +		 * walk drops its per-VMA read lock, and prevents new ones
> +		 * from starting (vma_start_read_unlocked() backs out when a
> +		 * VMA is write-locked).  The per-VMA write locks are released
> +		 * by mmap_write_unlock() via vma_end_write_all().
> +		 */
>  		mmap_write_lock(mm);
> +		VMA_ITERATOR(vmi, mm, 0);
> +		for_each_vma(vmi, vma)
> +			vma_start_write(vma);
>  		mmap_write_unlock(mm);
>  	}

[Severity: Critical]
Does this synchronization in __ksm_exit() in mm/ksm.c actually prevent ksmd
from acquiring a per-VMA read lock in find_mergeable_vma_locked() and racing
with exit_mmap()?

Unlike normal callers of vma_start_read_unlocked(), ksmd only holds mm_count
(via mmgrab()), not mm_users. Previously, callers took mmap_read_lock(mm)
first and then checked ksm_test_exit(mm) inside find_mergeable_vma() under
mmap_read_lock(mm), which serialized against mmap_write_lock(mm) in
__ksm_exit().

With this patch, find_mergeable_vma_locked() in mm/ksm.c checks
ksm_test_exit(mm) locklessly before calling vma_start_read_unlocked(mm,
address), and never re-checks ksm_test_exit(mm) after acquiring the per-VMA
read lock:

mm/ksm.c:find_mergeable_vma_locked() {
	if (ksm_test_exit(mm))
		return NULL;

	vma =3D vma_start_read_unlocked(mm, address);
	if (!vma)
		return NULL;
	...
}

Contrary to the comment in __ksm_exit(), vma_start_read_unlocked() in
mm/mmap_lock.c does not back out when a VMA is write-locked; when
lock_vma_under_rcu() returns NULL, it enters the slow path and blocks on
mmap_read_lock(mm):

mm/mmap_lock.c:vma_start_read_unlocked() {
	vma =3D lock_vma_under_rcu(mm, address);
	if (vma)
		return vma;

	/* Slow path: preclude VMA writers by temporarily getting mmap read lock. =
*/
	mmap_read_lock(mm);
	vma =3D vma_lookup(mm, address);
	if (vma && !vma_start_read_locked(vma))
		vma =3D NULL;
	mmap_read_unlock(mm);

	return vma;
}

And in __ksm_exit(), mmap_write_unlock(mm) calls vma_end_write_all(mm), whi=
ch
immediately releases all of the per-VMA write locks just acquired.

If mm->mm_users drops to 0 right after find_mergeable_vma_locked() passes
ksm_test_exit(mm) (in get_mergeable_page(), try_to_merge_with_zero_page(),
try_to_merge_with_ksm_page(), or break_cow()):

1. If ksmd calls vma_start_read_unlocked() while __ksm_exit() holds
   mmap_write_lock(mm), lock_vma_under_rcu() fails and ksmd waits on
   mmap_read_lock(mm) in the slow path. As soon as __ksm_exit() calls
   mmap_write_unlock(mm) (which also calls vma_end_write_all(mm)), ksmd
   acquires mmap_read_lock(mm), looks up the VMA, and acquires the per-VMA
   read lock via vma_start_read_locked(vma). Or if ksmd enters
   vma_start_read_unlocked() right after __ksm_exit() calls
   mmap_write_unlock(mm), lock_vma_under_rcu() succeeds directly because the
   per-VMA write locks were already released.

   Because find_mergeable_vma_locked() does not re-check ksm_test_exit(mm),
   ksmd proceeds to walk and modify page tables (and invoke MMU notifiers)
   under only the per-VMA read lock after __ksm_exit() and
   mmu_notifier_release() have finished, racing with exit_mmap() running
   unmap_vmas() and free_pgtables() (which frees page tables before
   tear_down_vmas() detaches the VMAs).

2. Because mm_users is not pinned across vma_start_read_unlocked(),
   exit_mmap() in mm/mmap.c can run concurrently with
   vma_start_read_unlocked():

mm/mmap.c:exit_mmap() {
	...
	mmap_write_lock(mm);
	unmap.mm_wr_locked =3D true;
	mt_clear_in_rcu(&mm->mm_mt);
	unmap_pgtable_init(&unmap, &vmi);
	free_pgtables(&tlb, &unmap);
	tlb_finish_mmu(&tlb);
	nr_accounted =3D tear_down_vmas(mm, &vmi, vma, ULONG_MAX);
destroy:
	__mt_destroy(&mm->mm_mt);
	mmap_write_unlock(mm);
	...
}

   In exit_mmap(), mt_clear_in_rcu(&mm->mm_mt) clears MT_FLAGS_USE_RCU and
   __mt_destroy(&mm->mm_mt) frees maple tree nodes synchronously without RCU
   callbacks, while lock_vma_under_rcu() -> mas_walk() in ksmd may still be
   walking mm->mm_mt under rcu_read_lock(), leading to a use-after-free on
   maple tree nodes (or a maple tree lockdep warning in the slow path's
   vma_lookup() after __mt_destroy() clears MT_FLAGS_LOCK_EXTERN).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102132416.3000=
84-1-xu.xin@linux.dev?part=3D4
