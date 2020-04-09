Return-Path: <bpf-owner@vger.kernel.org>
Date: Thu, 9 Apr 2020 16:52:09 +0100
From: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 01/28] x86/hyperv: use vmalloc_exec for the hypercall page
Message-ID: <20200409155209.4tqaipnwifcsrmda@debian>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-2-hch@lst.de>
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 01:58:59PM +0200, Christoph Hellwig wrote:
> Use the designated helper for allocating executable kernel memory, and
> remove the now unused PAGE_KERNEL_RX define.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Wei Liu <wei.liu@kernel.org>
