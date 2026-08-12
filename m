Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F33321A7;
	Wed, 12 Aug 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551021; cv=none; b=Z4n2N/JqdByMEYGYCwG9S+80bOvrGmUEcZeo2VRKB1O29zNkaWHBhYUAazKDC/+wgbrPT1zOluJNgdLSWd/LOZk0w4M3NnOErsz/whFquNRRP4FYJKsgiXEHBKK3pzV9jFSq82C4Dt/mgmfM57QAplFnzSlHxSaDFqcgOG7UEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551021; c=relaxed/simple;
	bh=wmWm1kvZnN86Aauc/ghDBnL8qyd8nHRBDI4td+5xAOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vbk9q4YPv2uoR6t2IhNEwjWPRv//EVLi8PDb5e6e8Z8jHaRtDKT7BbPAldH+ky4lmGc9dyYiFpDLz3mEedS3SglhKbUR9rvngajnY2yikKkfM8xg+y+LaHuh44b3Fdiv7ix77IipPQKxUVxATl3Gb0UKUkW1hQn9NPI+EgyOK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM4qaR/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM4qaR/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F151F000E9;
	Wed, 12 Aug 2026 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551020;
	bh=oqgprFoQpk6X79cFaupCN543/NvL2gaSG07GDodTWJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NM4qaR/Iv0YZT+GbSa7b2Eui/ZJEx0eufeIas0aYftFqkdhgMd24MvPSWXqiagVHL
	 zkRySsRlMZSXQFOpKLpGWicczSMOa35FFb8YET+D8KMg1hxH6A6z3oB23E/oik6eTj
	 oiPEGyiLZ/KcM8YDhhKagB/VS1uF6Az7WgpYnYc2sDi8YbaouZBiEkCGC7zP8UbW+A
	 znwufQ1yokoy/SVvDJbiNED2i3hAJ/B1XzN7jfXiPzqThIpVxukkcJ+Zox5lm20SOL
	 gfogzu3kAbRzOASSOs93VgR8ZU2hP/51zieEAKIs5XU/0kqFHuMssnlrp3eg6sqtcF
	 uAkkA3Vg1xlJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/33] KVM: s390: Prepare gmap for a second KVM
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812153631.3376090-19-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-19-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:10:18 +0000
Message-Id: <20260812161020.05F151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but an unrecover=
able failure in s390_kvm_mmu_commit_memory_region() leaves hardware page ta=
bles out of sync with KVM memslots.
- [High] This problem wasn't introduced by this patch, but non-atomic clear=
 of dirty_bitmap in s390_kvm_mmu_get_dirty_log() causes dirty page tracking=
 loss.
--

--- Patch [18]: [PATCH v6 18/33] KVM: s390: Prepare gmap for a second KVM i=
mplementation ---
commit e0cdf68355be56510fa59547630f7974c617a6a1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Prepare gmap for a second KVM implementation
   =20
Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move mmu code from s390 to gmap so the other
KVM implementation can use it as well.
   =20
No functional change.

> diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
> new file mode 100644
> index 0000000000000..b08b8229bb6ff
> --- /dev/null
> +++ b/arch/s390/kvm/gmap/kvm_mmu.c
> @@ -0,0 +1,133 @@
[ ... ]
> +/*
> + * Get (and clear) the dirty memory log for a memory slot.
> + */
> +int s390_kvm_mmu_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *lo=
g)
> +{
[ ... ]
> +	/* Clear the dirty log */
> +	if (is_dirty) {
> +		n =3D kvm_dirty_bitmap_bytes(memslot);
> +		memset(memslot->dirty_bitmap, 0, n);

[Severity: High]
This isn't a bug introduced by this patch, but in s390_kvm_mmu_get_dirty_lo=
g()
is it safe to use a non-atomic memset() here? If mark_page_dirty() sets bits
concurrently (e.g. via DMA or adapter interrupts) using atomic set_bit_le(),
this non-atomic memset() might overwrite those newly dirtied bits. Could th=
is
lead to lost dirty page tracking and data corruption post-migration?

> +	}
> +	r =3D 0;
> +out:
> +	mutex_unlock(&kvm->slots_lock);
> +	return r;
> +}
[ ... ]
> +void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
> +				       struct kvm_memory_slot *old,
> +				       const struct kvm_memory_slot *new,
> +				       enum kvm_mr_change change)
> +{
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;
> +	int rc =3D 0;
> +
> +	guard(mutex)(&kvm->slots_arch_lock);
> +
> +	if (change =3D=3D KVM_MR_FLAGS_ONLY)
> +		return;
> +
> +	mc =3D kvm_s390_new_mmu_cache();
> +	if (!mc) {
> +		rc =3D -ENOMEM;
> +		goto out;

[Severity: Critical]
This is a pre-existing issue, but in s390_kvm_mmu_commit_memory_region(),
could this early return on allocation failure leave hardware page tables ou=
t of
sync with KVM memslots? If an unprivileged userspace process deletes a
memslot and triggers KVM_MR_DELETE, jumping to the out label skips
dat_delete_slot(). The generic KVM code removes the memslot, but the guest
hardware could retain the physical memory mapping, potentially allowing the
guest to access stale or reallocated host memory.

> +	}
> +
> +	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		kvm_s390_update_cmma_dirty(kvm, old);
> +		switch (change) {
> +		case KVM_MR_DELETE:
> +			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);
> +			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D18
