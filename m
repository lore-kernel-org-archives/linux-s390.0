Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391636AbgJZWCL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Oct 2020 18:02:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c194so13164070wme.2
        for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2020 15:02:09 -0700 (PDT)
Date: Mon, 26 Oct 2020 22:02:06 +0000
From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v4 09/15] media/videbuf1|2: Mark follow_pfn usage as
 unsafe
Message-ID: <20201026220206.GA2802004@chromium.org>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201026105818.2585306-10-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201026105818.2585306-10-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Laurent Dufour <ldufour@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Daniel Jordan <daniel.m.jordan@oracle.com>, Michel Lespinasse <walken@google.com>

Hi Daniel,

On Mon, Oct 26, 2020 at 11:58:12AM +0100, Daniel Vetter wrote:
> The media model assumes that buffers are all preallocated, so that
> when a media pipeline is running we never miss a deadline because the
> buffers aren't allocated or available.
>=20
> This means we cannot fix the v4l follow_pfn usage through
> mmu_notifier, without breaking how this all works. The only real fix
> is to deprecate userptr support for VM_IO | VM_PFNMAP mappings and
> tell everyone to cut over to dma-buf memory sharing for zerocopy.
>=20
> userptr for normal memory will keep working as-is, this only affects
> the zerocopy userptr usage enabled in 50ac952d2263 ("[media]
> videobuf2-dma-sg: Support io userptr operations on io memory").

Note that this is true only for the videobuf2 change. The videobuf1 code
was like this all the time and does not support normal memory in the
dma_contig variant (because normal memory is rarely physically contiguous).

If my understanding is correct that the CONFIG_STRICT_FOLLOW_PFN is not
enabled by default, we stay backwards compatible, with only whoever
decides to turn it on risking a breakage.

I agree that this is a good first step towards deprecating this legacy
code, so:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Of course the last word goes to Mauro. :)

Best regards,
Tomasz

>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Michel Lespinasse <walken@google.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> --
> v3:
> - Reference the commit that enabled the zerocopy userptr use case to
>   make it abundandtly clear that this patch only affects that, and not
>   normal memory userptr. The old commit message already explained that
>   normal memory userptr is unaffected, but I guess that was not clear
>   enough.
> ---
>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/medi=
a/common/videobuf2/frame_vector.c
> index 6590987c14bd..e630494da65c 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -69,7 +69,7 @@ int get_vaddr_frames(unsigned long start, unsigned int =
nr_frames,
>  			break;
> =20
>  		while (ret < nr_frames && start + PAGE_SIZE <=3D vma->vm_end) {
> -			err =3D follow_pfn(vma, start, &nums[ret]);
> +			err =3D unsafe_follow_pfn(vma, start, &nums[ret]);
>  			if (err) {
>  				if (ret =3D=3D 0)
>  					ret =3D err;
> diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/medi=
a/v4l2-core/videobuf-dma-contig.c
> index 52312ce2ba05..821c4a76ab96 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-contig.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
> @@ -183,7 +183,7 @@ static int videobuf_dma_contig_user_get(struct videob=
uf_dma_contig_memory *mem,
>  	user_address =3D untagged_baddr;
> =20
>  	while (pages_done < (mem->size >> PAGE_SHIFT)) {
> -		ret =3D follow_pfn(vma, user_address, &this_pfn);
> +		ret =3D unsafe_follow_pfn(vma, user_address, &this_pfn);
>  		if (ret)
>  			break;
> =20
> --=20
> 2.28.0
>=20
