Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201026105818.2585306-6-daniel.vetter@ffwll.ch> <20201026221520.GC2802004@chromium.org>
In-Reply-To: <20201026221520.GC2802004@chromium.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 27 Oct 2020 09:05:01 +0100
Message-ID: <CAKMK7uG4f_7=9VgdQ9AE876gzLTNsszicMD9pKqeqvQybDSDpQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] mm/frame-vector: Use FOLL_LONGTERM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

On Mon, Oct 26, 2020 at 11:15 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Daniel,
>
> On Mon, Oct 26, 2020 at 11:58:08AM +0100, Daniel Vetter wrote:
> > This is used by media/videbuf2 for persistent dma mappings, not just
> > for a single dma operation and then freed again, so needs
> > FOLL_LONGTERM.
> >
> > Unfortunately current pup_locked doesn't support FOLL_LONGTERM due to
> > locking issues. Rework the code to pull the pup path out from the
> > mmap_sem critical section as suggested by Jason.
> >
> > By relying entirely on the vma checks in pin_user_pages and follow_pfn
> > (for vm_flags and vma_is_fsdax) we can also streamline the code a lot.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Pawel Osciak <pawel@osciak.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomasz Figa <tfiga@chromium.org>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-media@vger.kernel.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > --
> > v2: Streamline the code and further simplify the loop checks (Jason)
> > ---
> >  mm/frame_vector.c | 50 ++++++++++++++---------------------------------
> >  1 file changed, 15 insertions(+), 35 deletions(-)
> >
>
> Thank you for the patch. Please see my comments inline.
>
> > diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> > index 10f82d5643b6..d44779e56313 100644
> > --- a/mm/frame_vector.c
> > +++ b/mm/frame_vector.c
> > @@ -38,7 +38,6 @@ int get_vaddr_frames(unsigned long start, unsigned in=
t nr_frames,
> >       struct vm_area_struct *vma;
> >       int ret =3D 0;
> >       int err;
> > -     int locked;
> >
> >       if (nr_frames =3D=3D 0)
> >               return 0;
> > @@ -48,40 +47,25 @@ int get_vaddr_frames(unsigned long start, unsigned =
int nr_frames,
> >
> >       start =3D untagged_addr(start);
> >
> > -     mmap_read_lock(mm);
> > -     locked =3D 1;
> > -     vma =3D find_vma_intersection(mm, start, start + 1);
> > -     if (!vma) {
> > -             ret =3D -EFAULT;
> > -             goto out;
> > -     }
> > -
> > -     /*
> > -      * While get_vaddr_frames() could be used for transient (kernel
> > -      * controlled lifetime) pinning of memory pages all current
> > -      * users establish long term (userspace controlled lifetime)
> > -      * page pinning. Treat get_vaddr_frames() like
> > -      * get_user_pages_longterm() and disallow it for filesystem-dax
> > -      * mappings.
> > -      */
> > -     if (vma_is_fsdax(vma)) {
> > -             ret =3D -EOPNOTSUPP;
> > -             goto out;
> > -     }
> > -
> > -     if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> > +     ret =3D pin_user_pages_fast(start, nr_frames,
> > +                               FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM=
,
> > +                               (struct page **)(vec->ptrs));
> > +     if (ret > 0) {
> >               vec->got_ref =3D true;
> >               vec->is_pfns =3D false;
> > -             ret =3D pin_user_pages_locked(start, nr_frames,
> > -                     gup_flags, (struct page **)(vec->ptrs), &locked);
>
> Should we drop the gup_flags argument, since it's ignored now?

Hm right I think an earlier version even had that, but then I moved to
inlining the functionality in all the places it's used.

I'll drop the gup flag.

> > -             goto out;
> > +             goto out_unlocked;
> >       }
> >
>
> Should we initialize ret with 0 here, since pin_user_pages_fast() can
> return a negative error code, but below we use it as a counter for the
> looked up frames?

Indeed, that's a bug. Will fix for v5.
-Daniel

> Best regards,
> Tomasz
>
> > +     mmap_read_lock(mm);
> >       vec->got_ref =3D false;
> >       vec->is_pfns =3D true;
> >       do {
> >               unsigned long *nums =3D frame_vector_pfns(vec);
> >
> > +             vma =3D find_vma_intersection(mm, start, start + 1);
> > +             if (!vma)
> > +                     break;
> > +
> >               while (ret < nr_frames && start + PAGE_SIZE <=3D vma->vm_=
end) {
> >                       err =3D follow_pfn(vma, start, &nums[ret]);
> >                       if (err) {
> > @@ -92,17 +76,13 @@ int get_vaddr_frames(unsigned long start, unsigned =
int nr_frames,
> >                       start +=3D PAGE_SIZE;
> >                       ret++;
> >               }
> > -             /*
> > -              * We stop if we have enough pages or if VMA doesn't comp=
letely
> > -              * cover the tail page.
> > -              */
> > -             if (ret >=3D nr_frames || start < vma->vm_end)
> > +             /* Bail out if VMA doesn't completely cover the tail page=
. */
> > +             if (start < vma->vm_end)
> >                       break;
> > -             vma =3D find_vma_intersection(mm, start, start + 1);
> > -     } while (vma && vma->vm_flags & (VM_IO | VM_PFNMAP));
> > +     } while (ret < nr_frames);
> >  out:
> > -     if (locked)
> > -             mmap_read_unlock(mm);
> > +     mmap_read_unlock(mm);
> > +out_unlocked:
> >       if (!ret)
> >               ret =3D -EFAULT;
> >       if (ret > 0)
> > --
> > 2.28.0
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
