Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Sep 2019 09:42:15 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
Message-Id: <20190925064214.GB1857@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

(updated CC)

Hi,

On Tue, Sep 24, 2019 at 12:52:35PM -0500, Adam Ford wrote:
> On Mon, Jan 21, 2019 at 2:05 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Hi,
> >
> > v2 changes:
> > * replace some more %lu with %zu
> > * remove panics where they are not needed in s390 and in printk
> > * collect Acked-by and Reviewed-by.
> >
> >
> > Christophe Leroy (1):
> >   powerpc: use memblock functions returning virtual address
> >
> > Mike Rapoport (20):
> >   openrisc: prefer memblock APIs returning virtual address
> >   memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phys_alloc
> >   memblock: drop memblock_alloc_base_nid()
> >   memblock: emphasize that memblock_alloc_range() returns a physical address
> >   memblock: memblock_phys_alloc_try_nid(): don't panic
> >   memblock: memblock_phys_alloc(): don't panic
> >   memblock: drop __memblock_alloc_base()
> >   memblock: drop memblock_alloc_base()
> >   memblock: refactor internal allocation functions
> >   memblock: make memblock_find_in_range_node() and choose_memblock_flags() static
> >   arch: use memblock_alloc() instead of memblock_alloc_from(size, align, 0)
> >   arch: don't memset(0) memory returned by memblock_alloc()
> >   ia64: add checks for the return value of memblock_alloc*()
> >   sparc: add checks for the return value of memblock_alloc*()
> >   mm/percpu: add checks for the return value of memblock_alloc*()
> >   init/main: add checks for the return value of memblock_alloc*()
> >   swiotlb: add checks for the return value of memblock_alloc*()
> >   treewide: add checks for the return value of memblock_alloc*()
> >   memblock: memblock_alloc_try_nid: don't panic
> >   memblock: drop memblock_alloc_*_nopanic() variants
> >
> I know it's rather late, but this patch broke the Etnaviv 3D graphics
> in my i.MX6Q.
 
Can you identify the exact patch from the series that caused the
regression?

> When I try to use the 3D, it returns some errors and the dmesg log
> shows some memory allocation errors too:
> [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> memory window
> [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> memory window
> [    3.760583] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> [    3.766766] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
> [    3.776131] [drm] Initialized etnaviv 1.2.0 20151214 for etnaviv on minor 0
> 
> # glmark2-es2-drm
> Error creating gpu
> Error: eglCreateWindowSurface failed with error: 0x3009
> Error: eglCreateWindowSurface failed with error: 0x3009
> Error: CanvasGeneric: Invalid EGL state
> Error: main: Could not initialize canvas
> 
> 
> Before this patch:
> 
> [    3.691995] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    3.698356] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> [    3.704792] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> [    3.710488] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> [    3.733649] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> [    3.756115] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> [    3.762250] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
> [    3.771432] [drm] Initialized etnaviv 1.2.0 20151214 for etnaviv on minor 0
> 
> and the 3D gemos work without this.
> 
> I don't know enough about the i.MX6 nor the 3D accelerator to know how
> to fix it.
> I am hoping someone in the know might have some suggestions.

Can you please add "memblock=debug" to your kernel command line and send
kernel logs for both working and failing versions? 

-- 
Sincerely yours,
Mike.
