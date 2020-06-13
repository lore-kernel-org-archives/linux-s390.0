Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 13 Jun 2020 20:28:34 +0800
From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200613122834.GA23739@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20200611125144.GA2506@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kbuild-all@lists.01.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Herbert,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.7 next-20200611]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Herbert-Xu/printk-Make-linux-printk-h-self-contained/20200611-205340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b29482fde649c72441d5478a4ea2c52c56d97a5e
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago
config: powerpc-randconfig-s031-20200611 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-250-g42323db3-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=powerpc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/ptrace.c:53:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:53:22: sparse:    struct task_struct *
   kernel/ptrace.c:53:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:196:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:196:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:196:9: sparse:    struct task_struct *
   kernel/ptrace.c:241:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:241:44: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:241:44: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/user.c:105:27: sparse: sparse: unknown field name in initializer
   kernel/user.c:105:27: sparse: sparse: unknown field name in initializer
   kernel/user.c:105:27: sparse: sparse: unknown field name in initializer
   include/linux/ratelimit.h:14:9: sparse: sparse: no member 'lock' in struct ratelimit_state
   include/linux/ratelimit.h:15:11: sparse: sparse: no member 'interval' in struct ratelimit_state
   include/linux/ratelimit.h:16:11: sparse: sparse: no member 'burst' in struct ratelimit_state
   include/linux/ratelimit.h:40:11: sparse: sparse: no member 'flags' in struct ratelimit_state
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   arch/powerpc/kernel/signal_64.c:804:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_64.c:804:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_64.c:804:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_64.c:916:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_64.c:916:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_64.c:916:17: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   arch/powerpc/kernel/traps.c:312:16: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:312:16: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:312:16: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:1843:9: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:1843:9: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:1843:9: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:2299:9: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:2299:9: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/traps.c:2299:9: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   arch/powerpc/kernel/signal_32.c:843:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:843:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:843:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1100:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1100:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1100:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1295:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1295:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1295:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1371:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1371:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kernel/signal_32.c:1371:17: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   arch/powerpc/kvm/book3s_emulate.c:847:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kvm/book3s_emulate.c:847:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kvm/book3s_emulate.c:847:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kvm/book3s_emulate.c:1012:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kvm/book3s_emulate.c:1012:17: sparse: sparse: unknown field name in initializer
   arch/powerpc/kvm/book3s_emulate.c:1012:17: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/sched/core.c:4506:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4506:17: sparse:    struct task_struct *
   kernel/sched/core.c:4506:17: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/core.c:4705:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4705:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/core.c:4705:22: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/core.c:1388:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:1388:38: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/core.c:1388:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/sched/fair.c:5386:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct *
   kernel/sched/fair.c:8582:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:8582:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/fair.c:8582:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10692:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10825:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct *
   kernel/sched/fair.c:5330:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/sched/rt.c:912:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:912:70: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:912:70: sparse:    struct task_struct *
   kernel/sched/rt.c:2183:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2183:25: sparse:    struct task_struct *
   kernel/sched/rt.c:2183:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:1876:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:1876:13: sparse:    struct task_struct *
   kernel/sched/rt.c:1876:13: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:2300:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct *
   kernel/sched/rt.c:2320:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/sched/deadline.c:2059:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2059:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2059:13: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/deadline.c:2186:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2186:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2186:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/deadline.c:2385:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2404:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   kernel/sched/debug.c:435:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/debug.c:435:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/debug.c:435:22: sparse:    struct task_struct *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   net/ipv4/nexthop.c:1088:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/nexthop.c:1088:24: sparse:    struct rb_node [noderef] <asn:4> *
   net/ipv4/nexthop.c:1088:24: sparse:    struct rb_node *
   include/linux/rbtree.h:84:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:84:9: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree.h:84:9: sparse:    struct rb_node *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   drivers/char/random.c:475:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:475:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:475:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:477:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:477:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:477:9: sparse: sparse: unknown field name in initializer
   drivers/char/random.c:985:37: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:986:25: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:988:41: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:990:36: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:991:25: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:993:40: sparse: sparse: no member 'missed' in struct ratelimit_state
   drivers/char/random.c:1805:32: sparse: sparse: no member 'interval' in struct ratelimit_state
   drivers/char/random.c:1806:33: sparse: sparse: no member 'interval' in struct ratelimit_state
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/super.c:2326:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/super.c:2326:31: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/super.c:2326:31: sparse:    struct rcu_string *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/ctree.c:129:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:129:22: sparse:    struct extent_buffer [noderef] <asn:4> *
   fs/btrfs/ctree.c:129:22: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:1085:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:1085:17: sparse:    struct extent_buffer [noderef] <asn:4> *
   fs/btrfs/ctree.c:1085:17: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:1846:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:1846:17: sparse:    struct extent_buffer [noderef] <asn:4> *
   fs/btrfs/ctree.c:1846:17: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:3332:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:3332:9: sparse:    struct extent_buffer [noderef] <asn:4> *
   fs/btrfs/ctree.c:3332:9: sparse:    struct extent_buffer *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/extent-tree.c:4517:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:4517:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:4517:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5040:33: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5040:33: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5040:33: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5151:41: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5151:41: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5151:41: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5187:9: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5187:9: sparse: sparse: unknown field name in initializer
   fs/btrfs/extent-tree.c:5187:9: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/volumes.c:7336:9: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:7336:9: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:7336:9: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:7336:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:7336:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:7336:9: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:7356:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:7356:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:7356:9: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:539:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:539:24: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:539:24: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:858:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:858:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:858:17: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:932:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:932:33: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:932:33: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:939:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:939:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:939:25: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:951:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:951:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:951:17: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:1012:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:1012:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:1012:25: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:2055:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:2055:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:2055:17: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:2539:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:2539:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:2539:9: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:4104:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:4104:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:4104:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6325:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:6325:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:6325:9: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:6535:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6535:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6535:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6538:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6538:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:6538:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/volumes.c:7242:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:7242:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:7242:17: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:7253:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:7253:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:7253:25: sparse:    struct rcu_string *
   fs/btrfs/volumes.c:7267:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/volumes.c:7267:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/volumes.c:7267:25: sparse:    struct rcu_string *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/scrub.c:838:16: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:838:16: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:838:16: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1180:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1180:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1180:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1180:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:1180:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:1180:25: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:1189:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1189:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1189:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1189:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:1189:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:1189:17: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:1563:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1563:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:1563:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:703:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:703:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:703:17: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:717:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:717:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:717:9: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:775:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:775:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:775:25: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:2136:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2136:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2136:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2136:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:2136:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:2136:17: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:2143:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2143:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2143:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:2143:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:2143:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:2143:17: sparse:    struct rcu_string *
   fs/btrfs/scrub.c:3862:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:3862:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:3862:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/scrub.c:3901:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/scrub.c:3901:17: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/scrub.c:3901:17: sparse:    struct rcu_string *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/qgroup.c:1927:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:1927:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:1927:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:1945:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:1945:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:1945:25: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:2039:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:2039:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:2039:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:3844:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:3844:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:3844:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:4008:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:4008:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/qgroup.c:4008:17: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/dev-replace.c:683:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/dev-replace.c:683:25: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/dev-replace.c:683:25: sparse:    struct rcu_string *
   fs/btrfs/dev-replace.c:700:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/dev-replace.c:700:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/dev-replace.c:700:9: sparse:    struct rcu_string *
   fs/btrfs/dev-replace.c:279:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/dev-replace.c:279:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/dev-replace.c:279:9: sparse:    struct rcu_string *
   fs/btrfs/dev-replace.c:431:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/dev-replace.c:431:24: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/dev-replace.c:431:24: sparse:    struct rcu_string *
   fs/btrfs/dev-replace.c:493:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/dev-replace.c:493:9: sparse:    struct rcu_string [noderef] <asn:4> *
   fs/btrfs/dev-replace.c:493:9: sparse:    struct rcu_string *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/block-rsv.c:509:24: sparse: sparse: unknown field name in initializer
   fs/btrfs/block-rsv.c:509:24: sparse: sparse: unknown field name in initializer
   fs/btrfs/block-rsv.c:509:24: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   fs/btrfs/reflink.c:581:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/reflink.c:581:17: sparse: sparse: unknown field name in initializer
   fs/btrfs/reflink.c:581:17: sparse: sparse: unknown field name in initializer
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   include/linux/rculist_bl.h:24:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:17:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:17:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   drivers/md/md-linear.c:61:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-linear.c:61:16: sparse:    void [noderef] <asn:4> *
   drivers/md/md-linear.c:61:16: sparse:    void *
   drivers/md/md-linear.c:219:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-linear.c:219:19: sparse:    void [noderef] <asn:4> *
   drivers/md/md-linear.c:219:19: sparse:    void *
   drivers/md/md-linear.c:224:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-linear.c:224:9: sparse:    void [noderef] <asn:4> *
   drivers/md/md-linear.c:224:9: sparse:    void *
--
>> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
   include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
   include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
   include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
   include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
   drivers/md/md-multipath.c:37:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-multipath.c:37:40: sparse:    struct md_rdev [noderef] <asn:4> *
   drivers/md/md-multipath.c:37:40: sparse:    struct md_rdev *
   drivers/md/md-multipath.c:47:9: sparse: sparse: unknown field name in initializer
   drivers/md/md-multipath.c:47:9: sparse: sparse: unknown field name in initializer
   drivers/md/md-multipath.c:47:9: sparse: sparse: unknown field name in initializer
   drivers/md/md-multipath.c:147:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-multipath.c:147:40: sparse:    struct md_rdev [noderef] <asn:4> *
   drivers/md/md-multipath.c:147:40: sparse:    struct md_rdev *
   drivers/md/md-multipath.c:161:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-multipath.c:161:40: sparse:    struct md_rdev [noderef] <asn:4> *
   drivers/md/md-multipath.c:161:40: sparse:    struct md_rdev *
   drivers/md/md-multipath.c:261:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md-multipath.c:261:25: sparse:    struct md_rdev [noderef] <asn:4> *
   drivers/md/md-multipath.c:261:25: sparse:    struct md_rdev *

# https://github.com/0day-ci/linux/commit/17b41842ecf70ea595220b384e6380d29c39b555
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 17b41842ecf70ea595220b384e6380d29c39b555
vim +16 include/linux/ratelimit_types.h

