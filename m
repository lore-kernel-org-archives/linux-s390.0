Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994657;
	b=GjX2RQPKkUjrwsK/CzwUIbGGKPvF2qx3sPECTLxnIuJHfkVD8JsQTMfnzyTOf2GUQzlE
	 PKls+8fLmLRRxjgC/PSliBbNzPc79QJPufcJvzVzK0yc/DhafX4WhufRQw2KaMwmd5NuN
	 V+evPakxnEbFVILgDRqIfflrfod05Ye6D+vca/ABAThxtD+E1eG38eREObA4f5EAVPFns
	 CrzCl8RYc57AedE1tz52BjG5OVRZpDYiEAt8voGgaOpfmN67Y4SGBSmxHsAyezzHuv3tB
	 1XSCK9cyX+mgJqQg/8NmkR010vLtcZEx+7HrURcU8UNTXO22oNYPUMJz4TiAaPA7Qdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J+pizboib7QvoI9axwYZyyy7vwdfW+PSuP4oklTDdq8=;
	b=MqaCqDTt+/gqCSJ7TolPndgQmAJnB/nvocjIlHrnKWbzBNNyVsCA4kWdutouvThXZyMz
	 XHYa2VYJVdod7QtWcz/62H7HAi4vmB5mBRj+DOUKf9N1SGvQKBUTCpe476pTAupqCojby
	 EWbr0/rEjSDWceGNzaF1yGcZvRj+9DtCEamTxjA1711zAHKQEWtlx/1BGvrkdcQi7b5/Z
	 LzY1qSRek3YTUAsIV6EOM+kC3+qkcGCxwVTwcRjSUZMdaRyY8JhwQZPKWofO5R+9n53XU
	 RavmvDoAZlxJQ7e3xD8i8eqzlIT5tb2Lex62d7Fwu0gtaoW0ha7jIH841ZOgHa6uZlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JI7Fjp79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4F606A329;
	Fri,  6 Nov 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JI7Fjp79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976BB1F008A2;
	Fri,  6 Nov 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994657;
	bh=J+pizboib7QvoI9axwYZyyy7vwdfW+PSuP4oklTDdq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JI7Fjp79diyOgJGyEAlLvuBvkivUlChN4pI2c5NNLdEo/rS1rwWpe9CAWw9XfHviG
	 NXVlbshfWouovcnaNA0pYkpRCS2RSimV89VqY7SsQpNWGeXSEd6AIe2VpF5fC90MHd
	 W5B05QbSu3stzD3Mcg6PpiXFw0arGQs25PNnTS7LrYYSwzpEkihGVWgDZBK6CoZ2iM
	 0oEfcT3QCxt6qj+7rI+1TY6D3ns2uEznFvSddjTJOlAVnI68nR6YQSqdHt3tw2HoV0
	 xK2DJS+eFJf3cWXXev9N4nfDlZVy8bF8pxlWtG/FgFKQDO9UpmemSS/9Fd+8uOlhGf
	 kOHP4tGdwjhBw==
Message-ID: <sashiko-outbox-202177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/23] KVM: s390: arm64: Implement exception
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-19-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-19-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:50:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: s390: arm64: preemptible smp_processor_id() and migration
  race in sysreg access
- [Medium] KVM: s390: arm64: unsigned gltl overflow in inject_abt64()
--

commit 9004b39a5f6b970883241ce75cb94bfa9bdd2fe1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement exception injection

This commit adds guest exception entry and fault injection support for
arm64 guests running under KVM on s390.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 4de0f17052cb8..91e9f4a75ce73 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -511,8 +503,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> =20
>  	kvm_sigset_deactivate(vcpu);
>  out:
> -	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
> -		adjust_pc(vcpu);
> +	if (unlikely(vcpu_get_flag(vcpu, PENDING_EXCEPTION) ||
> +		     vcpu_get_flag(vcpu, INCREMENT_PC)))
> +		kvm_adjust_pc(vcpu);

[Severity: High]
Does accessing save-area registers with preemption enabled here and during
handle_exit() trigger a debug_smp_processor_id() splat and race with host
CPU migration?

At the out label (before vcpu_put()) and inside handle_exit(), the vCPU is
loaded (vcpu_is_loaded(vcpu) is true) while IRQs and preemption are
enabled.  When an exception is injected (for example via
kvm_inject_undefined() -> kvm_inject_sync() or inject_abt64()) or
delivered here via kvm_adjust_pc() -> kvm_inject_exception() ->
enter_exception64(), vcpu_read_sys_reg() and vcpu_write_sys_reg() access
VBAR_EL1, SCTLR_EL1, FAR_EL1, and ESR_EL1 through _vcpu_read_sys_reg() and
_vcpu_write_sys_reg():

arch/s390/include/asm/kvm_host_arm64.h:_vcpu_read_sys_reg()
	KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu, (C)->kvm=
);

Calling smp_processor_id() in preemptible context triggers a BUG splat
when CONFIG_DEBUG_PREEMPT is enabled, and if the vCPU task is preempted
and migrated between reading smp_processor_id() and reading vcpu->cpu,
KVM_BUG_ON() fires and terminates the VM:

CPU0                              CPU1
handle_exit() / kvm_adjust_pc()
  vcpu_read_sys_reg(vcpu, VBAR_EL1)
    smp_processor_id() -> 0
  <preempted and migrated>
                                  kvm_sched_in()
                                    kvm_arch_vcpu_load(vcpu, 1)
                                      vcpu->cpu =3D 1
                                  vcpu->cpu -> 1 !=3D 0
                                  KVM_BUG_ON()  <-- kills VM

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> index 425dbeaa421c6..33f40c5188c98 100644
> --- a/arch/s390/kvm/arm64/inject_fault.c
> +++ b/arch/s390/kvm/arm64/inject_fault.c
> @@ -2,6 +2,38 @@
> =20
>  #include <arm64/kvm_emulate.h>
> =20
> +static void pend_sync_exception(struct kvm_vcpu *vcpu)
> +{
> +	kvm_pend_exception(vcpu, EXCEPT_AA64_EL1_SYNC);
> +}
> +
> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned l=
ong addr)
> +{
> +	unsigned long cpsr =3D *vcpu_cpsr(vcpu);
> +	bool is_aarch32 =3D vcpu_mode_is_32bit(vcpu);
> +	u64 esr =3D 0;
> +
> +	if (kvm_vcpu_abt_iss1tw(vcpu))
> +		esr |=3D ESR_ELx_FSC_SEA_TTW(kvm_vcpu_abt_gltl(vcpu));
> +	else
> +		esr |=3D ESR_ELx_FSC_EXTABT;

[Severity: Medium]
Can ESR_ELx_FSC_SEA_TTW(kvm_vcpu_abt_gltl(vcpu)) overflow the 6-bit FSC
field into bit 8 of ESR_EL1 on a level -1 translation table walk?

vcpu->arch.sae_block.hai.gltl is declared as u8, so kvm_vcpu_abt_gltl()
zero-extends a two's-complement -1 (0xff) to 255 instead of -1.
ESR_ELx_FSC_SEA_TTW(255) then evaluates to 0x113 (0x14 + 255), which sets
bit 8 (ESR_ELx_CM for data aborts or a RES0 bit for instruction aborts) in
esr, and kvm_inject_size_fault() only masks off GENMASK_ULL(5, 0)
afterwards.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D19
