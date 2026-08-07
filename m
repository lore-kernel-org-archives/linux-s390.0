Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060DEEB3;
	Fri,  7 Aug 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119368; cv=none; b=It0x5u8e03CEXnDiW+2ZeT310YUZhCzRqvTlfj4qEWQANUFsPzRZCuiWaK1/r+TPCLULa5GUzp2NDJRtwIzjdWCH2tO6sgYx03hHPHXHeWFJ5A2kPK4JqZwmMkb62emyzi6ypr5/eqzW+QvZxy6Czg06NUNaDdw0lB7LK56OGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119368; c=relaxed/simple;
	bh=WZULOT6KVP3AQsi0pE1n5c4yQGRM4RWcdxDfNqlzAjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YM5T4ZmXEaWUYrtgjMr1E0Qu43VTbE6aNVDwu7Q4ACD7KijNHUrk8CzH3BuYoujMahehIpPyG5yR4SJ60SYMUWtnosaVfQpnNEIKjoJ4dzYGan5yJfhWzeDx4laPsrJrCK/3pYmgV3y0v2tcEIG6OoGoJLnho0bSkLbqjU76TA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRcNYgh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRcNYgh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B201F000E9;
	Fri,  7 Aug 2026 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119360;
	bh=e8vwAl9ehbANYvaUVmaaVX/+zN9/HZBWlrU/nhLOhoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRcNYgh1rQYqPMKKkCUH4ldzt6RUpq4JslvRqmCUcyr15rTFqjSrOEXzmF74+zGK8
	 1x+BDZAr/r+QfAwCeIcuQjsYtzMB9fAAY5qVKLl9weqYyjYaTAHOUaYIMqK6511acG
	 7GmZjr1uTeM/hGxd0Y19hrhIyJ8v159f8GBlQfBMiHB/XDpuo87rXfWM6g09BM+iYe
	 XUvYHOAYzyK5VuNEjSZAUV0IoggObtnBSrPkeeN5xyt4ecTxlaknCem3Xe/TQZgbmO
	 4E/+2OsfcPZ3KcxN2K5ynToifdbQ5yHvgZjMiBz5CujY2dOGiV4eCEQkj4nXTiJcCZ
	 VvTQoB/feMP3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] mm/cma: Allow dynamically creating CMA areas
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, devicetree@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-5-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-5-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:15:59 +0000
Message-Id: <20260807161600.60B201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] cma_free() double-frees pages into the buddy allocator, causin=
g memory corruption.
- [High] cma_create() ignores the return value of cma_activate_area(), publ=
ishing broken and partially-initialized CMA areas.
- [High] cma_create() relies on memblock_is_region_reserved() at runtime, w=
hich is discarded after early boot.
- [High] cma_for_each_area() only iterates over dynamic areas, breaking API=
s relying on scanning all CMA areas.
- [High] cma_free() checks if the CMA area is empty without holding the all=
ocation mutex, leading to a TOCTOU race with concurrent allocations.
- [Medium] totalcma_pages is permanently inflated if an early CMA area fail=
s to activate.
- [Medium] cma_create() fails to initialize cma->nid, defaulting it to 0 an=
d potentially breaking zone validation on NUMA systems.
- [Low] Dynamically created CMA areas are missing from sysfs and debugfs in=
terfaces.
--

--- Patch [5]: [PATCH v4 05/10] mm/cma: Allow dynamically creating CMA area=
s ---
commit ef1094abdd1bc24a286e7eaebd2724d471aebbfd
Author: Thierry Reding <treding@nvidia.com>

mm/cma: Allow dynamically creating CMA areas

This patch introduces cma_create() and cma_free() to allow dynamically=20
creating and freeing CMA regions at runtime. It separates static early area=
s=20
from dynamically allocated ones into different tracking structures.

> diff --git a/mm/cma.c b/mm/cma.c
> index a7929c758df15..8d8fe7c82ae5b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
[ ... ]
> @@ -198,19 +207,24 @@ static void __init cma_activate_area(struct cma *cm=
a)
>  			end_pfn =3D cmr->base_pfn + cmr->count;
>  			for (pfn =3D start_pfn; pfn < end_pfn; pfn++)
>  				free_reserved_page(pfn_to_page(pfn));
> +
> +			/* reset these so we don't later confuse cma_free() */
> +			cmr->bitmap =3D NULL;
> +			cmr->count =3D 0;
>  		}
>  	}
> -	totalcma_pages -=3D cma->count;
>  	cma->available_count =3D cma->count =3D 0;
>  	pr_err("CMA area %s could not be activated\n", cma->name);
> +
> +	return err;
>  }

