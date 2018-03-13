Date: Tue, 13 Mar 2018 23:22:08 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <201803132313.a4R8Y434%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180312175307.11032-3-deepa.kernel@gmail.com>
Return-Path: <fengguang.wu@intel.com>
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
Cc: kbuild-all@01.org, arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org, mark.rutland@arm.com, linux-mips@linux-mips.org, peterz@infradead.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org, sebott@linux.vnet.ibm.com, jejb@parisc-linux.org, will.deacon@arm.com, borntraeger@de.ibm.com, mingo@redhat.com, oprofile-list@lists.sf.net, catalin.marinas@arm.com, rric@kernel.org, cmetcalf@mellanox.com, oberpar@linux.vnet.ibm.com, acme@kernel.org, jwi@linux.vnet.ibm.com, rostedt@goodmis.org, ubraun@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org, hoeppner@linux.vnet.ibm.com, sth@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Deepa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
base:    
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/process.c: In function 'copy_thread':
>> arch/arm64/kernel/process.c:342:8: error: implicit declaration of function 'is_compat_thread'; did you mean 'is_compat_task'? [-Werror=implicit-function-declaration]
       if (is_compat_thread(task_thread_info(p)))
           ^~~~~~~~~~~~~~~~
           is_compat_task
   cc1: some warnings being treated as errors

vim +342 arch/arm64/kernel/process.c

b3901d54d Catalin Marinas  2012-03-05  307  
b3901d54d Catalin Marinas  2012-03-05  308  int copy_thread(unsigned long clone_flags, unsigned long stack_start,
afa86fc42 Al Viro          2012-10-22  309  		unsigned long stk_sz, struct task_struct *p)
b3901d54d Catalin Marinas  2012-03-05  310  {
b3901d54d Catalin Marinas  2012-03-05  311  	struct pt_regs *childregs = task_pt_regs(p);
b3901d54d Catalin Marinas  2012-03-05  312  
c34501d21 Catalin Marinas  2012-10-05  313  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
c34501d21 Catalin Marinas  2012-10-05  314  
bc0ee4760 Dave Martin      2017-10-31  315  	/*
bc0ee4760 Dave Martin      2017-10-31  316  	 * Unalias p->thread.sve_state (if any) from the parent task
bc0ee4760 Dave Martin      2017-10-31  317  	 * and disable discard SVE state for p:
bc0ee4760 Dave Martin      2017-10-31  318  	 */
bc0ee4760 Dave Martin      2017-10-31  319  	clear_tsk_thread_flag(p, TIF_SVE);
bc0ee4760 Dave Martin      2017-10-31  320  	p->thread.sve_state = NULL;
bc0ee4760 Dave Martin      2017-10-31  321  
071b6d4a5 Dave Martin      2017-12-05  322  	/*
071b6d4a5 Dave Martin      2017-12-05  323  	 * In case p was allocated the same task_struct pointer as some
071b6d4a5 Dave Martin      2017-12-05  324  	 * other recently-exited task, make sure p is disassociated from
071b6d4a5 Dave Martin      2017-12-05  325  	 * any cpu that may have run that now-exited task recently.
071b6d4a5 Dave Martin      2017-12-05  326  	 * Otherwise we could erroneously skip reloading the FPSIMD
071b6d4a5 Dave Martin      2017-12-05  327  	 * registers for p.
071b6d4a5 Dave Martin      2017-12-05  328  	 */
071b6d4a5 Dave Martin      2017-12-05  329  	fpsimd_flush_task_state(p);
071b6d4a5 Dave Martin      2017-12-05  330  
9ac080021 Al Viro          2012-10-21  331  	if (likely(!(p->flags & PF_KTHREAD))) {
9ac080021 Al Viro          2012-10-21  332  		*childregs = *current_pt_regs();
b3901d54d Catalin Marinas  2012-03-05  333  		childregs->regs[0] = 0;
d00a3810c Will Deacon      2015-05-27  334  
b3901d54d Catalin Marinas  2012-03-05  335  		/*
b3901d54d Catalin Marinas  2012-03-05  336  		 * Read the current TLS pointer from tpidr_el0 as it may be
b3901d54d Catalin Marinas  2012-03-05  337  		 * out-of-sync with the saved value.
b3901d54d Catalin Marinas  2012-03-05  338  		 */
adf758999 Mark Rutland     2016-09-08  339  		*task_user_tls(p) = read_sysreg(tpidr_el0);
d00a3810c Will Deacon      2015-05-27  340  
e0fd18ce1 Al Viro          2012-10-18  341  		if (stack_start) {
d00a3810c Will Deacon      2015-05-27 @342  			if (is_compat_thread(task_thread_info(p)))
d00a3810c Will Deacon      2015-05-27  343  				childregs->compat_sp = stack_start;
d00a3810c Will Deacon      2015-05-27  344  			else
b3901d54d Catalin Marinas  2012-03-05  345  				childregs->sp = stack_start;
b3901d54d Catalin Marinas  2012-03-05  346  		}
d00a3810c Will Deacon      2015-05-27  347  
c34501d21 Catalin Marinas  2012-10-05  348  		/*
c34501d21 Catalin Marinas  2012-10-05  349  		 * If a TLS pointer was passed to clone (4th argument), use it
c34501d21 Catalin Marinas  2012-10-05  350  		 * for the new thread.
c34501d21 Catalin Marinas  2012-10-05  351  		 */
b3901d54d Catalin Marinas  2012-03-05  352  		if (clone_flags & CLONE_SETTLS)
d00a3810c Will Deacon      2015-05-27  353  			p->thread.tp_value = childregs->regs[3];
c34501d21 Catalin Marinas  2012-10-05  354  	} else {
c34501d21 Catalin Marinas  2012-10-05  355  		memset(childregs, 0, sizeof(struct pt_regs));
c34501d21 Catalin Marinas  2012-10-05  356  		childregs->pstate = PSR_MODE_EL1h;
57f4959ba James Morse      2016-02-05  357  		if (IS_ENABLED(CONFIG_ARM64_UAO) &&
a4023f682 Suzuki K Poulose 2016-11-08  358  		    cpus_have_const_cap(ARM64_HAS_UAO))
57f4959ba James Morse      2016-02-05  359  			childregs->pstate |= PSR_UAO_BIT;
c34501d21 Catalin Marinas  2012-10-05  360  		p->thread.cpu_context.x19 = stack_start;
c34501d21 Catalin Marinas  2012-10-05  361  		p->thread.cpu_context.x20 = stk_sz;
c34501d21 Catalin Marinas  2012-10-05  362  	}
c34501d21 Catalin Marinas  2012-10-05  363  	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
c34501d21 Catalin Marinas  2012-10-05  364  	p->thread.cpu_context.sp = (unsigned long)childregs;
b3901d54d Catalin Marinas  2012-03-05  365  
b3901d54d Catalin Marinas  2012-03-05  366  	ptrace_hw_copy_thread(p);
b3901d54d Catalin Marinas  2012-03-05  367  
b3901d54d Catalin Marinas  2012-03-05  368  	return 0;
b3901d54d Catalin Marinas  2012-03-05  369  }
b3901d54d Catalin Marinas  2012-03-05  370  

:::::: The code at line 342 was first introduced by commit
:::::: d00a3810c16207d2541b7796a73cca5a24ea3742 arm64: context-switch user tls register tpidr_el0 for compat tasks

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
X10AAA==

--+QahgC5+KEYLbs62--
