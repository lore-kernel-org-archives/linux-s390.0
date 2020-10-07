Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 05/13] mm/frame-vector: Use FOLL_LONGTERM
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-6-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <fc0ac3fb-2758-bef1-76b4-8ac2449f5743@nvidia.com>
Date: Wed, 7 Oct 2020 14:13:42 -0700
MIME-Version: 1.0
In-Reply-To: <20201007164426.1812530-6-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

On 10/7/20 9:44 AM, Daniel Vetter wrote:
> This is used by media/videbuf2 for persistent dma mappings, not just
> for a single dma operation and then freed again, so needs
> FOLL_LONGTERM.
>=20
> Unfortunately current pup_locked doesn't support FOLL_LONGTERM due to
> locking issues. Rework the code to pull the pup path out from the
> mmap_sem critical section as suggested by Jason.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
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
>   mm/frame_vector.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> index 10f82d5643b6..39db520a51dc 100644
> --- a/mm/frame_vector.c
> +++ b/mm/frame_vector.c
> @@ -38,7 +38,6 @@ int get_vaddr_frames(unsigned long start, unsigned int =
nr_frames,
>   	struct vm_area_struct *vma;
>   	int ret =3D 0;
>   	int err;
> -	int locked;
>  =20
>   	if (nr_frames =3D=3D 0)
>   		return 0;
> @@ -48,35 +47,22 @@ int get_vaddr_frames(unsigned long start, unsigned in=
t nr_frames,
>  =20
>   	start =3D untagged_addr(start);
>  =20
> +	ret =3D pin_user_pages_fast(start, nr_frames,
> +				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  (struct page **)(vec->ptrs));
> +	if (ret > 0) {
> +		vec->got_ref =3D true;
> +		vec->is_pfns =3D false;
> +		goto out_unlocked;
> +	}

This part looks good, and changing to _fast is a potential performance impr=
ovement,
too.

> +
>   	mmap_read_lock(mm);
> -	locked =3D 1;
>   	vma =3D find_vma_intersection(mm, start, start + 1);
>   	if (!vma) {
>   		ret =3D -EFAULT;
>   		goto out;
>   	}
>  =20
> -	/*
> -	 * While get_vaddr_frames() could be used for transient (kernel
> -	 * controlled lifetime) pinning of memory pages all current
> -	 * users establish long term (userspace controlled lifetime)
> -	 * page pinning. Treat get_vaddr_frames() like
> -	 * get_user_pages_longterm() and disallow it for filesystem-dax
> -	 * mappings.
> -	 */
> -	if (vma_is_fsdax(vma)) {
> -		ret =3D -EOPNOTSUPP;
> -		goto out;
> -	}

Are you sure we don't need to check vma_is_fsdax() anymore?

> -
> -	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> -		vec->got_ref =3D true;
> -		vec->is_pfns =3D false;
> -		ret =3D pin_user_pages_locked(start, nr_frames,
> -			gup_flags, (struct page **)(vec->ptrs), &locked);
> -		goto out;
> -	}
> -
>   	vec->got_ref =3D false;
>   	vec->is_pfns =3D true;
>   	do {
> @@ -101,8 +87,8 @@ int get_vaddr_frames(unsigned long start, unsigned int=
 nr_frames,
>   		vma =3D find_vma_intersection(mm, start, start + 1);
>   	} while (vma && vma->vm_flags & (VM_IO | VM_PFNMAP));
>   out:
> -	if (locked)
> -		mmap_read_unlock(mm);
> +	mmap_read_unlock(mm);
> +out_unlocked:
>   	if (!ret)
>   		ret =3D -EFAULT;
>   	if (ret > 0)
>=20

All of the error handling still looks accurate there.

thanks,
--=20
John Hubbard
NVIDIA
