Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44977 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfHSI4P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Aug 2019 04:56:15 -0400
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-9-hch@lst.de>
In-Reply-To: <20190817073253.27819-9-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 10:56:02 +0200
Message-ID: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
Subject: Re: [PATCH 08/26] m68k: simplify ioremap_nocache
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, the arch/x86 maintainers <x86@kernel.org>, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, MTD Maling List <linux-mtd@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Christoph,

On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> Just define ioremap_nocache to ioremap instead of duplicating the
> inline.  Also defined ioremap_uc in terms of ioremap instead of
> the using a double indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, shouldn't we get rid of the sole user of ioremap_uc(), too?
Seems to make a difference on x86 only, where it is "strongly uncached"
(whatever that may mean ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
