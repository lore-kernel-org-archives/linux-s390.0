Return-Path: <bpf-owner@vger.kernel.org>
Date: Thu, 9 Apr 2020 10:08:13 -0700
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409170813.GD247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165030.GG20713@hirez.programming.kicks-ass.net>
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com

On Thu, Apr 09, 2020 at 06:50:30PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 09, 2020 at 09:08:26AM -0700, Minchan Kim wrote:
> > On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> > > This allows to unexport map_vm_area and unmap_kernel_range, which are
> > > rather deep internal and should not be available to modules.
> > 
> > Even though I don't know how many usecase we have using zsmalloc as
> > module(I heard only once by dumb reason), it could affect existing
> > users. Thus, please include concrete explanation in the patch to
> > justify when the complain occurs.
> 
> The justification is 'we can unexport functions that have no sane reason
> of being exported in the first place'.
> 
> The Changelog pretty much says that.

Okay, I hope there is no affected user since this patch.
If there are someone, they need to provide sane reason why they want
to have zsmalloc as module.

Acked-by: Minchan Kim <minchan@kernel.org>
