Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56891 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbfH3QGj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Aug 2019 12:06:39 -0400
Date: Fri, 30 Aug 2019 18:06:35 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/26] mips: remove ioremap_cachable
Message-ID: <20190830160635.GE26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-5-hch@lst.de> <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, Aug 19, 2019 at 08:57:30PM +0000, Paul Burton wrote:
> Hi Christoph,
> 
> On Sat, Aug 17, 2019 at 09:32:31AM +0200, Christoph Hellwig wrote:
> > Just define ioremap_cache directly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Paul Burton <paul.burton@mips.com>

Can you pick this patch up through the mips tree?
