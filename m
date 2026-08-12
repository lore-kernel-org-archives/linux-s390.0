Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA37326927;
	Wed, 12 Aug 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550912; cv=none; b=NIX+2fqGlkpy9vElIikX3CG8cM+zidsUqSXUA2nYqREwHvuDRcY6t9vOfRTm5HAFnWjzHbXsfvKtiGvU2GfUFNFMkLPtYsTVSrb6zqMXgVXMBL+uEYP9UJbtMUxQgZwf8YLUT5c9r1tAhwYKTZT9P3pw7U1nPgOLpXwAwmLjohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550912; c=relaxed/simple;
	bh=fshCfCkjotVnaU573XUmHtodk7a94hS8kNMrXJGT3Ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q45QEFvgc7M1yUEOsCm45EsUW6m6d9u9rzOYiwRB2Ku8Pr8utL0eUod3qRMqZXl4PYcyILBl8xAdKi88IrV58KKfZjP0aAxekSAZ8mkaCXBV3QILlEenBrza3FJATmS+LXqFKlFCw34E3KWJmRQNFwSvGs/4UnQP0RIhHE1DzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYstx4d1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYstx4d1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C51F000E9;
	Wed, 12 Aug 2026 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550910;
	bh=2jR8egsi+6GzPVDSLON8cTNC6QJVBkqxRYBbu8YYPPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYstx4d1NkTWA/+O0Ccit9DAyQcQZerUti+cSsnbJWDbBb4MT9yDH4E8gjOXxYXen
	 B/agVOk0eenxRgwReER6cwFKcQSyTxnVTwQWg/5Lin/G48G+1ookmoxWNMkHooHqOP
	 YTGNA90wxi2tj3ygOuDPhHEqNavZP+tEZVOB6tomXvstg2bL7JQYEeDqzHvgXbKu4/
	 V+biD34ccrxij4ku+cXhNCQKtgwxM/s34jp7BsggPfTGlW7+eivebdWPnVbGGqbwPn
	 bdQk2zQsbtI7vi8qJhPjOoZBcjcUJgB/FD3ManSZ38U6PhAM1FPjZVMHAkfrmX8SEC
	 NNI751TRINIRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/33] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260812153631.3376090-3-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:08:29 +0000
Message-Id: <20260812160829.D28C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling `kvm_init_with_dev()` multiple times within the same modul=
e to support multiple simultaneous KVM implementations corrupts KVM's stati=
c singleton state and guarantees list corruption.
- [High] `kvm_init_with_dev` is not exported, making it unusable by indepen=
dent loadable KVM architecture modules.
- [Medium] The patch fails to parameterize the `kvm_gmem_inode_cache` name,=
 causing a sysfs kmem_cache name collision when multiple KVM implementation=
s are loaded simultaneously.
- [Medium] The patch silently adds the `SLAB_ACCOUNT` flag to the async pag=
e fault kmem_cache without justification in the commit message.
--

--- Patch [2]: [PATCH v6 02/33] KVM: Make device name configurable ---
commit fddf3fec3ead355cf194e06551ca60993f2aec03
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Make device name configurable

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index b8aaa96b799bf..0157612491070 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
[ ... ]
> -int kvm_async_pf_init(void)
> +int kvm_async_pf_init(const char *cache_name)
>  {
> -	async_pf_cache =3D KMEM_CACHE(kvm_async_pf, 0);
> +	char *full_cache_name;
> +
> +	full_cache_name =3D kasprintf(GFP_KERNEL, "%s_async_pf", cache_name);
> +	if (!full_cache_name)
> +		return -ENOMEM;
> +
> +	async_pf_cache =3D kmem_cache_create(full_cache_name,
> +					   sizeof(struct kvm_async_pf), 0,
> +					   SLAB_ACCOUNT, NULL);

[Severity: Medium]
Does this silently introduce a behavior change? The previous KMEM_CACHE call
passed 0 for flags, but this adds SLAB_ACCOUNT. While accounting these
to the vCPU's memory cgroup is likely correct, shouldn't this functional
change be documented in the commit message?

> +	kfree(full_cache_name);
> =20
>  	if (!async_pf_cache)
>  		return -ENOMEM;

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0d80730e84240..0b34477bf325b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> +int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
> +		      struct module *module, const char *dev_name, int minor)
> +{
> +	char *cache_name;
>  	int r;
>  	int cpu;
> =20
> +	kvm_dev.minor =3D minor;
> +	kvm_dev.name =3D kstrdup_const(dev_name, GFP_KERNEL);

[Severity: High]
Can calling kvm_init_with_dev() multiple times corrupt the static miscdevice
and list state?

If multiple KVM implementations share the same kvm_main.o core and call this
initialization, they will unconditionally overwrite the shared static kvm_d=
ev
struct. Calling misc_register(&kvm_dev) a second time with the exact same
static struct would overwrite its list_head pointers, which structurally
guarantees misc_list corruption and a fatal kernel panic on the next
traversal.

> +	if (!kvm_dev.name)
> +		return -ENOMEM;
> +
>  	/* A kmem cache lets us meet the alignment requirements of fx_save. */
>  	if (!vcpu_align)
>  		vcpu_align =3D __alignof__(struct kvm_vcpu);
> +
> +	r =3D -ENOMEM;
> +	cache_name =3D kasprintf(GFP_KERNEL, "%s_vcpu", dev_name);
> +	if (!cache_name)
> +		goto err_dev_name;
>  	kvm_vcpu_cache =3D
> -		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
> +		kmem_cache_create_usercopy(cache_name, vcpu_size, vcpu_align,

[Severity: High]
Doesn't this also unconditionally overwrite the global kvm_vcpu_cache point=
er
and leak the previous cache when multiple implementations initialize?

>  					   SLAB_ACCOUNT,
>  					   offsetof(struct kvm_vcpu, arch),
>  					   offsetofend(struct kvm_vcpu, stats_id)

[ ... ]

> @@ -6597,6 +6615,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  	for_each_possible_cpu(cpu)
>  		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
>  	kmem_cache_destroy(kvm_vcpu_cache);
> +err_dev_name:
> +	kfree_const(kvm_dev.name);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);

[Severity: High]
Should kvm_init_with_dev() be exported? The commit states it is meant for
architectures providing multiple KVM implementations simultaneously, but
without an export macro like EXPORT_SYMBOL_FOR_KVM_INTERNAL, external
loadable architecture modules will fail to link against it.

[Severity: Medium]
Also, if multiple implementations are statically linked to avoid the missing
export, wouldn't kvm_gmem_init() (called earlier in this function) cause a
sysfs naming collision?

It does not take a dev_name parameter and hardcodes the name
"kvm_gmem_inode_cache". Because SLAB_ACCOUNT caches are unmergeable, the
second creation attempt will fail sysfs registration and emit a SLUB error
in dmesg.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D2
