Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:52336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfFQIWy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Jun 2019 04:22:54 -0400
Date: Mon, 17 Jun 2019 11:21:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190617082148.GF28859@kadam>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org

I once wrote a Smatch check based on a commit message that said we can't
pass dma_alloc_coherent() pointers to virt_to_phys().  But then I never
felt like I understood the rules enough to actually report the warnings
as bugs.

drivers/platform/x86/dcdbas.c:108 smi_data_buf_realloc() error: 'buf' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/net/caif/caif_virtio.c:414 cfv_create_genpool() error: 'cfv->alloc_addr' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:135 alloc_host_sq() error: 'sq->queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:272 create_qp() error: 'wq->rq.queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:2628 alloc_srq_queue() error: 'wq->queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:494 ocrdma_alloc_ucontext() error: 'ctx->ah_tbl.va' came from dma_alloc_coherent() so we can't do virt_to_phys()

drivers/infiniband/hw/cxgb4/qp.c
   129  static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
   130  {
   131          sq->queue = dma_alloc_coherent(&(rdev->lldi.pdev->dev), sq->memsize,
   132                                         &(sq->dma_addr), GFP_KERNEL);
   133          if (!sq->queue)
   134                  return -ENOMEM;
   135          sq->phys_addr = virt_to_phys(sq->queue);
   136          dma_unmap_addr_set(sq, mapping, sq->dma_addr);
   137          return 0;
   138  }

Is this a bug?

regards,
dan carpenter
