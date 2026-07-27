Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAB424652;
	Mon, 27 Jul 2026 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170010; cv=none; b=DBdx0gSoxpWVoUYVi/8Lg7hXNPUlN4TkxmDnmrm0rthHVCnfYWDEdIsxFQYCZgRvVSbaIE/EuLgz01d0sunFYooEH/FVTng/529EGO364vwPIqfX+RLmBShZzB+Cxw/lsoEY8AeF1sQMutKots8d0Sz5wRH9d/bvRJqwFRcZzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170010; c=relaxed/simple;
	bh=giOQ6+R6FSS62O1T8kHclShY3PgTSsy5Flb4kuKj6Eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jeUdA+M3PyPyt4mrZYz7qdQv7K3UGDciHvSWog4tSfUOnUYlAyDFU3IUgKrldJv9KD/ckROlc3T7aoxJIl4e7z/JR1p5uqpWyf4DbjuXy7hZOeuf6Q3cpYl0ANo0zAirvwztVPalyLY3BlRRtQy50xARLjbt6fAUXmRHRCTiFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/QWffwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/QWffwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3996E1F00A3A;
	Mon, 27 Jul 2026 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785170009;
	bh=MftOeW/pSVai2+7IRRfUuObRKZoUMoE3Dz00pJrOCxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/QWffwBSkN4j5VSy3rawdznab3RWLnek+qsWl0XGRka6a9UsiWa2dv9afvnVEr9M
	 X/zp2oQj1Mb8AEfBF/7QMB/cuiu6y3RmRmJYgQZZ8cDh0J9iy2XpcDGkQweWZiHMWh
	 ID4yusyxHBko7ip8KnyKyTySawtvdFnLxjHeUzmOcMRsCbgSbDPIhjR+qHmsbYudIx
	 aagXMuASLYHUJ/1wDOaWO1ZoBvMYFd6ZAMIH4ZWKuXcaW25FzY0/PXsrHAU0PdNNp+
	 +C0VigIRk9P1DsYzndXg17T5XBXM4YAeO/1Ip9d5iHLOzkB5yd1z5IZB3v4zknMHuc
	 MVfHfjditRW+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727150254.236021-7-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:33:28 +0000
Message-Id: <20260727163329.3996E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] For UCONTROL VMs, the ESCA block CPU array is accessed out of boun=
ds because vCPU IDs up to 254 are permitted, exceeding the array's size of =
248.
--

--- Patch [6]: [PATCH v3 06/10] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit 711c5a0b8c8ac3214d997bede21c76e30e58d712
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

This commit modifies vCPU destruction to skip clearing the ESCA entry if
the vCPU was not successfully initialized.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..2acdff130fa6c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
>  	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20
>  	WRITE_ONCE(sigp_ctrl->value, 0);

[Severity: High]
This is a pre-existing issue, but does this code write past the bounds of
the esca_block allocation for UCONTROL VMs?

Looking at kvm_arch_vcpu_precreate() in arch/s390/kvm/kvm-s390.c, the
bounds check for ESCA CPU slots is explicitly bypassed for UCONTROL VMs:

    if (!kvm_is_ucontrol(kvm) && !sca_can_add_vcpu(kvm, id))
        return -EINVAL;

This allows vCPU IDs up to 254. However, the ESCA block CPU array only has
248 slots, and the block itself is allocated as exactly 4 pages.

When destroying a vCPU with an ID >=3D 248, the write operation in this
function appears to access memory past the end of the esca_block.

A similar situation seems to happen in sca_inject_ext_call() when
processing external calls:

arch/s390/kvm/interrupt.c:sca_inject_ext_call() {
    ...
    union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
    ...
    rc =3D cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
    ...
}

Could this lead to kernel memory corruption if a UCONTROL VM is created
with large vCPU IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D6
