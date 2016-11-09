Return-Path: <fweisbec@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 9 Nov 2016 13:01:25 +0000
Message-ID: <CAFTL4hwQj_feMtKuTZC-u-Og+-H8VJJeVGeOYmuc0iZ_wPeuTQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] cputime: some optimizations and cleanups
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2016-10-31 12:36 GMT+00:00 Stanislaw Gruszka <sgruszka@redhat.com>:
> Patches remove accounting of utimescaled/stimescaled on architectures
> that do not provide those values (scaled cputimes are equal to normal
> cputimes) what is every architecture except powerpc and s390.
>
> Patches do not change user visible behaviour.
>
> There is very little documentation how scaled cputimes should be
> interpreted and what useful information they provide (at least
> I could not find that). Moreover they are exported to user-space
> only via not commonly used taskstats and delayacct interfaces (i.e.
> interfaces that are not used by standard linux tools AFICT). However
> I assume they can not be removed by whole (i.e. replaced by normal
> utimes/stimes on powerpc and s390).
>
> Stanislaw Gruszka (4):
>   cputime/powerpc: remove cputime_last_delta global variable
>   cputime/powerpc: remove cputime_to_scaled()
>   cputime/powerpc/s390: make scaled cputime arch specific
>   cputime: simplify task_cputime()
>
>  arch/ia64/kernel/time.c               |    4 +-
>  arch/powerpc/Kconfig                  |    1 +
>  arch/powerpc/include/asm/cputime.h    |   14 ----
>  arch/powerpc/kernel/time.c            |    8 +-
>  arch/s390/Kconfig                     |    1 +
>  arch/s390/kernel/vtime.c              |    9 ++-
>  arch/x86/kernel/apm_32.c              |    4 +-
>  include/asm-generic/cputime_jiffies.h |    1 -
>  include/asm-generic/cputime_nsecs.h   |    1 -
>  include/linux/kernel_stat.h           |    4 +-
>  include/linux/sched.h                 |   29 +++++---
>  kernel/fork.c                         |    2 +
>  kernel/sched/cputime.c                |  124 +++++++++------------------------
>  kernel/time/posix-cpu-timers.c        |    4 +-
>  14 files changed, 73 insertions(+), 133 deletions(-)
>

Excellent patchset!
Thanks a lot Stanislaw!

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