17b41842ecf70e Herbert Xu 2020-06-11  14  
17b41842ecf70e Herbert Xu 2020-06-11  15  struct ratelimit_state {
17b41842ecf70e Herbert Xu 2020-06-11 @16  	raw_spinlock_t	lock;		/* protect the state */
17b41842ecf70e Herbert Xu 2020-06-11  17  
17b41842ecf70e Herbert Xu 2020-06-11  18  	int		interval;
17b41842ecf70e Herbert Xu 2020-06-11  19  	int		burst;
17b41842ecf70e Herbert Xu 2020-06-11  20  	int		printed;
17b41842ecf70e Herbert Xu 2020-06-11  21  	int		missed;
17b41842ecf70e Herbert Xu 2020-06-11  22  	unsigned long	begin;
17b41842ecf70e Herbert Xu 2020-06-11  23  	unsigned long	flags;
17b41842ecf70e Herbert Xu 2020-06-11  24  };
17b41842ecf70e Herbert Xu 2020-06-11  25  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICL3I4l4AAy5jb25maWcAjFxLc+Q2Dr7nV3RNLruHJH6NM6ktHyiJUnNbEmmS6rZ9UTme
nsQVjz3rx27m3y9AvUgK6pk9bKYB8A0CH0DIP/7w44q9vT59vn29v7t9ePi6+mP/uH++fd1/
XH26f9j/a5XJVS3timfC/gzC5f3j29+/fHn63/75y93q/c+//ny02uyfH/cPq/Tp8dP9H2/Q
+P7p8Ycff0hlnYuiTdN2y7URsm4tv7IX7/rG52cP+58esLuf/ri7W/2jSNN/rn77+fTno3de
U2FaYFx8HUjF1N3Fb0enR0cDo8xG+snp2ZH739hPyepiZB953a+ZaZmp2kJaOQ3iMURdippP
LKEv253Um4mSNKLMrKh4a1lS8tZIbSeuXWvOMugml/B/IGKwKezOj6vC7fTD6mX/+vZl2i9R
C9vyetsyDasSlbAXpycgPsxNVkrAMJYbu7p/WT0+vWIP4zbIlJXDSt+9o8gta/zFuvm3hpXW
k1+zLW83XNe8bIsboSZxn3N1M9FD4XG6oyQx14znrCmtW7E39kBeS2NrVvGLd/94fHrc//Pd
1KvZMeV3ODGuzVaolBhMSSOu2uqy4Y13nD4VG6e29NRAS2PaildSX7fMWpau/aU1hpciIafB
GrguxCTc5jGdrjsJHJCV5aAQoFurl7ffX76+vO4/TwpR8JprkTrVM2u58y5DxGlLvuUlza9E
oZlFrSDZov43T0P2mukMWAZ2u9Xc8Dqjm6ZrXz+QksmKiTqkGVFRQu1acI07cj3vvDICJRcZ
5Di51CnP+nsn6mLiGsW04X2P41H5K8l40hS5CY90//hx9fQpOpx4Ru7+b6fzjNgp3L8NnE1t
zcR0eoB2xop00yZasixlxh5sfVCskqZtVMYsHzTK3n/eP79QSuXGlDUHtfG6qmW7vkETUzlF
GDcJiArGkJmgrlbXSmQl99t01Lwpy6UmnqqJYo065vZRG9dNv++zJYxXV3NeKQtd1cG4A30r
y6a2TF+TN7SXogxF3z6V0HzYyFQ1v9jbl79WrzCd1S1M7eX19vVldXt39/T2+Hr/+Ee0tdCg
Zanro1PCceSt0DZitzXczC0nJ0qJw4kTE0cNdnoYjOtbHpOu4WqwbRFeq45s11xXrMT1G9No
z0gmJgOqTIGOfdtlTrs99Vwf+Dpjma/ySIJbVrLrqCPHuOpp49odVUhvQdR5GREcP9iGwYNk
wqBLzsgL/R1H6nldOABhZOksqN+d0w6dNitD3DHQpBZ40zLhR8uv4Cp5SzeBhGsTkXAfXdP+
phOsGanJOEW3mqXEnOCYynK69x6n5qAahhdpUgrf6CAvZ7Vs7MX52ZwInojlF8fn0w52PGO7
q0+coxtNpgnudawE3sRbh6eqhDzT8CDGi7Hp/uE5is142WXqDyY2a+geTBAJrRAs5eBpRW4v
To58OupHxa48/vHJZFBEbTeAsHIe9XF82umPuftz//HtYf+8+rS/fX173r84cr8oghu4ENMo
BZjTtHVTsTZhAHbT4O73cBZmcXzywSMXWjbKu52KFbwze1xPVMA/aRH9bDfwH3/fknLT90ds
XMfozMzUUc6EbkPOdN1y8HSsznYis2vSLIJR9NqSIv2wSmTmEF9nFVuedA738cbfjp6+bgpu
yySYtAJEaCnN6dtkfCvSwFf1DGiJpu/QLB00Ibo2Mt2MMswyz5cDdAbIA7Y5AK2oJ9QcATUD
Y2oOa9EBAfYx+F1zG/yGc0g3SoKWoSe30vcgveOBuMPN1J8QYCY47IyD20kBudBHqdFlEJNG
tYNddRGE9nTL/WYVdGxkA3jQiy50FgU0QEiAcBJQypuKBQQX6kzzQQlJTxVZZ9RcpURQERoi
uJpSgdMWNxyRK6Is+E8FNzjUk0jMwD+WwgsI5jI0kakEF4Aq0XKMIusB/I+dHhSkVC0Kj7rf
4M9SrqwL79FGR5BDpUZtYF3gOXFhHnRQ+fQj9okVeG+BGuiNBvetQjwwgexIh3oGMfN8Dbak
nIV9I9gMDHX8u60r4UfLAZjjZQ77p6nDWF45gygEcbFnCxvLr6KfcOG8DVLSlzeiqFmZexrv
1uITXLzgE8w6stlM0BoMgKvREdaaGmVbYfiw15QhgVESprXwD2+DsteVmVPaIF4aqW6P8NYj
Lg4cjcoPHDSqjIN+/sLHOGuaWYvtE5ZuAtsI0eEluWhox7MstE2BksOobRzeqfT46GyIH/oU
mdo/f3p6/nz7eLdf8f/uHwFuMnDyKQJOiHK6UKNvPvVJQp3v7HGYzbbqOhv8e7BwzCkxC7Hl
hrr2JQvcnCkbOulhSrnEYAlsvgZ00SPzhWGct0Wc2Wq4sDLQVrNu8rzkHUiB05PgLaSmzZTl
VWfQtgCXc5FGeQ8Afbkoh7Cs388wGzeKqvR8PET1/HS3f3l5eoZo9MuXp+fXCeqDHBr4zalp
nfx0jAODA4OY7Ri8h6BXyR3XvyKVjl6R/eEw+7eYPZuqtyNAy8MZsBKvHhXuu/vE6y7ZqUph
W1VBGGgxSxEvXbMM82sVNRG/H4RT7mSJNBX2U1WgIKLDMh65u31VM2DgYHgko2OgHAImiVpT
eTAg+FFrh+Yw8eqNlkmpE967nl5t5joRBo0Jmo86E4zyqCgA+2dhAzqZYHXnZx1m2GmmlG9N
z88S4TvLqomMXVUxwLU1ABsBcA/ikovT00MCor44/kALDKZh6Oj41++Qw/6Ow8wDtwjFue5S
GRDD+UASsOHAcqa2zYUGI5Cum3oTHAqmIy/eT6EVuGYAriJUih2z6TqTfubPgqnvIshJUQbH
6cjQcV6ywsz5qNWATueM4eaud1wUaxvMIZzQ4HRqaRT3eJzp8nqOOljdJxQxuD7+MD1XuC2O
QbWs4ALmAHbhIiD49hWlOyJ2PUCxNs+iqTVZUrTH5+/fH3mtMDXt2s4X28GfwLGKhOsOMyKs
MiLxgVYfoMK6QUe+wa5lDZGW7E1hKNFHuC4Kci7AeYAlsQYsfBLbioztvK1RRfda4zLm5uLM
l8T0MigyqHbYw5VIoz5Fqvrc3Zy+3sY0A1ErM3GfcVukYK5a6dHvPNy+opP33E5gZJ25r7eU
LwSdGbLa4SgKkJIIQ0Mkgz1XjPKqvXyLelBcB445ZXUpabQIULJDHZg9pwRwtDSnG3vTnIe/
4ayrhVmLpNoKOVvktiJkNwCRiob7SS6OpwDqphlmYcMNpI5d5p3FxtgTALuIEtOohF0uN7dk
hsndRtQRjBONLKPuwUVBZHQFlz6weZXyU4L4CzS40JH2fTh5/1tICpXRDcu1hugSTrMIEkiD
NNwhHmYIkRjn0BwRrKlZE0vkfH0x5dRX+fP+P2/7x7uvq5e724cujR74T0CElyT+pVsPHYuP
D/vVx+f7/+6fgTQOh2TvZRqTutGrxUBrC7ltSwaon9KrQKritWewApblcrHzNSAsjOpm2WR3
nVU6TniVuXWE0UF/L3Cp0CG5Q8v9+HvYbYlH8bduWNQlTFkJ79EY/AGccxogodhK+YHP0xcs
CgiWsL5pj4+OqJDqpj1x/sgXPQ1Fo17obi6gm9BZrjU+zngpii6L1wUVmFRpt0wLlpSziwtX
ujbMvZCyEiNJ2pzBEJhSMbZJIMYEHEJNTFpVNgXh51A/nOvC0JdDCBzxe7Dcv0j3/XxLRsO/
IkMFyHL0lb1gzkTZPfp4T/dXIf4POQDSYsUbDAB30RnOg05parANbdZU9Bt+zma8wZzry9Y9
VCA2958aGzKF24EC2MnUDsusZOY/kDsJMFUW2P3OxZjCPRp/B7uPbIP02LTLvaL5XliUJS/w
va1DbaB5ZcMvjv5+/3F/+/H3/f7TUVjEglp4tnGqOnPb5wNjId7r9Dt6l+hLU3ryiIBc4BzL
dgETvnDcyJpLDWYRXy+Cy2UqO3N3vMZsJoT0s6TipA1Vhp4SPSeV0unZXgaXX8FlbC3TsKXG
o/c40juBHljOcvgDw2wEAPvr2gfFGGhyruaUMEL0qRFy9SJQl/J2cjR2qSBY2eBt2ZAnVwXj
OQwU959tMVecLb4PgAxWCs03Z1zArNvdZYcoW57nIhUI3w6kbXiKcUkUrcN92PDr4B0/cgTj
LTBw2yvWModonH9I3l48fxEFIL28P9/clG2ZpKQP9PuaAiy4DDLPISaF63Z3FP5vhINd4RKE
jvqQmFpfG5GySTAWcGZiTGcNLsAVUQHgBIsWls/4HD+JOdJneV0kVpXvnJGyzWNKHD76I7XJ
tWLGEMyti9fxjgCYD9L/CIkbuNo3UboGWoUD93mxLgevSR44pENsBOGz2DFovtSrijrsQ7ig
/u72+e7P+9f9HT6t/vRx/wVUZ//4OldB2eUN4xcOjzw5yC4AJe7Lv8GzAa5MfC+ERRKg2nhj
0F3lNghC3CDTVWwAf4iixue0FOsuIofUGO4q+qyo2wTL5KKOhAQ8wBTCjJkuxFFzR9Xckgyp
aHrfTStrDHPmL0J5UzsY1QcbZOEZiAWvLlPdnOtxDec7z02gJXbounNscZ4CgxLwxSK/Hh4F
o+5NhfCgL5KMV6V5YVqGPgNzSf3e91YrkDP8MiJ5mXxiVZjCmmesHAsL8NA3uOdfC7sE2xWm
Zab+cX4U3T3jdnNGUEVtKaWSVdW0BcOSoL6qFX0oycaSjG+IjOh6diT9+l1pRFqpq3Qdw9kd
Z5sBDcOuXzZCx93sGCYYHMrB+r6h+JUQ6pOU3yUry8yTp/atd32Ig4Os2xK9S4TiUeDlc8fp
hY1djUbIHmrbJjsRtp1yMGEzY7Uka6XcFODfWIjtrtJmXiQGNwTGDarzkEzUoX1bAu9mbIC+
WaU23PMawTWavOFxgDwEmWOdl7bXEReu8gDReYqPQJ5qyqwpwUKhrcQHXHxnJGbJr4RFK+aq
V3GDCYvimjvnHqj3NL8g0x51EPKmDDzR2kuvL3Xii0TZ91Sq6wHu23Ju2krRPeaMaXJqJfVW
swqsvl/yUUoE7tBqB6bKY+DlMaKYgc5+jj2bRXa/556ewBqcjhAbjnirtbLHgD0XjaT/vDm5
+FRuf/r99mX/cfVXhz+/PD99uo8TTSjWA76lMBLHdmK9t29Z+A50aKRgL/EDBgzbRR1EcR6Z
BLLfCVaGoeAmVlhE4Htn96ZuKpz4UXgV8DBaV3diZ7fEn2Qv3QWDpWR0sU4v1dSHJAY3e6gH
o9PxkwXyuX+aPTFLM4StBxuG9Qce3azZ8UKvwDo5OTs4817q/fl3SJ1++J6+3h+fHF4IaOj6
4t3Ln7fH72Z94M3Cst5D4+CLyq6tBODs2qsea0XlUhhk06YGGwp3+bpKZEmLWC2qQW6DtR1k
GZf0rStWdZnUCLBMl2FCfqj3SkxBEkuRzOmYXim08D3EjNXa46M5G3MdQV2iK3Ps8xUOQVDJ
YRTaJdGsgdBWl3Ff3XsW+UTtNgHf9xQr42bdR0ktr1N9rciKZHX7/HqPJmFlv37Zh6ljiFOF
A+BD8oDSK5NJM4lOa+G5CMhT+jcaMTjbWfCJq6guW5WKGQ1hhB+7ItllQrpvZORUD+vFZtBO
yC4NhTVt8dOLx95cJ+SpDfwkv/SXFY43Rv3jtweAlkRYRMbCMkxm6uPpV1P3Z2cUBGhoImew
YswZMguoIm115X3x44x61xgOUO5qH2DqneHVEtMdwwJvqpCqhNx5Vyj+PQrW2AkY55IpheaC
ZRnal9aZjEl+yry5w+N/7+/eXm9/f9i7jwtXrnLp1TvGRNR5ZRFVzVABxYIfaVBn2guZVAtl
Z2Swbanfr+Z9SDSe9tIE3eyr/een56+r6vbx9o/9ZzJFQCebp0xVn2muWN0wyqFN6eROxMP+
AyeGud1Qyn2gZQl5ly7lPpaaWFv4P4SPY2p7CihimaVgwpX0F42KdGSDmUWstwsVvJ/t+CVF
cEeDVw1yc1ytke0MCj4BnAU6EqFJF3VqjncpiDGICiP/4cSuFSWCQVOHFvyyA4dGUfdbS1Tl
jOYhSA0Z6vF5+GLFHUclatfpxdnRb+e0bZi92oSbSLzmrHdKwr7XfcKFmMNCyOV58jkfNmTH
rin/RUpXXfmo32sKoX2dMrC9C68DjAYtaOnG2I8Y/0ZJ6d2fm6Tx4pCb0xxiEO+3g8XhM/ZA
G0tFqs7WkdMZhTGXd6DMryv56ZNw/migAFxrxFJWN2BC3HZhGTvlqrKhDnIewk+BksVqy21Q
xDJkCE33wR0wW1f1RDXv8/eDonONkX30ORfc+zYBFLKumA5K/1ykKevy2l0nrFgnMU4wWRen
s/hxDrlOfTLfTi+b4qFxze1F7EKABr4XQAZ4qv4VbZKGOYMqcf+jNLNJ0HryekgIOjdQ71//
9/T8FwR2c/sPRmjDw1cwRwEtZZRJAzjglX3jL/BdVUTBtsE9XEDaV7muXL6P5OIS4UwpdarD
KQvV1d/jV6Z0VY+a3p20BERC4inVqtr/Ltj9brN1qqLBkIxlM/QbWS+gmab5uC6hxCFmofEq
VM0V9SGqk2htU9c8+qagBr2RG8Hp3e4abq1Y5OaSrs7tedOw9AB4LC2jv35yPIjPlplCodIv
nPa0XJ/Y61kgl6qZ+jlGk6mZTocSmu2+IYFcOBdMVtLf6OLo8M/iUKAyyqRN4uf4Boc68C/e
3b39fn/3Luy9yt5D6Exq7/Y8VNPtea/riLXyBVUFoe47HYMPOtlC+gNXf37oaM8Pnu05cbjh
HCqh6MSD40Y667OMsLNVA60919TeO3adAaoGpJNxe634rHWnaQemipZGlf0fz1i4CU7Q7f4y
3/DivC133xrPiYG/ogtbumNW5eGO0I/gcwkNTBQoFm1o8O+G4OtA7y09c6Cswj9SYozIrwOO
awIo06VDwftWKvqaHGS6dwZyMok6wAT7k6XpotU16YJF1gvfU9roD29MnxLYhWqpE0vtlLGe
2yjA7gfpDy2yYvHbN2dWDIs2CElEi23J6vbD0cmx92A30dpiG47ssaqtpiae8TRypR1l2UmW
ZQA54efJwg6yckNyrk7eU/0y5UXtai2jeZ2XcqfITxIE5xwX+d57Up9obV32/3Bf7IFO1taH
bJ4kfpjqYzC4cnG/uDXDp78OWl2+7d/2AKx+6VMuwZ9V6KXbNLmMzxfJa0t/fDTyc0P+7Yqe
rbSfcxqozjqRw+mFL1UHvskPT8fklwdmY/llOZ+NTfI5MU3MnAhGgZq0ZbjMA+MCUsrmvWVm
brGQDv/18xGjuNbETl7SOwwYm2aka7nh1CIuc7qUfGyIWZeDEvnlXCjuhNGDHzy19Zo4HyX4
nAgz6OizAcC8x4n6uMOg5nM6cUN1RxRudbngh9uXl/tP93fRH+vCdmk56wpI+Hwklm4Q8m0q
6sx9xTpr6uwf9fXbIJDvwhUhrTk9CfMEjuSqGqgywZ4dR6LjFMx2OUQYBM4PTbGUxCTT4Xv2
eLNUPidiF1zP6RWWf0SfNDuAXy1UEA8NmR+tunABMweyFCmf04tAunCiWiZzwUromRlAugH0
URId18zGM3ed8+hvYM0kjCAjlJG9SbALqu/UNFQWbVyBKs18nujA59TZSfVDV5LYApHPLi2S
O6y4EF5P+2+jzYPe3EiEyvasA+a6l5huncez6ZC7IEyPyD1rm6WeAmS1wT/dIPEPxXnJc4Bv
zD0WBThspA7/pL4/8qX8GguPngXPQhPdL8r1yFX4t6/8juLPnGLewvRn34iOQlLxemt2gr6E
2w7heAMOlCiSHsmllCoJ6ki6ty6qq5BB/EmuIZm1kFnqr0CgVEhrC0N/9f9/zp6uuXEcx7+S
uoer3aqdGsuOY/thHihKsjnWV0TZVvpFlenO7qQ2092VZG5m//0RpCgRFBjP3UN/GAAhfhMA
AVAjYaOmsyyZbB+u65lsfP6mq5L0HFz1+UptdhKUaI9qoLlvWsQVfveyoJRPjVILb0ZeHMIm
mZJLSvdtXKeWJtO5rFzzSIecXkyyFa22IcnFQRhdzttAGkgPJB96nMohvsfXu3XW/0xafbXZ
CK7oTU5IbI28eX96e/e8WnQNj62XLGy0oc5KegjXwOlcI7ACYrrpOcRJlQJdhUOWgTRBg6xg
TQYTnCzbx6XrjT8A1D4w+de5nDQSPOGq/iO9WA1REVBvFe4gkjCOvKyHhFeoknnq+kPB5b/M
WrMhu9zIjIMT2noDh/BZytqTtm563v/Gkf7l96f3b9/ef7358vQ/z59tVJd739pqF4gc1fTA
RdyeZOxV1YJNTIPx7Ap2kqWNeWBUR4qiPYY+1LS0HG9oTqyhlsnAgBfLxaqbtatm0aIjvpep
7wWZJW0ezXtoxWew/JRy1iRz/mf1h2ZfNGfc+6w9rI545rRHaOtPzv1HcGQdk0GmNpwmZJHJ
+iM5MhcBvrauV7mFYGniAg6k+O5dg4ZYUBck64cZkXBio3m2B8MAcrYyZoZIh67ALTol8A/F
4CRJ8wryB1xYU6rTC6c2sWQ8Bd/vIRdIX5UnMlGXpQbPI9VwnWgHbjnSfRLPq6w9SIdAEU0y
Rb3Ma2ns0XUgF9lEF94QprY0CbN3wR+14oLGDIHBgIPzHIjYDoMH6bWXkSpVB3GcF2FkexQU
0spkVv4w9qFoDtF3gA0nEA2Hu3LZNsh13cGO1+p/heqn//rt+evb++vTS//ru+tDZ0mLlAxp
HvF4zx/Bk2BKspT2IpcWvDAbG2w851RWxrOIFu4slZLs40oSB8asYnmRzsXmES1bdp3HoQ0N
cg95HkM4EUsZRNZhVJvk8oMqm/6z6Y8+qjc0DrwpdbyjjltYTPwuQkFpu3h2FHSyWyWI7Twj
wa6eHN2QxLYL5/rjTLh+UerXvLkaqviEpHCN9w67CZnWhz6U07rMyLTalFXAU5Opy5QBlUCa
F3D+cCwTEEiZ5q4GD+4sFVJK0/bQVlVutSBHLdHRUoMUbYXkxBySiS/+DGlRHB9E49qMQP6P
Ieu0xMBZ6mcF1L5HMQ5VtsHfUAZIqC5VYOY2dgAMnjsY3qfc3Ro1qUSBowPECVAeKzPidLyn
ZIEUxJgMDp6/RDylMgw0sq+L1K9OnwREFlMgcJOkkfGF/g7kc8GDFcofDjg493FaOD3mofBa
Dl7KxvVncCDD2fX13GhPsc8Q0ti1J0rmBCxrveklqjMGKBnKAzCkcDrzjAT23GDIiSkPZAp9
l6SpGc1XIfoE0rHYxaeAN5+/fX1//fYCOWxnOggUylr1d7RY+L0ETwBY36nwwHeQzA3tycOq
f3v+19fL4+uTrgP/pv4jiQw6etZddKJG/cHQh+Cw9mPYB3n8o08Z39Fvv6hmP78A+mleFevW
FKYyNX788gSJ/jR66tM3Ih8dNIqzJC1dU7AL1U0NoKArPkDZolPWkKv1Gr3E6ckwTpT065fv
356/+gME6dF0ngSy91HBkdXbH8/vn3+9OvXkZbBbtSlOZ/Ihi4nDoPCNvwsuGJ7GANHRMj0X
AcFe8YixQjI044fPj69fbn55ff7yryen4g9w7+p+RQP6igoRMSi1gCrHemeArZjzULr9QcTU
fXmd3G2WTg4hsV0udku37dAOcA03Ac2OSY3VIsGizgDqWyk2y4iyyQ0E2r3EZkNbLXz0sOk2
Xd92vfaNnX1W5xdIyz16x2XEYWFyYnsqzI3XHAfujiXVFh0o03NP9DIZ4h+/P3+BWAIzo2Yz
0emO9aajmHMl+XYBwdMpfLf9kAS4qP2U9jKwRE2niVbkYgu0ZIqof/48CFo31Tzpz8lE6R3S
vCYdIlTftUXtWvEtpC+G9xhGXmqWlQmDEER6x27MtzLRFBfWmLD4ZDYy2fPrb3/Axv3yTe1i
r9OQZBe9aF1BbARp79sEMrk7IqlOS2K/5uQlmUrpYGzTdrchJIESek2KWqKXpgI2sMtjR/hT
D8PnN3c0zDCd5uPshkUMKBMYRuM8qOP4AspW0ohzwAI7EKTnJuD0ZQh07hLDpjeJjKiNqejv
K9kfT/By0pA8YfJKAg4mgcXAR+cnINiY8pYo7XEaBidRqxbxNBcafT7l6geLlVjSCtfNuEn3
yB/b/O7Fks9gMheFUR0w/BLNQDj5h+XpPvBheaoVlFxQAL2ldo2ZsF3KA2vMBM/cBQCoTMsB
NkwYB6jO1/6Y0cUYKt1YGQGKIwweamdxEL3VmZwkLrb4qP1WSqPEIfRge5xlYd6X0vvVQ+o0
12lJAwt4oYFCSNFkNOYUdzNE0SLrr/qppxFxtI/hct8fX99wLFsLkesbHWYnEWs39tBHVRkF
VYOoMxJ+gDJe7xA1YoJ1fohw/RELnX5EZ/cK+D/NS0AsAIQC0KLbrBt075zUf5U0DFF3Jp91
+/r49e1FO6vc5I//mfVXnB/VXuK10As+ytzsNaX55Vg32rxvKA1SlKhgkyWYk5Qoq6oseo+1
Hp2qJk1OCjVGU6r1Zi5HrebUsOLHpip+zF4e35QU+uvz97ngoGdFJnDDf06TlHsbFMAhax8B
VuX1TXilY0n9KaeQZTVkkkFtAkysjtUHCN4IPchmCfMAoUe2T6sibZsHXAfYomJWHnv9Hkgf
fYhd+vX08IFg6znhNlBPvzZ3H1ZnNasPtFNQIu+IpItQDlQjcjubcaRv7UgPt37odmCcCEUi
55sYYJS8RakFFn1qRe7tMKzw+ajpHGDB4iGAcZI0w9Pf6NSP37/DJfUAhGBNQ/X4GVJye2uk
gtOms0Fc3iSHOL5iPsMH8BA/FFq/A1GVhYpDEgOlEAWyIbqU+7QQJe2+gMhqeBQrSSgJWtNh
044BgRoa5KznQ3+GjDNBpkrztyNq7RVXRsA8bvT08s8fQIV+fP769OVGsQpeR+vPFHy9jmbV
11BIP50JWglyqMLJgoFI5qoVwbE0LXSXc5v4MMiD0lYtJH2DywE3SnPAKulPDimPouUWf1+f
SkvohpnB6vnt3z9UX3/g0IUhmzWwSCq+dx5ai7XXq9K6+8LJ4zhB259upzG7Phzul0qmM8s0
3omhDivAkEDz6MJDf2lESxdz3jHDW9aADoWCuTTLDk6yfXgoNVXKORh4DkzJyCgGmCZQhzf3
t7BLP2+pWzTmY0Lj5vGPH5UY8/jy8vRyAzQ3/zRb12QRw+Oo+SQpZHQjPmAQ2II7jQnDdywj
ougCptKRAnaPjzpt/mKN81XPojhimJrx2ipitubnt8+4qbKYPS83loW/0POgI8azWk1dI+Sx
KnHmRAI5JNO14WN/jVYnMnAy5ARJIYaWHAKHMo5bvQ5maz2vYfv+b/Pv8kZtzze/maDWL/Ns
z8DZFKBk6OusMKdTTPmiAObwUKcN0saS1lkQ+IRTCgcozIF3iBUWsh20KCecApoAaBJ1rOKf
ESB5KFkhUAXG8XFhSNetMhz7q34XiasgV5l+zbY5g7ztxi8YBHi/IphJc/GAa1aw0bdAzdC0
QbkXTF4ueBRifHhBCfnY3WICTAYrA+rp54sHJOu2283ujiqnThpKRLToEjQy12fJJLlxOdm8
N+Upz+EH7X01EGUB768BDbcGUsL5KerVMmC5/OTt3zMup1CmbUsAPrUfEiRN/HFFyyt4ebyC
72iTq8WHmsgTJdyCgyZPzvQXIBEzzD647SYJBi/hayN1rQca2c1vz8pzkVLXZWO3AZ70E1CI
nvQV0BiTtxmp3hM4PJwuUUYfcC5J68c1Wt9Wt1XjUTU3TrFkvVx3fVK7WVId4GCzm6yVp6J4
CL5yAc9QFOSqPrCydRMDtyIrrLw1mTABuOm6iGbO5W61lLcLSqVUp3VewWu+YKk64weUDnUv
cnQpw+pE7raLJSMfdhMyX+4WC0fwNJAlurZVWpysGtm3Crde00n7LU18iDYbKne/JdAV2mGP
zUPB71Zr+gYjkdHdlroEk0iGd28UPTOvuUvuZZK5L/VA5qC+aaXjUFqfa3ioZwLw5bChm1RH
aQ267uxi1sDV0l46gZADEPLBc/S2yoAoWHe33VCBngPBbsW7uxk/kbT9dneoU9kRTNM0Wixu
yVXiVX5sYbyJFrPZaaBBn6UJ2zMpT8VoYzIPlD/9+fh2I8Dt7vff9Ot1b78+viq95B0MfvD1
mxelp9x8Uav0+Tv8192LWjBKkC34f/CdT89cyBUsdKJZDFzLGZhE6ty2RXx9V3K/EliULPb6
9PL4rj43G/9zVWN7twK4KvVHTKYaKgXqck/dYaT8gFa0nrgs5/C0KOmCPM5sT88YwZ4j+IHF
rGQ9o3jBI7boTgDtreO2o/OrJjhVQDKXkCEDoFVNZ92o0wOiEK2GCaWFKKnS6Vugwr9w3lAN
0dcG2Tgj9WeH7928/+f7083f1CT59z9u3h+/P/3jhic/qKXxd8eF3ooB+AHjQ2OgAdd9W4i+
HBtLkyvKIt1E0Lol42aP9mPAcH0nP3tK0iUZHv0JE8A7T+YijR6q1q6sN2+YZC3GgcEsM24Q
1IYNeKH/Jga1l0wGeAImF7H654OmNPX8w5OFxGvNrKMu+tGwUKWTw6xOyaFvEkbtIxatzmJ5
ocqlBS3sWDzLTyzcCm/5INGS2gyc9WSnaIFtweYVZ5OOnOTQwwUVc98PT/TaXHhsAEYLNBZJ
yw4D9nZNBesqpEkowtoDqoFW1dwEoNbpdFqSGvKB7XAgGJYY8SQZpjNXzk26F7JVFcbBe6Ny
QqsGgxAbeFg4O0mPnYHAQguSw7pwrsIMTPs3742NEmPQSw8DbHoWzBx3aZreRKvd7c3fsufX
p4v68/f5Rp2JJsVXzhbSVwfkeWvBMq7R/ceIUGo92VsTQSXpW8YPqzrOEvDAB++nwQXAd9hX
S/FUVCeZxi0V5XYRZZKxBudDMC++u5cNQiCCmTQVV2VCBwJoFcMlhTbvT4xMzZPe66c50lmM
JqmYiSz26dqUtqwyPoRRu11zbgO3f6IGalp37UIYsA4HnItj1qSnQGzenr7wYly6krxqGx/f
1nNbPECt0YlSX9MWh27qAMsK3qOqyrZR/0HJWEWF7FDmN3ipjdcCGNN0xIVBe6LmmoL2Zz17
mkpKFHp4Tlt0/gwmgtDaKfOCfOudNRzV3vzuo+UCXc1Y8GJNb+UDvmHUxfqA5F6GQrMqit3i
zz+JTw0Y0oJtvyaU6kOxXC6MrkojsADsIzkO69KxF2aboK5x3l+ff/kdRPfBS445WduRgdf6
D//FIuPyhnc10ABBZc9Kp1WC/orjl7MHD9QVX2/ou++JYLuj16pSbFPagtc+1IeKnEJOjVjC
autea/vXgPSzSbCBX2GwT/E2mbbRKgrl87OFcsbB9s6xQJYLXgUTrIxF2xQfsYynZeBiZdAF
W3mtEQX7hJmmSpOyQ3mtLBLD1M9tFEVBw2ANk3dF20iG0S4LnpPh2u5X1SlStoKR04w1nIZD
gyq0XFibh/Ja5YGNQyHoIwAwoXG4NiFOTdUgt2kD6ct4uyXfkHQKx03FEm9lxbf0gop5AYdY
QPcrO7ozeGiCtWJf+d64DjN6YcoH2aaFHyHqFrwy5VSD4boPtbektAanzOx+EOHO4oS6rz2c
SnBihfeuazqloktyvk4S7wO7lEPTBGhycX8SocwGFulVgmjlIc0ldnUfQH1LT/URTY/wiKan
2oS+WjOlTVd49wmJOWMRnTsbrRjjoULuWpMV9up2luDDQAtGp1yEsgHZUkOo3/ShfEnffEg1
3IHAM4efEuhznLAqTpdX655+Gu6dp47UkL6sIZVTqc4qSIvX+xvAnBNkx4eoQbTG4DXD+l7f
WdLajsJ3e9BHgiR7wcqM0aYlKA41o3eaERtabBOB/3WieaefRStPhCiSFeefo+2V3XpfVXvc
NXvS+9spcjixSyrI3Qfev+46GhWjXQkua0LnKuCurhqbUWOaH/Q7xwBe+HSLQIrTPR2Uq+CB
kRJdqIhCBD4CmBC721DNFCJUhtNFsiJa0OtW7Ol5+XNxZeQL1pxTnEGtOAcXiDzu6ZrJ4wN1
e+R+SH2FlRXaNYq8u+39LDsTbj0z5LhYefkQnVGak1sfwRs8245yu72lJQxArSG2n86rcpSf
VNEucFPgfbTyd0HVLZvb1ZVFrUvKtKAXafHQYMdF9TtaBMYqS1leXvlcydrhY9NZY0C0Niy3
q+3yiiCo/ps2ngFOLgMz7dyRyWoxu6YqKxwJXWZXjsISt0moIyH9vx0+29VuQWzNrAuaCtLl
0Z8afmmtd1yp+VnJUfj9Xoi5T7wtd16wOqI2K/rqykY85N43oX84Cl/pYjyQJ+whhXinTFzR
jeq0lPDwHzo6qquHw31e7bHn433OVl3AP+Y+DyoFimeXln0IfU9mS3crcoJrwQIdffecbdQR
1PuplRwCuDgOZc9uiquj3ySo7c3d4vbKcoPo+jZFYt82Wu0CeasB1Vb0Wmy20d3u2sfURHEN
5S4OUvE1JEqyQkmcKA+HhLPU18+Jkqn7XKyLqHLWZOoPvswLuL4oOMQL8muGGCk8463ku+Vi
RXmOoFL4mk3I3SLg2CFktLsyoLKQnNh4ZMF3kaoNyTetBY9C31T8dlEU0IIBeXttS5cVBxus
ny7TYlt9aqEuaAt9I3B1eHF+wgOr64ciZfTxC1Mo4O3GIZ1gIDCgFKcrlXgoq1rivFTJhfdd
vi/IS0mnbJseTjhK3ECulMIlINmEEnMgjb0MpGZur9qizvjQUD/75hDKdwRYyArGBfk2kMP2
Ij6V2B3NQPrLOjThRoLVNZuRcSZymQ/uRawT4W10oMlz1ddXB6gTDW3uBcSSDDrLksQRv5I0
61AVNUAHlRJl5TFDQp+SAclLx8LE1p9RJmIN9PLhGBiHJyIF3VhDIdqYIQ/+gVdfnDoaqv3c
AyhoXZMG2I1vUnRp41EQLA8CHBlgoDyEqO9vF9Fu1lgF3y7uyGAunURAcshqhtzhNfzseeJo
aMXBUE0rDzolgDF8hQm6mlNzRK1V9JamvCjI9DNPE3jYc7+HSGmNML6UQtyon/P4nsngmogS
StAG3CIJ4wZTtE9g0cYtOu5RNdW82ijRagbcbgiguc7z2m2tvjPq9W10u5gzvt1uIwzlgrOE
DbBpQzeWtUBrEqYWzvjRaWXWoJ4sg30E+JZvoyjEFsrfbkm2d5uPCt3tcKMy0aWJz0fwOj/J
YO1MiFl3YQ9BkhycmNpoEUU8UJu8a3FNBsWfBird0UNobXkOq0xYB27PhGhDPTqqs37ZUqeZ
ZHlourbbxarzC91bTkSJQQzGVR/EVQ+o5FSqOSAKBXtetmm06CilE+621MoQ3PvMWbSplKn/
leHw2qutYNnA37S6SNt669q5ClY/+ljC4vOA6oDKTS71iZ8Cz9P9OsiirmcF9DYPJmW6TDUr
MHN+Q1jt79O2gf6lGyzzg3NsQM5b2IQm/xMHwVmLxGaAHdmFFkEBWad7Jk8el6bNt9F64TMy
YFr2BjzYdrYdZWwBrPqD7qJtO2BTjjZdCLHro82WzbE84fp6gcT0qRuy4yJKTiCMRTiMB0QR
CwKTFLu7RTSHy2a3WSxI+JaEq2W3QaZnF7MjMfv8brkgeqaEzXFLfAQ23tgfVEAUXG62K0pM
tRQNPODlJQNze0eeYqmNKMMTsUESjIPIxWJ9h6PfNaJcbkh9TKeLTvOjKGdFmkItU/L5PkCn
tazK5Xa7nS0PvqS1UVv5T+zU+CtEN6rbLlfRovd8aSz6yPJCUDehluBebeOXC5s1BHDqGFxH
gVAOvc4TPjzYFCQR9SG87KVIG7jSxkoNYM75HamwjK0+7JbUDGb3PHLz8l7QOxpjfuhLggR7
oJr8Pwp1dpHn4GEWFooKum6cQOyl61Kg9dH7SdJ4zj3tYXfsDxcf4lfFQOOWV/Dotsm37LZR
4+lmAX+8YY/Aj3M8sybfRWRQjGJwd8xR7dTvwUEfw/wuaNbr5QoruWqLCXjYKh6h+5kLL1d3
5DmAR61IUT3RT5PfssCXFtb6DHCy6Zs7vl50uLHuNx33DCuO367QD5DPGYZIl5sm0Y/jAmEP
gbzSS4KPKMgOmkgknVBe4XUHQA59/Vg4roDCwW1QEK+rhpRQXQo7HGjQ4aEP+DEPWFprtNic
Elcs8uDVakh8jZh84Eh9uzKRTjS24YUMmUYAmYWQ7nTQzg5Xpqn38oGoL8vI3f8GQK+2BIES
TVmEt8oAvPQZLEMMAKFf0mhd/0eLgfgr1YRT5R5PFnmPvassOOSQrhRaReKWMJBgAXGZR6Ip
2O3ujgpBU5jV7nZtbQDPf7zAz/+l7Eu63MaVNf9KrrrvXdQpDiJFvT5eQCQl0cnJBDWkNzxZ
tuzKc9Npdzr9XtW/bwQAkhgCVPWiyqn4AiBmRACBiLvf4S+eJLv+8evrV/AT0pjxkscvWU2p
0XeaN7B/8gGt3Odihx1RmUOho4W2JIFI5DBrZsJplaPHJtHK2kSAZkhnQMIvWQExZ1PbFbSK
cPMftRJS671R1SrPCmJcqFRsefV87BgZEMv/ByMZru6BpC3NQPnLCwbtMGUkIpyIcwggH81S
/uVh16kcCfA8gtzKI3DV1AuNevoRmqkfGXxxeNQIG41Dbf6OmEZMXR9cULlMSzbdgk2pmMaW
eHpGQFpjhwd9yX3MUiP9JlCPZyWJ2qTMIK2DkNikrZkwSXI7L5OUBL6ZF5TrqJFgClsEXaYb
idrgGomml1f5EatzZU0wupACC1VNAu7L5XK0KQMEGaC96nKk689cQ1F/GjNL0IxaAQnKlOld
zclJEDhMeWYG1AhOyTa383Vv3QrukF+1QYsG21I51NZMz762e6p8+oXSufQDx4MDgBzyqZ+o
qva5NF/eqN/7+JA53g+qXPxIOq9Ro1gp0HbkIdVcuXMq2zEjD410cqbYWYTQ0XW9Cx52DHJe
iBfnL49/PF/vzk8Qn+JfdhCvf9+9fWclvN69/TlyWQ64DJ31kJXYjQyjqhdIJbhGJ5d304MW
JQow8pRKQXfkPi8xMVnhIb02oxVkbKz51q8C4xXcjLbmj7FYAsd1mh1ioqBZrf+Cpyr6G2mV
g/8cMtqapNJvuKUU76VvQLr78/H1M/fCa7tA40kOu9R8ji2o/MwSoetbKqeSU7Xriv6jSadt
nmc7cjHpBfu7Nl49COQcx457eYGz9nuPGn7IjFuSWh+j6hPR+qT1I/s5tIZTE/nC/sevN+eb
8KJuj8p6wn9awpSg7nbg+qc0Au0aTPC0yxVGRXDQlnQ0v69cr984U0X6rriYTJOb0+dHJtY+
vbxdX788ChckZnp4c7hcjvfNwzJDfrqFY/HjRHO7HNGJlPf5w7YxYp6NtIFp5OhHFYY2igL8
GEJnSnAnOwYTZt4zs/T3W7ycH3rfc7gq0XjWN3kCP77Bk8monV2cRMuc5f29w3HPxGK6csM5
+Eh2+OudGPuUxCs/vsmUrPwbXSEG/I26VUkY4Cu1xhPe4GH7zjqM8FdrM1OKT/OZoe38ABco
Jp46P/eOm/aJBwLGglhx43P7psx2BT1IZ9XLzLRvzuRM8MOSmetY3xwsxQcaOx4LzTVgyxSu
ac5joAqGvjmmByPcsc156W+Wie2ovo8KbMrip2we8HNoaYCQBlKqYVpn+vYhw8hgiMn+Va8c
Z5A+1KSFS89FcKC6j/aZJX1odTd1MwSe0++56yFtp53wvASpMsUfICiFyOH4qnD4epy/xnsK
DSg7M+2aFNRL1aGI8qHKNNnhkPB8vvB10rZlzj+/wASWFBvHs1TBkT6Q1uG3luPQXKaTHoPl
RJlORpYyca6jsq5Thy9/aOZzRVib9mvK2BxvIDhLD9dt+BWQZICWpWmXOx4eyPlTUJetbrGy
Hh7wXf8wyqbF782d6c8l1yIeI44ODQ7+cygSbxWYRPZ/8z5FAEyocq0bkiGFiYtdp3O4LLZi
hTCSGa/QDVQaLlxaOhiZG4zyue8yE0NBVF/KpktvfajdLjOIvd3BcuQ8SCPtSZXrvihHylBT
JkOpDTchJWavNqF5dfS9ex/JcVcl0mOAPL3FRtfs+woR74VAzBSmx09vEIDJ9NTX99o59Qlb
6Y51cdkkQ9s/KCuyPGF2EUWkyHdBNPl2LnkoIriZgeAro0JHr69Pj8+2IifWR+HvNFXPkiSQ
BJGHEocsZ3sHj7Bge+RX+fw4ijwynAgjiZgX2vgY2XZwuI3dUqpM6eQTAyuQ5jNLATQdVQXy
C+lc5XEIYypLlddMaMMOBlSuuuMPFei7FYZ2rPeKKp9Y0A/llz6vM4dorDISrjUPJ0fQaa29
aemqeuZegKZi90GSOGzZBRsE+pAemq21u/7+8htkwyh8VHInZj9tJ54yK6hNaXgn1jn0A0qF
qIwYM1cwXVyqwHu6CNNiVzjcv0iOD4soTdP6givkE4cfF3TteHMjmeQy/74ne+dzGJ31Fpvc
YdgGczPDzvHMQ8Bd694VGAxvdMv21jc4V1HvyvxyizWFtxE8PlSxZ51bNrg9seSGyfvRDw3l
dvI+r62WxsCq0r4rRyNrM18RV67ODIdH8zUZkz7ylrTdcDjxWCPpweVgaNS/XNZ69bB3jNG6
+di4Hg+C02RXjjxcEhvaNS7zHU7pOKGceNc7jqQBPGZb7CZXNh24GtMUFYXOm5wV25TFGAlu
HuseLzGHHOaWhldp6YIIqd8oqm6rYUu1+/GqYBJlnWkelTiVx5/MiB79UCDgjlWo1Ng3gEU8
SBC3vTui3n1xmBZWppStRq7czqRPD1mzt0sCYXKbHf4o+nBmgmidoXFQQGUqhBGLjP/Ig3Z8
QqSfeXY81Ck/UkLt+OHWr2IK0sp4aj7T0fd3TK8IVhe9YqOhFzqvnSWdc2CN73LmzaB7Axsn
1ckIIgMBGRbDyp1Mlydju5N6nx7y9J4Hk9Skkz5l/7XY59mSXT5oM2ekcP/mCFn6yB8Do9rt
MdUDxgBbF44QAbtV7xBVBOJoTVEIxaEs00Dto281ghz7MfDTFba6689TxY0nHsqGgweWKj/p
WYkHNuJ9x6/nt6cfz9e/WIWgHDxQCVYYtoNthXrCsizLvN7nVqbWOj/TK9TWc8TLPl2FXowl
bVOyiVYOP9kaz18LH2iLGlZFu8TakyEgZvkif1Ve0rbM1BGx2IRqehkFUo8mDYBx5sRbu9w3
26K3iayu6riZlC+IqDf3m1xr7ljOjP7n959veNRcrSlJWfhRiBoEjWgcmiVixItJrLJ1ZHWm
dHDlyL1IdDd0nEZTzCQWoLYoLiuTv+bPzrFTBI7yV+psKB7NdLRgSvLGVW+GxqGHpNnEriF9
Uv1rSULLn5vO8/3vn2/Xb3d/QBxEGWrpX99YNz3/fXf99sf18+fr57vfJddvTAWAGEz/1idk
CosTNuOynBb7mgdIxdQKJ6/DEQCwOQLM8FnRGgtVw8/LdRobtWoQGqMpKybZOXKf3luKC/G/
2ML7wqRNBv0uxvbj58cfb1gkaF67ooGzxKO5lmZlHRgFNKN5ALFrtk2/O378ODRMaDDL3ZOG
MuHE3bZ9UT+Yx4baoIDQLPKmjVeveftTrCGybsroUF0LOue90a5GMHodLIlDIxOjApy7O52Y
zCywIt1gMaJga7WwVkk1aGma1RQocwjFUSI46+RZcGrxEUxbh4B/QM1Z2lY31msRz8BigW3p
3afnJ+GMHglDzxIyQQ6cd9xzCcWh5Exc/DjqFpMcqXi5Rya5LEyl/AqhXB/fvr/am0Tfsjp8
//QftAZ9O/gRWDVBhDNcTLTST8Ux99AxoK4Ehn3XHNX7HUbXnv4q/LD17o4smX52Bjmxv/BP
CECRI2E0ym/jjSzLRWi4DhyeFiVLRjZejO00I0OVtkFIvUSX40zURpg+uVcP7Sb6xY+8C0Lv
qx1ChkvUdayH8RixlpSVQ+8cWbr7xMOvskeOJs3LBh2EUwmYhEvskqV0tS79yAGELiBxARvl
yBVGvWaeKgnDji0V4EB8KIuKCVWRH4wczc54AT4mKboPejAyMX7M/ZZLxPSB7jBVjYNzZDwh
cIs4Xt8ef/xgWzzfVxFxjKdcr5BX+zqLOKdyfdry3cip2Zm0W6sOcL7rymfXwz+ebzT1PNus
8HIC7tDWOpRnzJENx7grnVNqpam2SUzXmLwl4Lz+6Adru2NIRaIsgNcUW8xCWDDx00mj7KxL
U/WInxPPabYJdSWa04WQstBL4K7evDQdtQf3eJiERU69/vXj8eWzJuLIoKHclsYqlKSbEYx0
lro1++w8jOqN1sBglIGaNM9wYDeMpC+VgetuoZ1U0peT7pJIfYzKqX1bpEHie6qKhjSimIy7
7B80bmCOe9IVH5uaGNRttvaiILGpfhLY3bPNNtHar84nV+1gi4kCKx2Irq4k70n9cej1UNVi
WrXhZoXb3Ug8WaN+3mQv6kv51LVyh7HJkUkWe45Vri6N+ihZKFjf0jhK4oW5xTk2vnNoSjww
R8mH6pLEJvFcgvcqg3pMt/5KP2sTq0GVhKaJ2Tip7XElNfJiebxte82kWQ7zYuCOan2zvHBg
JSA19JRo2SwNA/+iTgLk48JkkWkoi4XSFJUpOySZPkn2+y7fE+2VlBgiTJQ8KuvOWVP8zz4c
K1uitv/b/zxJbad6ZEqxZuLsS12A26k1qkn4hGQ0WKmigo4kAY745woDzG1tRui+QAcEUny1
WvT58b/1M2CWJVfRBng2j6uYEwvFD1onHGroRUaBFQiLiq5x+KE7MW5eqPHoVoEIR7JQOvSl
u85hjh8FwpcWnedW9TW5WwXWiecCfBxIcm/lKmyS++ulsSPHyCQEw43EQE7aosqd+aUteofD
+SFMqh6hdCYjeg/CZI59E4M/e9fto8pc9mmwiW59Tubm+qIQ025+S7ChtziSu8vhXB7ij6mX
4yIZikHYyQqHxJfhcXn5YBdc0J0vNVvwLASMtlJLsnTYkp6tM5pjnEuyCaIpzTy2+PYk6PgF
JmvaBVh+aUiStkpiD5MO4HIB/EWBlOTFypgf05K0TzarSLvZG7H0HHg+dug6MsBEij0sqZh7
N5ImSHk4PbDpZb5nGtAptBG61aOEyBozMtpowl+rhRuZbj8E4MQKq5qEnFaJJt8hw8Tjqb6j
DGnTDZcxI8KGk782bhBdTNjc1ViEAGI0HZPa2WAJQxspaAvZ2gAf4x6SAuRWXe1TEccDg5HF
caY9f5R3JZp5H8aO12pKkf1VtMaebo4sIuJaI3njKEYrbkjTOrIJseLx5tqsF8vHxs/Kj5Ym
NefQHQqrUBDd/sDaNBmxeaIEdecyzbNqG67WdvW5VO/hpeNY4GNNP47OPTnuc7EDrZBlYrQm
wXLveragYcvWyHBMqe95AdpuQkNcavRss9lEmoxwOOPxnLhgSDRdT5IgAk9fgDkytgiNTHmV
s0/WYBopt0U2IkvCpi5959l5NtiuOYLnruDWzeBBUD88HznG0Or7BiJo5u1wLtDgOhj/jhRs
JLAWym/lDBay8IQLfSE7Jrid5T8tJPCBD8tBd2SpwnOJsA9BuAruVm7hI3AAqKYdFe+RAUkq
TqeVEYIIEsjwGa1fMOsR8D7WUFpoHqM0ZyvAQsHJhU7aws2BZj8OWaUF+GLAsxxRIx/pZmXb
FdneSgCmKos5jgw6XZidTC5a8MQ6E4rpR8jCo4uVl+GsBpisxuFUUZG0cOQx4dr+PQEU9aHO
8bkmRo5jNcADclrVVsZKNZ15y/f4s1XJl18vn+CZsu07dBzJu8x0RMEomMzI6Uw7Qc0HRjBQ
BJ224sN8PLzTMyJ9kKw9VyxOzgJOiwYwpNT8D83QoUyzVAf4uxdPPb3h1PGYzyrFpQ08S85T
GKZTNy2ZoC4ks+5XJmKIEROMuLHaTJAdd2LQ1rDkoCeIE6rKoZCloMn7Me1jHMG22BGMkaxU
yxRJ81XBidO0a3+g7Emfn5vung57avRnlfrhxexOScRKXbVBHGCvVQE8FPEq8HljzBmC47CW
0CLVpDigsuzbErskKVsGqo+6gKCFjYaviWeBOo2fDadMUTV2Ewbd5xX+NQC5+udZA0KQXZ00
6oxG40mZ2KIaB8kz1exAQVXPbWeqLgtP9MRx7i0ZmPiJCYoTGkTWt0C2Rj7FyLi+wfE+Dh3P
iEd44yxHXu8Cf1sZ41M7lVXoXd4fdYqtcY0UkAQQqr6dyfNvZKlWD5lVch95IXbmx0Fx5G9k
dJ94iZVNHfWxj0nLgNI8tSLtcnqxWseXpcWdVrqnjpFkugIH+v1DwoZsYH2kotj6S7aXyGoo
sg19F7HpWyvrvmqdJR8vJbUUfTGQKgyjy9DT1Hifr7CJOyC9fkJL1mksu7IyR9B4fTPKpkzF
8r1I63mhkqEXMQJaWwNF0BM07PcEb4w1YFTv7FLzSyykdQCIYlwVVXJ0jbTxDgopxsbHCqfd
NqlUbNtgGFteQ/w0oT+XKy90iiryvgqdB+A2Zx0uzYOyCqPQWjT7NGQ6ObaTc9S4NuML0SWJ
IjMbJtgearJHbQq4+GNeoSpErJm4ABKgLvahslXke0ajA8239q1zZR6NmKC1DjHqyhE3QsKh
vyTIiYNYs3D8cBapKC+D4/U0LIrNoRJ3yugTe5VFv4zWE5sI7UE0MVdF3baIl26ygJDEjl9A
tfMQVI2iXRrAlDjfg/7baIdsE9F5RD5zCKf1p6bsyT7HM4GnKkfx4okeK/R5y8wM2jpX1id2
paYTF5Nu9mI9QL4n5aXFz0jxaI1lDupPEkd45qNutJg7yaJQH8UKxvcddHQpTHIallmD6Vs2
Ixs6cKvh+KTrVmlmsVUnBZsGMpK3HMs36rNkaqGMNkNH0ZE4cIxRrnrcyjhQ9wkD8TFkR+oo
jCLHMHD6NphZhMLxj5hOUXhrRBS03IQOi0CNKw7W/vLoZLtOHKI9DQLKGm0NjqBdwy8AHLmZ
0oCOoQqmzqI595sRsUO6oHgd4x9duBHQmSJ1g9Ugy6TTRKPldQe0lHi1ceaQxPHtDDSVyIDw
+TPrTI5iL1V4EzqxxHN9jmEBnqfU302JSedYJ8szGnhYO+AfaH3WDTjWRivfNTraJHE4PdKZ
0EcnKsuH9SZAVxtQMvHVxrbOUjCpFC5+td0dP+aap2UFOyWJF7uhxA1tcOhc4UVFrMlsHlPT
nCEaVC3xlnc84KG+78ggqpJ1jF+LKVxSp1z+TrmPZCxhGzNlNQViWXsxcUCJ8QB0BpkSEvlx
uFwmRelDsSCMHYuTUORQMyCTae0uIdcFbzQuZ/ND/KDSYMOvCA0mTe8zsA2+qys6ICaPms8P
LI5JX5hTpwsBhcH585Dm6RjNYIEL4eDH9fvXxx9/Pn1CH7GQPeY2/rQn8CB0rr4kwOILT+zo
Oz+e88gQvxaE0dS3z1JvUMmcvnt9/Ha9++PXly/XV+m4ULlC2G2HtAL/e8rZCqPVTV/s1OBW
mr37rugq/uKNNQp27MkyyNRzMfgI+29XlGWnue+XQNq0Dyw7YgFFxdSSbVnoSegDxfMCAM0L
ADyvHRsWxb4e8pr1r3YyxMBt0x8kgg4KYGH/2Bwzzr7Xl/mcvVGLRn2+A82W7/KuYyqZepAG
zGx4aA8zdjBS4DQ61zPYkvS+BO9TOivjk69ndfa+KHmb9EU93T1pA8btlRW6qOg63Q8aI7YV
vngA/8M27wLPoT8xhgb3D8AQQosSXPrgrVxUtO+NcrAWc7huZODxlFNMzIYyjA4Ljfyon/lm
UGJlwtghnEei42RjxsebPyTp1J14Bl1x0gc6EPQXUyMR+wgHbnyiWKv23HzY6SbCE4lpsfCs
vThWKAju3T4ccwwzyyXJznbrSJY3+mwSJLvqgqzOCq0BBOx27g0jr3/wUZMTgWmfI+Ajq7dI
o9lAmWY2drFIrtJS/CIGEHIirpDwEP4IDXkKfrQbtigWepPdP3T62hNmu4tFGEiaqpFCRrLZ
AaemyZrG12l9Euuhd2Al6ooMd1MCrdLdW6uMszFStgW6guBCa8BVhRuk6XHnmOPHrDRKAV5a
9pd+FbmXtNEUyoXL4zUXXOVsKtRNhZ1BA7xlTakbQs5UbgKxR+8zFKayqHJHeucEbDvwGFP0
plwAY61qUYc2gFG2gnprM0W19o0dQ4oyqOTCt6jt46f/PD99/fPt7n/dsUnldH/NsCEtCaVW
3F1A7Fd308xzpJrx+VHibOgxgeJiADWfG1kMHWwGxCnaYlrrEGGGuP36uVSDLMwgYs6hgUw3
dpmtalwOl88zF2bxjLBhmjHemnHoYbu1wbNx9EabRNGtstjmrhaLcpdpYfadmjJUdNum+ZMn
1hnrssWwbcY0RTQ30qWXtK7xqsrLhOWmyrVXSDemkqKegFGkOoOafaP/GnhEQgjtpFlIKJAl
k9ksaXnsg2ClFtHSrsZktDnWykjnP4eGUut0Skdg+WLzG417QLUM62zyjKSQWjVqJhCyiuT1
nu05NnQ4Z3mrkzpyrgo13DgQ37P+sSnSY63mf4iKmoDlo1ZFRq6KS94BiA52WfSbuNvTAq9Q
Z+FqSzzUBOyV2AbcqKoGLx3TbEXEnTBQ6VKpHthGOWjBJHiBuiYddkZOJ7DbAFfMDNxRsxVm
1OmpjRfVcTnGs0BcY0BJcybA1qmz9lV7XHk+d2Vo9FdbhnrcJ6CSdLNmAzLLU2M42QFCOPlY
VVgYZJ5V2TTGMKv6lpxMEo1XOmn0eskdpxrcvDZGd7COqkgdXFZIVeTzHKK+BUfA0eD4nacV
ZGtFGBID0hgQJPMT9fJA1J6utLM+TuyL4tJiNK4OV2bzkmOSoMYXIxiYH2C00KSdA52w7RP1
gfVEGiCwCncKooMp8XwvNmhVYTVDc3lgIog9pgTdSE9XQeKb9WVUPGwlB/vLrrAGIOlK4ohM
AThbAZfgkjwsJhfZYxYKU+bGqBM5rsxyskGEOzYXayQmSQCSp4cm3OtfKOqs2DfmBwQVNeWd
4ew9llXRXPDcsvcO16tQspr6IRr/dEaNiTo6mVZXbhGHhwvQ2feX//129+X769frG8RAevz8
mQnaT89vvz293H15ev0GZz4/geEOksnTH8WTs8zP2O2YsOyv7Q7hUSWTi6sCI2xNyfum2/uB
j0nDvPubkphJyku8ileOaBNyj3S6dmVwXQURJqGItehysPaErmh7prk6knRVrod7lsSN6xsc
i6wkp4IkeBAvBcXXNa5gNhS/7+YMl8DhrAfQh2pn+DUTHvGz38ivz0/fzSFBzDFHppiiuhjB
AC4bOaoEOJPSOAFLKwSjbb6YQQvvMYbJV6SVCd97xziCC/kIPlKzXRYtjMBpsa+YhIzdTeiM
mnc7HTpklbXszqg4b72Zfyp9E7s+AnuM7y2hYbCM6iG9DA5+VbLUTKEXuVZ5YJtVa7M7MRFi
9qI/jki7WF1uZ8ZqMI8M80MwJNjezMr6MX8Xr6zFiqeeBqe6RLSpWXPcfx1fo4suBw+yxsot
qXJv17fIAn2YJTb+3dlYjKl+DzBlDub6hkiSbxvrY1NBwMW1h75f1th6QlNSOSpTNapR9Qjt
jGddUgVJnXs0bYxxwQhCvtR9OUtkPHhdUNB4BhUIqS0OpB+ZZLIO/E112SRhtIZ7l4NZaIW5
66N4FXEulzDJX8CgVamK+67hio3q4pR3UVrFIT+To8P5UNC+nP3f0u/pHR/7fMPevV6vPz89
Pl/v0vb4c3RTl37/9u37i8IqQyAiSf5LX9Qp18DAq1tnDe4Ro8ThOFBNf2SLm2sUTRlRa/2b
oDZDHU+rPDkriCs900t3hWt1njKQtTSgorrw8h81hzCL7a5NRdZphwKiy8OfWAGLCr+AmAZG
f88Uh/REHXEZJBttdkPPtM38pO9DYpj01dOn1+/X5+unt9fvL3CiwkhhcAcv3h55PdT767GS
/zyV2WrSu7+oMo6xRgX/aE1X8afDWNNITqv7bcZ+1+7h+su1RfKGBk+68Hc7RQnl+xISrURd
XhA1nWMZOQ7HviiRGgLmr00pfEYuTiReQPQbFhVde17gQHw/cSNMDkOXsxHGbwEmtvsVnvv9
aqUHzlGQyBG6W2GJffxcWGVBHSjMDFGYxFjBIhHRx6SXaSSupQxgmwUJDvQDTRubntIwKm2x
f4aWayZ4XBLSzBG5vhzjX14F5cot5088ke/0naHz/ZO8XGrOxLEOXYWNMftSlWHtuZKurSog
TJcLMggkgE8yBoa+eeIzAitkznL6Bi9lFJaoZ6aJ4xJ4mmXuCHBhBBmNQkjBPsa23eX+zOna
D5dnJGMJVphp38yQhD4y3YAeIC0t6HhD7/sqxtbNoq6bobsPPXyIV4RJaB56i6OxMCGO2Jlz
KPKsw4sJizFrN41jo7tS0T+6xi4EdZYNMrbEp9GhXtEq2fgxvCnhMnqP+jIYuZnk68cJ0qoA
rM0jVQXA+4iDG2R8SsB8mqPCSez2z6PwhV7s/SM+Vi+XlY3CFvnBX2hxAcArycYaOni7nq0D
yUAzdOcEDcBheqSyOJ6sqSxJAN+4wcb2fZPL5vGRjudkWQkEQvYXTsZT0H1fRtYhPEfgXMQ6
MFARvPEntMvZH2hysDVgeldbFrsCFx5p0e2kkCnEPHcrcQET+QqtgtBDGgOAGBO5JOCoFa1W
UYyuE7QnYbCkIAGDeUsj6AXTwBARlKnkQRQhReRAjIooAK0dV/wKj+PZqcqx9q2z7gkKlvY+
xsFkO3Ql7tk2t/JxO/+JZ0c2yfoGT3kKA48UaRDeWDkmztC/4PWZGJb6TnJl6cVfoat5T0MS
BGvX+Y5gEfIJ0p+ARGiLHTPihzd2d/4q0eFrauKpkshfHhbAghqpawxoKQFJbuZu+C9BWVBb
PZUhtK7CJmRphweGlTMp+nBIY0AFXUDWS/MIGBJkAjN64pl3uRPdtfnC21jvRgdtcBEIEId5
kMaypJIBw9qZ+xp/hqiyJEs6wZmSJMGXnI/8oGETt+g7SlXUWkeIIAQPfyJkA+V0RDxg9DhG
1umaHJMIn/314vXzxBEgQ0EA+GrZEqZHewS3r9PPPbRsxc4K1hro6cYMm18VW+2+I+2B40iF
lONacZVUZLblHiOqWbOfs0fJvsvrfY9bVDJGV0zj4wF9rABZGyEG6I/rJwjJCAmQ2AKQgqyc
8cg5nKZHd5xvwdEd8RtfjratK+zhiBa4jQ7HqRkyRgWPcLvhhLd5eV/gzx0E3Dft4IrjBwzF
fpvXSxzpIe86PCSkgAv2awFvOkoWKp82R8NrggZXJCVl6c6+7ZqsuM8f3A0oLrjcMGvevgA7
vK0XOfyAcr6HtrNCByo4G8f7pu4MB3oaS17RpYaGMPALYO6KSStg/MKYYx9Z+zjRfV5tC0c8
Uo7vHO64OVg2XdEsjN5DY97V6un7OAndnc/KvTwr7x/crX1MeXANJ34mJZsbTvhU5Gfa1AsZ
7B86y5ehxlBAPBI32rux92TbuYdsfy5qV2BY0Ww1hNXpF4pWpm5HyBx3BJQWWN2c3MMNWn1x
seVvGCo2atz1r1jfdAvFr8jDriQOK31g6HIxH905FGnX0GaHm5ZwjgZirC7MnOpY9sXy+Kx7
RxwujnUFfokEaNMtzZuW1ODPks0+dze1eV1B/PcFhp6UD444LpwBIiWnC19gCxZ0U+GIhy7W
54LJaQv9xDJYmCRdk6bEXQW2syw1EyUVPdbuRqZLGxcPl146wx0DR58T99rI0LwEe02HdRPn
OdZtubB8dq44brD8dHleE7qwtdGKdP375mHxE2zvc89ltkDSfGEp6A9snXE3QX+ACLDCONe9
ToMEOLSO11JipV7a+s5FUTULa+mlYPPAiX7Mu2axfT4+ZEz2W1hJKFttwbeII/ggl+HK1v0B
iI0WmK5LxstcRLKdYpiggjgDMGG8LfBOlOxZfkK/b35mDsOqfXvKjkd9NT+lRnFUk02WQOoH
lHI1h7RwPcgFXBqi68TJKFmrItvOBnO5VeBj2Ra6RYrIqq5N14AUHrelh+FA6HBQnwceVdfA
R+HU10hX12w5TvOhzs/ypdKkU1VPPz9dn58fX67ff/3krS7NPdTGhUxG58/wMrig2PM7zuUw
6+et2u8tAlio9HlZ0N6GtiV/ikJ7GOE2vKOVTmRNTXlbc9/gdGt3EcQDZhoP258y4YH7XaDC
ovvmUQ6xfNM5lm9mK3i8s+L1xfOgTxxtcoHRJLpMS8jp2XafEsw0ceKwunOksi2szrXT3BlF
AsACmMuiOGdkczkGvndoF5kgeoAfXxZ5dqyLwIrF3SyNo1lGOpjIQdDALb7AYqzoe0KdUffl
rGEUtb/Tk1sPAfkkdtRkd6u1aZn4/iJHl5A4jjbrRSYoGXiGXmRw1w5QHqFExlaZJoB4SXmX
Pj/+/Ikdb/ApleL7I1+I4F0N+gYG0HNmNGNfTecqNdtW/+uON1HfdPBi+fP1B1u0f96BZVpK
i7s/fr3dbct7WM4Gmt19e/x7tF97fP75/e6P693L9fr5+vn/sM9etZwO1+cf3Azr2/fX693T
y5fv+h4m+YwVXxCnx/EIJK2DZ1AS+KrTWlNxypH0ZEdcfTNy7ZjIJRxko5kUNAtQT3gqE/ub
9K4caJZ1HuZT2WSKIrz6749VSw+N8wOkJMfMPURHtqbOLcUGYbsnneriXYXkccnA2jXdukrD
Vs7huI0DM6qcOqv1yK3TrCi+PX59evmquVRRN5EsTRyPvDkM2h9uRM7gojWMkAXtNC8wGJ0/
tqLvEgSsmXiY0ne+Dunu+SX7UXXEImjIaIdQ0SFCGvYk2+emSMQR+TW9GfjCk3X4GQeXJM4p
dv8goUD/EFDG7wg/O4+fv17ffs9+PT7/xrbvK5vsn693r9f/++sJnqvwiHqcZZT/4G0LWzSu
L49/PF8/W8IP5M8kn6Jluq/jTHTiy8AJZtc4NyORmb0RicRODxMTS9/Bg8+qoDQHRRKNh8tb
/1Aw4Tsn5ndGOtN/sOtMjcUSPiakMsWvCSmqiwOxDPZHaWKtXoIoRGvQS8AfxGi1xBKeBmIz
mO2Pcooxu9RXI+fUp+r+yMeNZQ3K1w5K1/r7eb748CeU6KKii+GOvTavCvTWTGJBbH6QZMfe
cXcgynOiuXuwQaiu3jyrU3Gzb8aVN31Yp7G5SDzwMChGZ2b8MM6Sm/qscJ9J84rBvUbGOofJ
8EjpODxUu4KHoxYRfwxdwSg6m1NMQToV2850ksvL2ZxJ1xWNqyVAerJFbQiHx+WqXXHpj6hz
aDHE4PXF7mxm8MCSYHYCPPOPvJ0ugZmIaUrwbxD5F/xQgDNRpqGxP8LIw48+VKZV7OEmAbwZ
i/oeHldCLKic2u7OYGi3f/798+nT4/Nd+fg306LQ+dIeFPc4ddMKTSbNi5PeTSJI6lZ3JdWT
w6kBeHG+h6YvF+WgwVFE7cvj9qZlLBeQ5UVbZQJ3ZI5TOZvVtbBLLmgHuPw561qsREdJpz5W
w/a428E78UDplevr048/r6+s0rOKq3fKqMIhS+2+W9g8Rp3FOJW4kEB3OcjlgJOZkQWHC/pT
3UJyrpY5ClNBUaxpss3Sxe+SKouiMHbXkUmpQbC28pVkeEa0lDCxtoZ9c390libfB56rfrK3
xdMHS6IARwC26qiOfHQYaCtlsWWKR9vQojfW0B3TKYfSOJk5Djks9CZnnVYmKbdJ7QHEf4sx
txjpcUttxq5mW4JJrMA9D6rT7TR3EYJyJKkPGx9JH6yMNFccgibOO/U6CKXXOtBjf+oeKFQ6
IhrgfEvq9sTUbHP3pj9x1f8kqzzFfJ+YLGh/TAxIt8yJzb6dEGwsTKC7UyeWHRuabIA6W3xn
rK8uLhgRt5rAHDcLebnkN4VLDjRXJtYpN86GHL7MMciF6vPj9frp+7cf339eP999+v7y5enr
r9dH9PAX7irciyVY8rgElf6g9w8jTANCX+TAgyYaXZsvc3IFQXZL5za5O9Yp3JJbs3yi28VT
MGw1mVFUlTGGpV5YZI6rSVmnozr0XllR9L7O4AG3XJndEgUTp+4dN3UCZ0sKU+YWGPhts7Nf
jCsfQcy2qC9bLh2QsypMqSHub47KMZ/+oVXf2PGfQ5/qh2wTNcUKL9AdSMGqZbYgH1P9cSn8
HtIUF/FEkkMWUhoGDq8lsizcXXFyQedk//eP62+piObx4/n61/X19+yq/Lqj//P09ulP+95N
5F0dL0NbhLw+kXxSprTt/2/uZrHI89v19eXx7XpXwUEKoqCKYmTtQMq+si7W7aI4ctSGCtO3
B3ouev0ZdVWh8V/yCuKwau4fR5otoIu7r+u3769/07enT/9BQiaOaY81JTs43oUoJfNIqSAC
pwgrqRInivUF93WS+cW+2MGURGvynh8g1kOY4Fv8xNhFjiCCM4c8nzYmiJvxiF4hwKUiXL3N
rcAv4rhfRIw2cPsZtXIc23agBtdwfnA4Q5Teeq9f//MGBesgq6t4eiUQnp4xIb0foKGPBVyz
BSDaEKOohIaxERpT0CGWOq41i2rA63vUsnyGVUtgTuVuID2MGFgFcLqMHNF4hSaKN+iLkQn2
fLvp2pRsIoeLd87gDI8isoU4aNjz1AlVX5xIYhTxoBG6g68JC3yMGNoVZuR4oeDg6hENQDCi
IiSJlShBw3bMjRU5GjG6uEK6TjxarBZOtd3Tc7Lt+NP44BmTojikhoHShmUWJB4ybPow2iwM
dukn1M2AhPjQGfqUQCgCV3n7Mo02xmsakTEShAXjWCo9ErzdnGjRX0ZDqREi9dzu+yyIHUsu
Zyho6O/K0Ecjvqkc4t2OsdzxG8s/np9e/vMv/998H+322ztpLPnr5TNs4bbJzt2/ZlupfxsL
5hYO7yqjflPcQ63S5YUNHIMIAbwMkohniBjCzGsQHrJjwoO1c7mwY2KIAu+rULyTmhqsf336
+tXeIKRliLknjQYjhvtODWOaqLzaxNCqzxzIISddv82JKyXqv1vjSNujs0EkC2EqyalQ/Ytr
sG5GpEGjSc9s9vL04w3uv37evYk2nAdXfX378gQim5TJ7/4FTf32CH7hzJE1NWlHalrk9UL1
CGt0XDnR+FriMofW2Oq8N+zJ8MzgeYg9QKcGdeiz4MgcooQXpWjt2faM/b8utqTGTF3yjKQD
W3LBKoqmnWrJxCHLlgyoBo84WIDJqeqyHDKuaDmNqTx66Kg+1f0/AoEtzas48RMbGSW3qX5A
PKR9Qx1vHQBnWN8cMMEcUKOUQKpPFT/74eOOEe6eXtjo+vJoXKkDK1N/d6Lyjuw5A/h4NUvN
AXxI8GJ1p/HuZrIvhKIg6s3IvuixWmNC/WCNHGS7jT7m6k36jOTNxw1GvyS6dDshzrB/kiGj
pjd1HRlSNkePHXaTpjKuV3apBH04Zz2KxVosOUk/PFRJFCNVtyLBSTrbqOONHhhbgcDD+ULJ
kTDSCsRDoi32JQ9jtcxBo5T1wEIZClr6gREMS4MWu0+yxHbDXBg9ssltuksMoViDHGEUVZYQ
6x+OOIEEAaqV32tRxzQ6PmywMJQj9CEMMMuZqRxG8ORpjs/xpaw8x/hSy13sjncmOSjTyjYe
sb+9q3RXMFOWbDr7OD1SnW+o/EGE1SCvmAaLBtgak54YAzKvOoj8hg4TGmEqxIRmbNFIxkWT
toWxaKoLsO1EC/gfXz7/k8U2o2GAh0qbB17gB2usaqzKG24mxDNunx/fmAT9zV1SSJVWDTJ6
2DoWJMjsY/TIR3oK6BHarLAiJtGwI1VR3lht17oWPyPBysNk5InBjK2q0LGpS/t7f90TbNVd
JT1WbaCH6EAEJMJsCCcGWsUBXrHthxUb30uDuI1SD2lt6GhkGpmhoJURw0NJYBts6OObzMeH
+kOlnWfzMfX95TcQzxdHFBL9YxpsJAMX8Yvrzq5nf+GR3qc2FXE2kSmwDnl7TU+n6fXlJ1Mi
l8srg9DM2WUVmZ8MWDQ7WpSCnfBjV7gct8LLMeIgPG9qn5mDSh9IXeelXoihUdywwBllB3Zp
+0w1Dc3OA7kUwK3GGwIHjhqb8NZaMFqsPZBvy4vjNp9HUDlAiqHaV5qOM0NIOlYgKIxh6Cmp
FkG3wGNEWey5vQUJ+PCxRJlobJRk6ob0+en68qZ0A6EPdTr0vM5aU0sx2eqtoSP8AmjMcnvc
YS9IeLZg+4LfM8mESGNxYKiaUz6HGlTHGqA0L3dQPkw9kCxME2/1sTNRueoivWHLawqjHlPj
HC/S5mzO6ZCtVmtVxCkqaMW0KKR93FTYQ+/H9+jJbUs6HteCablqpCz+cwTnGAiS3DXQnO8i
ZahyQJycDxVTVV2RvsAgDsIabUs2gfBX4SoLFrBQwcfjfLUU80/JqDbE0XFmfNqhanfRfRi2
Dy3cHFSkZnXSbkJhfRjjYCCJAVbPP8RvOMY7WkTDJHemSv0bL7Tg2oIbaMdTPcnCHZEvMVSV
q2GyFltITtzQtWh61QZHEDsRpXHOgVOh1vYlGPhs/fn9y9vd4e8f19ffTndff11/vmEOXm+x
jmXYd/mDYaMnSUNOUb8qPdmLEo+DqCtoFcCFkzKSGnCnYP42jxYmqjja4stD8TEf7rfvAm+V
LLAxbVDl9AzWqqCpEnBFB7eNGg1IEvUlUxLH6WzSC0qcubdpudYjISsAGgdDxWM0v9DD80vM
EGsIB+aGSMUTNOsqXCwrOGdjDVw0gedBa1ilFgxtGoSxxM1vTBxxCBxL9WATLkEfzKh4YA8r
kqJUJtdXWAcxxEtulYUndxeFwYmH9Rakcz01mVniFSpWjwx9IMJ/WCkZ4GMXZCq+ciXEHYSp
HJi+quCqP9ORXFVhQOyZsysj3+4TwhZU9p8fDAmKFUXXDL49Nwr+tDLw7lMLSuMLOM9sLKBq
0zjA2oJkH/wAuzOXeM1Y+oEEvqqp6FiDZMuhCt0sDQ4/tpclhpVk26boJGPTlNhJGDUjSCMz
eoW0ByMfsWYCO6IPIVIhGgWLa0qBRbqSaBJEkWnCYPYC+98ZInxkelQOFSfwFd9zXHbbnNHS
6qHyIWNMhdUwWzYc61efFkPgoccjNl+AriAzQ+g7rnFtTldQVJsTj4E88ZXQbbE4F0Wx9SXE
q89Rtg/hDxP+H2vP1py2kvT7/goqT7tVyReEuD7sg5AEKOhmSWCcFxXBJKaODS7AdY7Pr9/u
GY00lxbOfrUvcejuGc21p6enLyrZxLrFxhoi6tByPFQYBNaIvIHrRD1zEzc4+waOWgIVbkhP
25pvihZ5kTpRb+8Q6WjVpGDiaP2tqoIe1a0aaZtjBb8K3xUdow5ZOErp1nmF3b21HzEqARvP
7sY8V+Yg1y1SQrKMZsON2YfATTknI1p4N02cDD1xzd59y2z1Kl/Blz7GIVMtxsWAsFAO7Agn
+lxjby2Bisijrg8KCfB3U+4UKM88JyK/yqOnfzFCj+a7myfTcCBrbGU4ye0QMyQf0ySCUbel
KD/q2kzcGjocptvbiRPdPHazwhsQXCAfkkI4Zq9plflh7JlcWLrUocc3Q0vwo6a9MBMlBn3+
LUJkFH2NtGU4yTbFeEdKPvjW3crBCF34wfTmt5j7SsvYeMVkTEgjMSs1HMha4qY2b2VufQ5G
H0GiPxzJYku3N3MdLccUUwGpxGQdKKq0STD5jY8s+V/loZ7g8bduTDQ7pW6hiuJPm/ibsqSm
l8wKuAlOerRXEyChNzRqPLLaSsHVcuy31QhCZMtD7boYDgf0lYShFNmTGwLALr9cKz//WlfO
UM5ut3/en08v+6t4tarUIxqGUx+3z6df6Fz+ePh1uG6f0XwGqjPK3qKTaxLoH4cvj4fzfoca
Sr3Oqm+OV4xsPby8+r2PauPVbV+3OyA77vY3OlJ/dGS1mOUBatSnm/PxJ7h+mbUR/nB0/n68
Pu0vB2UkW2l4YJH99c/T+Q/W//e/9+fPneDldf/IPuzKHarbPJjYtqwb/s0aqrVyhbUDJffn
X+8dti5wRQWuOmL+aKynuamXVFsF3Gxmfzk9o3Hgh+vrI8o6VBax8OtHk2mZR6NBbWuXv+63
f7y9Yj0XDLFwed3vd09KRiiaQnoW4Iq/EpmJ+ULhHB/Pp8Ojuk84qKkiLPxy7kUgRdM2OXVi
uRsuduLVyzT9akjyEnNGTZOE1uGu4iB/yPPUoXzEI9S+uuirE/txoRr2M5QRBU3Gxj7l/MlQ
Wl5zBvOCqGd8gY5cz1CKklXoadlAmGDsfqaGoRGoNrc0gWd2jkQbanwyN7+HyaqnSsJzgWFB
RKl2aEGdNazk4a93LQu8ue+prugCqRpRCqgWO71u2j3tWCnwKy2trI5m81FFMbn8sb8qkWZE
pnsVI+rYBCG+dsJaDWZSg2eBH3rMW1zOD7+I0PsBv5mrIeiczN1UGHYry5IwlO8nWJC9P8Wq
R/xdOKeCHJhvyvV+S4PU1ySiKIlLN2wJfXmfp0GMDjYGr3CfT7s/Ovnp7bzbm8/bAchYdqn6
6sBHpqHHUcp+QQcbDFkCrSuG/Sl9YFGfq7eVE4TTRBIKRdiwMlqs5E+JJ2sgprc/r8iIrSB6
BaO1Kp1UulVyUGNTypcRnh+HXYchO+n2155Z+XZy84nnI9KmbfxL7PWlxZFWUFRxA508LxZZ
sppTsZ2SGSdvegKsNM3KwvVrRHXkvZyu+9fzaUcYMfgYjrO2A62PPqMEr+n15fKLqCSNctlU
FX+yV0xFuGVQ9sw/ZzEwAEDZaDCy+g2yaZLy6brHyMyrNK9Vts634+M9yDOmuURNyxpRF0jc
zj/z98t1/9JJjh336fD6Lzx0d4efMKeeJsi+gAQIYMxNKdtgiZOWQPNyeIo/thYzsQw9PZ+2
j7vTS1s5Es9Ftk36tcmYeXc6B3daJYL9rALXbYxIGontgwq45fv/RZu2thk4hrx72z5Dg1t7
ROKb+XPLojaJ2xyeD8e/6F5VSS3X7kruE1Wilrp+axU0izmN8FyYZT6ltvE3hdv4B/h/XUGW
E4EBDQ9GTgwSrVt+c1RXTIHKgu9JTD+HVSSz3Jn0x5Q2ryJQD+MKGDkbqz8YjSiEbav37gZj
eAgZFJXtsAqv7Uz1KtMiHlhkhpeKICvGk5HtGDXm0WAgvyxWYBHzRjmfgMuRttqBPCwBGiWw
sC9y2QZautS7lIRHJ8wkRp/XTK11ibIFUqngynsCJKj6sxKW/1f2XpDKGKTsqzkGXKtJejJJ
LsLYqiUB3NRIX9brO9cmtPuS6XQF0EU6Bh71WsTnaeRYsukP/O53jd9qdq9p5MICYb4kIQ3V
2+A5PXI3eI6tGgV4kZN5XeohjWMkpwIGsLr60oDbAG+CjUIkuUmXm9yjTDyXG/fb0urK+SYj
1+6pZgZR5Iz6g0HbbQSwSjYcAIz7sjErACaDgVWqpnMVVAfILdm4MBEDBTDUlHF5sRzbFm2d
shxPncoR8/+v66mX1Kg7sTJl7Y16E0v5PewO9d9lgDnQ0X7EAWk8VNCTyUZdtQGzeXRaIhx5
zgRX2zx1yPhGXhj3sKzEjeK1HyYphj8tfFcLkLbYjMgXtiB2epuNWhH38NBghdvrj5SVzEBk
CieGUb05kPPbpEcDpmkaqnskclO7T3pbRH5cfrfqxtUlYmc10iyTJYs7PAdaBzL32FEYJZ7u
dFuwyemOLVeD5bCFpKWxng2trjpca7gyZeydSYVXcsJGNP+/VSzOzqfjteMfHxV1HnKFzM9d
R7fcVKuXCley5eszSBt6OqTI7fcGdD1NAV7iaf/CIrJxo2V5/xShg9GBquj30j5gCP970mDq
L08jf9iSNM51c9rQJXDuVD4Dwvyo25UT6mK2kyzA43ueKul+01xlfOvv48mGvkjqHeXm2odH
Ya6NGjkXxMjTURYuaQL5MIzyahyEnoLfEPJUlDMrNZHK6VpoFdK4aswqfS1fcrD6tnyh0Bxx
0JXNIOC3LR+r8LvfV/jhYDDpofds7mtQO1MAw7FabDgZqm330qQoFX9LL+/35ZfraNiz1SgM
wFUGpPkSIsY9nd30R/qSb/Y7fHkwGNHmFHzrAwW5bG6ObP2E8fj28vJeXRD0XV2lZmMh4shP
GBWwGmYYQ3d/3L3XmvW/0c/c8/KvaRiKuyVXjzBlwvZ6On/1Dpfr+fDjDd8X5BV3k4477jxt
L/svIZDBrTI8nV47/4Tv/Kvzs27HRWqHXPd/W1KU+6CHysL+9X4+XXan1z0MneBTEtOZW2S4
iNnGyXtWtyuvxAamy39RurK7g/b8xtX+mz9kiSm3CZpibgsTIG0FmV3gHGi/fb4+SexXQM/X
Tsaj9hwPV5Uzz/x+X80JiZevrkWaZlQoJVIRWb2ElFvE2/P2cng8XN+p4Xeinm1RMoS3KGS3
rYXnQgsVAWpR5EZelBq16pHZzYMRlzAbgRIgulGV6IrebL5jYRdcMYDDy357eTvvX/Zwpr7B
MEhjPI0Ca6hcMfC3ytRmmyQfj+SLiIDoS2sZbYa06LbGZTdky065VcoI4hAI82jo5Zs2+K0y
ZWArgsuN0eCRHg6/nq7kvHvfvDK3yTPd8VYbS/EXc0JbccOE35h9VwKkXj6x5dFkkIkyCwtr
NNB+qzE+3cjuWeMWw7moxcsRELbqxutioB5qTSNiKN+B5mnPSbuySoFDoG/drnx1v8uHPQu6
LWfuFMd8HvYmXWvchpF9ShnEUh1Uv+WO1SOvVFmadZVYPqJiHt1IvhxkA9U+OVzDfPVJ0xFg
KX3dLKmCUVfWOHEsW92zSYqWZNTKSaErvS4ipUYHliU3Fn/39UulbbflQi7K1TrI26QDN7f7
Fm3gyHCkw7kYxgJmQ/HUZoCxspYQNCJrAUx/YEsdXeUDa9yTHhrXbhz2FTM3DrHlu4sfhcOu
LBZzyEiVjMOhRao3vsNcwIhbMk9Q9zx3X9n+Ou6v/B4ucQOxVZdVHmH5t3z1XnYnE/WGWKli
Imcet+kpnDlwF0VP4dqDXl92AuOsjVXCzmQahd7RGlrMINyVBuO+3YrQcsZXyCyqfFhJeM3+
hT8PNXZ8VJvIgMZ1MNIjyova5DLVgbZ7PhyNuZFYPIFnBCKET+cLWiMcH0HCPe71hiwyFrNH
6Pxa1Jksdma2Sgta21jgszQ+M9NoFnVEQtVtp1tYnUxHkGOYj/v2+OvtGf7/erocmG0NcV4x
Dtwv0yQnh/V3alNk0tfTFY7Kg2yg1NyAeuSG99CRRNaXwU2mb8uKN7jHdFUTaQQBk6AZVBqi
aHfz5qI1k+wCjOxV6UEYpROrq/u8tNTMS/NbxHl/QSGClBemaXfYjagMbdMo7akKXvytXSHD
BTA1iTd6cPmXucMiVWMsBG5qtcnEaWjJ6h/+27wQhMB/KCkgyge6votBWu8OiCZz2VdciuVz
MHgXz/KgtaoY9MmE8Yu01x1K4/U9dUDaGRoAnTkZU9ZIfUe0TiL4iYmsJv/01+EFxW3cRI+H
C7czMw4LJsLo0kbgORmmAvTLNak1nFo9eaOkmuNlNkOjN9IDK89mXeloyjcTZdnA74EqymAB
KrAkHr1VEATpWB3YYXdjTnw9ujfH5H9rXcZZ+v7lFW/5LbuQccGugxkz1FALzVoNN5Pu0KJc
CDlKnociAuF3qP2WHvIKYOzqTDNIj46UT7W9liILJckU/IRdRVubIy7wKEsOxPBAt4Uc2BjB
uKLSRF1VCC+ShIolzYr42cwgx1hsaBRCK5siH02AKLn3XgoRCD/qIGSNEvw+MuPrSjiMtTAr
Ir0ICw5KesMDksXDHA+EHjHI7jq7p8OrGfwYMGiqI1fuwOcCWm7z0NoGiij3TL3uuuoU0ywp
hlFc7V4wB0F1azLbQiiSuAUZ4hs4pl+oxlQNj2C4aeZGOUwU17bTNs6MkEeqmN/fICmCKpCj
YSaVLh46+duPC7MOaIaxClOiGb81wDIK0gBONhk9daNymcQOyzdTlWxmGMpUAU5gpWaZH1PL
XqZSK5cxeQACnNNWe+6Ea8olA2lw6QXRZhzdqVaOvEcbGEaiX4hMN07ZG8cRy4LTgsJuG42C
hZu2xElmH3VSltegjLxoOFTXEOIT1w8T1KVnnk/uRqBhVkc8Q4/aMgmhN7pKRy3aLGEKAMEl
XVENqotEaiHaXNLZSiNXGt7I1ZLQIiCU3Qcy1XoC0wzdtP4VWzv2sqQlyS9hGRxM47UXRJRl
ludISirMIakARGxC+afJ+DJnDcsvLX00OYuM9i/uO9fzdsfEEZ1t5So/hJ9oUFlgHIk8oEW1
hgYaUlK7CSmYOl+vOk9Wmeszwwo605lERIQs5QxHzpQgILo7Xg2fF5SRX43OiwVZDBbprWJp
QX+NSL8kFK3mHNQ60XQua/m4JWaalUYKRgPFzDkl5SpUVEbzTBC661RDctNi9YxipJjV87tf
4clZr151UwzW6iarNCTvuewrmT8P5NC9yYyGM6A3C+X2CFjpzKgZqNHafM9yyhOUeUdCSzeN
HY6cacCMtL9CK4H5aNKTJgSBhuUTwMwgKab6QbLTa5TxCeVBmIdBpEUqQRBnpW6R0ecwUynA
/2Pfpfah4c8J0g86vnmeLNtFIiumuL2qNnX8se2AThOMDcuhslzHXfjlfYImACwmraRic/DG
ArcVzKDjZEqMZgAFCZxADcTfFD0lCVIFKDdOUSgyikBgthGYLZeScQRN7rurTAlIDBi7nOkG
c/ZvVGi3VtjXG95XqjNRUi1yK/qtwitDLldxwNP4SV/7NvV66i89DA3mKJqyeZIOPT+A+cDk
POoxIsBA7NJ27zUJ2jZjuGFK4JGqr+ePQMkjZH5AGifiE9+Mxn9rm0KFgqpSIWibAla4cIoA
E1EoH96wphBF5rO8pzUycTmM0vAU5oQI2Acdq8nYvDGmMG/tZE2crWKQxmBNPZRGyDKNuj2r
IMc7OcwZxYCaj/mzcg0yvBo1LQ7C1vGY9cRwyACcAhNK8QmBuLWtBY25rRmGD6c6JbwI8yMI
4m8+S8JEjoyoG52tUEvVRvcdhPC2FYRDL0uDbWwFb9M6U+MwngSmTFKy+iD0mSuKEvEqAtkW
bcQeWvCYrCp2s4e0UA9zGQxixTxXcDj5ygALkBm3sUFNVwEc4LBMg3nsYOJSepDqcHziWNIB
AQdomQJmjhnHT8Cq4wwVGJjeGLpE74+7VVKQIRkRjv5yzCeDHdNoNNl8nBG4hcL7MD37LO/T
a4Ej9dUIPaLJExjC0HlQ9koDg/3oBRms3hL+KAyKIHHCewcE/VkShgl915dKBbFH5oqVSDYw
Haw7LR+OfBiZJFXYV+X+u3uSXU9muTjXpLXDRRLkE/SMCYoFcPJknjm0h5ygaud8giKZIheA
K15OK7QYFZFrtfY3Zn3i/fO+wPXtq7f2mLxliFtBnkzgrq4ffEkY+PS3vwd6Uu7mouuZaQdF
k+hm8HeRJP86c4qv/gb/jQu6oTONSUc5lNOaveZE1IZ2itpXy008P8Ucdn171PA7vX4OEWWC
BJ2kMAvkp7frz/GnRiGpnSgMYLAfBs3uyaG52X2u1rrs3x5PnZ/UsDCZSVNZImiJdzlKx4JI
VJ8VcixOBOKQgNwOh7dsd8pQ7iIIvcyXOPPSz5TMg1ryhiJK1TYxwAciB6dhhy710rKaA+eb
yl+pQKzl0sLwo5lXuhnc8iUo/9MwO6EMModWupFhUES2zVgMVWpdATeGm8pSppLWgr428BTq
ab+V1zMOaZEsGLL/7xeNvF/Sz5RZkhRIQSvrWdMYH2nF4zlQ5ebwYrLzFREuBj9EIrVvXpA7
UzjuV14qOW3K36BSigD/RE8AOK0TOfMMiAz6TxwN5YOullgrX8WZrJjjv8s53Clf6ttD6oKo
hrBymU0H8vBW5KIbQcxkOh9lEswHSI+sKNTK5F0/XdBMyg1mufx9/M1PHdJ+CrEYmPW+aZmZ
o5VR3fvOskzvy4WTL+g2IdUqdaG6dnzbzmRIg+U10JagczUe1XopLKKW/Cuc8Dfad2s9A893
2lLiOoaoXKMmKT1TsWxQBj/EOfHvT4fLaTweTL5Yn2S0OHJKOHLUgjVmZCt+HypuRL2HKyRj
NZWahqPWj0YyaGnXeNDW4vHwxidJy0uNpNdasd2K6d/4JG1rphHR+VA0ItKgTiaZyEGHVMyN
iZiQhpAqSX/S1nfZ1AsxIIjhUivHrd+zeqS3pk5j6RWwCN8tBcVXjUICQW93mYLOWidTUM/g
Mn5Aj8SQBhsbSyDaprnuo01XaBmrsMa0bdRlEozLTK2OwVZ6VRgWH2RlhwpMLvCuD3dYlyqJ
yY78VUs+65ooS5wicGjlQU30kAVh2PJeI4jmjq+R6ASZ7y/VbiM4gB44cnCXGhGvgqJ1SD5q
M9znl0HLGYc0q2JGB9HyQjI3dxzgPpGbU4HKOMkiJwy+O0w1IWL0kwK+oufmfkr73dsZzVOa
XAK1XP0gnSz4C+7Mdysfw+jo91IQkXK4IcKEIyEGRW/Rt1U1UUpgrl3xPfHhuhD8Lr1FmcBH
WBep0kLFVXqRn7PX+SILXOnxyNSBCYhydxDVVMI0gUkd+YFugU+TcB3z/BhajgoYvNozWch1
dP9NnYy6HIJgivoZ/kgofR51sy4riTmfF36YyroeEs2b+unr5cfh+PXtsj+/nB73X572z6/7
8ydJShQ9y2HZ0mrxmqRIouSB3tA1jZOmDrSCEs9qmjBxvDRQMgPqOFgQMBgtaVtq4gcnomMc
NL1yZmiqEVDyvfRNkOGT+xh9JFoa1RCUvpORWYWYLpJRVdcQ1gHYn7GyWVrIbuu1WwoxLKwq
YKEh/ZRQVyvrCytQo3mkkE7+EEU+7iNjSzZERbbKq02L2771GY9T1/F5bpKTcSD9tWQoAD9K
vAKASLxaBUrSC4byPH5FIBOVVHqUhmXIbom4AD6hs9zj6c/j5/fty/bz82n7+Ho4fr5sf+6h
nsPjZ8yg+Au55ucfrz8/cUa63J+P++fO0/b8uGemkQ1D/UeTobxzOB7Q2ebw97Zy0avHKChw
G8Ms6+uFoZjSGRaBlEu0Zaw5Mb54t9KKl1y6SQLd3qPaj1U/PERvNknGVfNyTFFk76gU5crA
8/vr9dTZnc77zunc4VypGQ5OjHp2JeqSAu6ZcF+Jqd4ATdJ86QbpQgkGrCLMIgsl/YoENEkz
+UWhgZGE9YXNaHhrS5y2xi/T1KQGoFkDvtuYpE3eFxKumGFVKDxzqJu4UrBWXGjvuxXVfGb1
xtEqNBDxKqSBZtNT9tcAsz/EolgVC5A4iP7oshNXe779eD7svvyxf+/s2ML9dd6+Pr0b6zVT
Iv1zmGcuGt91CRhJmHlElcC41n5vMLAmYjs5b9cntMXfba/7x45/ZK1Ez4U/D9enjnO5nHYH
hvK2163RbNeNzDkhYO4CBD+n102T8KHy6NL32jzAJH7mrvLvgjUx2j7UByxrbYz4lDkso8Ry
MZs7pSbOnZEJICpkYS5ql1iJvjslqg4zKtRhhUxmVJEUGvmfyo5lOW4cd9+vSM1pt2o3azse
Z3LwgZKobk3rZUpyt/uicpyexJXxo9z27nz+AqAefIBK9uAqNwBRJEXiRYAIP7Oz76YcN6q8
2SrBB2WPE5yA3dF2nIUwjqBpaKZ1aNzt8VtoEq0iaCM300D3rTtnMC7+urCz58cck8Px1X+v
ij+c+W8msAfd7VimG+ViI8+iANz/qtB4e3qSZKm/ytn2g+u7SM4ZmOWpnaF9XS8sgSKDpU+B
sdyMqyKBbRR+GvFmYuwMPvv1ggN/OPOpm7U4ZYHYcw7BtQ1guyzMBP7gAwsG1oKmElW+vGxX
6vST3/C21q/TWsT98zcrxG3iQ/4iAFjfMrpE2UUZQ61i/1ODSrO1L9h0EJ7bf1yAopB5ngnm
S8eiaQNVfGYCtmjLIF6Yoaa8LNysxV4kTB8akTfijK3rYDN+7lkpOdNqwqraqUs/rQW2RtUo
hLmpApM8dVwqehU8PTxjEpOlUE/Tk+b26dvA0veVB/vt3F9u+d5fBgBb+/tj37RTfUZ1+/jl
6eFd+fbw+fAyXrsxXsnhrr8m6+NalVxY1jgIFa2cUnomZs2xco3huBthOIGICA/4e9a2EtMK
VFXfeFjU/npORR8RfBcmbFANnyg4VXpCsgo/vpFi9xxb48/7zy+3YO+8PL293j8yIjHPIpZz
EJzjB4gYZA5XgNanCn9iJNK7zGgpRMKjJqXwB32ZCZe7w3EWhI/SEbTdbC8vT5dIlsYSlLLz
QBdUTSSaRJI7zDWnr9n+jB7PTedWDWTdRflA03SRTbb79eRTH0t00mUxhv+6sb/1Jm5+w7KK
14jFNjiKj2PZ0AAWjRB82PJFZSt0HtZSB65RuCH2IWOyj2K80uMPsgaO7/4A+/p4//VRp9Xd
fTvcfQdr3ggLx2vTMPuHXK2Xv9zBw8d/4xNA1oPN8/758DCdIerQAtfvY7giPXxz+Yv7tNy1
GMA/z6P3vEdB1SUvz08+XVjuuapMhFp0Q9ntwkaMNxjNFOz5TEGMBP/DAczxQz8xt0MKbYjf
YCnfi76+mt89QvoIrFLg56brOc9KKRSQlCtpR9cIil3kAlMz0KqwpIsxsWOWGShcZVzf9Kmi
LCZz8ZkkuSwD2FK2fddm5rlzXKnE5jewAwoJpnoR8fVip5y3OHOD5YHVrimYIy7qXbzWvk8l
U4cCvk6PFWXGNIjMliIxWLUguiyQVSIOKHyjIO6ztuvtp2y7BH5OZyw25yEMcA4Z3fCau0Fw
zjwq1BbWeUAVRAr4qny7Vm07R1DFH82VFPnmV2xY6669BWsuqQp7xAMKlKUp+NeGYgKNC98j
uwaZbOtiey1mHCioZkzLCOVaBmWMpQYVjYfz/QPljSEnMEe/2/dWkon+3e/Me/AGGCXz1dbm
GDCZCBTWG/BCcXb+jGzXsL2892FpDL9nUfy7B3NKjU/D7Ff7rGYRESDOWEy+t+qYz4jd3ucg
5vHYuNLAjOibKq8s88mEYqPmBo5iJ1FOXYu8R2vSGKhQSty4ZeRE01RxBpLzWvZEMKOQqQA7
MpMSNYjqhltsCuFWDaeSOqtrtgP3XJnnhISjCvaiptM6U/VAboY4kSSqb/uL8yhzSsDD0HOh
8LhnTbq4IbS2Y13q+QAZm6qzYK5Hs8r1FzCmjyoITKeKM9+pu0I0G6xeTmcTHPupu15ZE5Nc
GT7bMrczZOJ837fCWLVYdRyUPOORorYrcDGHVIBPE2MWqiyh9DsQXOYJL2bSVrkz0/jdaswz
tcyWCQUYJfEr4QrGwrA5vJ6h64YQ+jTvmrWTgOQRFTEeQxo9gy+s52zWZVrURpaP7z2Nwj55
GvU6gj6/3D++fte3Tjwcjl/9A34Q0WW76fFuH0dyIxgD3HjPvs5uxToyOegY+XR+8TFIcdVl
sr08nz7woPt6LZwbi/imFEW2FLxoUfRujPE8rzdFVKE+L5WCB7hAZN0C/F3jhb+NVdMgOI2T
5+H+z8O/Xu8fBu3vSKR3Gv7iT7p+12CdejDMSuhiafloDOzIVCVfAcigbEAf4oPmDaJkK1TK
S6BVAtZVrLI6kGYgSzrOKTqMBnHT6QaaVMF09/COUleEt5Z6DVwYU73ZUGYFZj21L+zj+LXE
myUwCwO4Uc4FJuvRNTpxCaOmCyxHbGw8B0Pd66syv/GnXJ+w64BVvMe/7thN+dNr4G9miZhh
0yaHz29fqQhY9nh8fXnDyxfNjF2xyihGXhm2ggGcTnj197g8+et0HoVJ59fksodqhrILEosw
NxtYBea04G/Orp64XdSIIekObDWUMXOrhDMb08StYm850MgIa680ThsUCu/CnHc6LyEWXjg3
Y8yx/mhrEyH7eX/qg9mzqSM0/AWFPfdM9eEQfmrXdBFSVCRYwnj9deC8X7eMhCTSWRpqptqW
Nju30XWVNVXJW5P6HToTqPGHNSBY0cUSppaOZuPoprkmhLVjsmycijtiEOEOwi5GbWVIG/9h
NwceNwqnU7fZJhfcdqD9MywEUCZy4B9ul38ERyWEVBft9Di9ODk5cd8+0S5O+UQ1hYKkafCt
mLQGXN/ep8NYKTKlQ7HNaZQgApKBRpaJlgiMOqTbuoaxrVriV957rvl8NffBJS400Gaq7UTu
jnUGu3uTir1Q+ExwMgcpgDq8yy+NWcJUvzSvtu6rA8g4pl5vBHIqz12qwfQoLUA7cmdmGs6r
1vruJX0Oi0Tvqqfn4z/f4SXdb89aPq1vH7+a2iCw0Bgjh6rKHJ0FxlsPOsPji46ZrmaLVTRV
2jpodq+oxG9kNPCqqsUqHIVJRv35GZqpr8aHxjf0a7yfpwWrhunP9goUAlALkspKICERoRtn
ZcTyFOs4W9AMvryhOmByemv/ODcbaOCgKc7zilAm/XOMyGJe4y51ZLEbKWuH2WufJUZdzDLu
78fn+0eMxICBPby9Hv46wD+H17v379//Y+6+jk3EtqnGKJNfVStY+GOudShyEkflbho0urtW
7qQnEsYChS48QL7dagxw7Wo7xPA686K2DZ9Zp9HUR8duprBQWfttDYhgY6Kt0HZpchl6GmeS
TsgGqcp1jLoEewaN4951SM4jXjQp/48PPq1MZEetshK+SY+G2em7Ek+EYeVq36E/uI2Wrwt8
fqAAMwDEUiO9Raq323etkH25fb19h5rYHbrgPUuL3PdeH2o3n9leWiv/Ccqbz3hfNikNZZ+I
VqAdinfg6rsDHAYR6LH7qhiMQB3R23hDByWHYyDOGhjNKNCI8IpCb2kgwnyEM8GABGUdGVrE
MqquvTw7dRrBRRB4Wl6ZqXjjBZZW/50tejWYXIrErP8N9GUPoA/jRWKBdHTo8hpEQq4FbivH
qwD5oGogKOObtuI2Ksn1tCu1wUgjVY7Un7ArMGPWPM3opkidDaMbIGBfkEoK6x3PURwSTJCm
T4CUoKWXrat7xMODupUZqduObSZJTia3cJwBHNI4m63p0cOWApw99ZbALKoEFj5hL3uYdTW6
8S0bskflFEDx/PTfw8vzHbfWayMPdiuVslPEYX4GRRTYL3D5i3PzOVlggSitqzoheJhJU6Ps
D3vhBtLfMUcUdH8MwpfkmNQKL5vsjzHq2Q6UEv8EpWiyXvsBGST2Fl2jqEf15IP10lp3RcUl
ZqFKhJVsd05rlLXgKhkOQj9sSW6HQLXoPhVg3/K2JEce+/fhBR+A5RDzKT6pyPKpRK31fN1i
2i7zCCLpiBCMkgz1aLr51XLveevMdKm2h+MrSkXU5eKn/xxebr8ejAQpvLHK8o/QFVZMpV4L
b39nDZM72iseo9ZY2v7BO4xGydTTXuCv7Zmm0LrYx9rHMLuuQWshtZsg7GQgmkJs5JglFqai
2+BJoIRpUlRdAmhrEJMHa4nPbOLKqMc9mFxgWQF4YJP2AR3Sc2IN+Csea+PHQDYxhGTN8mST
tLwBqy2IjCrJB64GJpIiK9GJwccAE0Xw+WhUyoibeHJ9ltsRnpEt4M0ztyCVdeAWJhtcLgEl
Q2vBF+fsgTqNdi137t52pkMfm+ijK24NjFRNXN94zW8A0bIXFhKaxInhLyGgf3Qzgqn6+4KP
sXNvVDWx+qgyjB89B2EKhWf3nnvEmc/QtQuEzRI+mU6v3s3C0obRO5dw2fjrIsw59ORgSJ+b
FOm8o04XkBi1s67IX3fN842sTLCfc4hNuLU0UwVYNAsTqe+t4eOMAMHyeh12xCKMCB9PCOj5
SWS+tDyGDNDg1RV6uRfVwgq0PGQLLAoktIC9Ed5rFJaU+WOAJwP+NcBMo7azz3gR7KWo6aPP
/wFMrId4KCICAA==

--2fHTh5uZTiUOsy+g--
