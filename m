Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42136 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIuy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Aug 2019 04:50:54 -0400
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-4-hch@lst.de>
In-Reply-To: <20190817073253.27819-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 10:50:41 +0200
Message-ID: <CAMuHMdVT3VSQ1S=YEoTjYzxwpavy+43XUWA-wzCO56FuHK6R-g@mail.gmail.com>
Subject: Re: [PATCH 03/26] m68k, microblaze: remove ioremap_fullcache
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, the arch/x86 maintainers <x86@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, MTD Maling List <linux-mtd@lists.infradead.org>, alpha <linux-alpha@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sat, Aug 17, 2019 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
> No callers of this function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/kmap.h     | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
