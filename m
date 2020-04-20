Return-Path: <bpf-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de> <20200414131348.444715-27-hch@lst.de>
In-Reply-To: <20200414131348.444715-27-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 11:26:19 +0200
Message-ID: <CAMuHMdXO0TV09XYxyxjEA8YdvXVwg1u6Zs=z3PzCVb9Mw5boTQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] mm: remove vmalloc_user_node_flags
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Linux-Arch <linux-arch@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, Linux MM <linux-mm@kvack.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, bpf <bpf@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Christoph,

On Tue, Apr 14, 2020 at 3:22 PM Christoph Hellwig <hch@lst.de> wrote:
> Open code it in __bpf_map_area_alloc, which is the only caller.  Also
> clean up __bpf_map_area_alloc to have a single vmalloc call with
> slightly different flags instead of the current two different calls.
>
> For this to compile for the nommu case add a __vmalloc_node_range stub
> to nommu.c.

Apparently your nommu-cross-compilers are in quarantaine? ;-)

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,6 +150,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> +void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +               unsigned long start, unsigned long end, gfp_t gfp_mask,
> +               pgprot_t prot, unsigned long vm_flags, int node,
> +               const void *caller)
> +{
> +       return __vmalloc(size, flags);

On Mon, Apr 20, 2020 at 10:39 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Mon Apr 20, 18:38
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14213623/
>
> mm/nommu.c:158:25: error: 'flags' undeclared (first use in this function); did you mean 'class'?

"return __vmalloc(size, gfp_mask);", I assume?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
