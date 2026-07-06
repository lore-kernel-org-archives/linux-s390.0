Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216A442128;
	Mon,  6 Jul 2026 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332304; cv=none; b=Durm3UQosLwU6IDVkMoLNIh4IMG3+fdSNsgo057e8yZX+6OkB2G+Pv74mEqvjS5NqgZYanldyS2Ls+IDeXmIWZYtueefWrbQFmkPJ3eCOYpw4NfCQr8TSZnNB82HIR6mDpIdPtfnSum8YeTqBqXGyPp+1rkhidgVBWrleHi8S4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332304; c=relaxed/simple;
	bh=8KX5Nd5s52G4odlMEhDsLhmgQsAfLJcTnm1Uzn3qw+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PsmhQr/5Uwn9BXNHOnURE3UQ5qBSxm8B8gX6jukUfF2GDmCRnL36+qMg25waW+Su2cWgtUvFoY7rcLpvGk1unILCgU2KpMYm9AxftDExsfipcbcoqafd7QowzcsEj7+biR3O4Xn/+z/ekkBn8bLbbwb2O6cYB7d6yiBXAexO1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTyUIDqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTyUIDqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF771F000E9;
	Mon,  6 Jul 2026 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332302;
	bh=EKA7kzQdj29ygwryHYTciNHIU0HFIMqgjghQbTrYtnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTyUIDqOzFv3P79O1O93s9CYju64/lLHrLRaOjqbc4XX1hp99LG/+ZQl0L6DffhcX
	 YfoE4GNKZZXsELo8Xs0W7Tsdowt+Gw6OV+86TJEYVtYnQBXFtqM/R6TQNUgb8F62Uz
	 UwtXIB36DYTYuqfW9kmpjPMxzfpDTjZ9YOfARARXNacd+eAliGS+vEy//AQqb3B+tV
	 BNaM3pEPVENgDkjBhWSZtpWu3+Eydsoy7BKw58sxRwBKjP64hUUsbJy/X/ZWg/5QaP
	 IMIfytzDwL3BlTK+V5/30XQlku+TbzaKTewccUSpTKu7grf3zolyf4+NGkoixfHWTt
	 MB3ChTRCkutbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/27] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260706085229.979525-25-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:04:59 +0000
Message-Id: <20260706100500.BAF771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Mismatch between kvm->arch.mem_limit and gmap bounds allows an inf=
inite page fault loop.
- [High] kvm_max_guest_address() underflows to U64_MAX when the host's maxi=
mum memory address is less than 1GB.
- [Medium] Off-by-one boundary check error due to mismatched mem_limit sema=
ntics.

Pre-existing issues:
- [Critical] Lost dirty pages during live migration due to non-atomic memse=
t() in gmap_get_dirty_log().
- [High] Memory allocation in kvm_arch_commit_memory_region allows host Use=
-After-Free on OOM.
--

commit 07502b29add56a1b469b806719c1e501111b58a8
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vm/vcpu create destroy.

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 19249ec5c539f..3a4092698fae2 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -51,6 +56,82 @@ static u64 kvm_max_guest_address(void)
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: High]
Does this ALIGN_DOWN() calculation underflow to U64_MAX if the host's maxim=
um
memory address is less than 1GB? On hosts with low memory configurations
(e.g. sclp.hamax < 1GB), ALIGN_DOWN(max_addr + 1, 1 << 30) evaluates to 0,
causing the subtraction to underflow.

[Severity: Medium]
Will this inclusive boundary cause an off-by-one rejection of valid memory
slots? By subtracting 1 here, kvm_max_guest_address() returns an inclusive
boundary which is later assigned to mem_limit. If a memslot's exclusive end
address perfectly matches the maximum permitted address,
gmap_prepare_memory_region() could reject it:

if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
        return -EINVAL;

>  }
> =20
> +static int kvm_gmap_init(struct kvm *kvm)
> +{
[ ... ]
> +	kvm->arch.gmap =3D gmap_new(kvm, gpa_to_gfn(kvm->arch.guest_phys_size));
[ ... ]
> +int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> +{
[ ... ]
> +	ret =3D kvm_gmap_init(kvm);
> +	if (ret)
> +		goto out_err;
> +	kvm->arch.mem_limit =3D kvm_max_guest_address();

[Severity: High]
Can this mismatch between gmap bounds and mem_limit lead to an infinite page
fault loop? The gmap is limited to guest_phys_size (the requested IPA limit=
),
but mem_limit is set unconditionally to the maximum host-supported address.

If userspace creates a memslot beyond guest_phys_size but below mem_limit,
KVM resolving the PFN and calling gmap_link() would reject the address via
dat_entry_walk(), returning -EAGAIN, causing kvm_s390_faultin_gfn() to retry
endlessly.

[ ... ]
> @@ -113,6 +230,58 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kv=
m_irq_level *irq_level,
>  	return 0;
>  }
> =20
> +int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
> +			       struct kvm_dirty_log *log)
> +{
> +	return gmap_get_dirty_log(kvm, log);

[Severity: Critical]
This is a pre-existing issue, but does gmap_get_dirty_log() lose dirty pages
during live migration? It uses a non-atomic memset() to clear the dirty
bitmap after copying it:

gmap_get_dirty_log() {
    ...
    memset(memslot->dirty_bitmap, 0, n);
    ...
}

If a guest VCPU concurrently faults and marks a page dirty, the atomic bit =
set
operation in mark_page_dirty() could be blindly overwritten by the memset().

[ ... ]
> +void kvm_arch_commit_memory_region(struct kvm *kvm,
> +				   struct kvm_memory_slot *old,
> +				   const struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
> +{
> +	gmap_commit_memory_region(kvm, old, new, change);

[Severity: High]
This isn't a bug introduced by this patch, but does the memory allocation in
gmap_commit_memory_region() allow a host use-after-free on OOM? When host
userspace removes a memory slot, KVM calls commit_memory_region(), which
cannot return an error. However, gmap_commit_memory_region() dynamically
allocates memory via kvm_s390_new_mmu_cache():

gmap_commit_memory_region() {
    ...
    mc =3D kvm_s390_new_mmu_cache();
    if (!mc) {
        rc =3D -ENOMEM;
        goto out;
    }
    ...
}

If this fails under memory pressure, the function returns early and skips
dat_delete_slot(). The memslot deletion proceeds globally and the host memo=
ry
is freed, but the guest retains hardware page table entries pointing to it.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D24
