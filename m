Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37755 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgJLKq6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Oct 2020 06:46:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201012104646euoutp02ed115f1785fb69709f9bdc8ccc0e6767~9OObcuYHB1970119701euoutp02Z
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 10:46:46 +0000 (GMT)
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ed68968b-27bc-d776-8da8-ef21d6b3c378@samsung.com>
Date: Mon, 12 Oct 2020 12:46:39 +0200
MIME-Version: 1.0
In-Reply-To: <20201009124850.GP5177@ziepe.ca>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
        <20201009075934.3509076-10-daniel.vetter@ffwll.ch>
        <20201009123421.67a80d72@coco.lan> <20201009122111.GN5177@ziepe.ca>
        <20201009143723.45609bfb@coco.lan>
        <CGME20201009124900eucas1p26c93caa29c9925f1eef9be9ff7c6c65c@eucas1p2.samsung.com>
        <20201009124850.GP5177@ziepe.ca>
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Jason,

On 09.10.2020 14:48, Jason Gunthorpe wrote:
> On Fri, Oct 09, 2020 at 02:37:23PM +0200, Mauro Carvalho Chehab wrote:
>
>> I'm not a mm/ expert, but, from what I understood from Daniel's patch
>> description is that this is unsafe *only if*  __GFP_MOVABLE is used.
> No, it is unconditionally unsafe. The CMA movable mappings are
> specific VMAs that will have bad issues here, but there are other
> types too.

I'm trying to follow this thread, but I really wonder what do you mean 
by CMA movable mappings? If a buffer has been allocated from CMA and 
used for DMA, it won't be moved in the memory. It will stay at the same 
physical memory address all the time until freed by the owner. It just a 
matter of proper usage count tracking to delay freeing if it is still 
used somewhere.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
