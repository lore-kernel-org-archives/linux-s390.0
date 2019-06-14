Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfFNOCm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 10:02:42 -0400
Date: Fri, 14 Jun 2019 16:02:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 12/16] staging/comedi: mark as broken
Message-ID: <20190614140239.GA7234@kroah.com>
References: <20190614134726.3827-1-hch@lst.de>
 <20190614134726.3827-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614134726.3827-13-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org

On Fri, Jun 14, 2019 at 03:47:22PM +0200, Christoph Hellwig wrote:
> comedi_buf.c abuse the DMA API in gravely broken ways, as it assumes it
> can call virt_to_page on the result, and the just remap it as uncached
> using vmap.  Disable the driver until this API abuse has been fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/staging/comedi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
> index 049b659fa6ad..e7c021d76cfa 100644
> --- a/drivers/staging/comedi/Kconfig
> +++ b/drivers/staging/comedi/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config COMEDI
>  	tristate "Data acquisition support (comedi)"
> +	depends on BROKEN

Um, that's a huge sledgehammer.

Perhaps a hint as to how we can fix this up?  This is the first time
I've heard of the comedi code not handling dma properly.

thanks,

greg k-h
