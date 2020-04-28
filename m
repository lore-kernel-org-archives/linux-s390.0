Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Apr 2020 12:04:59 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: linux-next: Tree for Apr 28
Message-ID: <20200428190459.GA2299615@ubuntu-s3-xlarge-x86>
References: <20200428181006.06b4e3bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428181006.06b4e3bc@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-s390@vger.kernel.org

On Tue, Apr 28, 2020 at 06:10:06PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200424:
> 
> The qcom tree still had its build failure for which I reverted a commit.
> 
> The hwmon-staging tree gained a build failure for which I reverted
> a commit.
> 
> The mac80211-next tree gained a build failure so I used the version
> from next-20200424.
> 
> The drm-misc tree still had its build failure for which I disabled a
> COMPILE_TEST setting.
> 
> The akpm-current tree gained a conflict against the risc-v tree.
> 
> The akpm tree lost a patch that turned up elsewhere.
> 
> Non-merge commits (relative to Linus' tree): 4451
>  5474 files changed, 151275 insertions(+), 63274 deletions(-)

I am seeing the following build error on s390 defconfig, caused by
commit 743f242d65ec ("mm: support compat_sys_process_madvise").
Apologies if it has already been reported, I did a search of lore and
found nothing.

Cheers,
Nathan

$ make -j$(nproc) -s ARCH=s390 CROSS_COMPILE=s390x-linux- defconfig all
...
mm/madvise.c: In function '__se_compat_sys_process_madvise':
./include/linux/compiler.h:394:38: error: call to '__compiletime_assert_162' declared with attribute error: BUILD_BUG_ON failed: sizeof(unsigned long) > 4 && !__TYPE_IS_PTR(unsigned long)
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:375:4: note: in definition of macro '__compiletime_assert'
  375 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
./arch/s390/include/asm/compat.h:18:2: note: in expansion of macro 'BUILD_BUG_ON'
   18 |  BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
      |  ^~~~~~~~~~~~
./include/linux/syscalls.h:110:27: note: in expansion of macro '__SC_DELOUSE'
  110 | #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
      |                           ^
./include/linux/syscalls.h:111:35: note: in expansion of macro '__MAP3'
  111 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:112:35: note: in expansion of macro '__MAP4'
  112 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:113:35: note: in expansion of macro '__MAP5'
  113 | #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:114:22: note: in expansion of macro '__MAP6'
  114 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
      |                      ^~~~~
./arch/s390/include/asm/syscall_wrapper.h:80:36: note: in expansion of macro '__MAP'
   80 |   long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
      |                                    ^~~~~
./include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
   66 |  COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~
mm/madvise.c:1314:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
 1314 | COMPAT_SYSCALL_DEFINE6(process_madvise, int, which, compat_pid_t, upid,
      | ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:394:38: error: call to '__compiletime_assert_164' declared with attribute error: BUILD_BUG_ON failed: sizeof(unsigned long) > 4 && !__TYPE_IS_PTR(unsigned long)
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:375:4: note: in definition of macro '__compiletime_assert'
  375 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:394:2: note: in expansion of macro '_compiletime_assert'
  394 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
./arch/s390/include/asm/compat.h:18:2: note: in expansion of macro 'BUILD_BUG_ON'
   18 |  BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
      |  ^~~~~~~~~~~~
./include/linux/syscalls.h:108:27: note: in expansion of macro '__SC_DELOUSE'
  108 | #define __MAP1(m,t,a,...) m(t,a)
      |                           ^
./include/linux/syscalls.h:109:35: note: in expansion of macro '__MAP1'
  109 | #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:110:35: note: in expansion of macro '__MAP2'
  110 | #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:111:35: note: in expansion of macro '__MAP3'
  111 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:112:35: note: in expansion of macro '__MAP4'
  112 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:113:35: note: in expansion of macro '__MAP5'
  113 | #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
      |                                   ^~~~~~
./include/linux/syscalls.h:114:22: note: in expansion of macro '__MAP6'
  114 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
      |                      ^~~~~
./arch/s390/include/asm/syscall_wrapper.h:80:36: note: in expansion of macro '__MAP'
   80 |   long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
      |                                    ^~~~~
./include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
   66 |  COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~
mm/madvise.c:1314:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
 1314 | COMPAT_SYSCALL_DEFINE6(process_madvise, int, which, compat_pid_t, upid,
      | ^~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:266: mm/madvise.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:1723: mm] Error 2
make[1]: *** Waiting for unfinished jobs....
...
