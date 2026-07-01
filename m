Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05F367297;
	Wed,  1 Jul 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923180; cv=none; b=azUAbeJDqHVEGcR8tNgbzioPCJTcxCvyPkK75pdgppjzF8k1P52LWZEBq2qUXEcT1ueNgaVlN5shAAfcgTSEgrfaZoZfH/nO6ZawgPaqszDwWLLLPx0bXG9UyoYtbxaWJKWBdLpoRuyOYORadR7gkelLjEURx5xU0KKRCxGZBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923180; c=relaxed/simple;
	bh=WS8CNWqtZAvhA526nlTpDpwPeek1jVaTpJ3nCSElGIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZAkJLMd9JCfGNYtqN+Ywdb1Vi2V/rAY8faTrLNyYGC9O79t2EBiE5+hxb7dPXV7QScD+2QDIAr/UDO8WHASzYiXzpPOFi0u4gjkYbSXSXOlTsr2U9U05/Y2hubLrTDueq/OXl+SHH38d47COJUz4cfuqgAZUw/4XZNi05Racxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3oqTAy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3oqTAy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB951F000E9;
	Wed,  1 Jul 2026 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923177;
	bh=AqRo63/AfknCvA0T9i5Cc9P03ARt2N8Pz8OhVye1u88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3oqTAy2W3g0B8KJkigX8hbEFmqfOi+JzKmArn3FXiwmLCbGYePPTOOqMm6iJFqEJ
	 SkeAKkpbpjVpaRRLh1IpqZb/qZ87Awq+HuQxE/CmPdxs2ouALRPK1XBH4vXkv/GIxg
	 YAN45Cpomyi5NT74YsgWLoh0UXkvX6VuA6Gi4cP5JGWtEQs6Dc9Zm/vnyc1sEM1usP
	 oAG35JoS0F/ufBjvCYh6JE9WBPbGqJ0PM1hgeKc33ZEqdtZgl7LXuJjdHiSnu+VTc2
	 QrTVRKCbvKc9W75tDJdcMTUH15agiAPpW2STrzV5D+hyK8cBNkRWtj9UMMqt33u7/B
	 mNaSj8dAI+lPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, robh@kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:26:16 +0000
Message-Id: <20260701162616.8EB951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] cma_free() causes a double free and memory corruption by incor=
rectly calling free_reserved_page() on pages actively managed by the buddy =
allocator.
- [High] Compilation fails when CONFIG_CMA_SYSFS=3Dy or CONFIG_CMA_DEBUGFS=
=3Dy because cma_areas was changed from an exported array to a static list.
- [High] cma_create() ignores cma_activate_area() failures, allowing silent=
ly broken CMA objects into the list, causing a kernel panic in cma_free().
- [High] Time-of-Check to Time-of-Use (TOCTOU) race in cma_free() allows co=
ncurrent allocations to be erroneously ripped away.
- [Medium] Incorrect teardown ordering in cma_free() allows concurrent list=
 iterators to access a destroyed object.
- [Medium] Name collision for all unnamed early CMA areas and a lockless tr=
acking race for dynamic areas.
- [Medium] cma_create() is strictly annotated with __init, breaking its sta=
ted purpose to allow runtime dynamic creation.
- [Low] The patch removes the decrement of totalcma_pages in the cma_activa=
te_area() error path, permanently leaking the accounting.
--

commit cddc1d630ad599e76103540b31f303767b8a5454
Author: Thierry Reding <treding@nvidia.com>

mm/cma: Allow dynamically creating CMA areas
   =20
There is no technical reason why there should be a limited number of CMA
regions, so extract some code into helpers and use them to create extra
functions (cma_create() and cma_free()) that allow creating and freeing,
respectively, CMA regions dynamically at runtime.
   =20
The static array of CMA areas cannot be replaced by dynamically created
areas because for many of them, allocation must not fail and some cases
may need to initialize them before the slab allocator is even available.
To account for this, keep these "early" areas in a separate list and
track the dynamic areas in a separate list.

> diff --git a/mm/cma.c b/mm/cma.c
> index a13ce4999b39f..f989e2e98594f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -34,7 +34,12 @@
>  #include "internal.h"
>  #include "cma.h"
> =20
> -struct cma cma_areas[MAX_CMA_AREAS];
> +static DEFINE_MUTEX(cma_lock);
> +
> +struct cma cma_early_areas[MAX_EARLY_CMA_AREAS];
> +unsigned int cma_early_area_count;
> +
> +static LIST_HEAD(cma_areas);
>  unsigned int cma_area_count;

[Severity: High]
This patch changes cma_areas from an exported array to a static list, and
stops exposing cma_area_count. Were mm/cma_sysfs.c and mm/cma_debug.c missed
during this conversion?

For example, cma_sysfs_init() in mm/cma_sysfs.c still does:

    for (i =3D 0; i < cma_area_count; i++) {
        cma =3D &cma_areas[i];

Does this cause compilation failures when CONFIG_CMA_SYSFS=3Dy or
CONFIG_CMA_DEBUGFS=3Dy are enabled?

[ ... ]

> @@ -198,7 +203,6 @@ static void __init cma_activate_area(struct cma *cma)
>  				free_reserved_page(pfn_to_page(pfn));
>  		}
>  	}
> -	totalcma_pages -=3D cma->count;

[Severity: Low]
Is it intended to remove this decrement? If an early area fails to activate,
it appears the global totalcma_pages variable will remain artificially
inflated forever, corrupting CmaTotal statistics.

>  	cma->available_count =3D cma->count =3D 0;
>  	pr_err("CMA area %s could not be activated\n", cma->name);
>  }

