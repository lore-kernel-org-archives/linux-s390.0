Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3133 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGUdH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:33:07 -0400
Subject: Re: [PATCH 01/13] drm/exynos: Stop using frame_vector helpers
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-2-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <80718789-b3de-c30a-03c5-7c8cbf41f7d9@nvidia.com>
Date: Wed, 7 Oct 2020 13:32:55 -0700
MIME-Version: 1.0
In-Reply-To: <20201007164426.1812530-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

On 10/7/20 9:44 AM, Daniel Vetter wrote:
> All we need are a pages array, pin_user_pages_fast can give us that
> directly. Plus this avoids the entire raw pfn side of get_vaddr_frames.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> ---
>   drivers/gpu/drm/exynos/Kconfig          |  1 -
>   drivers/gpu/drm/exynos/exynos_drm_g2d.c | 48 ++++++++++++-------------
>   2 files changed, 22 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kcon=
fig
> index 6417f374b923..43257ef3c09d 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -88,7 +88,6 @@ comment "Sub-drivers"
>   config DRM_EXYNOS_G2D
>   	bool "G2D"
>   	depends on VIDEO_SAMSUNG_S5P_G2D=3Dn || COMPILE_TEST
> -	select FRAME_VECTOR
>   	help
>   	  Choose this option if you want to use Exynos G2D for DRM.
>  =20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_g2d.c
> index 967a5cdc120e..c83f6faac9de 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -205,7 +205,8 @@ struct g2d_cmdlist_userptr {
>   	dma_addr_t		dma_addr;
>   	unsigned long		userptr;
>   	unsigned long		size;
> -	struct frame_vector	*vec;
> +	struct page		**pages;
> +	unsigned int		npages;
>   	struct sg_table		*sgt;
>   	atomic_t		refcount;
>   	bool			in_pool;
> @@ -378,7 +379,7 @@ static void g2d_userptr_put_dma_addr(struct g2d_data =
*g2d,
>   					bool force)
>   {
>   	struct g2d_cmdlist_userptr *g2d_userptr =3D obj;
> -	struct page **pages;
> +	int i;

The above line can also be deleted, see below.

>  =20
>   	if (!obj)
>   		return;
> @@ -398,15 +399,11 @@ static void g2d_userptr_put_dma_addr(struct g2d_dat=
a *g2d,
>   	dma_unmap_sgtable(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt,
>   			  DMA_BIDIRECTIONAL, 0);
>  =20
> -	pages =3D frame_vector_pages(g2d_userptr->vec);
> -	if (!IS_ERR(pages)) {
> -		int i;
> +	for (i =3D 0; i < g2d_userptr->npages; i++)
> +		set_page_dirty_lock(g2d_userptr->pages[i]);
>  =20
> -		for (i =3D 0; i < frame_vector_count(g2d_userptr->vec); i++)
> -			set_page_dirty_lock(pages[i]);
> -	}
> -	put_vaddr_frames(g2d_userptr->vec);
> -	frame_vector_destroy(g2d_userptr->vec);
> +	unpin_user_pages(g2d_userptr->pages, g2d_userptr->npages);
> +	kvfree(g2d_userptr->pages);

You can avoid writing your own loop, and just simplify the whole thing down=
 to
two lines:

	unpin_user_pages_dirty_lock(g2d_userptr->pages, g2d_userptr->npages,
				    true);
	kvfree(g2d_userptr->pages);


>  =20
>   	if (!g2d_userptr->out_of_list)
>   		list_del_init(&g2d_userptr->list);
> @@ -474,35 +471,34 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct =
g2d_data *g2d,
>   	offset =3D userptr & ~PAGE_MASK;
>   	end =3D PAGE_ALIGN(userptr + size);
>   	npages =3D (end - start) >> PAGE_SHIFT;
> -	g2d_userptr->vec =3D frame_vector_create(npages);
> -	if (!g2d_userptr->vec) {
> +	g2d_userptr->pages =3D kvmalloc_array(npages, sizeof(*g2d_userptr->page=
s),
> +					    GFP_KERNEL);
> +	if (!g2d_userptr->pages) {
>   		ret =3D -ENOMEM;
>   		goto err_free;
>   	}
>  =20
> -	ret =3D get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
> -		g2d_userptr->vec);
> +	ret =3D pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
> +				  g2d_userptr->pages);
>   	if (ret !=3D npages) {
>   		DRM_DEV_ERROR(g2d->dev,
>   			      "failed to get user pages from userptr.\n");
>   		if (ret < 0)
> -			goto err_destroy_framevec;
> -		ret =3D -EFAULT;
> -		goto err_put_framevec;
> -	}
> -	if (frame_vector_to_pages(g2d_userptr->vec) < 0) {
> +			goto err_destroy_pages;
> +		npages =3D ret;
>   		ret =3D -EFAULT;
> -		goto err_put_framevec;
> +		goto err_unpin_pages;
>   	}
> +	g2d_userptr->npages =3D npages;
>  =20
>   	sgt =3D kzalloc(sizeof(*sgt), GFP_KERNEL);
>   	if (!sgt) {
>   		ret =3D -ENOMEM;
> -		goto err_put_framevec;
> +		goto err_unpin_pages;
>   	}
>  =20
>   	ret =3D sg_alloc_table_from_pages(sgt,
> -					frame_vector_pages(g2d_userptr->vec),
> +					g2d_userptr->pages,
>   					npages, offset, size, GFP_KERNEL);
>   	if (ret < 0) {
>   		DRM_DEV_ERROR(g2d->dev, "failed to get sgt from pages.\n");
> @@ -538,11 +534,11 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct =
g2d_data *g2d,
>   err_free_sgt:
>   	kfree(sgt);
>  =20
> -err_put_framevec:
> -	put_vaddr_frames(g2d_userptr->vec);
> +err_unpin_pages:
> +	unpin_user_pages(g2d_userptr->pages, npages);
>  =20
> -err_destroy_framevec:
> -	frame_vector_destroy(g2d_userptr->vec);
> +err_destroy_pages:
> +	kvfree(g2d_userptr->pages);
>  =20
>   err_free:
>   	kfree(g2d_userptr);
>=20

The rest all looks good, you've avoided the usual API pitfalls. :)

thanks,
--=20
John Hubbard
NVIDIA
