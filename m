Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from kernel.crashing.org ([76.164.61.194]:42788 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIW6M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 18:58:12 -0400
Message-ID: <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Apr 2020 08:56:41 +1000
In-Reply-To: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
References: <20200408115926.1467567-1-hch@lst.de>
         <20200408115926.1467567-20-hch@lst.de>
         <20200408122504.GO3456981@phenom.ffwll.local>
         <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
         <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, X86 ML <x86@kernel.org>, David Airlie <airlied@linux.ie>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-hyperv@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-s390@vger.kernel.org, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2020-04-09 at 11:41 +0200, Daniel Vetter wrote:
> Now if these boxes didn't ever have agp then I think we can get away
> with deleting this, since we've already deleted the legacy radeon
> driver. And that one used vmalloc for everything. The new kms one does
> use the dma-api if the gpu isn't connected through agp

Definitely no AGP there.

Cheers
Ben.
