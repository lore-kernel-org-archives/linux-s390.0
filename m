Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08859248F57;
	Fri, 31 Jul 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503962; cv=none; b=hRHBiC7c197kGgR0L847JZyV53M8h+HgJnTEkUaxI/YK7x5GiA/8RXIXz0ar3flQMn1qVhJUXoCyMLIktAMMW7hkF9W1jZsm9yKRT371Qoe67qNBzshI+xsEsCviwmH/arehlYhrqn1rE4aAwGMpMyEClYqdCqdWzfI85ZvuyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503962; c=relaxed/simple;
	bh=zdTHuPITqrizfGynfCSWYekriRcNA4Q5K23uEybd6UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPMaJhjaJHh5nQRQ/ZjhElUCkRfEaDv9aU9zeBgM2f+qqRcfTMDtxSQY1czN1yL9B1N6jGxO35XV/b11tDDwG3RXrNpgBtFyRvOJH9MYL9SR451p93faaeajlUsJNtoflcVvilPrM3uPexQCHWXjqn1logdK4PdugUrRbO9t/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4c8XDSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4c8XDSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5DC1F000E9;
	Fri, 31 Jul 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503960;
	bh=0lz6AcpUfPGFEmaCYe+0p7u8/BRdP7Q3DtohRiCswf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4c8XDSOZim2Jjq6JBp1jr4H5oMhN5KX5HOkVo1s+Md9vtDvJihzU0Eap+yZZe3yn
	 6rrhEq3XZdHpqq4HQXETTXAkQ0rEdSuyhuUjinOFLET8qgv4rTzN6wuLMFWHC0i5RV
	 SzxRdT4by6L3sTKOlA+TCamc6VG+930HfefeDK+YcI1d8fZk9QQxDrHeGsGVwXRDJV
	 oDkg0pyEYXO4FJPUVqPZqH80bR/SSM/FaOxaax5TitvM9yRlxcnHleXdkVP4U4JzEq
	 U/pufp0XkVL3EJcF6EMH/iIeVISGiPjdyOSwM/P2dF+WosxUx1+a5rHgH9zbZWUuOj
	 eEp48wRxdRF+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130138.173983-6-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:19:19 +0000
Message-Id: <20260731131920.5F5DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Host userspace and malicious guests can trigger a KVM_BUG_ON (WARN=
_ON_ONCE) by injecting an external call into a UCONTROL VM.
- [High] Fencing the KVM_S390_INTERRUPT ioctl entirely for UCONTROL VMs bre=
aks backwards compatibility.
--

--- Patch [5]: [PATCH v7 05/14] KVM: s390: ucontrol: Fix sca_clear_ext_call=
() ---
commit 22db5ca2b2a238d3fc521f6c7e38a951435c51a0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Fix sca_clear_ext_call()
   =20
When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA. This commit stops UCONTROL VMs from touching ESCA, fences the
KVM_S390_INTERRUPT ioctl, and adds checks to other ESCA paths.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..9db68e3ac178f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -60,13 +63,16 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu=
, int *src_id)
> =20
>  static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
>  {
> -	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>  	union esca_sigp_ctrl old_val, new_val =3D {.scn =3D src_id, .c =3D 1};
> +	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> +	union esca_sigp_ctrl *sigp_ctrl;
>  	int expect, rc;
> =20
>  	BUG_ON(!kvm_s390_use_sca_entries());
> +	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
> +		return -EINVAL;

[Severity: High]
Can a malicious guest or unprivileged host userspace process trigger this
assertion?

It appears UCONTROL VMs can still reach sca_inject_ext_call() through other
unfenced paths. For example, host userspace can call the KVM_S390_IRQ ioctl
with KVM_S390_INT_EXTERNAL_CALL without being fenced, as the UCONTROL check
was only added to KVM_S390_INTERRUPT.=20

The ioctl flows through:
kvm_arch_vcpu_unlocked_ioctl()
  case KVM_S390_IRQ:
    kvm_s390_inject_vcpu()
      do_inject_vcpu()
        sca_inject_ext_call()

Similarly, a guest executing a SIGP EXTERNAL CALL instruction can intercept
to __sigp_external_call(), which also calls kvm_s390_inject_vcpu() and will
ultimately hit this KVM_BUG_ON.=20

Would it be safer to return an error without the KVM_BUG_ON to prevent
a host denial of service if the system is configured with panic_on_warn?

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 5b2727d7dfd12..21574f57be72e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2934,6 +2934,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>  	case KVM_S390_INTERRUPT: {
>  		struct kvm_s390_interrupt s390int;
> =20
> +		r =3D -EINVAL;
> +		if (kvm_is_ucontrol(kvm))
> +			break;

[Severity: High]
Does completely fencing the KVM_S390_INTERRUPT ioctl for UCONTROL VMs
cause an ABI regression for older userspace tools?

If existing userspace relies on KVM_S390_INTERRUPT to inject non-external
interrupts (such as KVM_S390_PROGRAM_INT), this unconditional check would
cause those injections to fail with -EINVAL, potentially breaking existing
functionality.=20

Could this check be restricted to only rejecting the specific interrupt
types that rely on ESCA?

>  		r =3D -EFAULT;
>  		if (copy_from_user(&s390int, argp, sizeof(s390int)))
>  			break;

[ ... ]

> @@ -5456,6 +5459,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp=
, unsigned int ioctl,
>  		struct kvm_s390_interrupt s390int;
>  		struct kvm_s390_irq s390irq =3D {};
> =20
> +		if (kvm_is_ucontrol(vcpu->kvm))
> +			return -EINVAL;

[Severity: High]
Is this also prone to the same backwards compatibility regression mentioned
above for vCPU-level interrupt injections?

>  		if (copy_from_user(&s390int, argp, sizeof(s390int)))
>  			return -EFAULT;
>  		if (s390int_to_s390irq(&s390int, &s390irq))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D5
