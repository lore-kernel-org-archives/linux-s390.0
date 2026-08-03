Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219834027B;
	Mon,  3 Aug 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763279; cv=none; b=OayJyFH0y+puT+RI7YmE8tzABRYAU0B9IvLrr2DtRWGOq1nMR/8K8RtjswfxkzAAYb9IAbefS3YpkeiFJU00d+rw5+cuhzaDHcwknGpL3cBV7A5jWbMrgLA3563sOph1vpHI6VFheBnME16qy0saCcNPls3Vih8qt+NJCAPsAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763279; c=relaxed/simple;
	bh=eX8dleoVvfPqvakW2tqceSeGu7RwLineofWqE8v/3jA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C6K9E2bzL6F32gNvRa4USiJDI87hIjSDKMrsAorQxnJhrpK66SpNTdaIhGErsMuQ1JJGUoAQhASHvzEWbkAToN07RCihyElJVe5vTJ9m/4ewwtg+T6jboJCeG3Rdft7WWo53yqfPdKiPtxHMeuYLOjcpRYQRR5cIoqUkqjlcb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFfs894q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFfs894q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD171F000E9;
	Mon,  3 Aug 2026 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763265;
	bh=OZzrSZx+BqdmTPr5F4hYqmLb7dThY5Fk9E+d+/Xv20Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFfs894qx0/3Bsv1pWRSOeZX3FQWyxYyNmGnUS/yNVUG0g54aSDGWZs4k8VA/sKma
	 fOcLBSQoH9fz+kk5fa/xsqwAU/SsjhFOyo0cHfqFN9Cnl7WzSZ2zaTaN6WG+B2Ezxc
	 QCc2h6lu2vyviXA31l5ml/xPQFx/de48kPSL84zXiEIjFM45JN45pNyVSc6QGoey8n
	 wCjSjbXYe9TeiYFUc4PjRj6uxAzbb7ggM6NZbkFyTYvnAfj5GoDmpL7rJM9Gl3MXVN
	 xVhOmripCyiFNPy4IQr9fXoSLJub4fYs/Nsr/jO9Wvdi42t0azgHJV0PTNhNKMsrHY
	 AzGnCtuBRpjCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803124040.126471-6-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:21:03 +0000
Message-Id: <20260803132104.BDD171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardware-dependent ABI inconsistency for UCONTROL VMs when injec=
ting KVM_S390_INT_EXTERNAL_CALL via KVM_S390_IRQ.
--

--- Patch [5]: [PATCH v8 05/13] KVM: s390: ucontrol: Fix sca_clear_ext_call=
() ---
commit 450e8d67402bbac296dca888444bff5561662e98
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Fix sca_clear_ext_call()

This commit fixes an out-of-bounds access in sca_clear_ext_call() for
UCONTROL VMs by explicitly not touching ESCA. It also fences the
KVM_S390_INTERRUPT ioctl for UCONTROL VMs and adds extra checks to make
sure UCONTROL VMs won't touch ESCA.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..6b3f97a7513b3 100644
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
> +	if (kvm_is_ucontrol(vcpu->kvm))
> +		return -EINVAL;

[Severity: Medium]
Will this create a hardware-dependent ABI for UCONTROL VMs when injecting
KVM_S390_INT_EXTERNAL_CALL via KVM_S390_IRQ?

Looking at __inject_extcall(), sca_inject_ext_call() is only executed if the
host supports ESCA:

arch/s390/kvm/interrupt.c:__inject_extcall() {
    ...
	if (kvm_s390_use_sca_entries() && !kvm_s390_pv_cpu_get_handle(vcpu))
		return sca_inject_ext_call(vcpu, src_id);

	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
    ...
}

If the host lacks ESCA support, the UCONTROL check here in
sca_inject_ext_call() is bypassed, and the external call is successfully
queued.

Unlike KVM_S390_INTERRUPT, the KVM_S390_IRQ ioctl is not fenced for UCONTROL
VMs, allowing userspace to trigger this inconsistent behavior. Could this
cause the same ioctl to fail on modern hosts but succeed on older ones?

Would it be better to place the UCONTROL check higher up in __inject_extcal=
l()
to ensure consistent behavior, or to also fence KVM_S390_IRQ for UCONTROL V=
Ms?

> =20
> +	sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>  	old_val =3D READ_ONCE(*sigp_ctrl);
>  	old_val.c =3D 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D5
