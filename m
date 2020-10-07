Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgJGVaO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 17:30:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D2C0613D4
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 14:30:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s66so3675338otb.2
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 14:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-6-daniel.vetter@ffwll.ch> <fc0ac3fb-2758-bef1-76b4-8ac2449f5743@nvidia.com>
In-Reply-To: <fc0ac3fb-2758-bef1-76b4-8ac2449f5743@nvidia.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 7 Oct 2020 23:30:01 +0200
Message-ID: <CAKMK7uF7QBksDRsWhpuv-QhM3CN3+Gzg0-o-O-3rCsMWtr48xQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] mm/frame-vector: Use FOLL_LONGTERM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

On Wed, Oct 7, 2020 at 11:13 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 10/7/20 9:44 AM, Daniel Vetter wrote:
> > This is used by media/videbuf2 for persistent dma mappings, not just
> > for a single dma operation and then freed again, so needs
> > FOLL_LONGTERM.
> >
> > Unfortunately current pup_locked doesn't support FOLL_LONGTERM due to
> > locking issues. Rework the code to pull the pup path out from the
> > mmap_sem critical section as suggested by Jason.
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
> > ---
> >   mm/frame_vector.c | 36 +++++++++++-------------------------
> >   1 file changed, 11 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> > index 10f82d5643b6..39db520a51dc 100644
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
> > @@ -48,35 +47,22 @@ int get_vaddr_frames(unsigned long start, unsigned =
int nr_frames,
> >
> >       start =3D untagged_addr(start);
> >
> > +     ret =3D pin_user_pages_fast(start, nr_frames,
> > +                               FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM=
,
> > +                               (struct page **)(vec->ptrs));
> > +     if (ret > 0) {
> > +             vec->got_ref =3D true;
> > +             vec->is_pfns =3D false;
> > +             goto out_unlocked;
> > +     }
>
> This part looks good, and changing to _fast is a potential performance im=
provement,
> too.
>
> > +
> >       mmap_read_lock(mm);
> > -     locked =3D 1;
> >       vma =3D find_vma_intersection(mm, start, start + 1);
> >       if (!vma) {
> >               ret =3D -EFAULT;
> >               goto out;
> >       }
> >
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
>
> Are you sure we don't need to check vma_is_fsdax() anymore?

Since FOLL_LONGTERM checks for this and can only return struct page
backed memory, and explicitly excludes VM_IO | VM_PFNMAP, was assuming
this is not needed for follow_pfn. And the get_user_pages_locked this
used back then didn't have the same check, hence why it was added (and
FOLL_LONGTERM still doesn't work for the _locked versions, as you
pointed out on the last round of this discussion).

But now that you're asking, I have no idea whether fsdax vma can also
be of VM_IO | VM_PFNMAP type. I'm not seeing that set anywhere in
fs/dax.c, but that says nothing :-)

Dan, you added this check originally, do we need it for VM_SPECIAL vmas too=
?

Thanks, Daniel

>
> > -
> > -     if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> > -             vec->got_ref =3D true;
> > -             vec->is_pfns =3D false;
> > -             ret =3D pin_user_pages_locked(start, nr_frames,
> > -                     gup_flags, (struct page **)(vec->ptrs), &locked);
> > -             goto out;
> > -     }
> > -
> >       vec->got_ref =3D false;
> >       vec->is_pfns =3D true;
> >       do {
> > @@ -101,8 +87,8 @@ int get_vaddr_frames(unsigned long start, unsigned i=
nt nr_frames,
> >               vma =3D find_vma_intersection(mm, start, start + 1);
> >       } while (vma && vma->vm_flags & (VM_IO | VM_PFNMAP));
> >   out:
> > -     if (locked)
> > -             mmap_read_unlock(mm);
> > +     mmap_read_unlock(mm);
> > +out_unlocked:
> >       if (!ret)
> >               ret =3D -EFAULT;
> >       if (ret > 0)
> >
>
> All of the error handling still looks accurate there.
>
> thanks,
> --
> John Hubbard
> NVIDIA



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
