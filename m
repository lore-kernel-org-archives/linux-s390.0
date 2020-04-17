Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45351 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDQH20 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 03:28:26 -0400
MIME-Version: 1.0
References: <20200416220130.13343-1-willy@infradead.org>
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2020 09:28:14 +0200
Message-ID: <CAMuHMdWxhVoPCZ5+=Pf1LFpdE9vPv9GGTqTYMQP9oFz7eCxDaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Make PageWriteback use the PageLocked optimisation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux MM <linux-mm@kvack.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, alpha <linux-alpha@vger.kernel.org>, linux-riscv@lists.infradead.org

Hi Matthew,

On Fri, Apr 17, 2020 at 12:01 AM Matthew Wilcox <willy@infradead.org> wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> PageWaiters is used by PageWriteback and PageLocked (and no other page
> flags), so it makes sense to use the same codepaths that have already been
> optimised for PageLocked, even if there's probably no real performance
> benefit to be had.
>
> Unfortunately, clear_bit_unlock_is_negative_byte() isn't present on every
> architecture, and the default implementation is only available in filemap.c
> while I want to use it in page-writeback.c.  Rather than move the default
> implementation to a header file, I've done optimised implementations for
> alpha and ia64.  I can't figure out optimised implementations for m68k,
> mips, riscv and s390, so I've just replicated the effect of the generic
> implementation in them.  I leave it to the experts to fix that (... or
> convert over to using asm-generic/bitops/lock.h ...)
>
> v3:
>  - Added implementations of clear_bit_unlock_is_negative_byte()
>    to architectures which need it

I have two questions here?
  1. Why not implement arch_clear_bit_unlock_is_negative_byte()
     instead, so the kasan check in asm-generic is used everywhere?
  2. Why not add the default implementation to
     include/asm-generic/bitops/instrumented-lock.h, in case an arch_*()
     variant is not provided yet?

Note that you did 1 for s390.
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
