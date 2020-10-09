Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgJIMsx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 08:48:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5EC0613D5
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 05:48:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so10359962qkd.9
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 05:48:52 -0700 (PDT)
Date: Fri, 9 Oct 2020 09:48:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Message-ID: <20201009124850.GP5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch>
 <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca>
 <20201009143723.45609bfb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143723.45609bfb@coco.lan>
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Oct 09, 2020 at 02:37:23PM +0200, Mauro Carvalho Chehab wrote:

> I'm not a mm/ expert, but, from what I understood from Daniel's patch
> description is that this is unsafe *only if*  __GFP_MOVABLE is used.

No, it is unconditionally unsafe. The CMA movable mappings are
specific VMAs that will have bad issues here, but there are other
types too.

The only way to do something at a VMA level is to have a list of OK
VMAs, eg because they were creatd via a special mmap helper from the
media subsystem.

> Well, no drivers inside the media subsystem uses such flag, although
> they may rely on some infrastructure that could be using it behind
> the bars.

It doesn't matter, nothing prevents the user from calling media APIs
on mmaps it gets from other subsystems.

> If this is the case, the proper fix seems to have a GFP_NOT_MOVABLE
> flag that it would be denying the core mm code to set __GFP_MOVABLE.

We can't tell from the VMA these kinds of details..

It has to go the other direction, evey mmap that might be used as a
userptr here has to be found and the VMA specially created to allow
its use. At least that is a kernel only change, but will need people
with the HW to do this work.

> Please let address the issue on this way, instead of broken an
> userspace API that it is there since 1991.

It has happened before :( It took 4 years for RDMA to undo the uAPI
breakage caused by a security fix for something that was a 15 years
old bug. 

Jason
