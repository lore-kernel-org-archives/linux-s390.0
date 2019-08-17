Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:33236 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfHQVHb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 17 Aug 2019 17:07:31 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so13208464iog.0
        for <linux-s390@vger.kernel.org>; Sat, 17 Aug 2019 14:07:31 -0700 (PDT)
Date: Sat, 17 Aug 2019 14:07:29 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 15/26] asm-generic: ioremap_uc should behave the same
 with and without MMU
In-Reply-To: <20190817073253.27819-16-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908171403330.4130@viisi.sifive.com>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-mtd@lists.infradead.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Sat, 17 Aug 2019, Christoph Hellwig wrote:

> Whatever reason there is for the existence of ioremap_uc, and the fact 
> that it returns NULL by default on architectures with an MMU applies 
> equally to nommu architectures, so don't provide different defaults.
> 
> In practice the difference is meaningless as the only portable driver
> that uses ioremap_uc is atyfb which probably doesn't show up on nommu
> devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[ ... ]

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d02806513670..a98ed6325727 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h

[ ... ]

> @@ -1004,6 +985,21 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
>  }
>  #endif
>  
> +/*
> + * ioremap_uc is special in that we do require an explicit architecture
> + * implementation.  In general you do now want to use this function in a
                                         ^^^ not

> + * driver and use plain ioremap, which is uncached by default.  Similarly
                ^ instead 

> + * architectures should not implement it unless they have a very good
> + * reason.
> + */

Looks like this mess is only needed on x86 with certain graphics drivers 
and conflicts between MTRR and page table-based MMU attributes.


Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # rv32, rv64 boot


- Paul