[ ... ]

> @@ -219,41 +223,77 @@ void __init cma_reserve_pages_on_error(struct cma *=
cma)
>  	set_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags);
>  }
> =20
> +static void __init cma_init_area(struct cma *cma, const char *name,
> +				 phys_addr_t size, unsigned int order_per_bit)
> +{
> +	if (name)
> +		strscpy(cma->name, name);
> +	else
> +		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);

[Severity: Medium]
Will this use the correct counter for early areas? Since early areas now
correctly increment cma_early_area_count, cma_area_count will remain strict=
ly
at 0 throughout early boot. Will all unnamed early areas be assigned the
exact same name ('cma0\n'), potentially causing kobject registration
collisions?

Also, when cma_create() calls this locklessly, can concurrent dynamic creat=
ions
read the same cma_area_count and generate duplicate names?

> +
> +	cma->available_count =3D cma->count =3D size >> PAGE_SHIFT;
> +	cma->order_per_bit =3D order_per_bit;
> +
> +	INIT_LIST_HEAD(&cma->node);
> +}

[ ... ]

> @@ -1147,3 +1193,74 @@ void __init *cma_reserve_early(struct cma *cma, un=
signed long size)
> =20
>  	return ret;
>  }
> +
> +struct cma *__init cma_create(phys_addr_t base, phys_addr_t size,
> +			      unsigned int order_per_bit, const char *name)

[Severity: Medium]
The commit message states the goal is to allow creating regions dynamically=
 at
runtime. Does the __init annotation here and on cma_check_memory() prevent
that?=20

If a subsystem attempts to use this API dynamically at true runtime, won't =
it
branch into freed memory since the kernel permanently discards .init.text
after early boot?

> +{
> +	struct cma *cma;
> +	int ret;
> +
> +	ret =3D cma_check_memory(base, size);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	cma =3D kzalloc_obj(*cma, GFP_KERNEL);
> +	if (!cma)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cma_init_area(cma, name, size, order_per_bit);
> +	cma->ranges[0].base_pfn =3D PFN_DOWN(base);
> +	cma->ranges[0].early_pfn =3D PFN_DOWN(base);
> +	cma->ranges[0].count =3D cma->count;
> +	cma->nranges =3D 1;
> +
> +	cma_activate_area(cma);
> +
> +	mutex_lock(&cma_lock);
> +	list_add_tail(&cma->node, &cma_areas);

[Severity: High]
cma_activate_area() returns void, so any failures inside it cannot be check=
ed
here. If activation fails, cma_activate_area() frees the partial bitmaps and
zeroes cma->count, but leaves cmr->count intact.=20

Does adding this potentially broken object to the list cause a kernel panic
later if cma_free() is called on it? cma_free() would calculate nbits from
the unmodified cmr->count and call bitmap_empty() with a freed bitmap point=
er.

> +	totalcma_pages +=3D cma->count;
> +	cma_area_count++;
> +	mutex_unlock(&cma_lock);
> +
> +	return cma;
> +}
> +
> +void cma_free(struct cma *cma)
> +{
> +	unsigned int i;
> +
> +	/*
> +	 * Safety check to prevent a CMA with active allocations from being
> +	 * released.
> +	 */
> +	for (i =3D 0; i < cma->nranges; i++) {
> +		unsigned long nbits =3D cma_bitmap_maxno(cma, &cma->ranges[i]);
> +
> +		if (!bitmap_empty(cma->ranges[i].bitmap, nbits)) {
> +			WARN(1, "%s: range %u not empty\n", cma->name, i);
> +			return;
> +		}

[Severity: High]
Does this lockless emptiness check suffer from a Time-of-Check to Time-of-U=
se
(TOCTOU) race?=20

Because the check doesn't hold cma->alloc_mutex or cma->lock, couldn't a
concurrent cma_alloc() successfully acquire the mutex and allocate pages fr=
om
this region immediately after the lockless emptiness check succeeds?

> +	}
> +
> +	/* free reserved pages and the bitmap */
> +	for (i =3D 0; i < cma->nranges; i++) {
> +		struct cma_memrange *cmr =3D &cma->ranges[i];
> +		unsigned long end_pfn, pfn;
> +
> +		end_pfn =3D cmr->base_pfn + cmr->count;
> +		for (pfn =3D cmr->base_pfn; pfn < end_pfn; pfn++)
> +			free_reserved_page(pfn_to_page(pfn));

[Severity: Critical]
Will this loop cause a double free and memory corruption?

Successfully activated CMA pages are unreserved via
init_cma_reserved_pageblock(), which clears PG_reserved and hands them to t=
he
buddy allocator. If free_reserved_page() is called on pages that are active=
ly
managed by the buddy allocator or in use by callers, won't it reset the page
refcount and explicitly call __free_page() again, corrupting the buddy
allocator's free lists?

> +
> +		bitmap_free(cmr->bitmap);
> +	}
> +
> +	mutex_destroy(&cma->alloc_mutex);
> +
> +	mutex_lock(&cma_lock);
> +	totalcma_pages -=3D cma->count;
> +	list_del(&cma->node);

[Severity: Medium]
Is it safe to destroy cma->alloc_mutex and free the bitmaps before unlinking
the object from the global cma_areas list?

If a concurrent thread is executing cma_for_each_area(), it traverses the l=
ist
under cma_lock and might obtain a pointer to a struct cma that is midway
through teardown, potentially accessing a destroyed mutex or freed bitmaps.
Should the unlinking happen before the resources are destroyed?

> +	cma_area_count--;
> +	mutex_unlock(&cma_lock);
> +
> +	kfree(cma);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D6
