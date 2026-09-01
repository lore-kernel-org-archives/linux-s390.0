Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AA24501D
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263539; cv=none; b=qOW9yQ5v5cIA/+dstfQwmum4uov+1kf3QbgQmz4kQRu/zt3t6AYZRQWumtiqW5iKkGa2N/lPRd3utxnbCNu8FatTLkoqniAih7duRELaSDL4wuz46VbS6K4RAGU8YC+imKolSC/s2As1Pyzh7h9Iudxz8y8IEk0gFfo9F4xiWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263539; c=relaxed/simple;
	bh=UbTkIDbJA4IZ4ug51keZzex2+CG1MS6afqQ9X44DWwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NaWc07WCZhFycpnQezuteTrmWDxHlGwxOC464r9dpe3I6ZN2w9WzNaY5JOuDo/QY5eyU0yRRCp4U6QrGssCs3EvY6G1Z82U0J15DMg0U+WMmCXCAZYoMfiTfZDLFFv84hY0dOgnblnOs8af7CyUY2McXbkIMVQ89zjhLe29iZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzQXpjn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzQXpjn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B4D1F000E9;
	Tue,  1 Sep 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788263537;
	bh=wmQGR4Hf2WLqGx7rU95jefzTV5TaAtI/X0Q4sAW8aq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzQXpjn4l9g33Yqs7JeWDRbNcpkf7mil4uX0syecSSNTDWDe3q6mQArgybkzWeIAJ
	 ioi3lZqibouNJSDZHmTP7cRJA7HU657PNakLpoV0YarRZLFLsvDds/JkeHGN+jDDdc
	 FY8wztZ69RmUsFVly3t8O95GJdaoqd/o1d2W+7MZNLTe0Zy/JuFUTvu1mXgNGNDE1g
	 Ok6Eza28yddoKslM1kz3oad3G5puol98+lZkwA3wRI5xF09brkYqLS9LTJAoissuj+
	 qWVLrIGb6PTfMBJvzgas/BzUQRT2E8nMPPpseqKUMN2Lx4VBK//7E5HErvNN8DHL25
	 0DjsoF5wr//ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] mm: make userland page table freeing RCU-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-11-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-11-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:52:16 +0000
Message-Id: <20260901115217.73B4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] try_collapse_pte_mapped_thp accesses page tables under mmap_re=
ad_lock without excluding per-VMA locks, allowing concurrent MADV_DONTNEED =
to clear PMDs, leading to a UAF/Panic.
- [High] Page walk callbacks return ACTION_AGAIN infinitely when encounteri=
ng migration entries.
--

commit 2921a41442d23274b78e2a0ab1dcfe01ec2fff5f
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
mm: make userland page table freeing RCU-safe

This commit removes the configuration option for RCU table freeing, as all
architectures now support it, and cleans up dead code. It establishes a
kernel policy that all page tables are freed after an RCU grace period,
ensuring safe unconditional page table walks under RCU.

> With this change in place the kernel policy is now that all page tables a=
re
> freed after an RCU grace period, and thus it is now safe to unconditional=
ly
> perform page table walks under RCU, safe in the knowledge that page tables
> will not be freed underneath the walker.
>=20
> This is all that is guaranteed, however, so naturally it is still incumbe=
nt
> upon page table walkers to ensure that the page table entries are as
> expected.

[Severity: High]
This is a pre-existing issue, but will these page walk callbacks spin
forever if they encounter a migration entry?

For example, in fs/proc/task_mmu.c:clear_refs_pte_range():

	pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
	if (!pte) {
		walk->action =3D ACTION_AGAIN;
		return 0;
	}

Since pte_offset_map_lock() returns NULL non-transiently for migration
entries, walk_pmd_range() handles ACTION_AGAIN by looping back to again:
immediately without a scheduling point. Could an unprivileged user
triggering THP migration concurrently with a /proc/pid/clear_refs read
cause a CPU soft lockup here?

The same pattern appears to exist in smaps_pte_range() in the same file,
and queue_folios_pte_range() in mm/mempolicy.c.

[Severity: Critical]
This is a pre-existing issue, but does try_collapse_pte_mapped_thp() in
mm/khugepaged.c properly exclude per-VMA locks to prevent concurrent
MADV_DONTNEED from clearing PMDs?

When checking the page tables under mmap_read_lock(), the pmd_same() check
is nested inside the if (ptl !=3D pml) block:

mm/khugepaged.c:try_collapse_pte_mapped_thp() {
	...
	/* step 4: remove empty page table */
	if (!pml) {
		pml =3D pmd_lock(mm, pmd);
		if (ptl !=3D pml) {
			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
			if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
				flush_tlb_mm(mm);
				goto unlock;
			}
		}
	}
	...
}

If the system has ptl =3D=3D pml, this bypasses the pmd_same() check entire=
ly.
A concurrent MADV_DONTNEED running under the VMA lock could trigger
PT_RECLAIM and clear the PMD, freeing the PTE page.

Later in the same function:

mm/khugepaged.c:try_collapse_pte_mapped_thp() {
	...
	pgt_pmd =3D pmdp_collapse_flush(vma, haddr, pmd);
	pmdp_get_lockless_sync();
	pte_unmap_unlock(start_pte, ptl);
	if (ptl !=3D pml)
		spin_unlock(pml);

	mmu_notifier_invalidate_range_end(&range);

	mm_dec_nr_ptes(mm);
	page_table_check_pte_clear_range(mm, haddr, pgt_pmd);
	pte_free_defer(mm, pmd_pgtable(pgt_pmd));
	...
}

Does this result in pmdp_collapse_flush() being called on a cleared PMD,
passing a garbage PFN to pte_free_defer() and potentially causing a kernel
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D11
