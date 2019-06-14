Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: use exact allocation for dma coherent memory
Date: Fri, 14 Jun 2019 15:47:10 +0200
Message-Id: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hi all,

various architectures have used exact memory allocations for dma
allocations for a long time, but x86 and thus the common code based
on it kept using our normal power of two allocator, which tends to
waste a lot of memory for certain allocations.

Switching to a slightly cleaned up alloc_pages_exact is pretty easy,
but it turns out that because we didn't filter valid gfp_t flags
on the DMA allocator, a bunch of drivers were passing __GFP_COMP
to it, which is rather bogus in too many ways to explain.  Arm has
been filtering it for a while, but this series instead tries to fix
the drivers and warn when __GFP_COMP is passed, which makes it much
larger than just adding the functionality.
