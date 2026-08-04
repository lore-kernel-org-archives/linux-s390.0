Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE63EC811;
	Tue,  4 Aug 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868827; cv=none; b=oGbbxCQay6Nx5Vp6K1zuFhUdiUlL2H0F7p9E69ZZ/gLgGX2EneBErvIJaV+5MppNxsOBDDqdTe1PpDELM7k0NkKxj79dG+4LlfMgg3a6OlVXSc8tGBISS00qmTUrh/lnhGHRu0oTRtwetNQNs9286UX2mDpIbZfGnuKhQmNAfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868827; c=relaxed/simple;
	bh=eY65Bcxjph3ZcbvKYPqOyWN5aIDD1EspKXx052ly2Q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pe8ot/qZah16DgyF7jMI0da21UVFxnFbqGfvilpVYWKAP55CauAJcQIpZtpk3T8+cqMzkdmsIVR2yPKwF/q7wdLbZ+MjEh/SvHRYc0yQKUkMpCes5nCm1J97SfpmL3MSpMsTUXatgcdg6nO+6FATSVghzadCA7+v/4skiOPVPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deaG0tML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deaG0tML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A961F000E9;
	Tue,  4 Aug 2026 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868825;
	bh=56FFIoP2vrqnbsIDNf7SEtR8MKLE68KpquZxikJMcnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deaG0tMLAuyCzseptceLR5wnDtxCS0jS/So6suwWQbbHD/+ckssn2MzycxEEoNoab
	 9eV5U1D3bdhanrwhNdMQ+EEXw9Iu4UmuefUQtcrTIf7t+x2lQOHIe9fgAgvAswOavR
	 uNXFuuQlH3wPRjBSbEyv9ImwyYRWMeSHtzhfCOWLwA6hRl0CV9PlkcCdbeJFNvbMVT
	 RjmJ3iVKA1c1IVV8wCrg20MJSBVrj3V84VvywE+EAt7xa///riRBEyViKIWksHLIpn
	 eTOjiBg8nXaRGKbCHBV9rg+8/gfEUdBleKX7m9Y/xk0Ws2cBMGPedMpKD+d/kW8DZN
	 WgszvskJUGbuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] KVM: s390: Take srcu when importing watchpoint
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804162435.28617-7-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-7-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:40:23 +0000
Message-Id: <20260804184024.B9A961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Holding kvm->srcu across a copy_from_user() operation introduces a=
 userfaultfd deadlock vulnerability.
- [Low] Mixing goto-based error handling and scope-based cleanup helpers in=
 the same function.

Pre-existing issues:
- [High] Hardware breakpoint and watchpoint data allocated via KVM_SET_GUES=
T_DEBUG is leaked upon VCPU destruction.
- [High] Integer truncation bypasses length validation, allowing unbounded =
kmalloc requests and kernel log spam.
--

--- Patch [6]: [PATCH v2 6/7] KVM: s390: Take srcu when importing watchpoin=
t data ---
commit f52f981282afa4c844e3d3336d83110ab98f5741
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Take srcu when importing watchpoint data

This commit wraps the call to kvm_s390_import_bp_data() in an SRCU read-side
critical section using scoped_guard(). This is done to ensure that the
memslots array is not freed concurrently during the watchpoint import
process.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 611dcb5342101..0a197e055cad0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -4248,8 +4248,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm=
_vcpu *vcpu,
>  		/* enforce guest PER */
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_P);
> =20
> -		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
> -			rc =3D kvm_s390_import_bp_data(vcpu, dbg);
> +		if (dbg->control & KVM_GUESTDBG_USE_HW_BP) {
> +			scoped_guard(srcu, &vcpu->kvm->srcu)

[Severity: Low]
This isn't a bug, but does mixing scoped_guard() with the existing goto-bas=
ed
error handling in this function violate the cleanup guidelines?

According to include/linux/cleanup.h, mixing goto-based error handling with
scope-based cleanup helpers in the same function can create confusing
ownership semantics. The guidelines suggest converting all resources that
need a goto cleanup to scope-based cleanup, or converting none of them. In
this function, vcpu_put(vcpu) is still handled via a goto out; label.

> +				rc =3D kvm_s390_import_bp_data(vcpu, dbg);

[Severity: High]
Could holding the SRCU read lock across this call introduce a userfaultfd
deadlock?

Inside kvm_s390_import_bp_data(), the very first operation is:

arch/s390/kvm/guestdbg.c:kvm_s390_import_bp_data() {
    ...
    bp_data =3D memdup_array_user(dbg->arch.hw_bp, dbg->arch.nr_hw_bp,
                                sizeof(*bp_data));
    ...
}

If user space maps this array using userfaultfd, the VCPU thread will block
in copy_from_user() while holding the kvm->srcu read lock. If the user space
userfaultfd handler attempts to execute a VM-wide KVM ioctl that modifies
memslots (such as KVM_SET_USER_MEMORY_REGION), that ioctl will call
synchronize_srcu(&kvm->srcu). The VCPU thread would wait for the page fault
to be resolved, and the userfaultfd handler would wait for the SRCU lock to
be released.

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_s390_import_bp_data=
()
leak the dynamically allocated debug information upon VCPU destruction?

kvm_s390_import_bp_data() allocates memory for wp_info, bp_info, and old_da=
ta,
and assigns them to vcpu->arch.guestdbg. While these are freed during a
subsequent KVM_SET_GUEST_DEBUG ioctl via kvm_s390_clear_bp_data(vcpu), it
appears kvm_s390_clear_bp_data() is never invoked during VCPU destruction:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_destroy() {
    ...
    // No call to kvm_s390_clear_bp_data()
    ...
}

Could an unprivileged user who can create VCPUs repeatedly set hardware
breakpoints and then close the VCPU file descriptor to leak this memory?

[Severity: High]
This is a pre-existing issue, but can an integer truncation in
__import_wp_info() bypass length validation and cause unbounded kmalloc
requests?

When kvm_s390_import_bp_data() processes watchpoints, it calls
__import_wp_info(), where the user-provided __u64 length is truncated to an
int for the bounds check:

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
    wp_info->len =3D bp_data->len;
    ...
    if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
        return -EINVAL;
   =20
    wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
    ...
}

If a malicious user provides a length of 4GB + 1, the truncated integer
becomes 1, bypassing the bounds check. The code then calls kmalloc() with
the original __u64 size. Since it lacks __GFP_NOWARN, won't this trigger a
memory allocation warning dump in the kernel log?

> +		}
>  	} else {
>  		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
>  		vcpu->arch.guestdbg.last_bp =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D6
