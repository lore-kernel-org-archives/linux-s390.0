Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 10 Apr 2020 16:11:36 -0700
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200410231136.GA101325@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410023845.GA2354@jagdpanzerIV.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, Apr 10, 2020 at 11:38:45AM +0900, Sergey Senozhatsky wrote:
> On (20/04/09 10:08), Minchan Kim wrote:
> > > > Even though I don't know how many usecase we have using zsmalloc as
> > > > module(I heard only once by dumb reason), it could affect existing
> > > > users. Thus, please include concrete explanation in the patch to
> > > > justify when the complain occurs.
> > > 
> > > The justification is 'we can unexport functions that have no sane reason
> > > of being exported in the first place'.
> > > 
> > > The Changelog pretty much says that.
> > 
> > Okay, I hope there is no affected user since this patch.
> > If there are someone, they need to provide sane reason why they want
> > to have zsmalloc as module.
> 
> I'm one of those who use zsmalloc as a module - mainly because I use zram
> as a compressing general purpose block device, not as a swap device.
> I create zram0, mkfs, mount, checkout and compile code, once done -
> umount, rmmod. This reduces the number of writes to SSD. Some people use
> tmpfs, but zram device(-s) can be much larger in size. That's a niche use
> case and I'm not against the patch.

It doesn't mean we couldn't use zsmalloc as module any longer. It means
we couldn't use zsmalloc as module with pgtable mapping whcih was little
bit faster on microbenchmark in some architecutre(However, I usually temped
to remove it since it had several problems). However, we could still use
zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
really want to rollback the feature, they should provide reasonable reason
why it doesn't work for them. "A little fast" wouldn't be enough to exports
deep internal to the module.

Thanks.
