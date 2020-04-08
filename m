Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHMZK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 08:25:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so7622163wrm.3
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2020 05:25:08 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:25:04 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
Message-ID: <20200408122504.GO3456981@phenom.ffwll.local>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-20-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> If this code was broken for non-coherent caches a crude powerpc hack
> isn't going to help anyone else.  Remove the hack as it is the last
> user of __vmalloc passing a page protection flag other than PAGE_KERNEL.

Well Ben added this to make stuff work on ppc, ofc the home grown dma
layer in drm from back then isn't going to work in other places. I guess
should have at least an ack from him, in case anyone still cares about
this on ppc. Adding Ben to cc.
-Daniel

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/drm_scatter.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> index ca520028b2cb..f4e6184d1877 100644
> --- a/drivers/gpu/drm/drm_scatter.c
> +++ b/drivers/gpu/drm/drm_scatter.c
> @@ -43,15 +43,6 @@
>  
>  #define DEBUG_SCATTER 0
>  
> -static inline void *drm_vmalloc_dma(unsigned long size)
> -{
> -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> -	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> -#else
> -	return vmalloc_32(size);
> -#endif
> -}
> -
>  static void drm_sg_cleanup(struct drm_sg_mem * entry)
>  {
>  	struct page *page;
> @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
>  		return -ENOMEM;
>  	}
>  
> -	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> +	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
>  	if (!entry->virtual) {
>  		kfree(entry->busaddr);
>  		kfree(entry->pagelist);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
