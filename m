Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897495AbgJVLnr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Oct 2020 07:43:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1DC0613CF
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 04:43:47 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ev17so657811qvb.3
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 04:43:47 -0700 (PDT)
Date: Thu, 22 Oct 2020 08:43:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
Message-ID: <20201022114345.GO36674@ziepe.ca>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch>
 <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca>
 <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
 <20201021163702.GM36674@ziepe.ca>
 <CAKMK7uEjE5sHUq0hV_bnYjPKRxYyBnty0sLre+owANGZjLJg9Q@mail.gmail.com>
 <20201021232022.GN36674@ziepe.ca>
 <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.com>

On Thu, Oct 22, 2020 at 09:00:44AM +0200, Daniel Vetter wrote:
> On Thu, Oct 22, 2020 at 1:20 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 21, 2020 at 09:24:08PM +0200, Daniel Vetter wrote:
> > > On Wed, Oct 21, 2020 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:
> > > >
> > > > > The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> > > > > split that. So ideally ->mmap would never set up any ptes.
> > > >
> > > > /dev/mem makes pgoff == pfn so it doesn't get changed by remap.
> > > >
> > > > pgoff doesn't get touched for MAP_SHARED either, so there are other
> > > > users that could work like this - eg anyone mmaping IO memory is
> > > > probably OK.
> > >
> > > I was more generally thinking for io_remap_pfn_users because of the
> > > mkwrite use-case we might have in fbdev emulation in drm.
> >
> > You have a use case for MAP_PRIVATE and io_remap_pfn_range()??
> 
> Uh no :-)

So it is fine, the pgoff mangling only happens for MAP_PRIVATE

Jason
