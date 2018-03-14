MIME-Version: 1.0
In-Reply-To: <201803132313.a4R8Y434%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com> <201803132313.a4R8Y434%fengguang.wu@intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 13 Mar 2018 20:50:31 -0700
Message-ID: <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
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
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, kbuild-all@01.org, Stefan Haberland <sth@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The file arch/arm64/kernel/process.c needs asm/compat.h also to be
included directly since this is included conditionally from
include/compat.h. This does seem to be typical of arm64 as I was not
completely able to get rid of asm/compat.h includes for arm64 in this
series. My plan is to have separate patches to get rid of asm/compat.h
includes for the architectures that are not straight forward to keep
this series simple.
I will fix this and update the series.

-Deepa


On Tue, Mar 13, 2018 at 8:22 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
> base:
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>    arch/arm64/kernel/process.c: In function 'copy_thread':
>>> arch/arm64/kernel/process.c:342:8: error: implicit declaration of function 'is_compat_thread'; did you mean 'is_compat_task'? [-Werror=implicit-function-declaration]
>        if (is_compat_thread(task_thread_info(p)))
>            ^~~~~~~~~~~~~~~~
>            is_compat_task
>    cc1: some warnings being treated as errors
>
> vim +342 arch/arm64/kernel/process.c
>
> b3901d54d Catalin Marinas  2012-03-05  307
> b3901d54d Catalin Marinas  2012-03-05  308  int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> afa86fc42 Al Viro          2012-10-22  309              unsigned long stk_sz, struct task_struct *p)
> b3901d54d Catalin Marinas  2012-03-05  310  {
> b3901d54d Catalin Marinas  2012-03-05  311      struct pt_regs *childregs = task_pt_regs(p);
> b3901d54d Catalin Marinas  2012-03-05  312
> c34501d21 Catalin Marinas  2012-10-05  313      memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
> c34501d21 Catalin Marinas  2012-10-05  314
> bc0ee4760 Dave Martin      2017-10-31  315      /*
> bc0ee4760 Dave Martin      2017-10-31  316       * Unalias p->thread.sve_state (if any) from the parent task
> bc0ee4760 Dave Martin      2017-10-31  317       * and disable discard SVE state for p:
> bc0ee4760 Dave Martin      2017-10-31  318       */
> bc0ee4760 Dave Martin      2017-10-31  319      clear_tsk_thread_flag(p, TIF_SVE);
> bc0ee4760 Dave Martin      2017-10-31  320      p->thread.sve_state = NULL;
> bc0ee4760 Dave Martin      2017-10-31  321
> 071b6d4a5 Dave Martin      2017-12-05  322      /*
> 071b6d4a5 Dave Martin      2017-12-05  323       * In case p was allocated the same task_struct pointer as some
> 071b6d4a5 Dave Martin      2017-12-05  324       * other recently-exited task, make sure p is disassociated from
> 071b6d4a5 Dave Martin      2017-12-05  325       * any cpu that may have run that now-exited task recently.
> 071b6d4a5 Dave Martin      2017-12-05  326       * Otherwise we could erroneously skip reloading the FPSIMD
> 071b6d4a5 Dave Martin      2017-12-05  327       * registers for p.
> 071b6d4a5 Dave Martin      2017-12-05  328       */
> 071b6d4a5 Dave Martin      2017-12-05  329      fpsimd_flush_task_state(p);
> 071b6d4a5 Dave Martin      2017-12-05  330
> 9ac080021 Al Viro          2012-10-21  331      if (likely(!(p->flags & PF_KTHREAD))) {
> 9ac080021 Al Viro          2012-10-21  332              *childregs = *current_pt_regs();
> b3901d54d Catalin Marinas  2012-03-05  333              childregs->regs[0] = 0;
> d00a3810c Will Deacon      2015-05-27  334
> b3901d54d Catalin Marinas  2012-03-05  335              /*
> b3901d54d Catalin Marinas  2012-03-05  336               * Read the current TLS pointer from tpidr_el0 as it may be
> b3901d54d Catalin Marinas  2012-03-05  337               * out-of-sync with the saved value.
> b3901d54d Catalin Marinas  2012-03-05  338               */
> adf758999 Mark Rutland     2016-09-08  339              *task_user_tls(p) = read_sysreg(tpidr_el0);
> d00a3810c Will Deacon      2015-05-27  340
> e0fd18ce1 Al Viro          2012-10-18  341              if (stack_start) {
> d00a3810c Will Deacon      2015-05-27 @342                      if (is_compat_thread(task_thread_info(p)))
> d00a3810c Will Deacon      2015-05-27  343                              childregs->compat_sp = stack_start;
> d00a3810c Will Deacon      2015-05-27  344                      else
> b3901d54d Catalin Marinas  2012-03-05  345                              childregs->sp = stack_start;
> b3901d54d Catalin Marinas  2012-03-05  346              }
> d00a3810c Will Deacon      2015-05-27  347
> c34501d21 Catalin Marinas  2012-10-05  348              /*
> c34501d21 Catalin Marinas  2012-10-05  349               * If a TLS pointer was passed to clone (4th argument), use it
> c34501d21 Catalin Marinas  2012-10-05  350               * for the new thread.
> c34501d21 Catalin Marinas  2012-10-05  351               */
> b3901d54d Catalin Marinas  2012-03-05  352              if (clone_flags & CLONE_SETTLS)
> d00a3810c Will Deacon      2015-05-27  353                      p->thread.tp_value = childregs->regs[3];
> c34501d21 Catalin Marinas  2012-10-05  354      } else {
> c34501d21 Catalin Marinas  2012-10-05  355              memset(childregs, 0, sizeof(struct pt_regs));
> c34501d21 Catalin Marinas  2012-10-05  356              childregs->pstate = PSR_MODE_EL1h;
> 57f4959ba James Morse      2016-02-05  357              if (IS_ENABLED(CONFIG_ARM64_UAO) &&
> a4023f682 Suzuki K Poulose 2016-11-08  358                  cpus_have_const_cap(ARM64_HAS_UAO))
> 57f4959ba James Morse      2016-02-05  359                      childregs->pstate |= PSR_UAO_BIT;
> c34501d21 Catalin Marinas  2012-10-05  360              p->thread.cpu_context.x19 = stack_start;
> c34501d21 Catalin Marinas  2012-10-05  361              p->thread.cpu_context.x20 = stk_sz;
> c34501d21 Catalin Marinas  2012-10-05  362      }
> c34501d21 Catalin Marinas  2012-10-05  363      p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
> c34501d21 Catalin Marinas  2012-10-05  364      p->thread.cpu_context.sp = (unsigned long)childregs;
> b3901d54d Catalin Marinas  2012-03-05  365
> b3901d54d Catalin Marinas  2012-03-05  366      ptrace_hw_copy_thread(p);
> b3901d54d Catalin Marinas  2012-03-05  367
> b3901d54d Catalin Marinas  2012-03-05  368      return 0;
> b3901d54d Catalin Marinas  2012-03-05  369  }
> b3901d54d Catalin Marinas  2012-03-05  370
>
> :::::: The code at line 342 was first introduced by commit
> :::::: d00a3810c16207d2541b7796a73cca5a24ea3742 arm64: context-switch user tls register tpidr_el0 for compat tasks
>
> :::::: TO: Will Deacon <will.deacon@arm.com>
> :::::: CC: Catalin Marinas <catalin.marinas@arm.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> _______________________________________________
> Y2038 mailing list
> Y2038@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/y2038
