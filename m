Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63373914E1;
	Thu, 30 Jul 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430272; cv=none; b=JognaoNPtZ9JYnAB34tnOfmlvWeN0LQ9TuH9Lnv6LRceFN833KU3crVn2F0gAdM8HRWlpiZfIN/ZsG9ISaX64C/06ILZNxVyykVpPhAExFVn8L6sqTesuxVsMyqc2avcuJEQZCpXsAa1DPiSqCiy45NUXk9CDSc43bCQEvgc428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430272; c=relaxed/simple;
	bh=QsAeqHUxBLaOOrOZ6CswcKMoGr0oWkSvE5n7Tf3GwVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FaaJqOThFmDx2uGgX1bBos4XdWun1qH8ExOEG5Jb7A70eX4O9Xq4r1sfRL470bBVaBEsrHR89hlMP4dOjBF6SOExkdwyeBT1mX223pPN9oqzlu43effRobMp7NjVdaeCrbae6GyWEx4lWCoaHZ9EgQex6uvh3DL/1Xml3mq9eWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcqj1X+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcqj1X+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF71F000E9;
	Thu, 30 Jul 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430271;
	bh=JFo1JM2igaZfoKNPd6xNIjkyyqQ3ddikNo8PRjVmuOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcqj1X+2VIhPbnjvtlqSGGX6SkXfBIgL8zmalOHIn8AxJoeXdq11HwhJi0gOyK3H5
	 fJXDr03+e+psmKtCtqtSFU9eWThy+Shop8kaO7mBLwozo/1k7jErjSCyzoLZ576KiS
	 puLEd4v290eaR+gghD/ZKRIfTrXULlkl7sV2RFPAEws3Eb1dPbKmpuRjjHRxjaBdy4
	 U2v6mXmGBeM5vzb6aJMbKjPcPdA8YvYs3RUFGkNLlqDuXDBhEALUVn26686Bs/7D2b
	 dCcaBv2amfrWI7gFw3uXQfOsXagZx2MZmAViueE2pDH3BBmi6CDOEHsxHhs/0kHHyD
	 EAHPVbElSvNLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/14] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730162714.133327-5-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:51:10 +0000
Message-Id: <20260730165111.2CBF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a KVM_BUG_ON() in sca_inject_ext_call() and=
 sca_ext_call_pending() to assert that UCONTROL VMs never reach these funct=
ions. However, userspace can easily reach them because the patch fails to f=
ence VCPU-level ioctls and memory-mapped sie_block access.
--

--- Patch [4]: [PATCH v6 04/14] KVM: s390: ucontrol: Fix sca_clear_ext_call=
() ---
commit b27149eacddb40ae95c3a0b8dc6d91809e9ace8b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Fix sca_clear_ext_call()

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA. This patch fixes the issue by not touching ESCA for UCONTROL VMs
and fencing the VM-level KVM_S390_INTERRUPT ioctl. It also adds checks
to prevent sca_ext_call_pending() and sca_inject_ext_call() from running
on UCONTROL VMs.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..6013f28e3461f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -45,13 +45,16 @@ static struct kvm_s390_gib *gib;
>  static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl sigp_ctrl =3D sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl sigp_ctrl;
> =20
>  	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
>  		return 0;
> =20
> +	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
> +		return -EINVAL;

[Severity: Medium]
Is it possible for userspace to trigger this KVM_BUG_ON and cause a host
kernel warning splat?

For UCONTROL VMs, the sie_block is directly memory-mapped to userspace at
KVM_S390_SIE_PAGE_OFFSET. If userspace manually sets the CPUSTAT_ECALL_PEND
bit in sie_block->cpuflags and executes KVM_RUN, wouldn't it reach this
check during pending interrupt evaluation?

>  	BUG_ON(!kvm_s390_use_sca_entries());

[ ... ]

> @@ -60,13 +63,16 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu=
, int *src_id)
> =20
>  static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
>  {
> -	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>  	union esca_sigp_ctrl old_val, new_val =3D {.scn =3D src_id, .c =3D 1};
> +	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> +	union esca_sigp_ctrl *sigp_ctrl;
>  	int expect, rc;
> =20
>  	BUG_ON(!kvm_s390_use_sca_entries());
> +	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
> +		return -EINVAL;

[Severity: Medium]
Could this KVM_BUG_ON be reached via the VCPU-level ioctls?

While this patch fences the VM-level KVM_S390_INTERRUPT ioctl, it appears
that the VCPU-level KVM_S390_IRQ and KVM_S390_INTERRUPT ioctls in
kvm_arch_vcpu_unlocked_ioctl() remain unfenced for UCONTROL VMs.

If userspace calls one of these VCPU ioctls with KVM_S390_INT_EXTERNAL_CALL,
would it flow through kvm_s390_inject_vcpu() to sca_inject_ext_call() and h=
it
this assertion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D4
