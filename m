Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20990377AB5;
	Mon, 31 Aug 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212320; cv=none; b=ddQqzgA2v5xrHShq8H8Xs1llS/9KBi8qIbtuOqz/3fFYJ+ejHW7IQoDrBp7PRtxgbtzMK6/bpsbawEFCist6S+BRiqNeA7hW7kPOEiWsWrySRtxEBoXx37GcjSe/bclDmaHzu4PfRiT/UvUC0ZBgvPneLx3Iwk3HpsumGlSvXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212320; c=relaxed/simple;
	bh=stFFlEyKk4HZMcZYL7T2oAtmx8gSEyPrlDJdAKT/vPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVfa73npVvcVsYrJXj/gcWyGf3uLHUC6AvKyzhi3EwV3ZrfuMFyoomMg7V+8RxSHSVheVeToMRKDfyt0VlO16sljdl2QjVDTGRro6sscb5Z48hImk9go4tIwaALF+9zqtXkQskv5fYn7emMeTpsHrcNtTAl7Xd+dtFFNM8J7qY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXyc6aeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXyc6aeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0AB1F000E9;
	Mon, 31 Aug 2026 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212318;
	bh=9YBLqnUkuKfBEmHBJlKTgOEfgoP6n0QnIA0cLQk+ooY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXyc6aeScE83btIqwXe3rCOkrdbm78QBrdlmwuws4SdSkZE1u/2vA8HqlvR3yJsMs
	 dsG6Sub3MGdDPRovVLBjsMIthYE2nvLNIIEDCG1W24qXDlsoBEeRnFYLu8Oxp6nmNy
	 X2w8Fp9Oy2zaEHb7zCpP05+zprhZDznEQo/vFwUhZtKxMKrhEvWIZNJ8hkTZz0izWg
	 wNwX6pX+f8LTAHBV3DLUMGrcG5kqHpsfR9iI5ZXsH9Vy3yrCbaRy7P8/szzpyCUJrg
	 8M6miC5z4m3xjsEMuSDSIXwAnGHSbZJ3aNXofDKjhkUpXOVimEusZwHN7KUXoSwHQL
	 PBdYQ8S3Bdgkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/20] KVM: s390: arm64: Implement exception
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260831145536.913567-17-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:38:37 +0000
Message-Id: <20260831213838.3C0AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Synthesized ESR_ELx for injected exceptions (Aborts and Unknown ex=
ceptions) conditionally sets the IL bit, violating architectural requiremen=
ts.
--

commit 0f2bf8b10fedf69578d14536aed0e0dc39a725b4
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement exception injection

This commit adds core exception entry and fault injection mechanisms for the
s390 KVM arm64 architecture, enabling guest exception handling.

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> index 425dbeaa421c6..7ecf91f86d901 100644
> --- a/arch/s390/kvm/arm64/inject_fault.c
> +++ b/arch/s390/kvm/arm64/inject_fault.c
[ ... ]
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
> +
> +	pend_sync_exception(vcpu);
> +
> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
> +		esr |=3D ESR_ELx_IL;

[Severity: High]
Does this code conditionally omit the IL bit for injected aborts when the=20
trapped instruction is 16-bit?=20

The ARM architecture requires the IL bit in ESR_ELx to be unconditionally s=
et
to 1 for injected Instruction and Data Aborts, regardless of the trapping=20
instruction's length.=20

Could this cause the guest kernel to receive an architecturally incorrect=20
ESR_ELx value (IL=3D0 instead of IL=3D1) and potentially break guest except=
ion=20
handlers if it traps on a 16-bit instruction?

> +
> +	if (is_aarch32 || (cpsr & PSR_MODE_MASK) =3D=3D PSR_MODE_EL0t)
> +		esr |=3D (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
> +	else
> +		esr |=3D (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
[ ... ]
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>  {
> -	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	u64 esr =3D (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
> +
> +	/*
> +	 * Build an unknown exception, depending on the instruction
> +	 * set.
> +	 */
> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
> +		esr |=3D ESR_ELx_IL;

[Severity: High]
Similar to the abort injection above, does this code conditionally omit the=
 IL
bit for an injected Unknown exception?=20

The architecture also requires the IL bit to be unconditionally set to 1 fo=
r=20
Unknown exceptions.

> +
> +	kvm_inject_sync(vcpu, esr);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D16
