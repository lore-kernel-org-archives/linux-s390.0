From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/6] Introduce 64bit accessors and structures required to address y2038 issues in the posix_clock subsystem
Date: Wed, 15 Jul 2015 13:47:49 +0800
Message-ID: <cover.1436511577.git.baolin.wang@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de, john.stultz@linaro.org, heenasirwani@gmail.com, pang.xunlei@linaro.org, mingo@kernel.org, peterz@infradead.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org, fweisbec@gmail.com, hofrat@osadl.org, ahh@google.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, serge.hallyn@canonical.com, james.l.morris@oracle.com, serge@hallyn.com, paul@paul-moore.com, john.johansen@canonical.com, sds@tycho.nsa.gov, casey@schaufler-ca.com, penguin-kernel@I-love.SAKURA.ne.jp, neilb@suse.de, edumazet@google.com, jlayton@primarydata.com, keescook@chromium.org, linux-security-module@vger.kernel.org, baolin.wang@linaro.org, y2038@lists.linaro.org
List-ID: <linux-s390.vger.kernel.org>

This patch series change the 32-bit time types (timespec/itimerspec) to
the 64-bit types (timespec64/itimerspec64), and add new 64bit accessor
functions, which are required in order to avoid y2038 issues in the
posix_clock subsystem.

In order to avoid spamming people too much, I'm only sending the first
few patches of the patch series, and left the other patches for later.

And if you are interested in the whole patch series, see:
https://git.linaro.org/people/baolin.wang/upstream_0627.git

Thoughts and feedback would be appreciated.

Baolin Wang (6):
  time: Introduce struct itimerspec64
  timekeeping: Introduce current_kernel_time64()
  security: Introduce security_settime64()
  time: Introduce do_sys_settimeofday64()
  time: Introduce timespec64_to_jiffies()/jiffies_to_timespec64()
  cputime: Introduce cputime_to_timespec64()/timespec64_to_cputime()

 arch/powerpc/include/asm/cputime.h    |    6 +++---
 arch/s390/include/asm/cputime.h       |    8 ++++----
 include/asm-generic/cputime_jiffies.h |   10 +++++-----
 include/asm-generic/cputime_nsecs.h   |    6 +++---
 include/linux/cputime.h               |   16 +++++++++++++++
 include/linux/jiffies.h               |   22 ++++++++++++++++++---
 include/linux/lsm_hooks.h             |    5 +++--
 include/linux/security.h              |   20 ++++++++++++++++---
 include/linux/time64.h                |   35 +++++++++++++++++++++++++++++++++
 include/linux/timekeeping.h           |   24 +++++++++++++++++++---
 kernel/time/time.c                    |   28 +++++++++++++++-----------
 kernel/time/timekeeping.c             |    6 +++---
 security/commoncap.c                  |    2 +-
 security/security.c                   |    2 +-
 14 files changed, 148 insertions(+), 42 deletions(-)

-- 
1.7.9.5
