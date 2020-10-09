Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389018AbgJIOcL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 10:32:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C3C0613D5
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 07:32:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s4so10733646qkf.7
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 07:32:11 -0700 (PDT)
Date: Fri, 9 Oct 2020 11:32:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 14/17] resource: Move devmem revoke code to resource
 framework
Message-ID: <20201009143209.GS5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-15-daniel.vetter@ffwll.ch>
 <20201009123109.GO5177@ziepe.ca>
 <CAKMK7uFpPP-Q0jC0vM7vYPEcg0m4NzTw+Ld=swdTF3BgMX5Qug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFpPP-Q0jC0vM7vYPEcg0m4NzTw+Ld=swdTF3BgMX5Qug@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Hildenbrand <david@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Oct 09, 2020 at 04:24:45PM +0200, Daniel Vetter wrote:
> On Fri, Oct 9, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Oct 09, 2020 at 09:59:31AM +0200, Daniel Vetter wrote:
> >
> > > +struct address_space *iomem_get_mapping(void)
> > > +{
> > > +     return iomem_inode->i_mapping;
> >
> > This should pair an acquire with the release below
> >
> > > +     /*
> > > +      * Publish /dev/mem initialized.
> > > +      * Pairs with smp_load_acquire() in revoke_iomem().
> > > +      */
> > > +     smp_store_release(&iomem_inode, inode);
> >
> > However, this seems abnormal, initcalls rarely do this kind of stuff
> > with global data..
> >
> > The kernel crashes if this fs_initcall is raced with
> > iomem_get_mapping() due to the unconditional dereference, so I think
> > it can be safely switched to a simple assignment.
> 
> Ah yes I checked this all, but forgot to correctly annotate the
> iomem_get_mapping access. For reference, see b34e7e298d7a ("/dev/mem:
> Add missing memory barriers for devmem_inode").

Oh yikes, so revoke_iomem can run concurrently during early boot,
tricky.

> The reasons for the annotations is that iomem requests can happen
> fairly early, way before fs_initcalls happen. That means revoke_iomem
> needs to check for that and bail out if we race - nothing bad can
> happen since userspace isn't running at this point anyway. And
> apparently it needs to be a full acquire fence since we don't just
> write a value, but need a barrier for the struct stuff.

Yes, if that is what is happening it release/acquire is needed.

Jason
