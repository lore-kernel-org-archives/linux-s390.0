Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371496;
	b=X0Wn9wAN/RjNNNpLbb/SI6o3RsHaIiW/kRP//JIURutRzXe1SuiVVoSbYeu/aPS/HNZE
	 /E1Q7LZJ5aB9MIr2hA8zCs1TGUi9EZ5YDKsbLEaqqnDwF7fJ+f64VZALa9KE1CfP+qoPt
	 Zh2gfGSrk1ZSH7H0bCVZuWxmP8Bys/T7hSCGRIbI5uH5Xa+eKhfTXtPsV/GhhhAY2NI/j
	 E+3qbrs2XKSOZ+aO5YDHNZ+7Tjj279/HO5yKFPMW0Pdth+oz0E9vWIAqic6yREbOIIXvj
	 n1xt5PSLD4hIYy85dJglRv2qXFw6nYmoANiGk2aTGlkLfeG/MWTfFdlYdp+/1OIuT1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/AJXxh88ofL2EmTVTuJdaMcLODH3bnV50L91OVxIF4=;
	b=41jkdjGC3VuRt1xI2qHidoGBs3l7gSJxFMtyfYdzP1sH5LO2T2uh/IbkPWtslBWgIV9U
	 HN38G2EKfcTgR69CiZo3baYgmTycftEhcGCXxtGx7A/HVn0g2fTCwKGSz32NS/3QMAxyO
	 2KhyVwgSsPuzIKnAdVmqeOJIa2hzKZmtboxGoFCuNOCLatmDL2GhPJuMyZIEBgyyKWa9H
	 aIwyeXlYolQgzM0+W5CIjwrpUDdR6NK1y4X/WoH6urfRM3vibMj1/ryMNn82QFRnAoFLk
	 Y9pT2HBVQWW36bCAXNb7heVhHdzYCtQASdqx8F1gJ8r8/ryIYtHdYqutAY2eMOfnUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8ejGIg+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716A606A31A;
	Fri, 30 Oct 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8ejGIg+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5563E1F00A15;
	Fri, 30 Oct 2026 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371496;
	bh=H/AJXxh88ofL2EmTVTuJdaMcLODH3bnV50L91OVxIF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n8ejGIg+7xN6FNYSqmWb0hOPwVuDl/KSi8E/gvF6eQHSLkfHmVTnR9jgvpHXgEwIQ
	 Drap8g3sEvYxVD3aFlZeo2VQKFV6wKcxH3Qos9rv2UcwAQfYXEGfiepDt9Cm181B4M
	 enOHAXl5G0QJsgzpz8XBaIsuIx/2iyaZ0zhPoFRNLEuAjdd4J9/CKNReWiszfL25zC
	 kx4b5OMVeZRN2l5ruH+nn96mSyuUg1ldG54Ra78nfCtKqM7xSvfNFY2c6IKPCW22D7
	 20NxJJLrg9SvK082uxVBpkNLv7G/JkOK1IH6Zhg9tvjZ4ED9MFDPqJLSlq5ZjO+ZNo
	 Xox+ZDAqfb0xQ==
Message-ID: <sashiko-outbox-191120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] KVM: x86/mmu: don't zap the secondary MMU on
 permission upgrade
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>, kvm@vger.kernel.org, linux-mm@kvack.org, seanjc@google.com, pbonzini@redhat.com
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 =?utf-8?b?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFICgzMi1CSVQgQU5EIDY0LUJJ?=
 =?utf-8?b?VCk=?= <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029143336.390231-7-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029143336.390231-7-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 14:44:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] KVM: x86/mmu: stale SPTEs in kvm_unmap_gfn_range() on hugetlb =
PMD unshare
- [High] mm: change_protection() revokes _PAGE_RW under MMU_NOTIFIER_RANGE_=
PERM_UPGRADE
- [Medium] KVM: x86/mmu: kvm_unmap_gfn_range() skips APIC page reload on pe=
rm_upgrade
--

commit eb63ff65a947838d12f405a5148038708c2ed0d7
Author: Carlos L=C3=B3pez <clopez@suse.de>

KVM: x86/mmu: don't zap the secondary MMU on permission upgrade

This commit skips zapping secondary MMU SPTEs in kvm_unmap_gfn_range() when=
 an
mmu_notifier invalidation has range->perm_upgrade set, leaving permission
upgrades to be faulted in on demand.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index dc2aef72ffddc..a4258a8c0c899 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1719,6 +1719,13 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct k=
vm_gfn_range *range)
>  	lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
>  			    lockdep_is_held(&kvm->slots_lock));
> =20
> +	/*
> +	 * Do not bother zapping SPTEs if this is only a protection upgrade.
> +	 * Permissions will be faulted-in on demand.
> +	 */
> +	if (range->perm_upgrade)
> +		return false;

[Severity: Critical]
Can skipping the zap in arch/x86/kvm/mmu/mmu.c:kvm_unmap_gfn_range() leave
stale SPTEs pointing to freed 2MB hugetlbfs folios when hugetlb PMD page ta=
ble
sharing is active (CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING)?

