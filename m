Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F12488223
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931736; cv=none; b=QAESCqWYDOrqIXQtcFg1CuBZjlX8NHr5AWZjSQ9nXHD+O3RvZmWPJj/o4ki7RxuPgizbb/Swn5O783YNGKKzZ0wxOYYqXu6giCrrdGg1sXK5fpbciIfVVV41SOpPXRWNRuoySp5dbTFAVGsASBkxK81Z/a1mRKwGtGAp4pfpg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931736; c=relaxed/simple;
	bh=h7GNKsktAi3Gkg74cVGQ8iQp/b+EEUlVhHkeDR3YrWo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qutnoFJU8wE3ktKScw42qMLKugwnxVcgi6TKFBFuvzexVYZSjWJ+uWYPv08wWLZ7jUqQ7yCg3XaHmLEdtRDpGkrz0XNCOOrBGZLOgBQkznxH79lOPXmxADyf+dzd0qN2/1+HtTqQ2YCBJbAMnu8LK3SkfrZXJCSDSAA45YDgZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QofMp/S6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QofMp/S6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFDA1F000FF;
	Tue, 13 Oct 2026 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931734;
	bh=ibUJfB+28hW2wFJOdBo62K8n0F6KK/rS4kc37W5zLBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QofMp/S6l1viXok7/kmWXfSCGFmg8+OvFHV67BiwaduHvVVlpcoV57iEk029f3sUs
	 p3QtkUgUGsQX4xtpGk5sywHXAfPiPH7BJKmMjYKxxgx/p64P3g7gdpqqzruvXul7ya
	 m+g4SPp2+DggyosWEPj7IVymEPoBVvPHxgj/YAyhYdvxEMvEsf/qFAAShgJTE1VBc3
	 5RIrZqHe5mXzxWyp4rpR3KStP1hiLUznpnuA5vJVEUH/nVe3754QG8sPw+z8Xsd8Pr
	 f7ZFOPDo/EFhrgHcR+pRJd3LAzDouUZaK/FSA2CJqE5nSb6rBKKRrGb/e0sz/F+Rk3
	 i+rhY5oKx4DlA==
Message-ID: <sashiko-outbox-170599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] s390/sclp_mem: Allocate struct sclp_mem
 dynamically and add kobject release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "David Teigland" <teigland@redhat.com>, "Alexander
 Aring" <aahringo@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Richard Weinberger" <richard@nod.at>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Felix Kuehling" <Felix.Kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261013223946.1836757-9-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:48:52 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sysfs: kobject memory leak on init error paths and group creation =
race
- [Medium] sysfs: missing cleanup of previously allocated kobjects in initi=
alization loops
--

commit 191798937bad0f272b0f72f4ae28579cab8672f8
Author: Ian Rogers <irogers@google.com>

s390/sclp_mem: Allocate struct sclp_mem dynamically and add kobject release

sclp_init_mem() allocated a single array of struct sclp_mem with
kzalloc_objs() and registered each embedded kobject using a kobj_type
without a .release callback. Allocate each struct sclp_mem individually
with kzalloc_obj() instead and add sclp_mem_release() to free it.

> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 78c054e26d177..40a7f92729751 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
[ ... ]
> @@ -322,36 +325,40 @@ static struct attribute_group sclp_mem_attr_group =
=3D {
>  	.attrs =3D sclp_mem_attrs,
>  };
> =20
> -static int sclp_create_mem(struct sclp_mem *sclp_mem, struct kset *kset,
> -			   unsigned int id, bool config, bool memmap_on_memory)
> +static int sclp_create_mem(struct kset *kset, unsigned int id, bool conf=
ig,
> +			   bool memmap_on_memory)
>  {
> +	struct sclp_mem *sclp_mem;
>  	int rc;
> =20
> +	sclp_mem =3D kzalloc_obj(*sclp_mem);
> +	if (!sclp_mem)
> +		return -ENOMEM;
>  	sclp_mem->memmap_on_memory =3D memmap_on_memory;
>  	sclp_mem->config =3D config;
>  #ifdef CONFIG_KASAN
>  	sclp_mem->early_shadow_mapped =3D config;
>  #endif
>  	sclp_mem->id =3D id;
> -	kobject_init(&sclp_mem->kobj, &ktype);
> -	rc =3D kobject_add(&sclp_mem->kobj, &kset->kobj, "memory%d", id);
> -	if (rc)
> +	rc =3D kobject_init_and_add(&sclp_mem->kobj, &ktype, &kset->kobj,
> +				  "memory%d", id);
> +	if (rc) {
> +		kobject_put(&sclp_mem->kobj);
>  		return rc;
> -	return sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);
> +	}
> +	rc =3D sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);

