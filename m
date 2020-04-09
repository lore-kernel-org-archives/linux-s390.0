Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgDIQIa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 12:08:30 -0400
Date: Thu, 9 Apr 2020 09:08:26 -0700
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409160826.GC247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-11-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com

On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> This allows to unexport map_vm_area and unmap_kernel_range, which are
> rather deep internal and should not be available to modules.

Even though I don't know how many usecase we have using zsmalloc as
module(I heard only once by dumb reason), it could affect existing
users. Thus, please include concrete explanation in the patch to
justify when the complain occurs.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/Kconfig   | 2 +-
>  mm/vmalloc.c | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 36949a9425b8..614cc786b519 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -702,7 +702,7 @@ config ZSMALLOC
>  
>  config ZSMALLOC_PGTABLE_MAPPING
>  	bool "Use page table mapping to access object in zsmalloc"
> -	depends on ZSMALLOC
> +	depends on ZSMALLOC=y
>  	help
>  	  By default, zsmalloc uses a copy-based object mapping method to
>  	  access allocations that span two pages. However, if a particular
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3375f9508ef6..9183fc0d365a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2046,7 +2046,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
>  	vunmap_page_range(addr, end);
>  	flush_tlb_kernel_range(addr, end);
>  }
> -EXPORT_SYMBOL_GPL(unmap_kernel_range);
>  
>  int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
>  {
> @@ -2058,7 +2057,6 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
>  
>  	return err > 0 ? 0 : err;
>  }
> -EXPORT_SYMBOL_GPL(map_vm_area);
>  
>  static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  	struct vmap_area *va, unsigned long flags, const void *caller)
> -- 
> 2.25.1
> 
