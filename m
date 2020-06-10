Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgFJFzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Jun 2020 01:55:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7BFC03E96B
        for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2020 22:55:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w90so860004qtd.8
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2020 22:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200610052154.5180-1-cai@lca.pw>
In-Reply-To: <20200610052154.5180-1-cai@lca.pw>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 10 Jun 2020 07:54:50 +0200
Message-ID: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Potapenko <glider@google.com>, Kees Cook <keescook@chromium.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
>
> kernel_init_free_pages() will use memset() on s390 to clear all pages
> from kmalloc_order() which will override KASAN redzones because a
> redzone was setup from the end of the allocation size to the end of the
> last page. Silence it by not reporting it there. An example of the
> report is,

Interesting. The reason why we did not hit it on x86_64 is because
clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
thus is not instrumented. Arm64 probably does the same. However, on
s390 clear_page is defined to memset.
clear_[high]page are pretty extensively used in the kernel.
We can either do this, or make clear_page non instrumented on s390 as
well to match the existing implicit assumption. The benefit of the
current approach is that we can find some real use-after-free's and
maybe out-of-bounds on clear_page. The downside is that we may need
more of these annotations. Thoughts?

>  BUG: KASAN: slab-out-of-bounds in __free_pages_ok
>  Write of size 4096 at addr 000000014beaa000
>  Call Trace:
>  show_stack+0x152/0x210
>  dump_stack+0x1f8/0x248
>  print_address_description.isra.13+0x5e/0x4d0
>  kasan_report+0x130/0x178
>  check_memory_region+0x190/0x218
>  memset+0x34/0x60
>  __free_pages_ok+0x894/0x12f0
>  kfree+0x4f2/0x5e0
>  unpack_to_rootfs+0x60e/0x650
>  populate_rootfs+0x56/0x358
>  do_one_initcall+0x1f4/0xa20
>  kernel_init_freeable+0x758/0x7e8
>  kernel_init+0x1c/0x170
>  ret_from_fork+0x24/0x28
>  Memory state around the buggy address:
>  000000014bea9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  000000014bea9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >000000014beaa000: 03 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                     ^
>  000000014beaa080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  000000014beaa100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>
> Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 727751219003..9954973f89a3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1164,8 +1164,11 @@ static void kernel_init_free_pages(struct page *page, int numpages)
>  {
>         int i;
>
> +       /* s390's use of memset() could override KASAN redzones. */
> +       kasan_disable_current();
>         for (i = 0; i < numpages; i++)
>                 clear_highpage(page + i);
> +       kasan_enable_current();
>  }
>
>  static __always_inline bool free_pages_prepare(struct page *page,
> --
> 2.21.0 (Apple Git-122.2)
>
