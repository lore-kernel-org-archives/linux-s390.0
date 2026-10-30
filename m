Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371494;
	b=OlMUL3amYnTKyVx0iJvk1GVIwrD2666N+enEjwq8Xzqn97rj0Oy+lD7yTsWMcVx2uXuC
	 G/yFJaauaXO1ncJ98mzLSpiIOnWn/nulNIm4QhNLHMKOuObfkcuOc7vztAJnfox3QqVwi
	 5yvoCdCWe838VeGNCGrVAy2EnnZAbwXVUBvfaPupchp8E7NFwaEXxW+artGc4baFdYd+q
	 EPr3Thcev6mylocp7+AONpG+cNCLUNbwHIJWuttg9t/BhR3kLY0Yh5CGUJYZDK5M6WJ+g
	 qRG4hRhMpc7LtxUZwpLjFS5NRvEHY+m9792I/RDWv/oDOCCAzj4nfuGpPGJz25r+i0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hPt7qAKZRrvPL5BVnFsb1T/fR58XHGnKeaH+GP2tuQg=;
	b=PkkYZ+X7wVOWV8XrimwgiuN4m/Vlu8onSIdmnh4NOU2C/UJDLYNT8T8Tf3mN2+hfHsjT
	 IGLBhhLavto0MfzNyJw7UdbBbICP6f/sIyXp7qATC2bzCg5dOjtXxMebH83GpF576tsNO
	 iFTnOpf8wU04sv2k7pkrBJdV6icv+ON7HuEx8JccYm4BtsN3D2IweFlvOX9w7tJYWbF7M
	 EZMxOTVteFAM1bkhQN+oNjf3ewdstE9hP40x18OQszxTRKIpj/K2aYCMiMt/P0en5pYSM
	 FZX3tkzezJF8M2ao8TC8u+9xTo63L8LFxc2WnhQ5/UuTMIh26deKP2kBUAd9uxiowew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPlzr8wi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB5606A323;
	Fri, 30 Oct 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPlzr8wi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F841F0093A;
	Fri, 30 Oct 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371494;
	bh=hPt7qAKZRrvPL5BVnFsb1T/fR58XHGnKeaH+GP2tuQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPlzr8wia4+bjalsKbkMQTe5GEef4pxi+7XORZlnLWiUeuLwyyZKg1pPZzApsY2nl
	 IBNubWjp8tEQl4cY7ZF+jfV81kl6ngF3FFVFZH7r7Uh3UbbLcJHZpCnzfMCyVcR9P2
	 ddW9pWj946kNgm6+1HO0r9lV0DTcl/P5VneOdEcx/RsOGnUFH6borckNl88JdBHTHv
	 5D85EDUI5+gUseYdh7G2g7ViJ5Ymv80wXV0xZ8RlgrE8M2If6Hr+Lbx/Ap2Jt9K6D4
	 bLULvILaXGVHluk5Cujm0RlD1QVvegbjx53dYbv7IcReEC2hCyLq6Qt7+ZOSvUpUld
	 UsSFf16gZCB1g==
Message-ID: <sashiko-outbox-191118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm/mmu_notifier: add
 MMU_NOTIFIER_RANGE_PERM_UPGRADE
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>, kvm@vger.kernel.org, linux-mm@kvack.org, seanjc@google.com, pbonzini@redhat.com
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Muchun Song" <muchun.song@linux.dev>, "Oscar
 Salvador" <osalvador@suse.de>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029143336.390231-5-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029143336.390231-5-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 14:44:52 +0000
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
- [Critical] mm/hugetlb: hugetlb_change_protection() sets PERM_UPGRADE when=
 revoking access
- [High] mm/mmu_notifier: change_protection() sets PERM_UPGRADE when revoki=
ng write
- [High] mm: change_protection() revokes write access under MMU_NOTIFIER_RA=
NGE_PERM_UPGRADE
- [Low] mm/mmu_notifier: unused-but-set mn_flags when CONFIG_MMU_NOTIFIER=
=3Dn
--

