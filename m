Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56847 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbfH3QFV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Aug 2019 12:05:21 -0400
Date: Fri, 30 Aug 2019 18:05:15 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 19/26] arm64: remove __iounmap
Message-ID: <20190830160515.GC26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-20-hch@lst.de> <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:36:02AM +0100, Will Deacon wrote:
> On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> > No need to indirect iounmap for arm64.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/include/asm/io.h | 3 +--
> >  arch/arm64/mm/ioremap.c     | 4 ++--
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> Not sure why we did it like this...
> 
> Acked-by: Will Deacon <will@kernel.org>

Can you just pick this one up through the arm64 tree for 5.4?
