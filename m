MIME-Version: 1.0
In-Reply-To: <CABeXuvrtQfSsOipGTnfmONXS45Dqxy4_T7MAcfO4VajoSycW4w@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
 <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com>
 <CAK8P3a26g74UA5J5uQLwdjK3hq+htzjrdTYRKqfy_MawY7st+g@mail.gmail.com> <CABeXuvrtQfSsOipGTnfmONXS45Dqxy4_T7MAcfO4VajoSycW4w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Nov 2017 22:12:23 +0100
Message-ID: <CAK8P3a2ho3S3NYp4VL7kOAk-bg3bsUmLaJJVEvNfzPoEue3v3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
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
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com, David Miller <davem@davemloft.net>, Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Steven Rostedt <rostedt@goodmis.org>, Robert Richter <rric@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>, Stefan Haberland <sth@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 29, 2017 at 12:17 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Tue, Nov 28, 2017 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Nov 27, 2017 at 11:29 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Right. There are three options:
>
> 1. Use two configs to identify which syscalls need not be supported by
> new architectures.
> In this case it makes sense to say LEGACY_TIME_SYSCALLS and
> COMPAT_32BIT_TIME both need to be disabled for new architectures. And,
> I can reword the config to what you mention below.
>
> 2. Make the LEGACY_TIME_SYSCALLS eliminate non y2038 safe syscalls
> mentioned below only.
> In this case only the native and compat functions of the below
> mentioned syscalls need to be identified by the config. I like this
> option as this clearly identifies which syscalls are deprecated and do
> not have a 64 bit counterpart. Not all architectures need to support
> turning this off.
>
> 3. If we don't need either 1 or 2, then we could stick with what we
> have today in the series as CONFIG_64BIT_TIME will be deleted and they
> only need #ifdef CONFIG_64BIT.
>
> Let me know if anyone prefers something else.

I think I prefer to have both LEGACY_TIME_SYSCALLS to guard
the native deprecated syscalls (disabled on 32-bit architectures after
the conversion, and enabled on 64-bit architectures until
we merge the next one), and COMPAT_32BIT_TIME to guard the
compat versions of both the deprecated and the non-deprecated
syscalls (enabled on all existing 32-bit architectures after the
conversion, and on 64-bit architectures if they provide a compat
mode for the former).

Those two are not symmetric, but I think those are the most
common combinations, and the Kconfig symbol helps document
what they are.

There is one more category for things like io_getevents() and
rt_sigtimedwait that also need two separate compat versions,
one for 32-bit time_t and one for 64-bit time_t, but it seems better
to deal with those case-by-case rather than introducing another
Kconfig symbol.

        Arnd