commit 22cbc27b0ff3d2d6c7ee718ba2fc52e905cded0f
Author: Carlos L=C3=B3pez <clopez@suse.de>

mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE

This commit adds the MMU_NOTIFIER_RANGE_PERM_UPGRADE range flag to mark MMU
notifier invalidations that only upgrade permissions without revoking
existing access or changing PFNs. It sets this flag in
hugetlb_change_protection() and change_pud_range() when
mm_cp_is_perm_upgrade(cp_flags) is true.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da5d04edf7c10..3a988ca364e6c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6596,19 +6596,23 @@ long hugetlb_change_protection(struct vm_area_str=
uct *vma,
>  	long pages =3D 0, psize =3D huge_page_size(h);
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
> +	unsigned int mn_flags =3D 0;
>  	bool uffd_wp =3D cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve =3D cp_flags & MM_CP_UFFD_WP_RESOLVE;
>  	bool uffd_rwp =3D cp_flags & MM_CP_UFFD_RWP;
>  	bool uffd_rwp_resolve =3D cp_flags & MM_CP_UFFD_RWP_RESOLVE;
>  	struct mmu_gather tlb;
> =20
> +	if (mm_cp_is_perm_upgrade(cp_flags))
> +		mn_flags |=3D MMU_NOTIFIER_RANGE_PERM_UPGRADE;
> +
>  	/*
>  	 * In the case of shared PMDs, the area to flush could be beyond
>  	 * start/end.  Set range.start/range.end to cover the maximum possible
>  	 * range if PMD sharing is possible.
>  	 */
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
> -				0, mm, start, end);
> +				mn_flags, mm, start, end);

[Severity: Critical]
Can setting MMU_NOTIFIER_RANGE_PERM_UPGRADE in hugetlb_change_protection()
leave dangling mappings in a secondary MMU or leave writable secondary MMU
mappings to pages that the host unmapped or downgraded to read-only?

First, when PMD sharing is active on a MAP_SHARED hugetlbfs mapping (for
example, two processes sharing a PUD_SIZE-aligned PROT_READ mapping of a 2MB
hugetlbfs folio where only one process holds the folio rmap count on the
shared PMD table) and the process with a secondary MMU calls mprotect() to
upgrade to PROT_READ | PROT_WRITE, mprotect_fixup() sets MM_CP_PERM_UPGRADE.
hugetlb_change_protection() then advertises MMU_NOTIFIER_RANGE_PERM_UPGRADE,
telling secondary MMUs such as KVM to keep their existing SPTEs, and procee=
ds
to unshare and unmap the PUD entry:

mm/hugetlb.c:hugetlb_change_protection()
  -> huge_pmd_unshare()
    -> __huge_pmd_unshare()
         pud_clear(pud);

Because the PUD in this mm is now cleared and detached from the shared PMD
page table without zapping the secondary MMU, when the other process later
unmaps the file, unmap_hugepage_range() only notifies that other mm and dro=
ps
the shared folio's mapcount to zero. If the folio is subsequently migrated =
or
freed in migrate_hugetlb_folio(), folio_mapped(src) is false and
try_to_migrate() is skipped, freeing or reusing the physical page while the
first process's secondary MMU still retains a live mapping to it.

Second, unlike change_present_ptes() and change_huge_pmd(),
hugetlb_change_protection() ignores MM_CP_TRY_CHANGE_WRITABLE and
unconditionally overwrites the huge PTE protection with newprot
(vma->vm_page_prot):

mm/hugetlb.c:hugetlb_change_protection() {
    ...
    old_pte =3D huge_ptep_modify_prot_start(vma, address, ptep);
    pte =3D huge_pte_modify(old_pte, newprot);
    pte =3D arch_make_huge_pte(pte, shift, vma->vm_flags);
    ...
}

