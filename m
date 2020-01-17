Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:51849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgAQKK3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jan 2020 05:10:29 -0500
MIME-Version: 1.0
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Jan 2020 11:10:09 +0100
Message-ID: <CAK8P3a3bfO9EdL6o4+yY5BCw0pc1ANYocVjyohmG34jcjLiWpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, git@xilinx.com, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Paul Burton <paulburton@kernel.org>, Borislav Petkov <bp@alien8.de>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, the arch/x86 maintainers <x86@kernel.org>, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Fri, Jan 17, 2020 at 9:03 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
>
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - New patch suggested by Christoph

Acked-by: Arnd Bergmann <arnd@arndb.de>
