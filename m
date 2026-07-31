Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E83FCB2C;
	Fri, 31 Jul 2026 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504385; cv=none; b=jCZjuBW4aXmYsCmMKdBmHV7G8im1CZfU6apWc5rYPV2YZ7AaKUiy9GWQ618PowpKXL5WEE8kW29nmCusysMKvcpet9zZHM7GcY6dt38BeHN2Ul7jU8vQXaZmrArKeePcTLYPaz1NMYvyrtLaMPFU3bjzRwjLZ97SvWaXrSTQP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504385; c=relaxed/simple;
	bh=aJ6Ims8eNBrjMp81dEwP8lY1ukvhwWCzV8AostD9/hM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gdwsgefbq2qLnv0tZPgmua/8RI6o3jSHvCZCtv0IVnRbzgq4HKLfnenJYgonWaG8rOwbA5Xwc3Mqr9pPe4hK3XnOmxyK2YLuIyHny1M0eCkypxELnLqBGpuGuw0ZJ45w332r7VZsiLyt2ObwV16Gqdb3dn8Pr0jCb/eM07aBAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcbMku4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcbMku4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2D41F000E9;
	Fri, 31 Jul 2026 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504384;
	bh=58ZumfEHd4/+SXBO/aDdnPUe7NRJCpb/JjpgZXyVTNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcbMku4+Hym/U/RarpjjwCiMqdm+LxfgxYXdUBMbpfV/qBmx0QTTaqC7iaM8N38HA
	 GryLeTXRe9y/q/NDbHLIEQH/0J5CtpwN/Me8VqoGrKeVsSTx7LJTyJzY6trxXLqMI8
	 0nR38PzSPs7WUvp7PPsZvqtlyOikT4BxhdjVclZgKQP/djJjsd30x3XVQaZi0DJVab
	 00KG+xik3vZL9DDKXZW2VT0/TBEB5Cqb1BcqoAGl6MFJiYEeHmxbotbgVBdk/iunkP
	 mrJZNPel6/GMc1f1O6OveG8V4qocuaqpyh4mDphS963gdwzWu13rnsqy5nsXVOXMl0
	 ILptBQ0RQqn5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/31] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-3-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:26:23 +0000
Message-Id: <20260731132624.0A2D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory allocated for `kvm_dev.name` is leaked if the subsequent =
`cache_name` allocation fails.
- [Medium] Mixing `goto`-based error handling and `__free()` scope-based cl=
eanup within the same function.
--

--- Patch [2]: [PATCH v5 02/31] KVM: Make device name configurable ---
commit bb225c1b3b23a0088c5fdee909b0a0007a39479e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Make device name configurable

This commit allows KVM implementations to choose alternative device names.
This is especially useful for architectures providing multiple KVM
implementations simultaneously.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 994cb40cf2efe..18eb3d5d04f4c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -6491,23 +6490,39 @@ void kvm_unregister_perf_callbacks(void)
>  }
>  #endif
> =20
> -int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *mod=
ule)
> +int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct mod=
ule *module)
>  {
> +	return kvm_init_with_dev(vcpu_size, vcpu_align, module, "kvm", KVM_MINO=
R);
> +}
> +
> +int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
> +		      struct module *module, const char *dev_name, int minor)
> +{
> +	char *cache_name __free(kfree) =3D NULL;
>  	int r;
>  	int cpu;
> =20
> +	kvm_dev.minor =3D minor;
> +	kvm_dev.name =3D kstrdup_const(dev_name, GFP_KERNEL);
> +	if (!kvm_dev.name)
> +		return -ENOMEM;
> +
>  	/* A kmem cache lets us meet the alignment requirements of fx_save. */
>  	if (!vcpu_align)
>  		vcpu_align =3D __alignof__(struct kvm_vcpu);
> +	cache_name =3D kasprintf(GFP_KERNEL, "%s_vcpu", dev_name);
> +	if (!cache_name)
> +		return -ENOMEM;

[Severity: Medium]
Does this direct return leak kvm_dev.name?

The kvm_dev.name pointer is allocated via kstrdup_const() just above. If
kasprintf() fails, this path returns -ENOMEM directly instead of jumping
to the err_dev_name label to free the previously allocated memory.

>  	kvm_vcpu_cache =3D
> -		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
> +		kmem_cache_create_usercopy(cache_name, vcpu_size, vcpu_align,
>  					   SLAB_ACCOUNT,
>  					   offsetof(struct kvm_vcpu, arch),
>  					   offsetofend(struct kvm_vcpu, stats_id)
>  					   - offsetof(struct kvm_vcpu, arch),
>  					   NULL);
> +	r =3D -ENOMEM;
>  	if (!kvm_vcpu_cache)
> -		return -ENOMEM;
> +		goto err_dev_name;

[Severity: Medium]
Is it intended to mix scope-based cleanup with goto error labels here?

The kvm_init_with_dev() function declares cache_name using __free(kfree):

    char *cache_name __free(kfree) =3D NULL;

But it also uses traditional goto-based error unwinding throughout the rest
of the function, such as the goto err_dev_name seen here. The cleanup
subsystem guidelines require that functions either convert all resources to
scope-based cleanup or use goto labels exclusively. Mixing them in the same
function can lead to confusing ownership semantics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D2