[Severity: High]
Does calling sysfs_create_group() after kobject_init_and_add() in
sclp_create_mem() expose the sysfs directory to userspace before its
attributes are populated? Would it be safer to avoid this structural sysfs
race condition by assigning the attributes to ktype.default_groups instead?

> +	if (rc) {
> +		kobject_put(&sclp_mem->kobj);
> +		return rc;
> +	}
> +	return 0;
>  }
[ ... ]
> @@ -395,7 +401,7 @@ static int __init sclp_create_standby_mems_merged(str=
uct sclp_mem *sclp_mems,
>  		goto skip_add;
>  	for (addr =3D start; addr < start + size; addr +=3D block_size) {
>  		id =3D addr / block_size;
> -		rc =3D sclp_create_mem(&sclp_mems[id], kset, id, false,
> +		rc =3D sclp_create_mem(kset, id, false,
>  				     mhp_supports_memmap_on_memory());
>  		if (rc)
>  			break;
>  	}

[Severity: Medium]
If sclp_create_mem() fails and breaks out of this loop in
sclp_create_standby_mems_merged(), are the kobjects created in previous
iterations left registered? Should there be a centralized error cleanup
path to unwind and free these prior allocations?

>  skip_add:
>  	first_rn =3D rn;
>  	num =3D 1;
>  	return rc;
>  }
> =20
> -static int __init sclp_create_standby_mems(struct sclp_mem *sclp_mems, s=
truct kset *kset)
> +static int __init sclp_create_standby_mems(struct kset *kset)
>  {
>  	struct memory_increment *incr;
>  	int rc =3D 0;
> =20
>  	list_for_each_entry(incr, &sclp_mem_list, list) {
>  		if (incr->standby)
> -			rc =3D sclp_create_standby_mems_merged(sclp_mems, kset, incr->rn);
> +			rc =3D sclp_create_standby_mems_merged(kset, incr->rn);
>  		if (rc)
>  			return rc;
>  	}

[Severity: High]
When sclp_create_standby_mems_merged() returns an error, this loop in
sclp_create_standby_mems() returns directly. Could this leak all the
standby kobjects that were successfully created in earlier iterations of
the loop?

> -	return sclp_create_standby_mems_merged(sclp_mems, kset, 0);
> +	return sclp_create_standby_mems_merged(kset, 0);
>  }
> =20
>  static int __init sclp_init_mem(void)
>  {
> -	const unsigned long block_size =3D memory_block_size_bytes();
> -	unsigned int max_sclp_mems;
> -	struct sclp_mem *sclp_mems;
> -	struct sclp_mem_arg arg;
>  	struct kset *kset;
>  	int rc;
> =20
> -	max_sclp_mems =3D roundup(sclp.rnmax * sclp.rzm, block_size) / block_si=
ze;
> -	/* Allocate memory for all blocks ahead of time. */
> -	sclp_mems =3D kzalloc_objs(struct sclp_mem, max_sclp_mems);
> -	if (!sclp_mems)
> -		return -ENOMEM;
>  	kset =3D kset_create_and_add("memory", NULL, firmware_kobj);
>  	if (!kset)
>  		return -ENOMEM;
>  	/* Initial memory is in the "configured" state already. */
> -	arg.sclp_mems =3D sclp_mems;
> -	arg.kset =3D kset;
> -	rc =3D for_each_memory_block(&arg, sclp_create_configured_mem);
> +	rc =3D for_each_memory_block(kset, sclp_create_configured_mem);
>  	if (rc)
>  		return rc;

[Severity: High]
If for_each_memory_block() encounters an error during memory block
creation in sclp_init_mem(), returning directly here leaves the previously
created kset and any successfully configured memory kobjects registered.
Does this result in a permanent memory leak of these structures?

>  	/* Standby memory is "deconfigured". */
> -	return sclp_create_standby_mems(sclp_mems, kset);
> +	return sclp_create_standby_mems(kset);
>  }

[Severity: Medium]
Similarly, if sclp_create_standby_mems() fails later in sclp_init_mem(),
returning its error code directly leaves the kset and the initial
configured memory blocks leaked. Is an error handling path missing here to
clean up the kset and all child kobjects on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D8
