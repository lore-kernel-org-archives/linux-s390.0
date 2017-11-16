Date: Thu, 16 Nov 2017 10:04:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
In-Reply-To: <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711160958430.2191@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com> <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com> <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com, David Miller <davem@davemloft.net>, Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Steven Rostedt <rostedt@goodmis.org>, Robert Richter <rric@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>, Stefan Haberland <sth@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Nov 2017, Deepa Dinamani wrote:
> > I had on concern about x32, maybe we should check
> > for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
> > bits.
> 
> Thanks, I think you are right. I had the check conditional on
> CONFIG_64BIT_TIME and then removed as I forgot why I added it. :)
> 
> > Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
> > it help to just leave out that part for now and unconditionally
> > define '__kernel_timespec' as 'timespec' until we are ready to
> > convert the architectures?
> 
> Another approach would be to use separate configs:
> 
> 1. To indicate 64 bit time_t syscall support. This will be dependent
> on architectures as CONFIG_64BIT_TIME.
> We can delete this once all architectures have provided support for this.
> 
> 2. Another config (maybe COMPAT_32BIT_TIME?) to be introduced later,
> which will compile out all syscalls/ features that use 32 bit time_t.
> This can help build a y2038 safe kernel later.
> 
> Would this work for everyone?

Having extra config switches which are selectable by architectures and
removed when everything is converted is definitely the right way to go.

That allows you to gradually convert stuff w/o inflicting wreckage all over
the place.

Thanks,

	tglx
