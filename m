Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405A3B05AB;
	Fri, 31 Jul 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507511; cv=none; b=QT7Ck3fwdXFjUV5JELU56kOJ86q2JDY7w5t2RuVBkc43R6ujdYG+s6BkLyFmAxv2H8THoi8psd2HMXvX6crhCEEqCYZSqcKynkqMFz0Kukrj8dyol+ZNcx94q3PCsC9QCv33zXpCs40aIigCNi75CMBYTn8ciC85gtZUWf52SSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507511; c=relaxed/simple;
	bh=HrOJKE9RK+F7SHJlEVQ7H6VDQRlDzAk/eAehx2bFrtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gxna59kR2gZjgI0T2xtLlGm3b1zKz3LXJ8M5I0j+FONp9C1YoLrI6bNCJNtckOfClEaPmiqmxJKpl/2ZGD6yfzw0lItpUCfaO0g2LlOMjYTx6Zedx5B7v4gDvfXGKah8XJSZy/75X1fYJPqkkE8KqNz61Gmv6PMtiJBkb2Z+epA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi7WfOM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi7WfOM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61241F000E9;
	Fri, 31 Jul 2026 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507510;
	bh=+LUtMa5pq1aK11E6m+SYA/spDxt648GW3r5fROgPc5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yi7WfOM+FOV9kK8Te0SsEzaISDYUfAeu61Zf3NdTHpnRlmhq+7rm/hFBiqGhUrljy
	 cf8TsOVAn3A84U6UIOFFVo20WepSV0AQH5WA7KPTrthBjjumyjCb1ydPsVWrEOrnMe
	 Rqi00Z3PNlw91j3hHdsg9Ad8HkTJmpM52bsIWP+jeRJIaoiX0Y8RNhMk9Sk0A182/W
	 ypuguGADCmFSseHbKdUTrf8Xwxin691TmOlqgvkgXtLD1YGcGerhmIWOdSEiMkrFKy
	 71DnpH2rIxHDUMAfsZRupc0kbL92wZGUBTt5EsYO+uwFnDtNUVFREd5+Y9/S3pFjy2
	 Zp/T7mTLrD8ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 28/31] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-29-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-29-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:18:29 +0000
Message-Id: <20260731141829.E61241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Integer underflow in kvm_max_guest_address() when host memory is l=
ess than 1GB bypasses guest physical memory boundaries.
- [High] Incorrect calculation of KVM IPA limit causes VM creation failure =
for non-power-of-two maximum memory sizes.

Pre-existing issues:
- [High] s390_kvm_mmu_commit_memory_region silently ignores ENOMEM, leaving=
 hardware page tables out of sync with KVM memslots.
--

--- Patch [28]: [PATCH v5 28/31] KVM: s390: arm64: Implement vm/vcpu create=
 destroy. ---
commit 1d8cc2e3c6c2245e41621c3d2e7a8e11e5053070
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vm/vcpu create destroy.

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 8e17b7eef8131..3f1bbbf38abec 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -53,6 +58,83 @@ static u64 kvm_max_guest_address(void)
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: High]
If the host maximum address (sclp.hamax) is less than 1GB - 1, could
max_addr + 1 be strictly less than 1GB?

If so, ALIGN_DOWN(..., 1 << 30) would evaluate to 0, which would underflow =
to
U64_MAX when subtracting 1.

This U64_MAX value is then used in kvm_arch_vcpu_create() to set the hardwa=
re
execution block's memory size limit (msl):

    sae_block->msl =3D kvm_max_guest_address();

Could this eliminate hardware-enforced limits on guest physical memory,
allowing unprivileged guest VMs to bypass their memory bounds?

>  }
> =20
[ ... ]
> @@ -64,6 +146,13 @@ long kvm_arch_dev_ioctl(struct file *filp,
[ ... ]
>  u32 get_kvm_ipa_limit(void)
>  {
>  	return fls64(kvm_max_guest_address() + 1) - 1;

[Severity: High]
Does this formula improperly compute the number of bits required to address
the memory when the maximum address is not a perfect power of two?

For example, if max_addr + 1 is 3GB, fls64(3GB) - 1 evaluates to 31 bits,
but addressing 3GB actually requires 32 bits.

Because ARM64_MIN_PARANGE_BITS is 32, if the calculated limit drops to 31,
kvm_vm_type_ipa_size_shift() will return -EINVAL, which could prevent VM
creation on hosts with memory limits like 3GB.

>  }
> =20
[ ... ]
> @@ -103,6 +223,81 @@ static unsigned long system_supported_vcpu_features(=
void)
[ ... ]
> +void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_sl=
ot *old,
> +				   const struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
> +{
> +	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);

[Severity: High]
This isn't a bug introduced by this patch, but by wiring up
s390_kvm_mmu_commit_memory_region() here, are we exposing a pre-existing
error handling flaw?

In s390_kvm_mmu_commit_memory_region(), if kvm_s390_new_mmu_cache() fails:

    if (!mc) {
        rc =3D -ENOMEM;
        goto out;
    }

The function returns without performing the dat_delete_slot() or
dat_create_slot() updates.

Because kvm_arch_commit_memory_region() is called after active memslots are
swapped and cannot return an error, does this leave KVM and the hardware
page tables permanently out of sync?

If a memslot deletion fails to reach the hardware page tables, could the
guest retain access to host memory that has been formally released, leading
to a use-after-free?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D28
