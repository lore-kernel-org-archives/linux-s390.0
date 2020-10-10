Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 10 Oct 2020 11:24:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 10/17] media/videbuf1|2: Mark follow_pfn usage as
 unsafe
Message-ID: <20201010112416.4259249a@coco.lan>
In-Reply-To: <20201009075934.3509076-11-daniel.vetter@ffwll.ch>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
        <20201009075934.3509076-11-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tfiga@chromium.org>, Laurent Dufour <ldufour@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Daniel Jordan <daniel.m.jordan@oracle.com>, Michel Lespinasse <walken@google.com>

Em Fri,  9 Oct 2020 09:59:27 +0200
Daniel Vetter <daniel.vetter@ffwll.ch> escreveu:

> The media model assumes that buffers are all preallocated, so that
> when a media pipeline is running we never miss a deadline because the
> buffers aren't allocated or available.
>=20
> This means we cannot fix the v4l follow_pfn usage through
> mmu_notifier, without breaking how this all works. The only real fix
> is to deprecate userptr support for VM_IO | VM_PFNMAP mappings and
> tell everyone to cut over to dma-buf memory sharing for zerocopy.
>=20
> userptr for normal memory will keep working as-is.

I won't repeat here the discussions for patch 09/17, but
just to be clear about this one:

NACK.

We need a better alternative to avoid breaking existing
media applications.

>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
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
> ---
>  drivers/media/common/videobuf2/frame_vector.c | 2 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/medi=
a/common/videobuf2/frame_vector.c
> index 2b0b97761d15..a1b85fe9e7c1 100644
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



Thanks,
Mauro
