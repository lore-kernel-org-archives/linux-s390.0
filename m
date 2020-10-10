Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbgJJTYY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 10 Oct 2020 15:24:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C65AC08EA78
        for <linux-s390@vger.kernel.org>; Sat, 10 Oct 2020 10:28:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p13so12680269edi.7
        for <linux-s390@vger.kernel.org>; Sat, 10 Oct 2020 10:28:07 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id t7sm2096074edj.45.2020.10.10.10.28.05
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 10:28:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id d3so12847822wma.4
        for <linux-s390@vger.kernel.org>; Sat, 10 Oct 2020 10:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch> <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca> <20201009143723.45609bfb@coco.lan>
 <20201009124850.GP5177@ziepe.ca> <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
In-Reply-To: <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sat, 10 Oct 2020 19:22:48 +0200
Message-ID: <CAAFQd5CTT0re4ssj9NNTxhejFX_v_rCjy6=mX7C+dc=Lw9GOHw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Daniel,

On Fri, Oct 9, 2020 at 7:52 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Fri, Oct 9, 2020 at 2:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Oct 09, 2020 at 02:37:23PM +0200, Mauro Carvalho Chehab wrote:
> >
> > > I'm not a mm/ expert, but, from what I understood from Daniel's patch
> > > description is that this is unsafe *only if*  __GFP_MOVABLE is used.
> >
> > No, it is unconditionally unsafe. The CMA movable mappings are
> > specific VMAs that will have bad issues here, but there are other
> > types too.
> >
> > The only way to do something at a VMA level is to have a list of OK
> > VMAs, eg because they were creatd via a special mmap helper from the
> > media subsystem.
> >
> > > Well, no drivers inside the media subsystem uses such flag, although
> > > they may rely on some infrastructure that could be using it behind
> > > the bars.
> >
> > It doesn't matter, nothing prevents the user from calling media APIs
> > on mmaps it gets from other subsystems.
>
> I think a good first step would be to disable userptr of non struct
> page backed storage going forward for any new hw support. Even on
> existing drivers. dma-buf sharing has been around for long enough now
> that this shouldn't be a problem. Unfortunately right now this doesn't
> seem to exist, so the entire problem keeps getting perpetuated.
>
> > > If this is the case, the proper fix seems to have a GFP_NOT_MOVABLE
> > > flag that it would be denying the core mm code to set __GFP_MOVABLE.
> >
> > We can't tell from the VMA these kinds of details..
> >
> > It has to go the other direction, evey mmap that might be used as a
> > userptr here has to be found and the VMA specially created to allow
> > its use. At least that is a kernel only change, but will need people
> > with the HW to do this work.
>
> I think the only reasonable way to keep this working is:
> - add a struct dma_buf *vma_tryget_dma_buf(struct vm_area_struct *vma);
> - add dma-buf export support to fbdev and v4l

I assume you mean V4L2 and not the obsolete V4L that is emulated in
the userspace by libv4l. If so, every video device that uses videobuf2
gets DMA-buf export for free and there is nothing needed to enable it.

We probably still have a few legacy drivers using videobuf (non-2),
but IMHO those should be safe to put behind some disabled-by-default
Kconfig symbol or even completely drop, as the legacy framework has
been deprecated for many years already.

> - roll this out everywhere we still need it.
>
> Realistically this just isn't going to happen. And anything else just
> reimplements half of dma-buf, which is kinda pointless (you need
> minimally refcounting and some way to get at a promise of a permanent
> sg list for dma. Plus probably the vmap for kernel cpu access.
>
> > > Please let address the issue on this way, instead of broken an
> > > userspace API that it is there since 1991.
> >
> > It has happened before :( It took 4 years for RDMA to undo the uAPI
> > breakage caused by a security fix for something that was a 15 years
> > old bug.
>
> Yeah we have a bunch of these on the drm side too. Some of them are
> really just "you have to upgrade userspace", and there's no real fix
> for the security nightmare without that.

I think we need to phase out such userspace indeed. The Kconfig symbol
allows enabling the unsafe functionality for anyone who still needs
it, so I think it's not entirely a breakage.

Best regards,
Tomasz
