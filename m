Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790934;
	b=lRF7OQY4+LOHUcYwDbD7SBcFGb3P1hLeY4DjI2IYcoSC6FUd9uqZ36ZJELZneCN9PLkk
	 uxMD9F1oo3EACSM/6OgqiR+YfkDwFkb+Fdp1fPnRKpekTaZTYZk2FePF9/rb4siq40Brb
	 erihaexH4a/Q+Y844PqJQjSbyQ+i+hJFv2cha580IVOjujl9iONeLI/zum1OAE3+BkcDY
	 hG+3p5gapWRo/r1sxZ/8Ep/6AzTTw/Psj9313o299L6DcaLNsWVo2GQ2Xf2obeYo4CoZT
	 dNWM/XDkrbPYKYwJvDWwX2CUMevbpyW0wBAfKWGIe+qHU8fV7rHj2ebvFLUaU1o079w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YHJVXYzIVZH37r2Y5aYzfE4tJWffLlWtntnYeH+1Pa0=;
	b=vhOVcb1qfLg52418Mnfdt4Q/l8zd4Rew3cbwKHxNb7KvbyOZJG4178wuMzv1YhnMShjL
	 sK13YsIfP6r6rDCLBNDyDlBE1308YHLjOekTz8rOdn2Pip+/+9P9er8JR+QIZqTbrlbjW
	 Zq85p2QST86PC3JowGe79uPc0RzcD0B/zVKz6w7XbP5dPuvThS+YFFxtvzmhGX9kDJrku
	 HADEnFX8brObk1zGeKiUzBfNFl8jLrNhLqIuW7RSW3/XumBjfRyKDDF0LirEsI95keyfk
	 LjO4cnx4vJCxtnRM8p+FpSRCnm441e0JLTqIaKqn280KYfRn/WAHEZ6bGS01NNvkl9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSqNiCcH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0243606A31E;
	Fri, 27 Nov 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSqNiCcH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F71F00897;
	Fri, 27 Nov 2026 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790934;
	bh=YHJVXYzIVZH37r2Y5aYzfE4tJWffLlWtntnYeH+1Pa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSqNiCcHKEUe/had57FmduLkM0fWhViAl3vi2f+NwF/p4Q0gm3UTkNNFcrMKa7sZJ
	 F0kgmn5U6KFKKC8z2Jtk9h5+qetsBLTA6ihXlTmhoGv/wS21+ofFM0PzORuS7qj79w
	 lO4nxQAmD5ZRkSsp0nScV91kJwStTBnQ207e2oCkAeAo95yvDEt0sulGNNF+pgWUpq
	 +INpduWnFaY6glLBIEHQ791xRc/Fcz2VR4zOHkcFQxCreQGZx0em1WuEhWcQo18c0b
	 /WvxZhkdZzFUpaiUk6nT2UJcu13YOnX2tkr/WXhjX7D4w5VmlquwGlQ6CbZITjIETo
	 X5/XtWDxT5z0g==
Message-ID: <sashiko-outbox-237607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/25] KVM: s390: arm64: Implement exception
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-21-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
 <20261127-sysreg-v4-21-a6318d18aab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:48:53 +0000
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
- [Medium] KVM: s390: arm64: unsigned gltl overflow in inject_abt64()
--

commit 9e41f0d307b22656ebad8b0615877db473136b55
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement exception injection

This commit adds guest exception entry and fault injection support for s390
KVM arm64 guests.

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
field into bit 8 of ESR_EL1 on a level -1 Stage-1 translation table walk
fault?

ESR_ELx_FSC_SEA_TTW(n) expands to (0x14 + (n)), expecting a signed walk
level down to -1 for FEAT_LPA2 5-level page tables. Because
sae_block.hai.gltl is declared as u8 and kvm_vcpu_abt_gltl() returns it as
an int without sign-extending it, a level -1 walk encoded as 0xff becomes
255:

arch/s390/include/arm64/kvm_emulate.h:kvm_vcpu_abt_gltl() {
	return vcpu->arch.sae_block.hai.gltl;
}

0x14 + 255 evaluates to 0x113, setting bit 8 (ESR_ELx_CM for data aborts or
a RES0 bit for instruction aborts) in the guest's ESR_EL1. That extra bit
also survives kvm_inject_size_fault(), which only clears GENMASK_ULL(5, 0)
after calling __kvm_inject_sea().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-sysreg-v4-=
0-a6318d18aab5@linux.ibm.com?part=3D21
