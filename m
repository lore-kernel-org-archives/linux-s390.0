Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbgJIMVN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 08:21:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4BC0613D2
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 05:21:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m9so7687724qth.7
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 05:21:13 -0700 (PDT)
Date: Fri, 9 Oct 2020 09:21:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Message-ID: <20201009122111.GN5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch>
 <20201009123421.67a80d72@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009123421.67a80d72@coco.lan>
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Oct 09, 2020 at 12:34:21PM +0200, Mauro Carvalho Chehab wrote:
> Hi,
> 
> Em Fri,  9 Oct 2020 09:59:26 +0200
> Daniel Vetter <daniel.vetter@ffwll.ch> escreveu:
> 
> > Way back it was a reasonable assumptions that iomem mappings never
> > change the pfn range they point at. But this has changed:
> > 
> > - gpu drivers dynamically manage their memory nowadays, invalidating
> > ptes with unmap_mapping_range when buffers get moved
> > 
> > - contiguous dma allocations have moved from dedicated carvetouts to
> > cma regions. This means if we miss the unmap the pfn might contain
> > pagecache or anon memory (well anything allocated with GFP_MOVEABLE)
> > 
> > - even /dev/mem now invalidates mappings when the kernel requests that
> > iomem region when CONFIG_IO_STRICT_DEVMEM is set, see 3234ac664a87
> > ("/dev/mem: Revoke mappings when a driver claims the region")
> > 
> > Accessing pfns obtained from ptes without holding all the locks is
> > therefore no longer a good idea.
> > 
> > Unfortunately there's some users where this is not fixable (like v4l
> > userptr of iomem mappings) or involves a pile of work (vfio type1
> > iommu). For now annotate these as unsafe and splat appropriately.
> > 
> > This patch adds an unsafe_follow_pfn, which later patches will then
> > roll out to all appropriate places.
> 
> NACK, as this breaks an existing userspace API on media.

It doesn't break it. You get a big warning the thing is broken and it
keeps working.

We can't leave such a huge security hole open - it impacts other
subsystems, distros need to be able to run in a secure mode.

> While I agree that using the userptr on media is something that
> new drivers may not support, as DMABUF is a better way of
> handling it, changing this for existing ones is a big no, 
> as it may break usersapace.

media community needs to work to fix this, not pretend it is OK to
keep going as-is.

Dealing with security issues is the one case where an uABI break might
be acceptable.

If you want to NAK it then you need to come up with the work to do
something here correctly that will support the old drivers without the
kernel taint.

Unfortunately making things uncomfortable for the subsystem is the big
hammer the core kernel needs to use to actually get this security work
done by those responsible.

Jason
