Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2020 18:57:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 06/17] media: videobuf2: Move frame_vector into media
 subsystem
Message-ID: <20201009165740.GP438822@phenom.ffwll.local>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-7-daniel.vetter@ffwll.ch>
 <20201009121417.115db7d9@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201009121417.115db7d9@coco.lan>
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tfiga@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

On Fri, Oct 09, 2020 at 12:14:17PM +0200, Mauro Carvalho Chehab wrote:
> Em Fri,  9 Oct 2020 09:59:23 +0200
> Daniel Vetter <daniel.vetter@ffwll.ch> escreveu:
>=20
> > It's the only user. This also garbage collects the CONFIG_FRAME_VECTOR
> > symbol from all over the tree (well just one place, somehow omap media
> > driver still had this in its Kconfig, despite not using it).
> >=20
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Pawel Osciak <pawel@osciak.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomasz Figa <tfiga@chromium.org>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-media@vger.kernel.org
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/media/common/videobuf2/Kconfig        |  1 -
> >  drivers/media/common/videobuf2/Makefile       |  1 +
> >  .../media/common/videobuf2}/frame_vector.c    |  2 +
> >  drivers/media/platform/omap/Kconfig           |  1 -
> >  include/linux/mm.h                            | 42 -------------------
> >  include/media/videobuf2-core.h                | 42 +++++++++++++++++++
> >  mm/Kconfig                                    |  3 --
> >  mm/Makefile                                   |  1 -
> >  8 files changed, 45 insertions(+), 48 deletions(-)
> >  rename {mm =3D> drivers/media/common/videobuf2}/frame_vector.c (99%)
> >=20
> > diff --git a/drivers/media/common/videobuf2/Kconfig b/drivers/media/com=
mon/videobuf2/Kconfig
> > index edbc99ebba87..d2223a12c95f 100644
> > --- a/drivers/media/common/videobuf2/Kconfig
> > +++ b/drivers/media/common/videobuf2/Kconfig
> > @@ -9,7 +9,6 @@ config VIDEOBUF2_V4L2
> > =20
> >  config VIDEOBUF2_MEMOPS
> >  	tristate
> > -	select FRAME_VECTOR
> > =20
> >  config VIDEOBUF2_DMA_CONTIG
> >  	tristate
> > diff --git a/drivers/media/common/videobuf2/Makefile b/drivers/media/co=
mmon/videobuf2/Makefile
> > index 77bebe8b202f..54306f8d096c 100644
> > --- a/drivers/media/common/videobuf2/Makefile
> > +++ b/drivers/media/common/videobuf2/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  videobuf2-common-objs :=3D videobuf2-core.o
> > +videobuf2-common-objs +=3D frame_vector.o
> > =20
> >  ifeq ($(CONFIG_TRACEPOINTS),y)
> >    videobuf2-common-objs +=3D vb2-trace.o
> > diff --git a/mm/frame_vector.c b/drivers/media/common/videobuf2/frame_v=
ector.c
> > similarity index 99%
> > rename from mm/frame_vector.c
> > rename to drivers/media/common/videobuf2/frame_vector.c
> > index d44779e56313..2b0b97761d15 100644
> > --- a/mm/frame_vector.c
> > +++ b/drivers/media/common/videobuf2/frame_vector.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/sched.h>
> > =20
> > +#include <media/videobuf2-core.h>
> > +
>=20
> See my comment below...
>=20
> >  /**
> >   * get_vaddr_frames() - map virtual addresses to pfns
> >   * @start:	starting user address
> > diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platfo=
rm/omap/Kconfig
> > index f73b5893220d..de16de46c0f4 100644
> > --- a/drivers/media/platform/omap/Kconfig
> > +++ b/drivers/media/platform/omap/Kconfig
> > @@ -12,6 +12,5 @@ config VIDEO_OMAP2_VOUT
> >  	depends on VIDEO_V4L2
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
> > -	select FRAME_VECTOR
> >  	help
> >  	  V4L2 Display driver support for OMAP2/3 based boards.
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 16b799a0522c..acd60fbf1a5a 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1743,48 +1743,6 @@ int account_locked_vm(struct mm_struct *mm, unsi=
gned long pages, bool inc);
> >  int __account_locked_vm(struct mm_struct *mm, unsigned long pages, boo=
l inc,
> >  			struct task_struct *task, bool bypass_rlim);
> > =20
> > -/* Container for pinned pfns / pages */
> > -struct frame_vector {
> > -	unsigned int nr_allocated;	/* Number of frames we have space for */
> > -	unsigned int nr_frames;	/* Number of frames stored in ptrs array */
> > -	bool got_ref;		/* Did we pin pages by getting page ref? */
> > -	bool is_pfns;		/* Does array contain pages or pfns? */
> > -	void *ptrs[];		/* Array of pinned pfns / pages. Use
> > -				 * pfns_vector_pages() or pfns_vector_pfns()
> > -				 * for access */
> > -};
> > -
> > -struct frame_vector *frame_vector_create(unsigned int nr_frames);
> > -void frame_vector_destroy(struct frame_vector *vec);
> > -int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
> > -		     unsigned int gup_flags, struct frame_vector *vec);
> > -void put_vaddr_frames(struct frame_vector *vec);
> > -int frame_vector_to_pages(struct frame_vector *vec);
> > -void frame_vector_to_pfns(struct frame_vector *vec);
> > -
> > -static inline unsigned int frame_vector_count(struct frame_vector *vec)
> > -{
> > -	return vec->nr_frames;
> > -}
> > -
> > -static inline struct page **frame_vector_pages(struct frame_vector *ve=
c)
> > -{
> > -	if (vec->is_pfns) {
> > -		int err =3D frame_vector_to_pages(vec);
> > -
> > -		if (err)
> > -			return ERR_PTR(err);
> > -	}
> > -	return (struct page **)(vec->ptrs);
> > -}
> > -
> > -static inline unsigned long *frame_vector_pfns(struct frame_vector *ve=
c)
> > -{
> > -	if (!vec->is_pfns)
> > -		frame_vector_to_pfns(vec);
> > -	return (unsigned long *)(vec->ptrs);
> > -}
> > -
> >  struct kvec;
> >  int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
> >  			struct page **pages);
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-c=
ore.h
> > index bbb3f26fbde9..a2e75ca0334f 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -1254,4 +1254,46 @@ bool vb2_request_object_is_buffer(struct media_r=
equest_object *obj);
> >   */
> >  unsigned int vb2_request_buffer_cnt(struct media_request *req);
> > =20
> > +/* Container for pinned pfns / pages in frame_vector.c */
> > +struct frame_vector {
> > +	unsigned int nr_allocated;	/* Number of frames we have space for */
> > +	unsigned int nr_frames;	/* Number of frames stored in ptrs array */
> > +	bool got_ref;		/* Did we pin pages by getting page ref? */
> > +	bool is_pfns;		/* Does array contain pages or pfns? */
> > +	void *ptrs[];		/* Array of pinned pfns / pages. Use
> > +				 * pfns_vector_pages() or pfns_vector_pfns()
> > +				 * for access */
> > +};
> > +
> > +struct frame_vector *frame_vector_create(unsigned int nr_frames);
> > +void frame_vector_destroy(struct frame_vector *vec);
> > +int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
> > +		     unsigned int gup_flags, struct frame_vector *vec);
> > +void put_vaddr_frames(struct frame_vector *vec);
> > +int frame_vector_to_pages(struct frame_vector *vec);
> > +void frame_vector_to_pfns(struct frame_vector *vec);
> > +
> > +static inline unsigned int frame_vector_count(struct frame_vector *vec)
> > +{
> > +	return vec->nr_frames;
> > +}
> > +
> > +static inline struct page **frame_vector_pages(struct frame_vector *ve=
c)
> > +{
> > +	if (vec->is_pfns) {
> > +		int err =3D frame_vector_to_pages(vec);
> > +
> > +		if (err)
> > +			return ERR_PTR(err);
> > +	}
> > +	return (struct page **)(vec->ptrs);
> > +}
> > +
> > +static inline unsigned long *frame_vector_pfns(struct frame_vector *ve=
c)
> > +{
> > +	if (!vec->is_pfns)
> > +		frame_vector_to_pfns(vec);
> > +	return (unsigned long *)(vec->ptrs);
> > +}
> > +
> >  #endif /* _MEDIA_VIDEOBUF2_CORE_H */
>=20
> Please place those into a include/media/frame_vector.h file, instead of
> merging it directly at vb2 core header.
>=20
> Then include the new header at videobuf2-core.h and at frame_vector.c.

