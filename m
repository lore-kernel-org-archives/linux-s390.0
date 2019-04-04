Return-Path: <SRS0=X2Y2=SG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
Date: Thu, 04 Apr 2019 17:08:59 +1100
Message-ID: <87imvu1ev8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Jens Axboe <axboe@kernel.dk>, Will Deacon <will.deacon@arm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:
> On 4/3/19 5:11 AM, Will Deacon wrote:
>> On Wed, Apr 03, 2019 at 01:47:50PM +1100, Michael Ellerman wrote:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> index b18abb0c3dae..00f5a63c8d9a 100644
>>>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> @@ -505,3 +505,7 @@
>>>>  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
>>>>  422	32	futex_time64			sys_futex			sys_futex
>>>>  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
>>>> +424	common	pidfd_send_signal		sys_pidfd_send_signal
>>>> +425	common	io_uring_setup			sys_io_uring_setup
>>>> +426	common	io_uring_enter			sys_io_uring_enter
>>>> +427	common	io_uring_register		sys_io_uring_register
>>>
>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>>>
>>> Lightly tested.
>>>
>>> The pidfd_test selftest passes.
>> 
>> That reports pass for me too, although it fails to unshare the pid ns, which I
>> assume is benign.

If you run it as root it should work?

>>> Ran the io_uring example from fio, which prints lots of:
>> 
>> How did you invoke that? I had a play with the tests in:
>
> It's t/io_uring from the fio repo:
>
> git://git.kernel.dk/fio
>
> and you just run it ala:
>
> # make t/io_uring
> # t/io_uring /dev/some_device

Yeah that's all I did.

>> will@autoplooker:~/liburing/test$ ./io_uring_register 
>> RELIMIT_MEMLOCK: 67108864 (67108864)
>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>> [   35.478969] Mem abort info:
>> [   35.479296]   ESR = 0x96000004
>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
>> [   35.480528]   SET = 0, FnV = 0
>> [   35.480980]   EA = 0, S1PTW = 0
>> [   35.481345] Data abort info:
>> [   35.481680]   ISV = 0, ISS = 0x00000004
>> [   35.482267]   CM = 0, WnR = 0
>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [   35.483486] [0000000000000070] pgd=0000000000000000
>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [   35.484788] Modules linked in:
>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
>> [   35.486712] Hardware name: linux,dummy-virt (DT)
>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
>> [   35.488228] pc : link_pwq+0x10/0x60
>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
>> [   35.489550] sp : ffff000017e2bbc0
>
> Huh, this looks odd, it's crashing inside the wq setup.

Looks like you found a bug :)

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
