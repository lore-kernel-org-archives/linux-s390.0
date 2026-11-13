Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579958;
	b=NxO8d30bS6+bryLtzJj4LXZNytYzZzsSTqlftZiX9RF8A+dfQOg+3aMj8+uyNcANxq4E
	 FnJZljkNxLQiPeIH6AXBxdb8NasbrFWuCiEL/sqlx3FAvCcO7ZMyjVhulBsyzrU8a3eEl
	 rqbv3OLa+I5SXRyY0vxQztnjta9Fssngw1o2swH4Iz5Btz9YW16qYXtBxx1IZrfv2Xyrl
	 0FE557MuLqNjBJdWFc9wD8b2VSHgYxanewZfirTgRwpzwrGFTSETjgUbK5a5PAaY4gX18
	 64p+0RvC2OB2USWZY/jgXuhTMQ1wXYI0aX0b8X98dsWb8l95Q36sUE26vDjyx5ZG+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uGazlu8ZE2iEilyNSWyDR4PXa0zhg5n8Ju1m9LVZYdk=;
	b=zpFooomPS3xpmZOdtFbkFo8pMpvnA2oDYHQb9epqPhXC42xaMopmclkzXSzwG7gEm4uN
	 fEHaMcF+LZB7jKmIjWcJ2VCalGOUOx2pzgRxtOpwQ48DSIWo4Ue85ub6/fYN2mNP1HuPK
	 EUXkxaHHvwY7aC5z07r1LADfoQ7v20CBtrimWfdO0FfQyTXdbsRYbCEUDm+B6rByv4qkJ
	 9eDHx+OWosYNRGBTTtfpZhpjwrGcWDyHNk0geGlMdQRGjSYYCcbIHh2yncVStgXbyVcsO
	 WXLnsoTaJA0MmEiTt9xlRPeTfJyZig1VvN6U/gzVRqB1GB8vXjnw4PM+j00LFrpxRZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Mtjvb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2E606A323;
	Fri, 13 Nov 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Mtjvb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805011F000C4;
	Fri, 13 Nov 2026 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579958;
	bh=uGazlu8ZE2iEilyNSWyDR4PXa0zhg5n8Ju1m9LVZYdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6Mtjvb0izQ7tMW+TKdqltTALnjGs/s/qsTtCiTcxiW9ImCMu/US8fU27eyNhqJdT
	 efkP8fjCq75tG1xSi7ByXwXxEiGFAnLcBXatGj+H3LjNQ3hZnlp2XqggdjB8vVk4qi
	 MkIvQgQzBvWWsRc6HCqKMErR6nuc3k9ZUhsmto5prZfybTk/F1pIxh6TMOiioaqtAO
	 eYdgERV82+3FlsTSGOfGby2HBZiBzhxTFbMFiTPwoZf+g9CB0YwnSCcF26OZXpuVk3
	 GkFC+7jk4S/KyGcLSNsk+VnujlOs73HWdbTUFTWayH1ODqJ3Wyf6bJts+ivnA3Y4Uc
	 ZGFNU8JJE/ctg==
Message-ID: <sashiko-outbox-212981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] mm/mmu_notifier: add
 MMU_NOTIFIER_RANGE_PERM_UPGRADE
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>, kvm@vger.kernel.org, linux-mm@kvack.org
Cc: linux-s390@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, ljs@kernel.org, imbrenda@linux.ibm.com, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, frankja@linux.ibm.com, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Muchun Song" <muchun.song@linux.dev>, "Oscar
 Salvador" <osalvador@suse.de>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261112142039.907090-8-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-8-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm: change_protection() strips write bit for soft-dirty on
  perm upgrade
--

commit 292879801a9c3725b053aaa1391bad7e3b1f0588
Author: Carlos L=C3=B3pez <clopez@suse.de>

mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE

This commit adds the MMU_NOTIFIER_RANGE_PERM_UPGRADE flag to indicate that a
range invalidation only upgrades access permissions, and sets it in
change_protection() for permission upgrades and userfaultfd write-protect
resolves.

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 70922e19c741d..ce3dd4b23c25b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -582,8 +582,9 @@ static inline long change_pud_range(struct mmu_gather=
 *tlb,
>  			continue;
> =20
>  		if (!range.start) {
> -			mmu_notifier_range_init(&range,
> -						MMU_NOTIFY_PROTECTION_VMA, 0,
> +			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
> +						mm_cp_is_perm_upgrade(cp_flags) ?
> +						MMU_NOTIFIER_RANGE_PERM_UPGRADE : 0,
>  						vma->vm_mm, addr, end);
>  			mmu_notifier_invalidate_range_start(&range);
>  		}

[Severity: Medium]
Can change_protection() still downgrade writable entries to read-only when
MMU_NOTIFIER_RANGE_PERM_UPGRADE is set on a VMA with soft-dirty tracking
enabled?

When vma_soft_dirty_enabled(vma) is true, newprot lacks the write bit, so
pte_modify(), pmd_modify(), and pud_modify() clear it.  When restoring
writability, set_write_prot_commit_flush_ptes() delegates to
maybe_change_pte_writable(), which returns false whenever
pte_needs_soft_dirty_wp() is true even if pte_write(oldpte) was set:

mm/mprotect.c:set_write_prot_commit_flush_ptes() {
	if (pte_write(oldpte)) {
		set_write =3D maybe_change_pte_writable(vma, ptent);
		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
				       /* idx =3D */ 0, set_write, tlb);
		return;
	}
    ...
}

can_change_pmd_writable() and can_change_pud_writable() similarly reject
entries lacking the soft-dirty bit before checking pmd_write(oldpmd) or
pud_write(oldpud).

Writing 4 (CLEAR_REFS_SOFT_DIRTY) to /proc/pid/clear_refs enables soft-dirty
tracking on all VMAs while clear_refs_test_walk() skips VM_PFNMAP VMAs, and
clear_soft_dirty() skips pinned PTEs via pte_is_pinned() (which can be
writable without the soft-dirty bit after a read swap-in of an exclusive
anonymous page).  A subsequent permission upgrade or userfaultfd resolve
then advertises MMU_NOTIFIER_RANGE_PERM_UPGRADE while write-protecting those
present entries, leaving secondary MMUs with stale writable mappings or
breaking CoW pin coherency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D6
