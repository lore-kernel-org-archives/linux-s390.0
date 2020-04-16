Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgDPUhl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 16:37:41 -0400
Date: Thu, 16 Apr 2020 13:37:36 -0700
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200416203736.GB50092@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
 <20200410231136.GA101325@google.com>
 <20200411072052.GA31242@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411072052.GA31242@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Christoph,


Sorry for the late.

On Sat, Apr 11, 2020 at 09:20:52AM +0200, Christoph Hellwig wrote:
> Hi Minchan,
> 
> On Fri, Apr 10, 2020 at 04:11:36PM -0700, Minchan Kim wrote:
> > It doesn't mean we couldn't use zsmalloc as module any longer. It means
> > we couldn't use zsmalloc as module with pgtable mapping whcih was little
> > bit faster on microbenchmark in some architecutre(However, I usually temped
> > to remove it since it had several problems). However, we could still use
> > zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
> > really want to rollback the feature, they should provide reasonable reason
> > why it doesn't work for them. "A little fast" wouldn't be enough to exports
> > deep internal to the module.
> 
> do you have any data how much faster it is on arm (and does that include
> arm64 as well)?  Besides the exports which were my prime concern,

https://github.com/sjenning/zsmapbench

I need to recall the memory. IIRC, it was almost 30% faster at that time
in ARM so was not trivial at that time. However, it was story from
several years ago.

> zsmalloc with pgtable mappings also is the only user of map_kernel_range
> outside of vmalloc.c, if it really is another code base for tiny
> improvements we could mark map_kernel_range or in fact remove it entirely
> and open code it in the remaining callers.

I alsh have temped to remove it. Let me have time to revist it in this
chance.

Thanks.
