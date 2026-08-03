Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F8237713;
	Mon,  3 Aug 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776981; cv=none; b=PF2ku6FGl/MGVBsv+T6OWGZRmZnnsDE6J5sqtbshOOd0VsSIoRHkRsI3Q2ywZO1mfAelfkg1jNqXKXalF2ebBdCea/DNuwYR9k7fZve+UaTE/LA9XPQvLlDgu7eyqAbCEF6kdagr0YBmFfwYd54G/aHkZ6JADlb7qpSAqVl8pUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776981; c=relaxed/simple;
	bh=Qq+7inmcXGXgzNYT4r/b35k5/CSdOvMD8XZ9Ytd9hKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=neXcB++5Wy9sxOBxEPH4FWIgSrvH5jqej4Wy9C9K306clwQ6+VnPv8YZ+F7qwmTdjni+G4wf1UURDN65VmOuQ1rdVhblwy4VJ0KJRYyjIjcdb94K+L2l58o3P2C0XPSub6V3/0V7kd+7Y64fGTXQtqA7Du5iBhaacFPQMauMhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IimcuZt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IimcuZt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F11F000E9;
	Mon,  3 Aug 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776979;
	bh=2mzzMVWuw+h6RvXng1iuiSAfeIwSgwbte0ZD9CbkEhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IimcuZt8tNPjmCg+jBGX+PGe6q4LTRFcxfjDHNS7cBkBbqsM/MhjdksO7OjEKa8FA
	 F1U9oTkgZecNHpeiMwqhjlCv0FAVeu5R/oujDHq5p8jpXJrV/HKwGlhk6qvAB6Vmoj
	 0llt2ljrSYeanrcHkF5bsqiyqe3+310C9OPfrlvsywhhphd32gQ1mawoL64PS6rb2S
	 EpqqJ4IV5uomIyYF1Cfrp+LT/ghvBtep1F+IhfhDtSiiei/PeTgi8syxNh77UwkNAk
	 uNl/rdyU/BCvPsq1K76XtDt8BYF1ln4RScfeC5on+KY0d8e26B0DkGkfq4Hg2q0vL2
	 QSw3TrCh9/TPA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 15/23] KVM: s390: ucontrol: Fix
 sca_clear_ext_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803160924.236807-16-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-16-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:09:38 +0000
Message-Id: <20260803170939.460F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] UCONTROL VM external call injection fails or succeeds inconsiste=
ntly depending on the host's hardware ESCA support.
--

--- Patch [15]: [GIT PULL v1 15/23] KVM: s390: ucontrol: Fix sca_clear_ext_=
call() ---
commit 4cf53d54c2a9bad47bf30203ae51ce4109c4612e
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Fix sca_clear_ext_call()

This commit addresses an issue where cleaning up a UCONTROL VM would touch
memory outside of the allocated ESCA block. It fixes this by avoiding ESCA
access for UCONTROL VMs and fencing the KVM_S390_INTERRUPT ioctl for them.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6c..6b3f97a7513b3 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -45,13 +45,16 @@ static struct kvm_s390_gib *gib;
>  static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl sigp_ctrl =3D sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl sigp_ctrl;
> =20
>  	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
>  		return 0;
> +	if (kvm_is_ucontrol(vcpu->kvm))
> +		return 0;

[Severity: Medium]
Will this cause pending software external calls to be ignored on hosts with
ESCA?

If the host supports ESCA and kvm_s390_use_sca_entries() is true, the system
will rely on sca_ext_call_pending(). By returning 0 here for UCONTROL VMs,
won't any pending software external calls be ignored?

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
Does this create an ABI inconsistency where UCONTROL VMs behave differently
based on the host's hardware capabilities?

When userspace calls the KVM_S390_IRQ ioctl on a UCONTROL VM to inject
KVM_S390_INT_EXTERNAL_CALL, __inject_extcall() checks if the host
supports ESCA:

arch/s390/kvm/interrupt.c:__inject_extcall() {
    ...
    if (kvm_s390_use_sca_entries() && !kvm_s390_pv_cpu_get_handle(vcpu))
        return sca_inject_ext_call(vcpu, src_id);
    ...
}

If the host doesn't support ESCA, it bypasses sca_inject_ext_call() and
successfully queues the interrupt via the software fallback.=20

But if the host does support ESCA, it calls sca_inject_ext_call() which
will now hit this check and return -EINVAL instead of queuing it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D15
