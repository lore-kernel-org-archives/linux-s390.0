Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch> <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca> <20201009143723.45609bfb@coco.lan>
 <20201009124850.GP5177@ziepe.ca> <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
 <20201009180145.GB5177@ziepe.ca>
In-Reply-To: <20201009180145.GB5177@ziepe.ca>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 9 Oct 2020 21:31:21 +0200
Message-ID: <CAKMK7uGnKX-n+4eoa+tStJxsBzuPq1HF5tDjo8ph4PXqFKQ0pg@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Oct 9, 2020 at 8:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Oct 09, 2020 at 07:52:05PM +0200, Daniel Vetter wrote:
>
> > > > If this is the case, the proper fix seems to have a GFP_NOT_MOVABLE
> > > > flag that it would be denying the core mm code to set __GFP_MOVABLE.
> > >
> > > We can't tell from the VMA these kinds of details..
> > >
> > > It has to go the other direction, evey mmap that might be used as a
> > > userptr here has to be found and the VMA specially created to allow
> > > its use. At least that is a kernel only change, but will need people
> > > with the HW to do this work.
> >
> > I think the only reasonable way to keep this working is:
> > - add a struct dma_buf *vma_tryget_dma_buf(struct vm_area_struct *vma);
> > - add dma-buf export support to fbdev and v4l
> > - roll this out everywhere we still need it.
>
> It seems to me there is a technical way forward to restore user
> compat, so it is really no different than RDMA/DRM pain we both
> suffered before.
>
> Thus no justification to NAK it. If media wants things to keep working
> they have to do the technical path like you outline above.
>
> > Realistically this just isn't going to happen.
>
> If your series goes ahead it will get solved. Someone will take on the
> huge project to either add DMA buf to the drivers people still care
> about, or do the work above to transparently handle in kernel.
>
> If we allow things to keep working without consequence then nobody
> will do it.
>
> The only reason we did the 4 years of work in RDMA was because Linus
> went in and broke the uABI for a security fix. It was hundreds of
> patches to fix it, so I don't have much sympathy for "it is too hard"
> here.

Oh fully agreeing with you here, I just wanted to lay out that a)
there is a solid plan to fix it and b) it's way too much work for me
to just type it as a part of a "learn me some core mm semantics"
project :-)

I was hoping that we could get away with a special marker for
problematic vma, and filter those out. But after all the digging I've
noticed that on anything remotely modern, there's just nothing left.
Device memory management has become massively more dynamic in the past
10 years.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
