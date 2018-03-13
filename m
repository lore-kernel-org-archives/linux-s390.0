Date: Tue, 13 Mar 2018 23:30:51 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <201803132351.1SZJ68nV%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
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


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Deepa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
base:    
config: powerpc-iss476-smp_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/oprofile/backtrace.c: In function 'user_getsp32':
>> arch/powerpc/oprofile/backtrace.c:31:19: error: implicit declaration of function 'compat_ptr'; did you mean 'complete'? [-Werror=implicit-function-declaration]
     void __user *p = compat_ptr(sp);
                      ^~~~~~~~~~
                      complete
>> arch/powerpc/oprofile/backtrace.c:31:19: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
   cc1: all warnings being treated as errors

vim +31 arch/powerpc/oprofile/backtrace.c

6c6bd754 Brian Rogan 2006-03-27  27  
6c6bd754 Brian Rogan 2006-03-27  28  static unsigned int user_getsp32(unsigned int sp, int is_first)
6c6bd754 Brian Rogan 2006-03-27  29  {
6c6bd754 Brian Rogan 2006-03-27  30  	unsigned int stack_frame[2];
62034f03 Al Viro     2006-09-23 @31  	void __user *p = compat_ptr(sp);
6c6bd754 Brian Rogan 2006-03-27  32  
62034f03 Al Viro     2006-09-23  33  	if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
6c6bd754 Brian Rogan 2006-03-27  34  		return 0;
6c6bd754 Brian Rogan 2006-03-27  35  
6c6bd754 Brian Rogan 2006-03-27  36  	/*
6c6bd754 Brian Rogan 2006-03-27  37  	 * The most likely reason for this is that we returned -EFAULT,
6c6bd754 Brian Rogan 2006-03-27  38  	 * which means that we've done all that we can do from
6c6bd754 Brian Rogan 2006-03-27  39  	 * interrupt context.
6c6bd754 Brian Rogan 2006-03-27  40  	 */
62034f03 Al Viro     2006-09-23  41  	if (__copy_from_user_inatomic(stack_frame, p, sizeof(stack_frame)))
6c6bd754 Brian Rogan 2006-03-27  42  		return 0;
6c6bd754 Brian Rogan 2006-03-27  43  
6c6bd754 Brian Rogan 2006-03-27  44  	if (!is_first)
6c6bd754 Brian Rogan 2006-03-27  45  		oprofile_add_trace(STACK_LR32(stack_frame));
6c6bd754 Brian Rogan 2006-03-27  46  
6c6bd754 Brian Rogan 2006-03-27  47  	/*
6c6bd754 Brian Rogan 2006-03-27  48  	 * We do not enforce increasing stack addresses here because
6c6bd754 Brian Rogan 2006-03-27  49  	 * we may transition to a different stack, eg a signal handler.
6c6bd754 Brian Rogan 2006-03-27  50  	 */
6c6bd754 Brian Rogan 2006-03-27  51  	return STACK_SP(stack_frame);
6c6bd754 Brian Rogan 2006-03-27  52  }
6c6bd754 Brian Rogan 2006-03-27  53  

:::::: The code at line 31 was first introduced by commit
:::::: 62034f03380a64c0144b6721f4a2aa55d65346c1 [POWERPC] powerpc oprofile __user annotations

:::::: TO: Al Viro <viro@ftp.linux.org.uk>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
