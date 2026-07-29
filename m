Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D495411A1F;
	Wed, 29 Jul 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342922; cv=none; b=UkHy7gk86gI331Nfw3TtQlycKksNpg/WuZ8o6QYABvMreh7RMhNstyYdNsyodhUiErfB15Tkb5/TmOBUaY66qk3Uroy0FdnAD+ACG9IXbgP9DQ0yqomMGXk+z3PmUr5WIS7ubl+WKfGbd7pNzRXBN2u3Mo4z2DyOgTo8VqXAPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342922; c=relaxed/simple;
	bh=3xgqX10ROYlke4Y7g6+kbWJI71ZAvlfYtb6BB8Qsjkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UT39xUbkayNFVmF4PjZmm2a3B3GL1Z/ylv5EsXk4l1k0HRzWA1vSqzjrnU6JLkRUXxotYS8250nO1Zz+nGxAC4OLPeEnQ5OkpIx+8kJQ9/Bp0XGvkluMhIwQKlYUCkJ8fB6niFPZ0ADui8Au48xVIfIK77zMo8nQ3+KawB8lkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0etTpIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0etTpIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4D1F000E9;
	Wed, 29 Jul 2026 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342921;
	bh=FzTRepEBTaYg6S4skEGauvhuai/LzBm9NnU5vONjhZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0etTpInN5YS2wKhph7yVmb+E9tGUgbSY0/ZpMvqTUgySwPmDppw4tClGoqckEqbA
	 ILm0WTg0v8dfpv4fPhPD7LzcR58JMuQfNgzIJcpXQyBtwo6bb1xCfJo+MDVwfaM6bf
	 WMMJ8bociz4zT9vgoNvDjGlcDD/1L6eXUK3JaCL9+XrZA7XqVQ1n8dI1DS07XSf4Ar
	 YwY4F16cQT5y+bpqH/mU4hcs9iHIbIP2vh5LCeOJfk9XWy7uUO68v24P5TrzFQuDZu
	 L26q76JTu6izaqLB9FMGFevLQpRc+SNSc/DWweH94/4JbSf+M/ymOUKL/3ziIZ8rwP
	 in0E2Su613QYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/13] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729152938.782383-4-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:35:20 +0000
Message-Id: <20260729163521.03A4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Creating and destroying a KVM_VM_S390_UCONTROL VM with vCPU ID=
s >=3D KVM_S390_ESCA_CPU_SLOTS (248) causes out-of-bounds memory accesses o=
n `esca_block->cpu`.
- [High] gmap_remove_child() is called without holding the parent gmap's ch=
ildren_lock in the error path of kvm_arch_vcpu_create().
--

--- Patch [3]: [PATCH v5 03/13] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit de5b0e7f34127f8db5eb8b0fa184043139c25a8c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU is destroyed. This patch ensures the ESCA entry
is only cleared if the vCPU was successfully created to avoid
clearing the original vCPU's ESCA entry by mistake.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..2acdff130fa6c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
>  	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;

[Severity: Critical]
This is a pre-existing issue, but can this out-of-bounds access still occur
for UCONTROL VMs?

In kvm_arch_vcpu_precreate(), the sca_can_add_vcpu() bounds check is skipped
for UCONTROL VMs, which allows vcpu_id to be up to KVM_MAX_VCPUS - 1 (254):

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_precreate() {
	...
	if (!kvm_is_ucontrol(kvm) && !sca_can_add_vcpu(kvm, id))
		return -EINVAL;
	...
}

Because the esca_block->cpu array only has KVM_S390_ESCA_CPU_SLOTS (248)
elements, if a UCONTROL vCPU with an ID between 248 and 254 successfully
initializes, it would bypass the new !vcpu->arch.initialized check here.

When this vCPU is destroyed in sca_clear_ext_call() or handles an external =
call
interrupt in sca_inject_ext_call(), computing &sca->cpu[vcpu->vcpu_id] resu=
lts
in a pointer outside the allocated esca_block.

Could this allow writing out of bounds when WRITE_ONCE(sigp_ctrl->value, 0)=
 is
called?

>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 096b426c1281b..3e40a52bfd152 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3459,7 +3459,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;
> =20
>  	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race in the
error handling path of kvm_arch_vcpu_create() for UCONTROL VMs?

If kvm_s390_vcpu_setup() fails, the code jumps to out_ucontrol_uninit:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
	...
out_ucontrol_uninit:
	if (kvm_is_ucontrol(vcpu->kvm)) {
		gmap_remove_child(vcpu->arch.gmap);
		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
	}
	...
}

Because kvm->lock is released prior to calling kvm_arch_vcpu_create(), mult=
iple
concurrent vCPU creations could fail and execute this error path simultaneo=
usly.

Since gmap_remove_child() mutates the parent gmap's children list without
holding the children_lock, could this lead to list corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D3
