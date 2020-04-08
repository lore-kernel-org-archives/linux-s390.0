Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 8 Apr 2020 18:07:43 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: decruft the vmalloc API
Message-ID: <20200408160743.GA30662@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408160324.GS25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408160324.GS25745@shell.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, bpf@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

On Wed, Apr 08, 2020 at 05:03:24PM +0100, Russell King - ARM Linux admin wrote:
> I haven't read all your patches yet.
> 
> Have you tested it on 32-bit ARM, where the module area is located
> _below_ PAGE_OFFSET and outside of the vmalloc area?

I have not tested it.  However existing in-kernel users that use
different areas (and we have quite a few of those) have not been
changed at all.  I think the arm32 module loader (like various other
module loaders) falls into that category.
