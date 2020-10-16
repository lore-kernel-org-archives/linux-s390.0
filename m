Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2836 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404682AbgJPHpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Oct 2020 03:45:17 -0400
Subject: Re: [PATCH v2 03/17] misc/habana: Stop using frame_vector helpers
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-4-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <13282062-f8d7-62e4-1ee8-9462ac056ed5@nvidia.com>
Date: Fri, 16 Oct 2020 00:45:15 -0700
MIME-Version: 1.0
In-Reply-To: <20201009075934.3509076-4-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Oded Gabbay <oded.gabbay@gmail.com>, Omer Shpigelman <oshpigelman@habana.ai>, Ofir Bitton <obitton@habana.ai>, Tomer Tayar <ttayar@habana.ai>, Moti Haimovski <mhaimovski@habana.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Piskorski <ppiskorski@habana.ai>

On 10/9/20 12:59 AM, Daniel Vetter wrote:
> All we need are a pages array, pin_user_pages_fast can give us that
> directly. Plus this avoids the entire raw pfn side of get_vaddr_frames.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Omer Shpigelman <oshpigelman@habana.ai>
> Cc: Ofir Bitton <obitton@habana.ai>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Cc: Moti Haimovski <mhaimovski@habana.ai>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pawel Piskorski <ppiskorski@habana.ai>
> --
> v2: Use unpin_user_pages_dirty_lock (John)
> ---
>   drivers/misc/habanalabs/Kconfig             |  1 -
>   drivers/misc/habanalabs/common/habanalabs.h |  3 +-
>   drivers/misc/habanalabs/common/memory.c     | 49 ++++++++-------------
>   3 files changed, 20 insertions(+), 33 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA

>=20
> diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kc=
onfig
> index 8eb5d38c618e..2f04187f7167 100644
> --- a/drivers/misc/habanalabs/Kconfig
> +++ b/drivers/misc/habanalabs/Kconfig
> @@ -6,7 +6,6 @@
>   config HABANA_AI
>   	tristate "HabanaAI accelerators (habanalabs)"
>   	depends on PCI && HAS_IOMEM
> -	select FRAME_VECTOR
>   	select DMA_SHARED_BUFFER
>   	select GENERIC_ALLOCATOR
>   	select HWMON
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/h=
abanalabs/common/habanalabs.h
> index edbd627b29d2..c1b3ad613b15 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -881,7 +881,8 @@ struct hl_ctx_mgr {
>   struct hl_userptr {
>   	enum vm_type_t		vm_type; /* must be first */
>   	struct list_head	job_node;
> -	struct frame_vector	*vec;
> +	struct page		**pages;
> +	unsigned int		npages;
>   	struct sg_table		*sgt;
>   	enum dma_data_direction dir;
>   	struct list_head	debugfs_list;
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/haban=
alabs/common/memory.c
> index 5ff4688683fd..327b64479f97 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -1281,45 +1281,41 @@ static int get_user_memory(struct hl_device *hdev=
, u64 addr, u64 size,
>   		return -EFAULT;
>   	}
>  =20
> -	userptr->vec =3D frame_vector_create(npages);
> -	if (!userptr->vec) {
> +	userptr->pages =3D kvmalloc_array(npages, sizeof(*userptr->pages),
> +					GFP_KERNEL);
> +	if (!userptr->pages) {
>   		dev_err(hdev->dev, "Failed to create frame vector\n");
>   		return -ENOMEM;
>   	}
>  =20
> -	rc =3D get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
> -				userptr->vec);
> +	rc =3D pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
> +				 userptr->pages);
>  =20
>   	if (rc !=3D npages) {
>   		dev_err(hdev->dev,
>   			"Failed to map host memory, user ptr probably wrong\n");
>   		if (rc < 0)
> -			goto destroy_framevec;
> +			goto destroy_pages;
> +		npages =3D rc;
>   		rc =3D -EFAULT;
> -		goto put_framevec;
> -	}
> -
> -	if (frame_vector_to_pages(userptr->vec) < 0) {
> -		dev_err(hdev->dev,
> -			"Failed to translate frame vector to pages\n");
> -		rc =3D -EFAULT;
> -		goto put_framevec;
> +		goto put_pages;
>   	}
> +	userptr->npages =3D npages;
>  =20
>   	rc =3D sg_alloc_table_from_pages(userptr->sgt,
> -					frame_vector_pages(userptr->vec),
> -					npages, offset, size, GFP_ATOMIC);
> +				       userptr->pages,
> +				       npages, offset, size, GFP_ATOMIC);
>   	if (rc < 0) {
>   		dev_err(hdev->dev, "failed to create SG table from pages\n");
> -		goto put_framevec;
> +		goto put_pages;
>   	}
>  =20
>   	return 0;
>  =20
> -put_framevec:
> -	put_vaddr_frames(userptr->vec);
> -destroy_framevec:
> -	frame_vector_destroy(userptr->vec);
> +put_pages:
> +	unpin_user_pages(userptr->pages, npages);
> +destroy_pages:
> +	kvfree(userptr->pages);
>   	return rc;
>   }
>  =20
> @@ -1405,8 +1401,6 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 =
addr, u64 size,
>    */
>   void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *us=
erptr)
>   {
> -	struct page **pages;
> -
>   	hl_debugfs_remove_userptr(hdev, userptr);
>  =20
>   	if (userptr->dma_mapped)
> @@ -1414,15 +1408,8 @@ void hl_unpin_host_memory(struct hl_device *hdev, =
struct hl_userptr *userptr)
>   							userptr->sgt->nents,
>   							userptr->dir);
>  =20
> -	pages =3D frame_vector_pages(userptr->vec);
> -	if (!IS_ERR(pages)) {
> -		int i;
> -
> -		for (i =3D 0; i < frame_vector_count(userptr->vec); i++)
> -			set_page_dirty_lock(pages[i]);
> -	}
> -	put_vaddr_frames(userptr->vec);
> -	frame_vector_destroy(userptr->vec);
> +	unpin_user_pages_dirty_lock(userptr->pages, userptr->npages, true);
> +	kvfree(userptr->pages);
>  =20
>   	list_del(&userptr->job_node);
>  =20
>=20
