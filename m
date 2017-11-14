MIME-Version: 1.0
In-Reply-To: <20171110224259.15930-1-deepa.kernel@gmail.com>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Nov 2017 15:24:40 +0100
Message-ID: <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t conversion
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com, David Miller <davem@davemloft.net>, Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Steven Rostedt <rostedt@goodmis.org>, rric@kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>, Stefan Haberland <sth@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 10, 2017 at 11:42 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html
>
> Big picture is as per the lwn article:
> https://lwn.net/Articles/643234/
>
> The series is directed at converting posix clock syscalls:
> clock_gettime, clock_settime, clock_getres and clock_nanosleep
> to use a new data structure __kernel_timespec at syscall boundaries.
> __kernel_timespec maintains 64 bit time_t across all execution modes.
>
> vdso will be handled as part of each architecture when they enable
> support for 64 bit time_t.
>
> The compat syscalls are repurposed to provide backward compatibility
> by using them as native syscalls as well for 32 bit architectures.
> They will continue to use timespec at syscall boundaries.
>
> CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
> or timespec at syscall boundaries.
>
> The series does the following:
> 1. Enable compat syscalls unconditionally.
> 2. Add a new __kernel_timespec type to be used as the data structure
>    for all the new syscalls.
> 3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
>    [1] and [2] to switch to new definition of __kernel_timespec. It is
>    the same as struct timespec otherwise.
>
> Arnd Bergmann (1):
>   y2038: introduce CONFIG_64BIT_TIME

The series looks good to me overall, and I've added it to my build-testing tree
to see if it shows any regressions in random configurations.

I had on concern about x32, maybe we should check
for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
bits.

Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
it help to just leave out that part for now and unconditionally
define '__kernel_timespec' as 'timespec' until we are ready to
convert the architectures?

       Arnd
