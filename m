Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12B432300;
	Wed,  5 Aug 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929482; cv=none; b=icCR/ahTe8ApNwnZve+2FrjfWJ+XJX0j44W2lMe3QZ1jaBR4RHi07SPOWox60uLC86nhGhrVCsOWxvo1Ok7S3nWNLQc7ib9VzIQbDy43+nOwyAyc0Aes7qTlnTFWLJwCzgYpzQi2q7uKCq6JH1lxf4Es30CAPGwnYGpV8DRvTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929482; c=relaxed/simple;
	bh=8dAvxp4D37FWkC53uVrs8NeSNPSEGTQmZ7PaekzZi1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HhDEDHMOkyYxsyfck/YnL9ohYSX0aMFktGlh+4GtX/VFRVzhPaCb4SeYeY4GBaYeRRDFJW+7qRsK74Hz9Fo5xLlMjTW5xX1sfXEXFB9m7pIYx+l08G9KOGYmjBXmDSrrrmHEG40knGSNg9yR9oTb8qQqqhKXvgL44PWRPsHzZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOHSdjPF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOHSdjPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9909C1F00A3A;
	Wed,  5 Aug 2026 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929481;
	bh=2gQIayWx4Yubk/3nGYfbwdk6Qi+G+jI+TMPth/dWjk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOHSdjPFiA5ZvvwtmGYO8nsn1W6rP+QNhQH03sA05aWNbxTBUyFG/4hRLc5nh5gN7
	 Ih5sUX7oJuHXafrxYXwzJ/KgHL0auL1VxELog25FHWWD9K3xes/1XWIO6kJ55jJRiF
	 K3FBzJ5mdxtSO8gZ7SrsrfsL5xeUsZH6/N9YVJJi865aXv6+wi9LXDoCuqupxNsnTm
	 VDcPeBcoq/6aWVy/PcKjIHASvDp98XuG+D+9eUQ4WAFIwS9MFmGpQPCs3ICA78Ks0n
	 OPuEXvZ9wjGMrn2t+gQ1MAUD4TRCN8VAJ+64GqyD+DzbtpZv0tXl9tyH9X9XONMedS
	 Ats7Z2guwrcrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] KVM: s390: Take srcu when importing watchpoint
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805110455.7200-7-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-7-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:31:20 +0000
Message-Id: <20260805113120.9909C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing goto-based error handling and scope-based cleanup helpers=
 in the same function.

Pre-existing issues:
- [High] VCPU guest debug hardware breakpoints are leaked when the VCPU is =
destroyed.
- [High] Integer truncation in watchpoint length check bypasses MAX_WP_SIZE=
, leading to a massive kmalloc and WARN_ON_ONCE.
--

--- Patch [6]: [PATCH v3 6/8] KVM: s390: Take srcu when importing watchpoin=
t data ---
commit e0e29f54e03d9a52cf7d59a9894e63da62df0c7d
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Take srcu when importing watchpoint data

This commit adds a scoped_guard around kvm_s390_import_bp_data to ensure
the srcu lock is held while backing up original guest memory contents of a
watchpoint. This prevents concurrent memslot updates from freeing the
memslots array during the read operation.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 611dcb5342101..0a197e055cad0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4248,8 +4248,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm=
_vcpu *vcpu,
>  		/* enforce guest PER */
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_P);
> =20
> -		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
> -			rc =3D kvm_s390_import_bp_data(vcpu, dbg);
> +		if (dbg->control & KVM_GUESTDBG_USE_HW_BP) {
> +			scoped_guard(srcu, &vcpu->kvm->srcu)

[Severity: Medium]
Does mixing scoped_guard with the existing goto out; error handling
in this function violate the cleanup subsystem guidelines?

The documentation states that for a given routine, we should convert all
resources that need a goto cleanup to scope-based cleanup, or convert
none of them.

> +				rc =3D kvm_s390_import_bp_data(vcpu, dbg);

[Severity: High]
This isn't a bug introduced by this patch, but does the guest debug memory
get leaked when the VCPU is destroyed?

Looking at the memory allocated here in kvm_s390_import_bp_data():

arch/s390/kvm/guestdbg.c:kvm_s390_import_bp_data() {
    ...
    wp_info =3D kmalloc_objs(*wp_info, nr_wp, GFP_KERNEL_ACCOUNT);
    ...
}

It seems the cleanup path kvm_arch_vcpu_destroy() fails to call
kvm_s390_clear_bp_data(vcpu) to release these resources. Could this allow
a host userspace process to slowly drain host memory by repeatedly
creating and terminating VMs with hardware breakpoints?

[Severity: High]
This is a pre-existing issue, but is there an integer truncation here that
bypasses the MAX_WP_SIZE check?

When __import_wp_info() is called:

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
    wp_info->len =3D bp_data->len;
    if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
        return -EINVAL;

    wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
    ...
}

If userspace passes a large length like 0x100000005, wp_info->len
(a 32-bit signed integer) would truncate it to 5, passing the validation
check. However, kmalloc then receives the untruncated 64-bit bp_data->len,
attempting a large allocation that could trigger a warning and cause host
instability.

> +		}
>  	} else {
>  		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
>  		vcpu->arch.guestdbg.last_bp =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D6
