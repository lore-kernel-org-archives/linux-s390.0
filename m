Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 13 Jun 2020 16:29:01 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200613142901.65xieioomt6bbqa6@ltop.local>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200613122834.GA23739@xsang-OptiPlex-9020>
 <20200613130949.GA22005@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613130949.GA22005@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org

On Sat, Jun 13, 2020 at 11:09:49PM +1000, Herbert Xu wrote:
> On Sat, Jun 13, 2020 at 08:28:34PM +0800, kernel test robot wrote:
> > 
> > Hi Herbert,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.7 next-20200611]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Herbert-Xu/printk-Make-linux-printk-h-self-contained/20200611-205340
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b29482fde649c72441d5478a4ea2c52c56d97a5e
> > :::::: branch date: 13 hours ago
> > :::::: commit date: 13 hours ago
> > config: powerpc-randconfig-s031-20200611 (attached as .config)
> > compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-250-g42323db3-dirty
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=powerpc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
> >    include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
> >    include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
> >    include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
> >    include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
> 
> This looks like a bug in sparse as the same code compiles just
> fine.

Hi,

When trying to reproduce, before using sparse, I get:
      CC      kernel/ptrace.o
    In file included from ./include/linux/printk.h:10:0,
                     from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/lockdep.h:43,
                     from ./include/linux/spinlock_types.h:18,
                     from ./arch/powerpc/include/asm/lppaca.h:45,
                     from ./arch/powerpc/include/asm/paca.h:17,
                     from ./arch/powerpc/include/asm/current.h:13,
                     from ./include/linux/sched.h:12,
                     from kernel/ptrace.c:13:
    ./include/linux/ratelimit_types.h:16:2: error: unknown type name ‘raw_spinlock_t’
      raw_spinlock_t lock;  /* protect the state */
      ^
    In file included from ./include/linux/wait.h:9:0,
                     from ./include/linux/pid.h:6,
                     from ./include/linux/sched.h:14,
                     from kernel/ptrace.c:13:
    ./include/linux/ratelimit.h: In function ‘ratelimit_state_init’:
    ./include/linux/spinlock.h:100:16: warning: passing argument 1 of ‘__raw_spin_lock_init’ from incompatible pointer type [enabled by default]
      static struct lock_class_key __key;    \
                    ^
    ./include/linux/ratelimit.h:14:2: note: in expansion of macro ‘raw_spin_lock_init’
      raw_spin_lock_init(&rs->lock);
      ^
    ./include/linux/spinlock.h:95:15: note: expected ‘struct raw_spinlock_t *’ but argument is of type ‘int *’
       extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
                   ^
    make[1]: *** [scripts/Makefile.build:281: kernel/ptrace.o] Error 1
    make: *** [Makefile:1777: kernel] Error 2


while there is no such problem with the previous commit.
I think the problem is that:
* ratelimit.h needs raw_spinlock_t
* spinlock_types.h needs lockdep.h
* lockdep.h needs ratelimit.h


Best regards,
Luc
