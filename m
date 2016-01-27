Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 27 Jan 2016 11:40:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160127104032.GB2939@linux-mips.org>
References: <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <56983054.4070807@imgtec.com>
 <20160115004753.GN3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115004753.GN3818@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160127104032.B2B_95pqHGYa6LH58_EmZ7g7Ck-P1q3xKsJp6N6HSho@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 14, 2016 at 04:47:53PM -0800, Paul E. McKenney wrote:

> So you need to build a different kernel for some types of MIPS systems?

Yes.  We can't really do without.  Classic MIPS code is not relocatable
without the complexity of PIC code as used by ELF DSOs - and their
performanc penalty.  Plus we have a number of architecture revisions
ovr the decades, big and little endian, 32 and 64 bit as the major
stumbling stones.  There however are groups of similar systems that
can share kernel binaries.

> Or do you do boot-time rewriting, like a number of other arches do?

We don't rewrite the code (as in the .text of the vmlinux binary) but we
do runtime code generation for a few highly performance sensitive area
of the kernel code such as copy_page() or TLB exception handlers.  This
allows more flexibility than just inserting templates into the kernel
code.  Downside - it means we have some of the complexity of as and ld
in the kernel.

  Ralf
