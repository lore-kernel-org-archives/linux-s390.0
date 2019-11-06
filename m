Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34492 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKFSQu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 13:16:50 -0500
MIME-Version: 1.0
References: <20191029064834.23438-12-hch@lst.de> <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
In-Reply-To: <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Nov 2019 19:16:38 +0100
Message-ID: <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
Subject: Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, Greentime Hu <green.hu@gmail.com>, MTD Maling List <linux-mtd@lists.infradead.org>, Guan Xuetao <gxt@pku.edu.cn>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, linux-mips@vger.kernel.org, alpha <linux-alpha@vger.kernel.org>, nios2-dev@lists.rocketboards.org

Hi Palmer,

On Wed, Nov 6, 2019 at 7:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> It looks like the difference in prototype between the architectures is between
>
>     void __iomem *ioremap(resource_size_t, size_t)
>     void __iomem *ioremap(phys_addr_t, size_t)
>     void __iomem *ioremap(phys_addr_t, unsigned long)
>     void __iomem *ioremap(unsigned long, unsigned long)
>
> shouldn't they all just be that first one?  In other words, wouldn't it be
> better to always provide the generic ioremap prototype and unify the ports
> instead?

Agreed. But I'd go for the second one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
