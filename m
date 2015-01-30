Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
Subject: [PATCH 3/3] s390/cputime: SMT based scaling of CPU runtime deltas
Date: Fri, 30 Jan 2015 15:02:42 +0100
Message-Id: <1422626562-6966-4-git-send-email-phacht@linux.vnet.ibm.com>
In-Reply-To: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Philipp Hachtmann <phacht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The scheduler calculates CPU runtime deltas to account for a task's
runtime. These deltas have to be adapted on SMT CPUs to reflect the real
processing power consumed during the last delta.
This patch introduces scale_rq_clock_delta which is used by the
scheduler to scale the calculated delta by an SMT based factor.

Signed-off-by: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
---
 arch/s390/include/asm/cputime.h | 17 ++++++++++++++++-
 arch/s390/kernel/vtime.c        |  4 ++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index fee50dd..e44f285 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -8,6 +8,8 @@
 #define _S390_CPUTIME_H
 
 #include <linux/types.h>
+#include <linux/percpu.h>
+#include <asm/smp.h>
 #include <asm/div64.h>
 
 #define CPUTIME_PER_USEC 4096ULL
@@ -20,6 +22,9 @@ typedef unsigned long long __nocast cputime64_t;
 
 #define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
 
+DECLARE_PER_CPU(u64, mt_scaling_mult);
+DECLARE_PER_CPU(u64, mt_scaling_div);
+
 static inline unsigned long __div(unsigned long long n, unsigned long base)
 {
 #ifndef CONFIG_64BIT
@@ -172,6 +177,7 @@ static inline clock_t cputime64_to_clock_t(cputime64_t cputime)
  *
  * Returns an incrementing time stamp in ns.
  */
+#define cpu_exec_time cpu_exec_time
 static inline u64 cpu_exec_time(int cpu_unused)
 {
 	u64 timer;
@@ -181,7 +187,16 @@ static inline u64 cpu_exec_time(int cpu_unused)
 
 	return ((ULLONG_MAX - timer) * 1000) / 4096;
 }
-#define cpu_exec_time cpu_exec_time
+
+#define scale_rq_clock_delta scale_rq_clock_delta
+static inline void scale_rq_clock_delta(u64 *delta)
+{
+	u64 mult = __get_cpu_var(mt_scaling_mult);
+	u64 div = __get_cpu_var(mt_scaling_div);
+
+	if (smp_cpu_mtid)
+		*delta = (*delta * mult) / div;
+}
 
 cputime64_t arch_cpu_idle_time(int cpu);
 
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 97b3c12..5d9bbd0 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -26,8 +26,8 @@ static atomic64_t virt_timer_current;
 static atomic64_t virt_timer_elapsed;
 
 static DEFINE_PER_CPU(u64, mt_cycles[32]);
-static DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
-static DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
+DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
+DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
 
 static inline u64 get_vtimer(void)
 {
-- 
2.1.4
