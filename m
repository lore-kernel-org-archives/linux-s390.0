Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPaf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 11:30:35 -0400
Date: Fri, 14 Jun 2019 17:30:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 12/16] staging/comedi: mark as broken
Message-ID: <20190614153032.GD18049@kroah.com>
References: <20190614134726.3827-1-hch@lst.de>
 <20190614134726.3827-13-hch@lst.de>
 <20190614140239.GA7234@kroah.com>
 <20190614144857.GA9088@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144857.GA9088@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org

On Fri, Jun 14, 2019 at 04:48:57PM +0200, Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 04:02:39PM +0200, Greg KH wrote:
> > Perhaps a hint as to how we can fix this up?  This is the first time
> > I've heard of the comedi code not handling dma properly.
> 
> It can be fixed by:
> 
>  a) never calling virt_to_page (or vmalloc_to_page for that matter)
>     on dma allocation
>  b) never remapping dma allocation with conflicting cache modes
>     (no remapping should be doable after a) anyway).

Ok, fair enough, have any pointers of drivers/core code that does this
correctly?  I can put it on my todo list, but might take a week or so...

Ian, want to look into doing this sooner?

thanks,

greg k-h
