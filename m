Return-Path: <linux-arch-owner@vger.kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory include/asm header
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Date: Fri, 17 Jan 2020 10:43:34 +0100
Message-ID: <87y2u6cta1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eumichal.simek@xilinx.com, git@xilinx.com, Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Michal Simek <michal.simek@xilinx.com> writes:

> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
>
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