When a guest backed by a MAP_SHARED hugetlbfs VMA faults in a 2MB page,
huge_pmd_share() can map a shared PMD table into kvm->mm's PUD while KVM
installs a present 2MB leaf SPTE and drops the GUP reference in
kvm_mmu_finish_page_fault().

If host userspace later upgrades permissions via mprotect() over the VMA or=
 a
PUD-aligned range (where hugetlb_split() does not unshare beforehand),
mprotect_fixup() sets MM_CP_PERM_UPGRADE and
mm/hugetlb.c:hugetlb_change_protection() marks the mmu_notifier range with
MMU_NOTIFIER_RANGE_PERM_UPGRADE:

mm/hugetlb.c:hugetlb_change_protection() {
	if (mm_cp_is_perm_upgrade(cp_flags))
		mn_flags |=3D MMU_NOTIFIER_RANGE_PERM_UPGRADE;
	...
	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
				mn_flags, mm, start, end);
	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
	...
		ptl =3D huge_pte_lock(h, mm, ptep);
		if (huge_pmd_unshare(&tlb, vma, address, ptep)) {
			...
			pages++;
			spin_unlock(ptl);
			address |=3D last_addr_mask;
			continue;
		}
}

With range->perm_upgrade set, kvm_unmap_gfn_range() returns false without
zapping its SPTEs. However, inside the loop,
hugetlb_change_protection() -> huge_pmd_unshare() -> __huge_pmd_unshare()
clears the PUD entry (pud_clear(pud)) in kvm->mm, decrements the shared PMD
count, and skips the rest of the 1GB PUD range without re-populating PTEs or
issuing a non-upgrade mmu_notifier invalidation.

Because the shared PMD table holds only a single rmap count across all shar=
ing
VMAs, once the other sharing VMA unmaps the range via
__unmap_hugepage_range() -> hugetlb_remove_rmap(folio), folio_mapped(folio)
becomes false while kvm->mm is already pud_none() and KVM still holds live
SPTEs.

When that folio is subsequently migrated or truncated,
mm/migrate.c:unmap_and_move_huge_page() (or try_to_migrate() ->
mm/rmap.c:__rmap_walk_file() stopping once rwc->done / folio_not_mapped() is
true, or fs/hugetlbfs/inode.c:remove_inode_single_folio() ->
hugetlb_unmap_file_folio()) sees !folio_mapped(src) and skips mmu_notifier
invalidation on kvm->mm:

mm/migrate.c:unmap_and_move_huge_page() {
	if (folio_mapped(src)) {
		...
		try_to_migrate(src, ttu);
		was_mapped =3D 1;
	}

	if (!folio_mapped(src))
		rc =3D move_to_new_folio(dst, src, mode);
}

This leaves the guest with direct read/write access to the migrated or freed
folio, and if the guest later faults on that GFN after a new folio is mappe=
d,
KVM attempts to replace the still-present leaf SPTE with a different PFN and
hits BUG() in arch/x86/kvm/mmu/tdp_mmu.c:__handle_changed_spte():

	if (was_leaf && is_leaf && pfn_changed) {
		...
		BUG();
	}

[Severity: High]
Is it always guaranteed that primary MMU entries retain _PAGE_RW when
range->perm_upgrade is set?

In mm/mprotect.c:change_protection(), newprot (vma->vm_page_prot) is passed=
 to
pte_modify(), pmd_modify(), pud_modify(), and huge_pte_modify(). Because
_PAGE_RW is not in _COMMON_PAGE_CHG_MASK, those helpers overwrite _PAGE_RW =
from
newprot. Whenever vma->vm_page_prot has _PAGE_RW =3D=3D 0 (such as MAP_PRIV=
ATE VMAs
or MAP_SHARED VMAs where vma_wants_writenotify() was true due to VM_UFFD_WP,
soft-dirty tracking, vm_ops_needs_writenotify, or vma_fs_can_writeback),
_PAGE_RW is stripped from any already-writable entry in the range unless
explicitly restored:

1. In mm/hugetlb.c:hugetlb_change_protection() and
   mm/huge_memory.c:change_huge_pud(), MM_CP_TRY_CHANGE_WRITABLE is not
   implemented:

mm/hugetlb.c:hugetlb_change_protection() {
	...
	old_pte =3D huge_ptep_modify_prot_start(vma, address, ptep);
	pte =3D huge_pte_modify(old_pte, newprot);
	pte =3D arch_make_huge_pte(pte, shift, vma->vm_flags);
}

   Any already-writable hugetlb PTE or huge PUD has _PAGE_RW cleared during
   mprotect() permission upgrades (e.g. PROT_READ | PROT_WRITE to
   PROT_READ | PROT_WRITE | PROT_EXEC), UFFDIO_WRITEPROTECT(enable_wp=3Dfal=
se)
   across a range containing already-writable hugetlb pages, or
   mm/userfaultfd.c:userfaultfd_clear_vma() on UFFDIO_UNREGISTER / close(uf=
fd)
   (which calls change_protection() with MM_CP_UFFD_WP_RESOLVE while VM_UFF=
D_WP
   is still set before userfaultfd_reset_ctx() updates vma->vm_page_prot).

