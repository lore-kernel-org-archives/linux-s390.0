Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985487;
	b=qbjh/7fYXGLzJsZ80sAad0qr7JN3gN2+1hLElXkjOy+to9VpKgpRxIq3/HOIbQZURWGP
	 GVhvNM+heiNEcmpoCEwi5wZrm4s78prWKSfC0bjQ5pXfaFd2s2tgYjwKk6l4iz5jUrKh1
	 kgPuSGsT7KcHPoeE5AcyTQmZdqJIRLciyhSHRn8ZiZXqiDCpNnc+avuAq2dknzZjXe7yu
	 zz2rI5fta7KtuDd3tumFU8hBilHbUU4ik590f5PJ7ors4j10nSfNc/cbZ8jsq70RjDjfw
	 v603twmqnxPaqZUD06U662YkGiqIAYQRbQM9PXMDUlDQLNbWvFhnPilqKmSKtyZHXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xMAGa3S8aYyHIE/94f8xfinpQSCHE0yPXUnRRCP8Qww=;
	b=WEakt97o5oRrWaOVQ8reXalazB4KQTL/yKG4eSf1A0300NnGl99t9GCJzZmdMn90s8K1
	 5hS2d8VSx6F68MivfPGJgp+d54gRnjwKRv/cLvPKMcdOcoAjVGwh4eDxQbEDfJUZoqWG2
	 0lER4R4zd+qU/gGTn5+tFLjp3hI8I+ciauNfRPbfEImS7Ka4SV1+Kp/27VGk7baDCqwy+
	 k/seuE4O+nnVkyU40DH0n3XXbStnsu6DyMJA+8gAvBSJrItT91lQF0I8kEwnXwbYr6wMf
	 xiAa5UNDqTjZVu+36ySwstHkDaM6qPY6Rhm2QMFNbOqnhph7q3gXQYNl9KLDg/47XGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/TCih5o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D7606A326;
	Fri,  6 Nov 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/TCih5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C41F008A1;
	Fri,  6 Nov 2026 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985486;
	bh=xMAGa3S8aYyHIE/94f8xfinpQSCHE0yPXUnRRCP8Qww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/TCih5oYWiGwtP04gvJW2Sj8pl0muq1PQKRakZ1TE5pfgP9oDseRS0IAjjOKCjIS
	 l2YfNJwmP1jJlWZ+Q4Jtyaox7AleNX/d2VdyHsTghXlYUlg3vjb4U3+PJBrUNCvL4d
	 jAlVRDl2PHVtlwGeF524qZCwLc2Tb1RXJ8O50LgbI3wfKXVhMrSnUvGouHZTvEs/lP
	 y8UXXlboBuxSC2GPoQSxllU1KCiJDR5jz0pTBuSqgf6ZRT3UevMPEHhCGqe1DvGKsx
	 bXNhQDlFxe9R6WgI8s+gGkfCDMkOI9MRhGFhHZdv6PWash+kFt1Szm2PLrv7Vyu2YS
	 n8OwVXWvm050g==
Message-ID: <sashiko-outbox-201908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/23] KVM: arm64: Share system register code with
 s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-8-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-8-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:18:05 +0000
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
- [Medium] KVM: arm64: piecemeal sys_regs.c sharing and mixed PAuth/SVE
  changes
--

commit 0c97a3ae40885547f256dfa51f22f3c444581c17
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Share system register code with s390

This commit wraps selected pointer authentication, SVE, and system register
helpers in arch/arm64/kvm/ with ARM64_S390_COMMON guards so they can be
compiled into s390 KVM.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 157bf4b812020..d83df5ff68f4a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -366,6 +366,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  	kvm_arm_teardown_hypercalls(kvm);
>  }
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  static bool kvm_has_full_ptr_auth(void)
>  {
>  	bool apa, gpa, api, gpi, apa3, gpa3;
> @@ -400,6 +401,8 @@ static bool kvm_has_full_ptr_auth(void)
>  		(apa + api + apa3) =3D=3D 1);
>  }
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  {
>  	int r;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 878ea4500c5c5..26ec4751e17e2 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -307,12 +307,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, cons=
t struct kvm_one_reg *reg)
>  	return err;
>  }
> =20
> -#endif /* ARM64_S390_COMMON =3D=3D 1 */
> -
>  #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
>  #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
>  #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */

[ ... ]

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index e71c1b169b491..fa1ed13daeb92 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c

[ ... ]

> @@ -3269,6 +3288,8 @@ static int set_imp_id_reg(struct kvm_vcpu *vcpu, co=
nst struct sys_reg_desc *r,
>  	.val =3D mask,					\
>  	}
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *=
r)
>  {
>  	__vcpu_assign_sys_reg(vcpu, r->reg, vcpu->kvm->arch.nr_pmu_counters);

[ ... ]

> @@ -5416,6 +5440,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_=
reg_desc *reg)
>  {
>  	u32 id =3D reg_to_encoding(reg);

[Severity: Medium]
As reported by Marc Zyngier on v2 [1], why does this patch cherry-pick
isolated helper blocks from arch/arm64/kvm/sys_regs.c instead of sharing the
architectural system register code and sys_reg_descs[] table as a whole?

Leaving sys_reg_descs[], kvm_reset_sys_regs(), kvm_handle_sys_reg(), and
arm64_check_features() unshared causes commit "KVM: s390: arm64: Implement
arm sysreg managing infrastructure" to duplicate the architectural system
register table and core handling logic in arch/s390/kvm/arm64/sys_regs.c,
which risks the two implementations diverging over time. Abstracting the
underlying vCPU state accessors would allow reusing sys_regs.c and its
descriptor tables directly.

In addition, this commit bundles pointer authentication capability sharing =
in
arch/arm64/kvm/arm.c and SVE helper sharing in arch/arm64/kvm/guest.c into
the same patch as the system register changes, rather than splitting them to
match the corresponding s390 feature patches.

[1] https://lore.kernel.org/r/87o6ehmkzz.wl-maz@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D8