Makes sense, I'll do that for v3.

> With such changes:
>=20
> Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for taking a look.
-Daniel

>=20
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 6c974888f86f..da6c943fe9f1 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -815,9 +815,6 @@ config DEVICE_PRIVATE
> >  	  memory; i.e., memory that is only accessible from the device (or
> >  	  group of devices). You likely also want to select HMM_MIRROR.
> > =20
> > -config FRAME_VECTOR
> > -	bool
> > -
> >  config ARCH_USES_HIGH_VMA_FLAGS
> >  	bool
> >  config ARCH_HAS_PKEYS
> > diff --git a/mm/Makefile b/mm/Makefile
> > index d5649f1c12c0..a025fd6c6afd 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -111,7 +111,6 @@ obj-$(CONFIG_PAGE_EXTENSION) +=3D page_ext.o
> >  obj-$(CONFIG_CMA_DEBUGFS) +=3D cma_debug.o
> >  obj-$(CONFIG_USERFAULTFD) +=3D userfaultfd.o
> >  obj-$(CONFIG_IDLE_PAGE_TRACKING) +=3D page_idle.o
> > -obj-$(CONFIG_FRAME_VECTOR) +=3D frame_vector.o
> >  obj-$(CONFIG_DEBUG_PAGE_REF) +=3D debug_page_ref.o
> >  obj-$(CONFIG_HARDENED_USERCOPY) +=3D usercopy.o
> >  obj-$(CONFIG_PERCPU_STATS) +=3D percpu-stats.o
>=20
>=20
>=20
> Thanks,
> Mauro

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
