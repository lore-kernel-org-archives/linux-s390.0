Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgDHPiI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 11:38:08 -0400
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
 <20200408151203.GN20730@hirez.programming.kicks-ass.net>
 <20200408151519.GQ21484@bombadil.infradead.org>
 <20200408153602.GA28081@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce1cb560-2670-c79d-48eb-e4dd423aecb0@infradead.org>
Date: Wed, 8 Apr 2020 08:37:59 -0700
MIME-Version: 1.0
In-Reply-To: <20200408153602.GA28081@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/8/20 8:36 AM, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 08:15:19AM -0700, Matthew Wilcox wrote:
>>>>>  config ZSMALLOC_PGTABLE_MAPPING
>>>>>  	bool "Use page table mapping to access object in zsmalloc"
>>>>> -	depends on ZSMALLOC
>>>>> +	depends on ZSMALLOC=y
>>>>
>>>> It's a bool so this shouldn't matter... not needed.
>>>
>>> My mm/Kconfig has:
>>>
>>> config ZSMALLOC
>>> 	tristate "Memory allocator for compressed pages"
>>> 	depends on MMU
>>>
>>> which I think means it can be modular, no?
>>
>> Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
>> is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
>> 'n' instead of 'y'.
> 
> In Linus' tree you can select PGTABLE_MAPPING=y with ZSMALLOC=m,
> and that fits my understanding of the kbuild language.  With this
> patch I can't anymore.
> 

Makes sense. thanks.

-- 
~Randy
