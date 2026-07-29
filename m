Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D93AEB26;
	Wed, 29 Jul 2026 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348133; cv=none; b=WcTYB8uob5JcIyfjUW8kv5izaJ4PDt82jT057xxKiy4epey+NFJiUq39cqbNgMhhPz6veXV9+AKr6biyKWlcX/wwGKR5gYpng5dlmUhwkaaQsPa4C57WlNt4m1c4jzxAptOnN2F7fdLpwVh+Nr287n4TtLAQAscEIrgqYkLgMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348133; c=relaxed/simple;
	bh=mt7dw3J04Rsk2VEoQRgQmLJEXHRXbFb7/6Lpr48+7n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RXdTcr0WLfBG3RylGBD4/5cNYiznpj7XuL1SzACNuBnaylKzWGI2RM0J9wao7NwCo0f2v/3KGUJzeWQac1ed3OgHN/VZNjB8NR1caF1AvAUkIptDOfr/sIWNO0o5xuGqq72Iam7RUWP/NTU10fAg6gsG4JKGCwNEerIdMOVxh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZbMP8Ix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZbMP8Ix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B484E1F000E9;
	Wed, 29 Jul 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348129;
	bh=8JyWJBqkdPOj7EwcOgUOCs+Agwff3aK7G5/y4WgwZlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZbMP8IxSOJYgK31rauAaUb1dDrRvDC3jmJ6VM2lTewNonNWk8gULh0xxlsYlcl8I
	 kTDEw1y3F4wq370vKRHyIEFd+61lH3pGR5ohEuhsZMpT7X/tVhDIjS21PuVBFPsaaj
	 se8E+9SiGTcxHKKHzaSx+whCP+/fU1ihRVXh4/Jj5JsqQV6L3CMETzXC6c56kPQJzM
	 z7jAYqwkWy/30l0BmwcmO4UOrLuia2GZtH4yL0SOq/gJy1/Lo7PjOhGoMhpCO8WeRE
	 wNJXso4wy/B/BQT2WlSu8gGpF9hHzW3ebnMkS+XVSlq6ur55oUnyn2jdv1zev6WyRG
	 NOIrgECDmUQEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/13] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729152938.782383-10-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:02:08 +0000
Message-Id: <20260729180208.B484E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `vcpu->arch.pv.stor_base` and `sida_addr` in `kvm_s=
390_pv_create_cpu` error path.
--

--- Patch [9]: [PATCH v5 09/13] KVM: s390: Free the mmu cache when kvm_arch=
_vcpu_create() fails ---
commit b7924aec9fd280e9673810b13295e30b7a659f81
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails

The mmu cache is the first thing that is allocated in
kvm_arch_vcpu_create(), but in case of failure it was not freed.
This patch refactors the function to use scope-based cleanup to ensure
proper cleanup on failure.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c04b7e84c4346..40f33cdcdf84d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -3861,22 +3860,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
> =20
>  	rc =3D kvm_s390_vcpu_setup(vcpu);
> -	if (rc)
> -		goto out_ucontrol_uninit;
> +	if (rc) {

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
kvm_s390_pv_create_cpu() leak vcpu->arch.pv.stor_base and sida_addr when
called from kvm_s390_vcpu_setup() here?

If uv_call() fails during kvm_s390_pv_create_cpu(), it attempts cleanup
by calling kvm_s390_pv_destroy_cpu():

arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu() {
	...
	if (cc) {
		u16 dummy;

		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
		return -EIO;
	}
	...
}

However, kvm_s390_pv_destroy_cpu() returns early because the PV handle
is not yet set:

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu() {
	...
	if (!kvm_s390_pv_cpu_get_handle(vcpu))
		return 0;
	...
}

Since vcpu->arch.pv.handle is assigned only after a successful uv_call(),
it is 0 during this error path. As a result, kvm_s390_pv_destroy_cpu()
does not free the previously allocated stor_base and sida_addr.=20

The caller then propagates the error back here, and generic KVM code skips
kvm_arch_vcpu_destroy(), making the memory leak permanent.

> +		if (kvm_is_ucontrol(vcpu->kvm)) {
> +			scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
> +				gmap_remove_child(vcpu->arch.gmap);
> +			vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
> +		}
> +		return rc;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D9
