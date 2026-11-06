Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995844;
	b=5AYlR56K3zxnEeR0MEyeRub2ja5A0ZPGwzyKJCrZQPXgJwe1yu6KdjtUN6xB6UxiAwed
	 MydOzS/6bEJkDxVcrJswYKVqj3N9gCn1VfKDLrnGMln5iUoBZ48WlOI5OxSB/rIX4UDF0
	 F9l5lrAOulPWj11rOM1bZcJFFnb1EkwmojTa2Ao8gZSqn9f4vxAYM0I2I2pr+Aq6BU28d
	 Et+3hrbGz4JiLsA2Cd1wj18GPTwa257Sw9E8rP6n3ozi4niYj5Fog/doFYV1ro49rmQ7v
	 OT9OCoBB1KINuFOPdAR1h2hJhpetoQ3vpCHym5gZ3Am1ABgbkF7bDk7iEa/RtyLjWdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dK5ikpJ3Ehrl8Rpf2JL5Uz3SzaBhmdsRWWT52oRBwxk=;
	b=ici9+Qw1siLc4B9uTFNVQ2qg1qw8l1AE3nR8Qww7NXBpLDXfy9g7RacYu9Dbcs4ik0ab
	 f72KeSmAG70ExAEXBvXQr/uIGk89NssYBKkQpQrZDoq66pqx6ZrV6eWD/24QcDcFtod+f
	 Ulmt/25pwTdL2UA8uMYhNhxkx0wR9axSpIUci4PGbNhgwrIrhE0FVUBeJjx6cASK1mCOj
	 eLNn+lTyrAjDc405XcCjoX3mgFBPGtycKqkqdnpJIArzMR1joeX9B7lGRNPHZxA6CLPjP
	 O3TlrbKJqsLOn/Hi5KIVtLXRbdTec/tKAozbIzHBL7wL/Ebd6v8TMH01SeJgJBxzdig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpoGGTj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD3606A329;
	Fri,  6 Nov 2026 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpoGGTj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269D61F008A4;
	Fri,  6 Nov 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793995843;
	bh=dK5ikpJ3Ehrl8Rpf2JL5Uz3SzaBhmdsRWWT52oRBwxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gpoGGTj+X210gjCvfLOFwO/Iu6uUvimZwSAm0MJ3ajRw5rwbpWnnf+fjE94qKKDos
	 aoiDbhLWI45RLjp1zh6McPEyEoUVDfT9CaMTA/JXucN8UBxsYlmCG1BW2EBK4kyzwa
	 Zh8/Au7C1J7wBF7nNAsbzDQduQwphJphhfj8r0Ske0TX6cePFfmyB7kbL0QhXe6aWc
	 eEoZE7++PG2iwTSGP6g3vCT2bvtCHNuPyp1jrSs5X+9kRV2S+xsJ8OyoVA//UN18jf
	 YpEfx9eBT28afvxNYzBWQ7PMVsAQ3O7SPTM2Eloodc2FTqsrb2PhmwSZy/SxvmsrBA
	 EKWIuvrfgm5XQ==
Message-ID: <sashiko-outbox-202185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/23] KVM: s390: arm64: Finalize page fault handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-20-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-20-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:10:42 +0000
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
- [Medium] KVM: s390: arm64: preemptible smp_processor_id() in fault
  injection
--

commit 2432a7ede0d5feb054800e41b623b3e845ffe9c3
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Finalize page fault handling

This commit replaces temporary -ENOEXEC returns in the arm64-on-s390 page
fault handler with address size fault and synchronous external abort
injection into the guest, and bounds the guest address limit and
ID_AA64MMFR0_EL1.PARANGE against the supported physical address range.

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> index 31e0d036896f1..7a6f6ba326c13 100644
> --- a/arch/s390/kvm/arm64/mmu.c
> +++ b/arch/s390/kvm/arm64/mmu.c
[ ... ]
> @@ -32,12 +33,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_=
t fault_ipa,
>  	ret =3D kvm_s390_faultin_gfn(vcpu, NULL, &f);
>  	if (ret <=3D 0)
>  		return ret;
> -	if (ret =3D=3D PGM_ADDRESSING)
> +	if (ret =3D=3D PGM_ADDRESSING) {
>  		/*
> -		 * Without the relevant sysregs we cannot do anything for now.
> -		 * Go back to userspace with an error. TODO sysreg handling
> +		 * There is no page with the requested address. Inject size fault
> +		 * which is the closest arm match to PGM-addressing
>  		 */
> -		return -ENOEXEC;
> +		kvm_inject_size_fault(vcpu);
> +		return 1;
> +	}
>  	KVM_BUG_ON(ret, vcpu->kvm);
>  	return -EINVAL;
>  }
[ ... ]
> @@ -98,16 +130,17 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  	}
> =20
>  	if (translation) {
> -		/*
> -		 * For both cases:
> -		 * Without the relevant sysregs we cannot do anything for now.
> -		 * Go back to userspace with an error. TODO sysreg handling
> -		 */
> -		if (fault_ipa >=3D BIT_ULL(get_kvm_ipa_limit()))
> -			return -ENOEXEC;
> +		/* Beyond the PA range programmed for the guest */
> +		if (fault_ipa >=3D kvm_get_pa_address(vcpu->kvm)) {
> +			kvm_inject_size_fault(vcpu);
> +			return 1;
> +		}
> =20
> -		if (fault_ipa >=3D vcpu->kvm->arch.guest_phys_size)
> -			return -ENOEXEC;
> +		/* Falls between the IPA range and the PA range? */
> +		if (fault_ipa >=3D vcpu->kvm->arch.guest_phys_size) {
> +			fault_ipa |=3D FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
> +			return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
> +		}
>  	}

[Severity: Medium]
Can calling kvm_inject_size_fault() and kvm_inject_sea() (as well as
kvm_inject_sea_iabt() and kvm_inject_sea_dabt() below) from
kvm_handle_guest_abort() invoke smp_processor_id() in preemptible context?

kvm_arch_vcpu_ioctl_run() calls handle_exit() -> kvm_handle_guest_abort()
with both interrupts and preemption enabled while the vCPU is loaded
(vcpu->cpu !=3D -1).  The fault injection helpers access FAR_EL1 and ESR_EL1
through vcpu_read_sys_reg() and vcpu_write_sys_reg(), which expand to
_vcpu_read_sys_reg() and _vcpu_write_sys_reg():

arch/s390/include/asm/kvm_host_arm64.h:_vcpu_write_sys_reg() {
	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
		KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu, (C)->kv=
m); \
		(vcpu_is_loaded(C)) \
			? __vcpu_write_sr((C), (V), (R), 0) \
			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })
}

When a guest faults on an address above its IPA or PA range, this triggers
a debug_smp_processor_id() warning under CONFIG_DEBUG_PREEMPT=3Dy, and if
the vCPU thread is preempted and migrated to another CPU between reading
vcpu->cpu and smp_processor_id() (where kvm_sched_out() / kvm_sched_in()
update vcpu->cpu), KVM_BUG_ON() fires and marks the VM bugged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D20
