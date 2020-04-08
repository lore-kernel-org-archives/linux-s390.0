Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgDHPMd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 11:12:33 -0400
Date: Wed, 8 Apr 2020 17:12:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200408151203.GN20730@hirez.programming.kicks-ass.net>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:01:00AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 4/8/20 4:59 AM, Christoph Hellwig wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 36949a9425b8..614cc786b519 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -702,7 +702,7 @@ config ZSMALLOC
> >  
> >  config ZSMALLOC_PGTABLE_MAPPING
> >  	bool "Use page table mapping to access object in zsmalloc"
> > -	depends on ZSMALLOC
> > +	depends on ZSMALLOC=y
> 
> It's a bool so this shouldn't matter... not needed.

My mm/Kconfig has:

config ZSMALLOC
	tristate "Memory allocator for compressed pages"
	depends on MMU

which I think means it can be modular, no?
