Return-Path: <SRS0=/4+2=SF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <20190325144737.703921-1-arnd@arndb.de>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
Date: Wed, 03 Apr 2019 13:47:50 +1100
Message-ID: <87tvff24a1.fsf@concordia.ellerman.id.au>
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
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>, linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Jens Axboe <axboe@kernel.dk>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index b18abb0c3dae..00f5a63c8d9a 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -505,3 +505,7 @@
>  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
>  422	32	futex_time64			sys_futex			sys_futex
>  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
> +424	common	pidfd_send_signal		sys_pidfd_send_signal
> +425	common	io_uring_setup			sys_io_uring_setup
> +426	common	io_uring_enter			sys_io_uring_enter
> +427	common	io_uring_register		sys_io_uring_register

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Lightly tested.

The pidfd_test selftest passes.

Ran the io_uring example from fio, which prints lots of:

IOPS=209952, IOS/call=32/32, inflight=117 (117), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=116 (116), Cachehit=0.00%
IOPS=209920, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209920, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=114 (114), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=112 (112), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=110 (110), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=105 (105), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=104 (104), Cachehit=0.00%
IOPS=210080, IOS/call=32/32, inflight=102 (102), Cachehit=0.00%
IOPS=210112, IOS/call=32/32, inflight=100 (100), Cachehit=0.00%
IOPS=210080, IOS/call=32/32, inflight=97 (97), Cachehit=0.00%
IOPS=210112, IOS/call=32/32, inflight=97 (97), Cachehit=0.00%
IOPS=210112, IOS/call=32/31, inflight=126 (126), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=126 (126), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=125 (125), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=119 (119), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=117 (117), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=114 (114), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=111 (111), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=108 (108), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=107 (107), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=105 (105), Cachehit=0.00%

Which is good I think?


cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