For any MAP_PRIVATE hugetlb VMA, and for any MAP_SHARED hugetlb VMA with
VM_UFFD_WP enabled (where vma_wants_writenotify() is true and
vma_set_page_prot() clears VMA_SHARED_BIT from vma->vm_page_prot), newprot =
is
read-only. When mprotect() upgrades permissions (for example adding
PROT_EXEC with MM_CP_PERM_UPGRADE) or userfaultfd resolves write protection
(MM_CP_UFFD_WP_RESOLVE via uffd_wp_range() or userfaultfd_clear_vma()), any
already-writable huge PTE in the range has its write bit stripped to
read-only while MMU_NOTIFIER_RANGE_PERM_UPGRADE tells secondary MMUs not to
zap their writable mappings.

Similarly, hugetlb_change_protection() unconditionally downgrades writable
migration entries to readable migration entries even when
mm_cp_is_perm_upgrade(cp_flags) is true:

mm/hugetlb.c:hugetlb_change_protection() {
    ...
    if (softleaf_is_migration_write(entry)) {
        if (folio_test_anon(folio))
            entry =3D make_readable_exclusive_migration_entry(
                        swp_offset(entry));
        else
            entry =3D make_readable_migration_entry(
                        swp_offset(entry));
        newpte =3D swp_entry_to_pte(entry);
        pages++;
    }
    ...
}

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 96e32e0159166..8c17875cdcfa6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -597,8 +597,13 @@ static inline long change_pud_range(struct mmu_gathe=
r *tlb,
>  			continue;
> =20
>  		if (!range.start) {
> +			unsigned int mn_flags =3D 0;
> +
> +			if (mm_cp_is_perm_upgrade(cp_flags))
> +				mn_flags |=3D MMU_NOTIFIER_RANGE_PERM_UPGRADE;
> +
>  			mmu_notifier_range_init(&range,
> -						MMU_NOTIFY_PROTECTION_VMA, 0,
> +						MMU_NOTIFY_PROTECTION_VMA, mn_flags,
>  						vma->vm_mm, addr, end);
>  			mmu_notifier_invalidate_range_start(&range);
>  		}

[Severity: High]
Does change_pud_range() also set MMU_NOTIFIER_RANGE_PERM_UPGRADE in cases
where the underlying page table walk actually revokes write access?

1. In change_softleaf_pte() and change_non_present_huge_pmd() (as well as
hugetlb_change_protection()), cp_flags is not checked when handling writable
non-present entries. Both SOFTLEAF_MIGRATION_WRITE and
SOFTLEAF_DEVICE_PRIVATE_WRITE entries are unconditionally downgraded to
readable entries during permission upgrades:

mm/mprotect.c:change_softleaf_pte() {
    ...
    if (softleaf_is_migration_write(entry)) {
        ...
        if (folio_test_anon(folio))
            entry =3D make_readable_exclusive_migration_entry(swp_offset(en=
try));
        else
            entry =3D make_readable_migration_entry(swp_offset(entry));
        ...
    } else if (softleaf_is_device_private_write(entry)) {
        entry =3D make_readable_device_private_entry(swp_offset(entry));
        ...
    }
    ...
}

2. In change_huge_pud() (as in hugetlb_change_protection()),
MM_CP_TRY_CHANGE_WRITABLE is not handled:

mm/huge_memory.c:change_huge_pud() {
    ...
    oldpud =3D pudp_invalidate(vma, addr, pudp);
    entry =3D pud_modify(oldpud, newprot);
    set_pud_at(mm, addr, pudp, entry);
    ...
}

Whenever vma->vm_page_prot is read-only (such as a MAP_SHARED DAX PUD VMA
where vma_wants_writenotify() is true), pud_modify(oldpud, newprot) strips
write permission from already-writable huge PUDs while
MMU_NOTIFIER_RANGE_PERM_UPGRADE is advertised.

3. In change_present_ptes() and change_huge_pmd(), pte_modify() and
pmd_modify() first apply newprot (which is read-only when !VM_SHARED or
vma_wants_writenotify()), and only restore write permission if
MM_CP_TRY_CHANGE_WRITABLE is set and can_change_pte_writable() or
can_change_pmd_writable() returns true. For already-writable PTEs or PMDs
where can_change_shared_pte_writable() returns false (for example, a writab=
le
shared PTE cleaned by clean_record_pte(), or a clean writable
VM_PFNMAP/VM_MIXEDMAP entry) or where vm_normal_page() is NULL in a
!VM_SHARED VMA, write permission is stripped while secondary MMUs are told
no access was revoked.

[Severity: High]
What happens when change_protection() runs with MM_CP_PERM_UPGRADE,
MM_CP_UFFD_WP_RESOLVE, or MM_CP_UFFD_RWP_RESOLVE on a writable MAP_SHARED V=
MA
without vm_ops->page_mkwrite/pfn_mkwrite (such as shmem/tmpfs) after
vma->vm_page_prot has been downgraded to PAGE_COPY for userfaultfd-wp or
soft-dirty tracking?

When userfaultfd-wp is registered or soft-dirty is cleared on a writable
MAP_SHARED shmem VMA, vma_set_page_prot() sees vma_wants_writenotify() retu=
rn
true, clears VMA_SHARED_BIT on its local flags copy, and stores read-only
PAGE_COPY in vma->vm_page_prot while vma->flags retains
VMA_SHARED_BIT | VMA_WRITE_BIT.

Later, when uffd_wp_range(), userfaultfd_clear_vma(), or mprotect_fixup()
checks whether MM_CP_TRY_CHANGE_WRITABLE should be set, it calls
vma_wants_manual_pte_write_upgrade(vma):

mm/vma.h:vma_wants_manual_pte_write_upgrade()
  -> vma_wants_writenotify(vma, vma->vm_page_prot)

In vma_wants_writenotify(), because shmem has no page_mkwrite or pfn_mkwrite
callback, execution reaches:

mm/vma.c:vma_wants_writenotify() {
    ...
    /* The open routine did something to the protections that pgprot_modify
     * won't preserve? */
    if (pgprot_val(vm_page_prot) !=3D
        pgprot_val(vma_pgprot_modify(vm_page_prot, vma->flags)))
        return false;
    ...
}

Because vm_page_prot is already PAGE_COPY whereas
vma_pgprot_modify(vm_page_prot, vma->flags) computes PAGE_SHARED (and in
mprotect_fixup(), vma_wants_manual_pte_write_upgrade(vma) is also called
after vma_flags_reset_once() updates vma->flags but before
vma_set_page_prot(vma) updates vma->vm_page_prot), vma_wants_writenotify()
returns false. As a result, MM_CP_TRY_CHANGE_WRITABLE is not set, and
change_present_ptes() and change_huge_pmd() apply read-only newprot
(PAGE_COPY), stripping _PAGE_RW from all present writable PTEs and PMDs in
the range while change_pud_range() sets MMU_NOTIFIER_RANGE_PERM_UPGRADE.

[Severity: Low]
When CONFIG_MMU_NOTIFIER=3Dn, does mn_flags in change_pud_range() and
hugetlb_change_protection() trigger a -Wunused-but-set-variable warning und=
er
W=3D1?

In include/linux/mmu_notifier.h, when CONFIG_MMU_NOTIFIER is disabled,
mmu_notifier_range_init() is a macro that drops the flags argument:

#define mmu_notifier_range_init(range,event,flags,mm,start,end)  \
	_mmu_notifier_range_init(range, start, end)

So mn_flags is initialized and modified with |=3D, but never read after
preprocessing when CONFIG_MMU_NOTIFIER=3Dn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029143336.3902=
31-3-clopez@suse.de?part=3D2
