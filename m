Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47569 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfFNOt2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 10:49:28 -0400
Date: Fri, 14 Jun 2019 16:48:57 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/16] staging/comedi: mark as broken
Message-ID: <20190614144857.GA9088@lst.de>
References: <20190614134726.3827-1-hch@lst.de> <20190614134726.3827-13-hch@lst.de> <20190614140239.GA7234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614140239.GA7234@kroah.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org

On Fri, Jun 14, 2019 at 04:02:39PM +0200, Greg KH wrote:
> Perhaps a hint as to how we can fix this up?  This is the first time
> I've heard of the comedi code not handling dma properly.

It can be fixed by:

 a) never calling virt_to_page (or vmalloc_to_page for that matter)
    on dma allocation
 b) never remapping dma allocation with conflicting cache modes
    (no remapping should be doable after a) anyway).
