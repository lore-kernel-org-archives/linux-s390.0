MIME-Version: 1.0
In-Reply-To: <201803132351.1SZJ68nV%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com> <201803132351.1SZJ68nV%fengguang.wu@intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 13 Mar 2018 20:56:19 -0700
Message-ID: <CABeXuvp617xkFgMDz8WR_=e6tj2d5LDpF56R-iXCOAqM=tdm+A@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] include: Move compat_timespec/ timeval to compat_time.h
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
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
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Will Deacon <will.deacon@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>, Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

This is again a tricky include file ordering when linux/compat.h is
included instead of asm/compat.h. is_compat_task() is unconditionally
defined in linux/compat.h as a macro which conflicts with inline
function define in asm/compat.h for this arch.
As before, I will do the simple thing here and leave the asm/compat.h
to keep this series simple.
I will submit follow up patches to eliminate direct inclusion asm/compat.h.

I will include this also in the update.

-Deepa

On Tue, Mar 13, 2018 at 8:30 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
> base:
> config: powerpc-iss476-smp_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/oprofile/backtrace.c: In function 'user_getsp32':
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: implicit declaration of function 'compat_ptr'; did you mean 'complete'? [-Werror=implicit-function-declaration]
>      void __user *p = compat_ptr(sp);
>                       ^~~~~~~~~~
>                       complete
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
>    cc1: all warnings being treated as errors
>
> vim +31 arch/powerpc/oprofile/backtrace.c
>
> 6c6bd754 Brian Rogan 2006-03-27  27
> 6c6bd754 Brian Rogan 2006-03-27  28  static unsigned int user_getsp32(unsigned int sp, int is_first)
> 6c6bd754 Brian Rogan 2006-03-27  29  {
> 6c6bd754 Brian Rogan 2006-03-27  30     unsigned int stack_frame[2];
> 62034f03 Al Viro     2006-09-23 @31     void __user *p = compat_ptr(sp);
> 6c6bd754 Brian Rogan 2006-03-27  32
> 62034f03 Al Viro     2006-09-23  33     if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  34             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  35
> 6c6bd754 Brian Rogan 2006-03-27  36     /*
> 6c6bd754 Brian Rogan 2006-03-27  37      * The most likely reason for this is that we returned -EFAULT,
> 6c6bd754 Brian Rogan 2006-03-27  38      * which means that we've done all that we can do from
> 6c6bd754 Brian Rogan 2006-03-27  39      * interrupt context.
> 6c6bd754 Brian Rogan 2006-03-27  40      */
> 62034f03 Al Viro     2006-09-23  41     if (__copy_from_user_inatomic(stack_frame, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  42             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  43
> 6c6bd754 Brian Rogan 2006-03-27  44     if (!is_first)
> 6c6bd754 Brian Rogan 2006-03-27  45             oprofile_add_trace(STACK_LR32(stack_frame));
> 6c6bd754 Brian Rogan 2006-03-27  46
> 6c6bd754 Brian Rogan 2006-03-27  47     /*
> 6c6bd754 Brian Rogan 2006-03-27  48      * We do not enforce increasing stack addresses here because
> 6c6bd754 Brian Rogan 2006-03-27  49      * we may transition to a different stack, eg a signal handler.
> 6c6bd754 Brian Rogan 2006-03-27  50      */
> 6c6bd754 Brian Rogan 2006-03-27  51     return STACK_SP(stack_frame);
> 6c6bd754 Brian Rogan 2006-03-27  52  }
> 6c6bd754 Brian Rogan 2006-03-27  53
>
> :::::: The code at line 31 was first introduced by commit
> :::::: 62034f03380a64c0144b6721f4a2aa55d65346c1 [POWERPC] powerpc oprofile __user annotations
>
> :::::: TO: Al Viro <viro@ftp.linux.org.uk>
> :::::: CC: Paul Mackerras <paulus@samba.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
