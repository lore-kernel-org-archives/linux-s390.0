Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:41619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKKLV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Nov 2019 05:11:21 -0500
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-18-hch@lst.de>
In-Reply-To: <20191029064834.23438-18-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 11:10:59 +0100
Message-ID: <CAK8P3a0zfmup8DYQQnT3GNCkgcv9cWxejj2QAr+FmYWs46ZuHQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] lib: provide a simple generic ioremap implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, the arch/x86 maintainers <x86@kernel.org>, alpha <linux-alpha@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-mtd <linux-mtd@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> A lot of architectures reuse the same simple ioremap implementation, so
> start lifting the most simple variant to lib/ioremap.c.  It provides
> ioremap_prot and iounmap, plus a default ioremap that uses prot_noncached,
> although that can be overridden by asm/io.h.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
