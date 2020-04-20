Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40061 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgDTJ2I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Apr 2020 05:28:08 -0400
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de> <20200414131348.444715-25-hch@lst.de>
In-Reply-To: <20200414131348.444715-25-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 11:27:56 +0200
Message-ID: <CAMuHMdXktO=2n1tbE5RWRfE1CMd9bP-aHJQifO3J9HYxoQEuXQ@mail.gmail.com>
Subject: Re: [PATCH 24/29] mm: remove __vmalloc_node_flags_caller
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Linux-Arch <linux-arch@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, Linux MM <linux-mm@kvack.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Christoph,

On Tue, Apr 14, 2020 at 3:21 PM Christoph Hellwig <hch@lst.de> wrote:
> Just use __vmalloc_node instead which gets and extra argument.  To be
> able to to use __vmalloc_node in all caller make it available outside
> of vmalloc and implement it in nommu.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

One more nommu failure below...

> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,8 +150,8 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> -void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
> -               void *caller)
> +void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> +               int node, const void *caller)
>  {
>         return __vmalloc(size, flags);

On Mon, Apr 20, 2020 at 10:39 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Mon Apr 20, 18:38
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14213623/
>
> mm/nommu.c:164:25: error: 'flags' undeclared (first use in this function); did you mean 'class'?

"return __vmalloc(size, gfp_mask);"

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
