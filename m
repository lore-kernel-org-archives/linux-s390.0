Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
Subject: [RFC] [PATCH 0/3] sched: Support for real CPU runtime and SMT scaling
Date: Fri, 30 Jan 2015 15:02:39 +0100
Message-Id: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Philipp Hachtmann <phacht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello,

when using "real" processors the scheduler can make its decisions based
on wall time. But CPUs under hypervisor control are sometimes
unavailable without further notice to the guest operating system.
Using wall time for scheduling decisions in this case will lead to
unfair decisions and erroneous distribution of CPU bandwidth when
using cgroups.
On (at least) S390 every CPU has a timer that counts the real execution
time from IPL. When the hypervisor has sheduled out the CPU, the timer
is stopped. So it is desirable to use this timer as a source for the
scheduler's rq runtime calculations.

On SMT systems the consumed runtime of a task might be worth  more
or less depending on the fact that the task can have run alone or not
during the last delta. This should be scalable based on the current
CPU utilization.

The first patch introduces two little hooks to the optional architecture
funtions cpu_exec_time and scale_rq_clock_delta.
Calls to cpu_exec_time replace calls to sched_clock_cpu a few times but
are mapped back to sched_clock_cpu if architecture does not define
cpu_exec_time. The call to scale_rq_clock_delta is added into
update_rq_clock (sched/core.c) and defaults to a NOP when not defined
by architecture code.

Regards

Philipp


Philipp Hachtmann (3):
  sched: Support for CPU runtime and SMT based adaption
  s390/cputime: Provide CPU runtime since IPL
  s390/cputime: SMT based scaling of CPU runtime deltas

 arch/s390/include/asm/cputime.h | 31 +++++++++++++++++++++++++++++++
 arch/s390/kernel/vtime.c        |  4 ++--
 kernel/sched/core.c             |  4 +++-
 kernel/sched/fair.c             |  8 ++++----
 kernel/sched/sched.h            |  8 ++++++++
 5 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.1.4
