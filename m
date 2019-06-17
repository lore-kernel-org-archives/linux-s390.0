Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp119.ord1c.emailsrvr.com ([108.166.43.119]:42302 "EHLO
        smtp119.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbfFQNVs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Jun 2019 09:21:48 -0400
Subject: Re: [PATCH 12/16] staging/comedi: mark as broken
References: <20190614134726.3827-1-hch@lst.de>
 <20190614134726.3827-13-hch@lst.de> <20190614140239.GA7234@kroah.com>
 <20190614144857.GA9088@lst.de> <20190614153032.GD18049@kroah.com>
 <20190614153428.GA10008@lst.de>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <60c6af3d-d8e4-5745-8d2b-9791a2f4ff56@mev.co.uk>
Date: Mon, 17 Jun 2019 14:15:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190614153428.GA10008@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org

On 14/06/2019 16:34, Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 05:30:32PM +0200, Greg KH wrote:
>> On Fri, Jun 14, 2019 at 04:48:57PM +0200, Christoph Hellwig wrote:
>>> On Fri, Jun 14, 2019 at 04:02:39PM +0200, Greg KH wrote:
>>>> Perhaps a hint as to how we can fix this up?  This is the first time
>>>> I've heard of the comedi code not handling dma properly.
>>>
>>> It can be fixed by:
>>>
>>>   a) never calling virt_to_page (or vmalloc_to_page for that matter)
>>>      on dma allocation
>>>   b) never remapping dma allocation with conflicting cache modes
>>>      (no remapping should be doable after a) anyway).
>>
>> Ok, fair enough, have any pointers of drivers/core code that does this
>> correctly?  I can put it on my todo list, but might take a week or so...
> 
> Just about everyone else.  They just need to remove the vmap and
> either do one large allocation, or live with the fact that they need
> helpers to access multiple array elements instead of one net vmap,
> which most of the users already seem to do anyway, with just a few
> using the vmap (which might explain why we didn't see blowups yet).

Avoiding the vmap in comedi should be do-able as it already has other 
means to get at the buffer pages.

When comedi makes the buffer from DMA coherent memory, it currently 
allocates it as a series of page-sized chunks.  That cannot be mmap'ed 
in one go with dma_mmap_coherent(), so I see the following solutions.

1. Change the buffer allocation to allocate a single chunk of DMA 
coherent memory and use dma_mmap_coherent() to mmap it.

2. Call dma_mmap_coherent() in a loop, adjusting vma->vm_start and 
vma->vm_end for each iteration (vma->vm_pgoff will be 0), and restoring 
the vma->vm_start and vma->vm_end at the end.

I'm not sure if 2 is a legal option.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
