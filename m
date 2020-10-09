Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJIRwR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 13:52:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C655C0613D7
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 10:52:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e20so9313079otj.11
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch> <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca> <20201009143723.45609bfb@coco.lan> <20201009124850.GP5177@ziepe.ca>
In-Reply-To: <20201009124850.GP5177@ziepe.ca>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 9 Oct 2020 19:52:05 +0200
Message-ID: <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Oct 9, 2020 at 2:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Oct 09, 2020 at 02:37:23PM +0200, Mauro Carvalho Chehab wrote:
>
> > I'm not a mm/ expert, but, from what I understood from Daniel's patch
> > description is that this is unsafe *only if*  __GFP_MOVABLE is used.
>
> No, it is unconditionally unsafe. The CMA movable mappings are
> specific VMAs that will have bad issues here, but there are other
> types too.
>
> The only way to do something at a VMA level is to have a list of OK
> VMAs, eg because they were creatd via a special mmap helper from the
> media subsystem.
>
> > Well, no drivers inside the media subsystem uses such flag, although
> > they may rely on some infrastructure that could be using it behind
> > the bars.
>
> It doesn't matter, nothing prevents the user from calling media APIs
> on mmaps it gets from other subsystems.

I think a good first step would be to disable userptr of non struct
page backed storage going forward for any new hw support. Even on
existing drivers. dma-buf sharing has been around for long enough now
that this shouldn't be a problem. Unfortunately right now this doesn't
seem to exist, so the entire problem keeps getting perpetuated.

> > If this is the case, the proper fix seems to have a GFP_NOT_MOVABLE
> > flag that it would be denying the core mm code to set __GFP_MOVABLE.
>
> We can't tell from the VMA these kinds of details..
>
> It has to go the other direction, evey mmap that might be used as a
> userptr here has to be found and the VMA specially created to allow
> its use. At least that is a kernel only change, but will need people
> with the HW to do this work.

I think the only reasonable way to keep this working is:
- add a struct dma_buf *vma_tryget_dma_buf(struct vm_area_struct *vma);
- add dma-buf export support to fbdev and v4l
- roll this out everywhere we still need it.

Realistically this just isn't going to happen. And anything else just
reimplements half of dma-buf, which is kinda pointless (you need
minimally refcounting and some way to get at a promise of a permanent
sg list for dma. Plus probably the vmap for kernel cpu access.

> > Please let address the issue on this way, instead of broken an
> > userspace API that it is there since 1991.
>
> It has happened before :( It took 4 years for RDMA to undo the uAPI
> breakage caused by a security fix for something that was a 15 years
> old bug.

Yeah we have a bunch of these on the drm side too. Some of them are
really just "you have to upgrade userspace", and there's no real fix
for the security nightmare without that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
