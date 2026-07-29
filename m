Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01016469837;
	Wed, 29 Jul 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344105; cv=none; b=FqLJ4Yk7CmS5MB+d/C9PsJYF6XjV1/A687NJzR5lFFbpW4R5sJrL+OmNYz96iKLW4Ug5clu/2MAS3YxI+dQjPM+mAdIUJ/OzQBL3FLYUxOv7hy+mFTJixKKKNhvxruu9jTOApeKk7yOqZHWCgJFPwhhYmFffa3qSVHVFYyKbvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344105; c=relaxed/simple;
	bh=LS1Dd1hTLB61Qh4BQY+4iac3jZECt+CqgZOyClVlWLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqXtLU6uhGF3HuBNFaHiR0WBJNHrG8lBxVyhNaBRwd640FajX4ax4RAl6q+tuK7F/FrpWyc9xdpUePHx7rL3Skq/2jxk4zUMPpt8X5DWzmeFztlb5mP0tudKu9g5VRctvNMEJ/lz51K9kBsT0/5c5wMiZV4fk6eLuM0D3SVVh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGmYZYxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGmYZYxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9641F000E9;
	Wed, 29 Jul 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344103;
	bh=UIPtQz1wnCSOGwRnrOqGSbMBdjkSAfmxp1OAl/skvFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGmYZYxy1PQjagyliqNOr7Tdt9WDFhE0kIY+U6XmypjYoXBD0sKklkfrWok3S/Z0D
	 9c2Zu3SYU3AlJB6Y//hklWt/5ghOoAsEw1dqSue40uX7SVQ0pYfk75MlEWGG84CVhl
	 H0h2PkNBSkcb2gptL1lEwPTcWVss52qQihSUQ/1f1mPjBnOL2m4kjfTwvj7W/xK4gm
	 Ryca9vVjWmz9raQlkGplgthWHyteh2S3AIsXiqtT90IjSvvztkQcyWQ+slZYpiObPI
	 OyL2Iw5v+a5m2pYjvU9+lxxqXVew50dtxlVBvgPBigPJj6uvdhWcYOTSBoJAY08gzY
	 pOeHAGVl2r2bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729152938.782383-5-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:55:03 +0000
Message-Id: <20260729165503.8F9641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added `KVM_BUG_ON` checks for UCONTROL VMs violate KVM s=
ubsystem guidelines against userspace-reachable assertions, creating a Deni=
al of Service vulnerability.

Pre-existing issues:
- [Medium] Incomplete fix leaves an out-of-bounds memory read in `sca_ext_c=
all_pending()` for UCONTROL VMs.
- [Low] Inconsistent fix leaves an out-of-bounds pointer calculation in `sc=
a_inject_ext_call()` for UCONTROL VMs.
--

--- Patch [4]: [PATCH v5 04/13] KVM: s390: ucontrol: Fix sca_clear_ext_call=
() ---
commit 497994f9fead637806bdf9fa1fbe4ded72deee52
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Fix sca_clear_ext_call()

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA. Fix by not touching ESCA for UCONTROL VMs, and opportunistically
add checks in sca_ext_call_pending() and sca_inject_ext_call().

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..d02724bd1829c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -50,6 +50,8 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, =
int *src_id)
>  	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
>  		return 0;
> =20
> +	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
> +		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but does this function still perform an
out-of-bounds memory read before we even reach this new check?

At the top of sca_ext_call_pending(), sigp_ctrl is initialized by value:

static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
{
        struct esca_block *sca =3D vcpu->kvm->arch.sca;
        union esca_sigp_ctrl sigp_ctrl =3D sca->cpu[vcpu->vcpu_id].sigp_ctr=
l;

For a UCONTROL VM, vcpu_id can be up to 254, but the ESCA array only has
248 slots. Does this cause an unconditional out-of-bounds memory read when
entering the function?

[Severity: High]
Could this KVM_BUG_ON check be triggered by host userspace?

According to the KVM subsystem guidelines, userspace-reachable BUG_ON or
WARN_ON calls act as a denial of service. If a host userspace process invok=
es
the KVM_S390_INTERRUPT ioctl to inject a KVM_S390_INT_EXTERNAL_CALL into a
UCONTROL VM, wouldn't this wedge the VM and potentially trigger a panic?

>  	BUG_ON(!kvm_s390_use_sca_entries());
> =20
>  	if (src_id)

[ ... ]

> @@ -66,6 +68,8 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, i=
nt src_id)
>  	int expect, rc;
> =20
>  	BUG_ON(!kvm_s390_use_sca_entries());
> +	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
> +		return -EINVAL;

[Severity: High]
Similar to the check in sca_ext_call_pending() above, is this KVM_BUG_ON
reachable from host userspace and acting as a denial of service?

[Severity: Low]
This isn't a bug introduced by this patch, but is the pointer calculation
for sigp_ctrl at the top of sca_inject_ext_call() also occurring before
this new check?

static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
{
        struct esca_block *sca =3D vcpu->kvm->arch.sca;
        union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_c=
trl;
        ...

While it is just an address calculation, for UCONTROL VMs it calculates an
out-of-bounds pointer. Could this be moved after the check, similar to how
it was fixed in sca_clear_ext_call() below?

> =20
>  	old_val =3D READ_ONCE(*sigp_ctrl);
>  	old_val.c =3D 0;

[ ... ]

> @@ -84,10 +88,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu,=
 int src_id)
>  static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl *sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_uc=
ontrol(vcpu->kvm))
>  		return;
> +
> +	/* Initialize after the above check, to prevent going out of bounds */
> +	sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20
>  	WRITE_ONCE(sigp_ctrl->value, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D4
