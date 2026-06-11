Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C443DA5B0;
	Thu, 11 Jun 2026 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175992; cv=none; b=mVJ+r6Y2jGjZqeEMFHMTakK3gdrGtVv+8dGM8eEipu3gAYoV99UdPre/WM+XK8awCixip3hWs9HTvR1Ypb6ldJnursM66GBZMGxcfywhCzi2SWZGG6G29LeioXkrWgnArSM8TsEgtTGUUNVIb1KFGGACuSaS5iTJN0FnmWCMWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175992; c=relaxed/simple;
	bh=K55qjqO7FiMjt44aQQymgHKzft4/9sa+j6Sk5zLWf5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzuRd3DhdqJGfzwRr5X77FXBnN/0L4W6Jho/+p7YokIt6q0TfQYhBXSqn4+LtnDfBMN3JlOJVDJ4TrU830NiJM/ARS/afAMklQnlFjfLoS2bIB8Cbysh2msSnADL5NJduyN7NfSQg99kr7E713rwxGcuqcYjo2icFK1BI6zcAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrBWLyGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrBWLyGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826B01F00893;
	Thu, 11 Jun 2026 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175990;
	bh=FVo3wDxRGP55Rl4s02CnONSU1P8za2nTBIlbWIPXvec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrBWLyGK4XuRdi6hcXw9M6JO5wCwcMkXhn78IW7TWY53EDs2mpuaGfdunham3a1Nq
	 TrJlpFNJOTqecODXkELsZpt01oWIQuXdO1OyNiXrs+gcT+Zwfi4ID2CwDSIh4QBhA+
	 oxHBH+EIbuFMangnITtV4g1+lgbugDm8MP5sKBxu7jW2shX/c+sjYuYqBbMx0GEvIQ
	 qUCsFUfN7UNdt8dr0REMOZAeVop2/YzCxY4FDj4KEZq9LK0fZGlAnJHx258siHAaoN
	 W5j0MUibpHHvsrLmap8BAkzLitYB+YmSyCTzo/Ib46KYwCU8XXA/9XIVYra9peLLJY
	 SAz25CILpyIvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KVM: s390: vsie: Fix allocation of struct
 vsie_rmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260611104850.110313-4-imbrenda@linux.ibm.com>
References: <20260611104850.110313-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:06:30 +0000
Message-Id: <20260611110630.826B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled memory allocation failures in `handle_sske()` and `handl=
e_pfmf()` lead to an unkillable infinite kernel loop.
--

commit abe0e652d367e02d61446edc9873e41898b993e0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix allocation of struct vsie_rmap

This commit fixes a copy-paste error in the allocation size for struct
vsie_rmap in kvm_s390_mmu_cache_topup().

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa2..a4fe664f65ee1 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache =
*mc)
>  		mc->pts[mc->n_pts] =3D o;
>  	}
>  	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
> -		o =3D kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
> +		o =3D kzalloc_obj(struct vsie_rmap, GFP_KERNEL_ACCOUNT);
>  		if (!o)
>  			return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but I noticed some callers of
kvm_s390_mmu_cache_topup() do not check its return value.

For example, looking at handle_sske() in arch/s390/kvm/priv.c:

    if (rc =3D=3D -ENOMEM) {
        kvm_s390_mmu_cache_topup(vcpu->arch.mc);
        continue;
    }

If kvm_s390_mmu_cache_topup() returns -ENOMEM due to memcg limits, does
this create an infinite loop since it immediately retries with an empty
cache and fails again?

The same pattern appears in handle_pfmf() in arch/s390/kvm/priv.c:

    if (rc =3D=3D -ENOMEM) {
        kvm_s390_mmu_cache_topup(vcpu->arch.mc);
        continue;
    }

Without a fatal_signal_pending() check in these loops, could this prevent
the host OOM killer from terminating the VM process?

>  		mc->rmaps[mc->n_rmaps] =3D o;
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611104850.1103=
13-1-imbrenda@linux.ibm.com?part=3D3
