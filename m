Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFF414A2F;
	Mon,  6 Jul 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331743; cv=none; b=gTFbtou8hJ1L3becRvRsPA/t0e9gUGdUeuGcLc7kW7cEwjW9OqUw4YV0Tr/cl9R0nVPEADyRXi9YHUpy0dzDXaYUobGVmOimnw37MPExAP8v0rBtPRlqCDV7CeX+Z/c1WcgOxMONk4fXLOuN9qrVICW4EbkflxS6dWu8tyhA9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331743; c=relaxed/simple;
	bh=9ki5cF70D3Uh3ZOW6IDmpeK33szzbrypcA1bbqKDVb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZU2WlqBDurwYW0P0EO4s8MZTfXUSS94CwC2gcJIOfNSMOhyz6QWhF98Fy0zNSN2U5OR5SRsCq2W5fH6hT8hP8P35McbKqlxhtsXpTcGh3DIr+wcVAWuh82msbU9e45RZM8WMkiw9DfFtE4aLPpBL4XbzJ3LXHxUKBqQvO0EN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxzW/x6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxzW/x6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45631F000E9;
	Mon,  6 Jul 2026 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331739;
	bh=2Bd4ZNNAr16/hhJQLZA+glw+EwFamZs+63t8jbmQ9WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxzW/x6TMR4pu0UnBbrNXMug//fGY0wBBvH5h15LRc4oxr0nhErrTEwZBSauq674I
	 tXIgP9MuAh1xlJmyKE1ozrPGLAHgkPJ/BzcXLBetd8kVnW/hyO36Et8G7lZOUXgZJh
	 jZabBht1Y0PewRVe46QkjpSpc0fWblg9TuLic58B82pzG7fklOGN6zUwLjaNwvc3B5
	 nLegJ3gg+kfsy3NuTGI+SclqcLIzX7iABhTmD0RRgTqghnuFM8gbivz18CXAURVDsh
	 NBO6hduMa+bVLXokuHucX4IzpvcUGkLaLoXvaGt8xcmsrP2hQK5vSFTmWogXv8HKkp
	 CXh3AGxUoByOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/27] KVM: s390: arm64: Implement required functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260706085229.979525-24-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:55:38 +0000
Message-Id: <20260706095538.B45631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PSCI SYSTEM_OFF handler fails to stop other vCPUs, leading to pote=
ntial guest corruption during shutdown.
- [Medium] Empty stubs for exception injection cause guest vCPUs to hang in=
 an infinite loop.
--

commit b5600b88451aab2daf96c3e367bc2f2db0abeb0c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement required functions

This commit implements the required functions for s390 to support shared
arm64 KVM code. It also introduces a basic SMCCC handler to stop a vCPU.

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> new file mode 100644
> index 0000000000000..a0ebe5ffa19a6
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/handle_exit.c

[ ... ]

> +static int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
> +{
> +	u32 func_id =3D vcpu_get_reg(vcpu, 0);
> +	u64 val =3D PSCI_RET_NOT_SUPPORTED;
> +	int ret =3D 1;
> +
> +	if (func_id =3D=3D PSCI_0_2_FN_SYSTEM_OFF) {
> +		spin_lock(&vcpu->arch.mp_state_lock);
> +		WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
> +		spin_unlock(&vcpu->arch.mp_state_lock);
> +		kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);

[Severity: High]
Does this actually stop all other vCPUs in the system?

Because the mp_state is only updated for the calling vCPU, broadcasting
KVM_REQ_SLEEP will leave the other vCPUs in their current state. When they
process the sleep request, won't they evaluate their own mp_state, see they
aren't STOPPED, and continue executing guest code while the VM is supposed
to be shutting down?

> +		memset(&vcpu->run->system_event, 0,
> +		       sizeof(vcpu->run->system_event));
> +		vcpu->run->system_event.type =3D KVM_SYSTEM_EVENT_SHUTDOWN;
> +		vcpu->run->system_event.ndata =3D 1;
> +		vcpu->run->system_event.data[0] =3D 0;
> +		vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> +		val =3D PSCI_RET_INTERNAL_FAILURE;
> +		ret =3D 0;
> +	}
> +	vcpu_set_reg(vcpu, 0, val);
> +
> +	return ret;
> +}

[ ... ]

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> new file mode 100644
> index 0000000000000..425dbeaa421c6
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/inject_fault.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <arm64/kvm_emulate.h>
> +
> +/**
> + * kvm_inject_undefined - inject an undefined instruction into the guest
> + * @vcpu: The vCPU in which to inject the exception
> + *
> + * It is assumed that this code is called from the VCPU thread and that =
the
> + * VCPU therefore is not currently executing guest code.
> + */
> +void kvm_inject_undefined(struct kvm_vcpu *vcpu)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +}

[Severity: Medium]
Will this empty stub cause the guest to get stuck in an infinite exit loop?

Since the function does nothing, it doesn't advance the guest's Program
Counter or update exception state. When handle_exit() resumes the guest,
won't it immediately re-execute the same trapping instruction over and over,
hanging the vCPU and burning host CPU cycles?

> +
> +int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D23
