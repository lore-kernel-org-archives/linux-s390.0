Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgJGSrI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 14:47:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C796C0613D4
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 11:47:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s7so4049969qkh.11
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 11:47:08 -0700 (PDT)
Date: Wed, 7 Oct 2020 15:47:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 13/13] vfio/type1: Mark follow_pfn as unsafe
Message-ID: <20201007184705.GY5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
 <20201007173911.GX5177@ziepe.ca>
 <CAKMK7uEbAAJPPmv1yM_-V24Xg=S=NWxs2Yhi51kb-4AZLbFTTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEbAAJPPmv1yM_-V24Xg=S=NWxs2Yhi51kb-4AZLbFTTg@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Wed, Oct 07, 2020 at 08:14:06PM +0200, Daniel Vetter wrote:

> Hm, but wouldn't need that the semi-nasty vma_open trick to make sure
> that vma doesn't untimely disappear? Or is the idea to look up the
> underlying vfio object, and refcount that directly?

Ah, the patches Alex was working on had the refcount I think, it does
need co-ordination across multiple VFIO instances IIRC.

At least a simple check would guarentee we only have exposed PCI BAR
pages which is not as bad security wise as the other stuff.

Jason