[Severity: Medium]
Does this removal leave totalcma_pages permanently inflated if an early boot
area fails to activate? Early areas still have their page count added during
cma_new_area() prior to activation.

[ ... ]
> @@ -221,41 +235,85 @@ void __init cma_reserve_pages_on_error(struct cma *=
cma)
[ ... ]
> +static int cma_check_memory(phys_addr_t base, phys_addr_t size)
> +{
> +	if (!size || !memblock_is_region_reserved(base, size))
> +		return -EINVAL;

[Severity: High]
Is it safe to call memblock_is_region_reserved() from cma_create() at runti=
me?
Since memblock_is_region_reserved() and memblock data structures are marked
__init_memblock, won't they be discarded after early boot on architectures
without CONFIG_ARCH_KEEP_MEMBLOCK, leading to a use-after-free?

[ ... ]
> @@ -1053,12 +1098,12 @@ bool cma_release_frozen(struct cma *cma, const st=
ruct page *pages,
[ ... ]
> +int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
> +{
> +	struct cma *cma;
> +
> +	mutex_lock(&cma_lock);
> +
> +	list_for_each_entry(cma, &cma_areas, node) {

[Severity: High]
Since cma_areas only contains dynamically created regions, will callers of
cma_for_each_area() now silently skip all standard early-boot CMA areas?

[ ... ]
> @@ -1149,3 +1213,78 @@ void __init *cma_reserve_early(struct cma *cma, un=
signed long size)
[ ... ]
> +struct cma *cma_create(phys_addr_t base, phys_addr_t size,
> +		       unsigned int order_per_bit, const char *name)
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

[Severity: Medium]
Should cma->nid be initialized to NUMA_NO_NODE here? Since kzalloc_obj()
leaves it as 0, could this cause pfn_range_intersects_zones() to validate
against Node 0 instead of the correct node, potentially bypassing NUMA zone
overlap checks?

> +
> +	mutex_lock(&cma_lock);
> +
> +	cma_init_area(cma, name, size, order_per_bit, true);
> +	cma->ranges[0].base_pfn =3D PFN_DOWN(base);
> +	cma->ranges[0].early_pfn =3D PFN_DOWN(base);
> +	cma->ranges[0].count =3D cma->count;
> +	cma->nranges =3D 1;
> +
> +	cma_activate_area(cma);
> +
> +	list_add_tail(&cma->node, &cma_areas);

[Severity: High]
What happens if cma_activate_area() fails (e.g., due to an -ENOMEM during
bitmap allocation)? The error code is discarded, and the partially-initiali=
zed
cma object (with uninitialized mutexes and locks) is added to the global
cma_areas list. Could this cause crashes when the caller or other subsystems
try to use or free it?

> +	totalcma_pages +=3D cma->count;
> +	cma_area_count++;
> +
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
> +		if (nbits && !bitmap_empty(cma->ranges[i].bitmap, nbits)) {
> +			WARN(1, "%s: range %u not empty\n", cma->name, i);
> +			return;
> +		}
> +	}

[Severity: High]
Can a concurrent thread successfully allocate from this CMA area right after
the bitmap_empty() check completes? The check is performed outside of
cma->alloc_mutex, so a race could lead to destroying the mutex and freeing
the underlying memory while it is actively being allocated.

> +
> +	mutex_lock(&cma_lock);
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
Does this loop double-free pages into the buddy allocator? When
cma_activate_area() is initially called, it invokes
init_cma_reserved_pageblock() which clears the PageReserved flag and inserts
the memory into the buddy allocator. If cma_free() later iterates over these
pages and calls free_reserved_page(), won't that blindly call __free_pages()
on pages already managed by the buddy allocator, corrupting the free lists?

[ ... ]
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index 523ba4a0f9f76..548b0157e7b5a 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -204,9 +204,9 @@ static int __init cma_debugfs_init(void)
> =20
>  	cma_debugfs_root =3D debugfs_create_dir("cma", NULL);
> =20
> -	for (i =3D 0; i < cma_area_count; i++)
> -		if (test_bit(CMA_ACTIVATED, &cma_areas[i].flags))
> -			cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
> +	for (i =3D 0; i < cma_early_area_count; i++)
> +		if (test_bit(CMA_ACTIVATED, &cma_early_areas[i].flags))
> +			cma_debugfs_add_one(&cma_early_areas[i], cma_debugfs_root);

[Severity: Low]
Since sysfs and debugfs initialization now strictly iterate over
cma_early_areas during boot, are dynamically created CMA areas intentionally
excluded from these interfaces?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D5
