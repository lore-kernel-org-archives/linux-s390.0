Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgDHPBD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 11:01:03 -0400
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
Date: Wed, 8 Apr 2020 08:01:00 -0700
MIME-Version: 1.0
In-Reply-To: <20200408115926.1467567-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 4/8/20 4:59 AM, Christoph Hellwig wrote:
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

It's a bool so this shouldn't matter... not needed.

>  	help
>  	  By default, zsmalloc uses a copy-based object mapping method to
>  	  access allocations that span two pages. However, if a particular


-- 
~Randy
