Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33908 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392614AbgJZWP0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Oct 2020 18:15:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id k21so6657182wmi.1
        for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2020 15:15:22 -0700 (PDT)
Date: Mon, 26 Oct 2020 22:15:20 +0000
From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v4 05/15] mm/frame-vector: Use FOLL_LONGTERM
Message-ID: <20201026221520.GC2802004@chromium.org>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201026105818.2585306-6-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201026105818.2585306-6-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

Hi Daniel,

On Mon, Oct 26, 2020 at 11:58:08AM +0100, Daniel Vetter wrote:
> This is used by media/videbuf2 for persistent dma mappings, not just
> for a single dma operation and then freed again, so needs
> FOLL_LONGTERM.
>=20
> Unfortunately current pup_locked doesn't support FOLL_LONGTERM due to
> locking issues. Rework the code to pull the pup path out from the
> mmap_sem critical section as suggested by Jason.
>=20
> By relying entirely on the vma checks in pin_user_pages and follow_pfn
> (for vm_flags and vma_is_fsdax) we can also streamline the code a lot.
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
> Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> --
> v2: Streamline the code and further simplify the loop checks (Jason)
> ---
>  mm/frame_vector.c | 50 ++++++++++++++---------------------------------
>  1 file changed, 15 insertions(+), 35 deletions(-)
>=20

Thank you for the patch. Please see my comments inline.

> diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> index 10f82d5643b6..d44779e56313 100644
> --- a/mm/frame_vector.c
> +++ b/mm/frame_vector.c
> @@ -38,7 +38,6 @@ int get_vaddr_frames(unsigned long start, unsigned int =
nr_frames,
>  	struct vm_area_struct *vma;
>  	int ret =3D 0;
>  	int err;
> -	int locked;
> =20
>  	if (nr_frames =3D=3D 0)
>  		return 0;
> @@ -48,40 +47,25 @@ int get_vaddr_frames(unsigned long start, unsigned in=
t nr_frames,
> =20
>  	start =3D untagged_addr(start);
> =20
> -	mmap_read_lock(mm);
> -	locked =3D 1;
> -	vma =3D find_vma_intersection(mm, start, start + 1);
> -	if (!vma) {
> -		ret =3D -EFAULT;
> -		goto out;
> -	}
> -
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
> -
> -	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> +	ret =3D pin_user_pages_fast(start, nr_frames,
> +				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  (struct page **)(vec->ptrs));
> +	if (ret > 0) {
>  		vec->got_ref =3D true;
>  		vec->is_pfns =3D false;
> -		ret =3D pin_user_pages_locked(start, nr_frames,
> -			gup_flags, (struct page **)(vec->ptrs), &locked);

Should we drop the gup_flags argument, since it's ignored now?

> -		goto out;
> +		goto out_unlocked;
>  	}
> =20

Should we initialize ret with 0 here, since pin_user_pages_fast() can
return a negative error code, but below we use it as a counter for the
looked up frames?

Best regards,
Tomasz

> +	mmap_read_lock(mm);
>  	vec->got_ref =3D false;
>  	vec->is_pfns =3D true;
>  	do {
>  		unsigned long *nums =3D frame_vector_pfns(vec);
> =20
> +		vma =3D find_vma_intersection(mm, start, start + 1);
> +		if (!vma)
> +			break;
> +
>  		while (ret < nr_frames && start + PAGE_SIZE <=3D vma->vm_end) {
>  			err =3D follow_pfn(vma, start, &nums[ret]);
>  			if (err) {
> @@ -92,17 +76,13 @@ int get_vaddr_frames(unsigned long start, unsigned in=
t nr_frames,
>  			start +=3D PAGE_SIZE;
>  			ret++;
>  		}
> -		/*
> -		 * We stop if we have enough pages or if VMA doesn't completely
> -		 * cover the tail page.
> -		 */
> -		if (ret >=3D nr_frames || start < vma->vm_end)
> +		/* Bail out if VMA doesn't completely cover the tail page. */
> +		if (start < vma->vm_end)
>  			break;
> -		vma =3D find_vma_intersection(mm, start, start + 1);
> -	} while (vma && vma->vm_flags & (VM_IO | VM_PFNMAP));
> +	} while (ret < nr_frames);
>  out:
> -	if (locked)
> -		mmap_read_unlock(mm);
> +	mmap_read_unlock(mm);
> +out_unlocked:
>  	if (!ret)
>  		ret =3D -EFAULT;
>  	if (ret > 0)
> --=20
> 2.28.0
>=20
