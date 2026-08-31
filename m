Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A7383C86;
	Mon, 31 Aug 2026 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210805; cv=none; b=qMXoSgDhsH7AvSx2tpa7DIwYvqDcqoKJdqC1BFh705Mvp+qhPfKTHWy5QffyD9TZe7AwfFQIqSbGzAOYfuprRFiBV62ZnWp1VdD7DDo8dXEJ3vHvfy3711D7js/n8M1nW1FpQYrMn8Vwr4Q1nr/Ec1UE7lH/xGZp/FWzjWsK5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210805; c=relaxed/simple;
	bh=chWwGG/6+d+w9FtTG8nxbPowLdFT8+eGGUesr5VVQbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VDuXvTSoBAAbLxcgUUHUV0WKPDZHrr736MLuI36YqgT3Gu/QyTtpTDbgKFyhF0QXd25q7YzBKnszAnzb8waIsVKgLtljvb2gDxQj4725u9YjcZLAK6nfVpLgT1wwU1sNvGBWRg2Kuj0/VvkWz1FowUO6fQVfCVtIBVKjxANQGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyS0vyHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyS0vyHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890211F000E9;
	Mon, 31 Aug 2026 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210804;
	bh=+nWqetRWWEYJBiQUHu/kwNnAW1TlGG2QGYnh0zXbLz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XyS0vyHi+ywZJcJNvRkUbkjdsHLsdWZyrYIzM2Tw5T1OJBEJ1dLY26Ln0UTJdOFK3
	 QRnUspCsl4k5tY5uCcspDjBYwUEHraXC2SndYu9WKMBAkh3z/zgL0AFHO6/3FsBKHB
	 7M8sUsT8fdS+ufp0o/xv0oRJMBdx4C7jP+Rdb2ABAE7FtBqQ0pc/H654AAxLKcCj5O
	 wFBhoqELr2eR32P8f/iwverZmEaETG6aa8aok/FQ2pWWKrH5GxSFlgF4meZA4794ga
	 nBEjJt9ULuO/AWcMaz7DnmRIs3HhHLVJWZVBVFGBD+iFYroCM0YrVBr7jKm3bCDC81
	 wVvmpTXkpAEtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/23] KVM: s390: arm64: Implement required functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260831144802.834315-20-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:13:23 +0000
Message-Id: <20260831211323.890211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stubbed exception injection functions cause infinite trap loops, a=
llowing guest userspace to permanently hang a VCPU.
- [High] Incorrect endianness mapping for 32-bit FPSR/FPCR registers access=
ed via KVM_GET_ONE_REG / KVM_SET_ONE_REG.
--

commit 93d3dbc5966621adfcec645f4ad14f3ea7a0f69a
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement required functions

This commit implements the required arm64 KVM shared functions for s390,
adding necessary headers and basic exception injection stubs. It also
provides a temporary SMC/HVC exit handler.

> diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/ar=
m64/kvm_emulate.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/include/arm64/kvm_emulate.h

[ ... ]

> +static __always_inline u64 *vcpu_fpsr(struct kvm_vcpu *vcpu)
> +{
> +	return &vcpu->arch.sae_block.fpsr;
> +}

[Severity: High]
Because s390 is big-endian, does returning a u64 pointer here cause data
corruption during KVM_GET_ONE_REG or KVM_SET_ONE_REG calls?

The shared arm64 code treats fp_regs.fpsr as a 32-bit value and casts the
returned pointer to (u32 *). Pointing to a 64-bit value on a big-endian
system means the cast will access the most-significant 32 bits (which are
zero) instead of the lower 32 bits containing the actual register state.

> +
> +static __always_inline u64 *vcpu_fpcr(struct kvm_vcpu *vcpu)
> +{
> +	return &vcpu->arch.sae_block.fpcr;
> +}

[Severity: High]
Does this have the same 32-bit KVM API endianness corruption issue as
vcpu_fpsr() above?

[ ... ]

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/inject_fault.c

[ ... ]

> +void kvm_inject_undefined(struct kvm_vcpu *vcpu)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +}

[Severity: High]
Does leaving this stub empty cause an infinite trap loop on the host?

When an unprivileged guest userspace process executes an undefined
instruction, KVM triggers an exception intercept. The KVM handler
kvm_handle_unknown_ec() calls kvm_inject_undefined(), which does nothing
here.

Since kvm_handle_unknown_ec() returns 1 and the stub doesn't advance the
guest PC, KVM will immediately re-enter the guest at the exact same faulting
instruction, permanently hanging the guest VCPU.

> +
> +int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	return 1;
> +}

[Severity: High]
Does this stub act identically to kvm_inject_undefined() and cause a hang
when a Synchronous External Abort is triggered (for example, via
KVM_SET_VCPU_EVENTS)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D19
