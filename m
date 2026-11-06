Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990729;
	b=Ixn1OPuxpxl+CgwjbJUb4l6rfVDxO1ZPWc6LqXUV1LszUII7cT0qYEnUcbroPIND2TSa
	 Amuv81nnsAd77DOPPaO2B5VuQFLz71ohv7ZeAah3H8KBmonRoRwYvaGfvG83gFr78Dn9x
	 Ct2wnbt6NGDfEWAwEsrEKvcwuGRZGRx+27EMQBhNb628xQGv2MP3bFFpvVVk2nfyBUOUc
	 XNxXypnsyJc03EvX4yxtO9G6ZPh86sqolAYStRO2uHN3rq5pVvIwdbwEgQ0P0MY3TUNBX
	 kPcDJkfls42ZS0fe3Yw8Ukn6G9ZmX1qC3HdYIREhhAGK7ICgGieYRPeVl6cjZf3OUUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNLxcl/7ryzRAwl+jM/Z8IFsimfNedXfhYCn8zPHQEE=;
	b=YfGGVhyV8AdzZPtOFeVsqUm/WAn+037ZafhW+OiC3B7jRJoJ3tWo82PSXluoCaazwNXF
	 05Mn+YOxyKNZMZfHs3b9jqNHUl5dDHC2MNpkfeokJvMRiqJFpr6+WViDxjhJMSq/eBG+h
	 LRZXZ2eeaod845S9fVKFh2oZlME6r2ihWHI08kU1cxLKMZxZhblR5kU3zZbt/IO92Vsdo
	 Vw4Z0phhCuqIzCAPoWfwmBwj0z9BNSKy3Ymwz4Zx8SJoMbEMgGNlqm7WUACiWg5irMFn8
	 Ya2XRARgu1lWp9A0x+ZSl30eLO/m/fr94TXrDrjWLUrQzzJGAw50YQVfeYGfXIfXBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRYPyyjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AF606A326;
	Fri,  6 Nov 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRYPyyjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C9F1F0089F;
	Fri,  6 Nov 2026 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990729;
	bh=FNLxcl/7ryzRAwl+jM/Z8IFsimfNedXfhYCn8zPHQEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRYPyyjXlAWM5shDLcYNZZdHBKNyELV6SZ+p3K/aARncKjm2gaWxNAlu4pc/lvGws
	 cuzq0RagKboo+XGrHZtTsDAWdEqLPzLnwgnn32Cai5JGfuWCsAcJQgeOeL39J1N8Z8
	 tD0xeBjezjk7YWW9QVzF/kK6Q/Lf8CQft/BqfzA/SowxFEnr3RXiT3dKw+H5AIUNJQ
	 Wwpg74ORaFyYivtvmsmAJxaMGzFqh2qU/2VDHyvMMvC7xswKHa7ZzHEF8YJ+0N84HU
	 a7jZo+aojtd+QLTo/bUPZAtTs/smWRUWrbaZRzxPdqyGAG+/38V/zQKAHjv43XnHOn
	 NrHfp3vBJFHaQ==
Message-ID: <sashiko-outbox-202093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/23] KVM: s390: arm64: Implement arm sysreg
 managing infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-16-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-16-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:45:28 +0000
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
- [High] KVM: s390: arm64: preemptible smp_processor_id() in
  _vcpu_read/write_sys_reg()
--

commit a0eb8c366cfc592c3052299b9ed41b9fe9cc173f
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement arm sysreg managing infrastructure

This commit implements the infrastructure for the s390 host to read, write,
and trap guest arm64 system registers using EASR/SASR instructions and
shared arm64 sysreg tables.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> index 9afe37f6696c8..35b6d8972359c 100644
> --- a/arch/s390/include/asm/kvm_host_arm64.h
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
[ ... ]
> @@ -219,4 +245,181 @@ static inline void kvm_arch_async_page_present_queu=
ed(struct kvm_vcpu *vcpu)
> =20
>  #define kvm_supports_32bit_el0() false
> =20
> +#define __vcpu_sys_reg(__vcpu, __reg) \
> +	vcpu_read_sys_reg(__vcpu, __reg)
> +
> +#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) \
> +	vcpu_write_sys_reg(__vcpu, __val, __reg)
> +
> +#define __vcpu_rmw_sys_reg(v, r, op, val)				\
> +	do {								\
> +		u64 __v =3D vcpu_read_sys_reg(v, r);			\
> +		__v op (val);						\
> +		vcpu_write_sys_reg(v, __v, r);				\
> +	} while (0)
> +
> +/**
> + * _vcpu_read_sys_reg() - read a guest sysreg with easr
> + * @C: vcpu to read from; if loaded, may only be called from its own thr=
ead
> + * @R: sysreg id; must be readable by easr; must be compile time constant
> + *
> + *   if SYSREGS_ON_CPU: proceed with flags =3D 0
> + *   otherwise:         proceed with flags =3D EASR_FLAG_SA
> + *
> + */
> +#define _vcpu_read_sys_reg(C, R) \
> +	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
> +		KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu, (C)-=
>kvm); \
> +		(vcpu_is_loaded(C)) \
> +			? __vcpu_read_sr((C), (R), 0) \
> +			: __vcpu_read_sr((C), (R), EASR_FLAG_SA); })
> +
> +/**
> + * _vcpu_write_sys_reg() - write a guest sysreg with sasr
> + *
> + * @C: vcpu to write to; if loaded, may only be called from its own thre=
ad
> + * @V: value to write
> + * @R: sysreg id; must be writable by sasr; must be compile time constant
> +
> + *   if SYSREGS_ON_CPU: proceed with flags =3D 0
> + *   otherwise:         proceed with flags =3D SASR_FLAG_INITIALIZED
> + */
> +#define _vcpu_write_sys_reg(C, V, R) \
> +	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
> +		KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu, (C)-=
>kvm); \
> +		(vcpu_is_loaded(C)) \
> +			? __vcpu_write_sr((C), (V), (R), 0) \
> +			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })

[Severity: High]
Can _vcpu_read_sys_reg() and _vcpu_write_sys_reg() call smp_processor_id()
with preemption enabled?

vcpu_load() sets vcpu->cpu and then calls put_cpu(), and
kvm_arch_vcpu_ioctl_run() re-enables local interrupts before calling
handle_exit().  When exit handlers such as kvm_handle_sys_reg() or
kvm_handle_guest_abort() read or write save-area registers,
vcpu_is_loaded() is true in preemptible context.

On CONFIG_DEBUG_PREEMPT=3Dy kernels, smp_processor_id() triggers a
check_preemption_disabled() BUG splat.  On any preemptible kernel, if the
vCPU thread is migrated between reading (C)->cpu and evaluating
smp_processor_id(), the preempt notifier updates (C)->cpu to the new CPU
and KVM_BUG_ON() fires falsely, killing the VM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D16
