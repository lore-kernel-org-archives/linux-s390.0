Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37017 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728251AbfFNOPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 10:15:48 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 16/16] dma-mapping: use exact allocation in
 dma_alloc_contiguous
Date: Fri, 14 Jun 2019 14:15:44 +0000
Message-ID: <a90cf7ec5f1c4166b53c40e06d4d832a@AcuMS.aculab.com>
References: <20190614134726.3827-1-hch@lst.de>
 <20190614134726.3827-17-hch@lst.de>
In-Reply-To: <20190614134726.3827-17-hch@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: 'Christoph Hellwig' <hch@lst.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Christoph Hellwig
> Sent: 14 June 2019 14:47
> 
> Many architectures (e.g. arm, m68 and sh) have always used exact
> allocation in their dma coherent allocator, which avoids a lot of
> memory waste especially for larger allocations.  Lift this behavior
> into the generic allocator so that dma-direct and the generic IOMMU
> code benefit from this behavior as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-contiguous.h |  8 +++++---
>  kernel/dma/contiguous.c        | 17 +++++++++++------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index c05d4e661489..2e542e314acf 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -161,15 +161,17 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>  		gfp_t gfp)
>  {
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> -	size_t align = get_order(PAGE_ALIGN(size));
> +	void *cpu_addr = alloc_pages_exact_node(node, size, gfp);
> 
> -	return alloc_pages_node(node, gfp, align);
> +	if (!cpu_addr)
> +		return NULL;
> +	return virt_to_page(p);
>  }

Does this still guarantee that requests for 16k will not cross a 16k boundary?
It looks like you are losing the alignment parameter.

There may be drivers and hardware that also require 12k allocates
to not cross 16k boundaries (etc).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
