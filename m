MIME-Version: 1.0
In-Reply-To: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com> <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 13:46:30 +0100
Message-ID: <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>, Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>> All the current architecture specific defines for these
>> are the same. Refactor these common defines to a common
>> header file.
>>
>> The new common linux/compat_time.h is also useful as it
>> will eventually be used to hold all the defines that
>> are needed for compat time types that support non y2038
>> safe types. New architectures need not have to define these
>> new types as they will only use new y2038 safe syscalls.
>> This file can be deleted after y2038 when we stop supporting
>> non y2038 safe syscalls.
>
> You are now include a <linux/*.h> from several asm files
> (
>  arch/arm64/include/asm/stat.h
>  arch/s390/include/asm/elf.h
>  arch/x86/include/asm/ftrace.h
>  arch/x86/include/asm/sys_ia32.h
> )
> It works, and it is done in many places, but it looks somewhat weird.
> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
> opinions here.

I don't think we have such a rule. If a header file is common to all
architectures (i.e. no architecture uses a different implementation),
it should be in include/linux rather than include/asm-generic, regardless
of whether it can be used by assembler files or not.

>> --- a/drivers/s390/net/qeth_core_main.c
>> +++ b/drivers/s390/net/qeth_core_main.c
>> @@ -32,7 +32,7 @@
>>  #include <asm/chpid.h>
>>  #include <asm/io.h>
>>  #include <asm/sysinfo.h>
>> -#include <asm/compat.h>
>> +#include <linux/compat.h>
>>  #include <asm/diag.h>
>>  #include <asm/cio.h>
>>  #include <asm/ccwdev.h>
>
> Can you move that into the other includes (where all the other <linux/*> includes are.

Good catch, this is definitely a rule we have ;-)

       Arnd
