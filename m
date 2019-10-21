Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfJUIXQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Oct 2019 04:23:16 -0400
Date: Mon, 21 Oct 2019 10:23:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 08/21] x86: clean up ioremap
In-Reply-To: <20191017174554.29840-9-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1910211019540.1904@nanos.tec.linutronix.de>
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

Please change the subject to:

       x86/mm: Cleanup ioremap()

> Use ioremap as the main implemented function, and defined

ioremap() please

s/defined/define/

> ioremap_nocache to it as a deprecated alias.

ioremap_nocache() as a deprecated alias of ioremap().

Aside of that this lacks any form of rationale. Please add some WHY to it.

Should this go with your larger series or can this be picked up
independently?

Thanks,

	tglx