2. For 4KB PTEs in mm/mprotect.c:change_present_ptes() and 2MB THP PMDs in
   mm/huge_memory.c:change_huge_pmd(), restoring _PAGE_RW depends on
   MM_CP_TRY_CHANGE_WRITABLE from vma_wants_manual_pte_write_upgrade(vma),
   which calls mm/vma.c:vma_wants_writenotify(vma, vma->vm_page_prot):

mm/vma.c:vma_wants_writenotify() {
	if (pgprot_val(vm_page_prot) !=3D
	    pgprot_val(vma_pgprot_modify(vm_page_prot, vma->flags)))
		return false;
}

   On a MAP_SHARED VMA where vm_ops_needs_writenotify(vma->vm_ops) is false
   (such as shmem/memfd) and vma->vm_page_prot was set to read-only due to
   VM_UFFD_WP or soft-dirty tracking, or in mm/mprotect.c:mprotect_fixup()
   where vma_flags_reset_once() updates vma->flags before calling
   vma_wants_manual_pte_write_upgrade(vma) and vma_set_page_prot(vma):

mm/mprotect.c:mprotect_fixup() {
	vma_flags_reset_once(vma, &new_vma_flags);
	if (vma_wants_manual_pte_write_upgrade(vma))
		mm_cp_flags |=3D MM_CP_TRY_CHANGE_WRITABLE;
	if (vma_flags_is_perm_upgrade(old_vma_flags, new_vma_flags))
		mm_cp_flags |=3D MM_CP_PERM_UPGRADE;
	vma_set_page_prot(vma);
}

   vma_wants_writenotify() returns false and MM_CP_TRY_CHANGE_WRITABLE is n=
ot
   set, so change_present_ptes() and change_huge_pmd() strip _PAGE_RW from
   already-writable PTEs and PMDs. Even when MM_CP_TRY_CHANGE_WRITABLE is s=
et,
   can_change_shared_pte_writable() and can_change_pmd_writable() only rest=
ore
   _PAGE_RW if the entry is dirty, downgrading writable-but-clean shared
   PTEs/PMDs to read-only.

Because kvm_unmap_gfn_range() skips zapping on range->perm_upgrade, KVM kee=
ps
writable leaf SPTEs (PT_WRITABLE_MASK, shadow_host_writable_mask, and
shadow_mmu_writable_mask) while the host PTE is now read-only, bypassing ho=
st
write-fault tracking. If a subsequent non-write KVM fault (such as an
access-tracking fault or shadow MMU exec fault) resolves the read-only host=
 PTE
with fault->map_writable =3D false, make_spte() clears shadow_host_writable=
_mask
and shadow_mmu_writable_mask on the present leaf SPTE and triggers the
WARN_ON_ONCE in arch/x86/kvm/mmu/tdp_mmu.c:tdp_mmu_map_handle_target_level(=
):

	else if (is_shadow_present_pte(iter->old_spte) &&
		 (!is_last_spte(iter->old_spte, iter->level) ||
		  WARN_ON_ONCE(leaf_spte_change_needs_tlb_flush(iter->old_spte, new_spte)=
)))
		kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn, iter->level);

[Severity: Medium]
What happens to the APIC access page reload in
arch/x86/kvm/mmu/mmu.c:kvm_unmap_gfn_range() when range->perm_upgrade is tr=
ue?

Further down in kvm_unmap_gfn_range(), invalidations on
APIC_ACCESS_PAGE_PRIVATE_MEMSLOT issue KVM_REQ_APIC_PAGE_RELOAD:

	if (kvm_x86_ops.set_apic_access_page_addr &&
	    range->slot->id =3D=3D APIC_ACCESS_PAGE_PRIVATE_MEMSLOT)
		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);

When arch/x86/kvm/vmx/vmx.c:vmx_set_apic_access_page_addr() handles
KVM_REQ_APIC_PAGE_RELOAD, it resolves the PFN with FOLL_WRITE:

	pfn =3D __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted_pa=
ge);
	if (is_error_noslot_pfn(pfn))
		return;

	read_lock(&vcpu->kvm->mmu_lock);
	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
	else
		vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(pfn));

If the VMA backing APIC_ACCESS_PAGE_PRIVATE_MEMSLOT is made read-only (e.g.=
 via
mprotect(..., PROT_READ)) before the page is faulted in or while the backing
page is migrated, swapped out, or unmapped, __kvm_faultin_pfn() fails after
kvm_check_request() has already cleared KVM_REQ_APIC_PAGE_RELOAD, leaving
APIC_ACCESS_ADDR uninitialized or holding a stale HPA.

When write permission on that VMA is later restored via
mprotect(..., PROT_READ | PROT_WRITE), range->perm_upgrade is true and the
early return in kvm_unmap_gfn_range() skips requesting
KVM_REQ_APIC_PAGE_RELOAD. Since APIC_ACCESS_ADDR in the VMCS is not updated=
 on
demand during kvm_mmu_do_page_fault(), wouldn't this leave APIC_ACCESS_ADDR
stale?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029143336.3902=
31-3-clopez@suse.de?part=3D4
