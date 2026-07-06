Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3F3C2787;
	Mon,  6 Jul 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331501; cv=none; b=KJ2CDihEm1i+uQ/TTMFCLvEfj6+RHGgypjnNcRuAcBtjOTjIr6aKBocOvbjBrMB4rMoCEApYKKzu7JU/bh0Axw6yapZPXNKD/nPPN9DODsbQSqIQ/AdKCWBoNeB9jZSwMEQtWvqrg/411yFnHIMNkPiSbPN2L5w0sQXjb0f740U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331501; c=relaxed/simple;
	bh=ywoaDCiitG6UUpbjXRz5XjrlLVumC9HZGxpFMZ3I8eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/C5ISiesENl44r8mG8BhhcoFmqZRD3nfYL7G4Xsx3YGQQmkbfcfp976XL6Zj4KqedasujBYGh09P+66PNngV483kENqwqwsteVRqUszlQeVjnIbvKIlVt2VHZQW5ramDrJ0Bvs8w3mxdREUpuPoU6L1Tz39DnY238ZOD1cRjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcBaW/E1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcBaW/E1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB021F00A3A;
	Mon,  6 Jul 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331491;
	bh=zN2f75xRCPsJVmuL136Mb/updeydU4Ru6dHCSJnNi1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcBaW/E1zeMDTNokdLZAj+MaOAifKXjrq3xDU9jXuHvI30MI/9pGdmGKA6I/3X8Jd
	 8+02sQMRnsdesYru1hqeBxQ6hHoJ2yA3E+lI8vGjafVsFGlBXu7pmPKewBb3RNOus3
	 kZCXaCrn0sF2cxFwc695F/EUAcemj8H1jetepKOkKW4D+HizYQpk8mR0TvMaCu+C67
	 ilz/3ug6AU4lqjSPuoU3+NG0/DWm+GSnzi7s456+rpXWLdeC13xFMn0oZqfbvBapuT
	 0uyLMNNK+ZJ8ryrYUX1F1p5nHL9RC6N8np8H0a/MrjvujEToiGXb94eiz/R0d9OVij
	 KkOILjVLzTm2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/27] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260706085229.979525-23-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:51:30 +0000
Message-Id: <20260706095130.DEB021F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Integer underflow in `kvm_max_guest_address()` allows bypassing =
IPA limit checks, leading to shift-out-of-bounds undefined behavior.
- [Medium] Falsely advertises support for `KVM_CAP_ARM_USER_IRQ` while sile=
ntly dropping interrupt injections.
--

commit cf17b7229eed87d0fba2ede0e60b154b44cdfc5e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Add basic arm64 kvm module
   =20
Add basic code for the new arm64 on s390 KVM implementation.
Add kernel module boilerplate code and trivial functions.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 0000000000000..19249ec5c539f
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -20,172 +20,192 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  {
>  	int ret;
> =20
>  	switch (ext) {
>  	case KVM_CAP_NR_VCPUS:
>  	case KVM_CAP_MAX_VCPUS:
>  	case KVM_CAP_MAX_VCPU_ID:
>  		ret =3D KVM_MAX_VCPUS;
>  		break;
>  	case KVM_CAP_ARM_VM_IPA_SIZE:
>  		ret =3D get_kvm_ipa_limit();
>  		break;
>  	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_ARM_USER_IRQ:
>  		ret =3D 1;

[Severity: Medium]
Since kvm_vm_ioctl_irq_line() silently drops interrupts and returns success,
does advertising support for KVM_CAP_ARM_USER_IRQ here cause userspace to
believe the capability works, leading to lost interrupts and guest hangs?

>  		break;
>  	default:
>  		ret =3D 0;
>  	}
> =20
>  	return ret;
>  }
> =20
>  static u64 kvm_max_guest_address(void)
>  {
>  	u64 max_addr;
> =20
>  	if (sclp.hamax =3D=3D U64_MAX)
>  		max_addr =3D TASK_SIZE_MAX;
>  	else
>  		max_addr =3D min_t(u64, TASK_SIZE_MAX, sclp.hamax);
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: Medium]
Can this underflow if max_addr + 1 is less than 1GB?=20

If sclp.hamax restricts the maximum address to less than 1GB,=20
ALIGN_DOWN(max_addr + 1, 1 << 30) will evaluate to 0. Subtracting 1 would
then underflow to U64_MAX.

>  }
> =20
>  vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *v=
mf)
>  {
>  	return VM_FAULT_SIGBUS;
>  }
> =20
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg)
>  {
>  	return -EINVAL;
>  }
> =20
>  u32 get_kvm_ipa_limit(void)
>  {
>  	return fls64(kvm_max_guest_address() + 1) - 1;

[Severity: Medium]
If kvm_max_guest_address() returns U64_MAX due to the underflow above, this
will evaluate to U32_MAX.=20

Could this large value cause the IPA limit validation checks to be bypassed,
allowing untrusted userspace to provide a large shift value and trigger a
shift-out-of-bounds undefined behavior?

>  }
[ ... ]
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_lev=
el,
>  			  bool line_status)
>  {
>  	return 0;

[Severity: Medium]
This isn't a bug in the implementation of the stub, but since
KVM_CAP_ARM_USER_IRQ is advertised as supported, will returning success here
without injecting the interrupt deceive userspace and silently drop the
interrupts?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D22
