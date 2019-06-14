Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 14 Jun 2019 17:05:58 +0200
From: 'Christoph Hellwig' <hch@lst.de>
Subject: Re: [PATCH 16/16] dma-mapping: use exact allocation in
 dma_alloc_contiguous
Message-ID: <20190614150558.GA9402@lst.de>
References: <20190614134726.3827-1-hch@lst.de> <20190614134726.3827-17-hch@lst.de> <a90cf7ec5f1c4166b53c40e06d4d832a@AcuMS.aculab.com> <20190614145001.GB9088@lst.de> <d93fd4c2c1584d92a05dd641929f6d63@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93fd4c2c1584d92a05dd641929f6d63@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Christoph Hellwig' <hch@lst.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 14, 2019 at 03:01:22PM +0000, David Laight wrote:
> I'm pretty sure there is a lot of code out there that makes that assumption.
> Without it many drivers will have to allocate almost double the
> amount of memory they actually need in order to get the required alignment.
> So instead of saving memory you'll actually make more be used.

That code would already be broken on a lot of Linux platforms.
