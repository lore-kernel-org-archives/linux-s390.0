Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63A37AA92;
	Tue,  4 Aug 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846546; cv=none; b=mUc0bTPy0I8hGlHl1G2R8yOm8vxJXE8+liAFHD2vC8qwgAu6JxtJgV/4D5uqq2dyoOoaM2h3coAPQcoBQYXHsWS3Xym2N6mwkr56rzJynghSH2Xxj/vDZVpvJ5x4zpoEFmfple7hBRXkv+LpmJANtB4QTc2J4S9bhRLvQseDDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846546; c=relaxed/simple;
	bh=H+2psfMgOiE4Ox7TBta8HargJLZW6xh5KDW8441YVf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVZPVflm5phjaPVsg9pMrbCNMTtoLn/aXSi6exEsLPda4l9s2ZwiuAHdtsXBarDqirY/B2EP+KNPGjTEniYhK37EJRaTomvOI/6/bxkYGsCkqLNJjTdGCcLlhDYPQKOJ/2P2NWaJcXzfEP9j7ezCY+/6fmZf0L1AWLh3B+Fb5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALxEXedh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALxEXedh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8540A1F000E9;
	Tue,  4 Aug 2026 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846544;
	bh=cjQfxFdWnLtW7TUAJvUqSzQ4OVh2KvMu3dSvlDslkKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ALxEXedhdqZWrhTI8xCn9qmShAa8KOepwE3N/0vzG7MkDuvOY/1cTIxtXF8XzJfOE
	 qxLtcm/uN8BgLJhA7dAOHp3PAcWkPTHvsK1adUiI7mpn7Mbi2JceP+XQQNv3mAzfap
	 W4zcFKtSu/wi9SrVFORasoa/c4Rb0HlTOrm+iKqILxgjqmKT2e/o429kr1rJoOTDmj
	 WiYwWuhGdk9emyGrwuqBc7LwAXq0pHbXhpEb4l77QNrccCfTsIr2sY5PgfiGBdesZL
	 Im6iGbkx+mg5pBWwlR+2+NRRCaYPF5OJShjfyjP+Bq2JdLq0MNbw94j0ogDLtgTuae
	 OCIL8QsrSNe4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: s390: memory leak in guest debug handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804120631.736919-4-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:29:03 +0000
Message-Id: <20260804122904.8540A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `kvm_s390_import_bp_data()`, if importing a hardware watchpoint=
 fails on a subsequent iteration, the dynamically allocated `old_data` buff=
ers from watchpoints imported in previous iterations are permanently leaked.
- [High] The KVM_SET_GUEST_DEBUG ioctl calls `read_guest_abs()` (which inte=
rnally accesses KVM memslots) without holding the `kvm->srcu` lock, violati=
ng KVM memslot locking rules and risking a Use-After-Free.
- [High] Leak of hardware watchpoint and breakpoint structures upon vCPU de=
struction because `kvm_s390_clear_bp_data()` is never called in the vCPU te=
ardown path.
--

--- Patch [3]: [PATCH 3/3] KVM: s390: memory leak in guest debug handling -=
--
commit 56d3bf3acb3de4323dcc94259c523dacec14841e
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: memory leak in guest debug handling

bp_data is freed only for the error case by kfree(bp_data).
Every successful KVM_SET_GUEST_DEBUG will leak bp_data.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 69835e1d4f207..4c02dbebb2eb3 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_bp_info =3D bp_info;
>  	vcpu->arch.guestdbg.nr_hw_wp =3D nr_wp;
>  	vcpu->arch.guestdbg.hw_wp_info =3D wp_info;
> +	kfree(bp_data);
>  	return 0;
>  error:
>  	kfree(bp_data);
>  	kfree(wp_info);

[Severity: High]
This is a pre-existing issue, but do we also leak the dynamically allocated
old_data buffers for watchpoints on this error path?

When iterating over the breakpoints, if a later hardware watchpoint fails
validation, the function jumps to this error path. It frees the wp_info
array, but does not appear to loop over the already processed wp_info
elements to free the wp_info->old_data buffers that were allocated in
__import_wp_info().

Could an unprivileged user trigger this error path repeatedly to exhaust
memory?

>  	kfree(bp_info);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does read_guest_abs() get called without
holding the kvm->srcu lock when importing watchpoints?

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
    wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
    ...
    ret =3D read_guest_abs(vcpu, wp_info->phys_addr, wp_info->old_data,
                         wp_info->len);
    ...
}

The KVM_SET_GUEST_DEBUG ioctl takes vcpu->mutex but not kvm->srcu. The call
chain __import_wp_info() -> read_guest_abs() -> kvm_read_guest() ->
gfn_to_memslot() expects kvm->srcu to be held to prevent use-after-free if
a memslot is concurrently removed. Should the SRCU lock be acquired before
reading guest memory here?

[Severity: High]
This is a pre-existing issue, but do we leak the guest debug structures if a
vCPU is destroyed while debugging is still enabled?

arch/s390/kvm/guestdbg.c:kvm_s390_import_bp_data() {
    ...
    vcpu->arch.guestdbg.hw_bp_info =3D bp_info;
    vcpu->arch.guestdbg.nr_hw_wp =3D nr_wp;
    vcpu->arch.guestdbg.hw_wp_info =3D wp_info;
    ...
}

If the userspace VMM process exits or crashes, kvm_arch_vcpu_destroy() is
called. However, kvm_arch_vcpu_destroy() in arch/s390/kvm/kvm-s390.c does n=
ot
appear to call kvm_s390_clear_bp_data() to clean up these dynamically
allocated arrays.

Would it be possible for an attacker to exhaust host memory by repeatedly
spawning and destroying debug-enabled VMs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120631.7369=
19-1-borntraeger@linux.ibm.com?part=3D3
