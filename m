Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
Subject: [PATCH 2/3] s390/cputime: Provide CPU runtime since IPL
Date: Fri, 30 Jan 2015 15:02:41 +0100
Message-Id: <1422626562-6966-3-git-send-email-phacht@linux.vnet.ibm.com>
In-Reply-To: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Philipp Hachtmann <phacht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The cpu maintains a cpu timer which runs only while the cpu
is available to the system (i.e. not scheduled away by the hypervisor).
This patch introduces a function cpu_exec_time that returns a
time stamp which reflects the cpu's real processing time since IPL.

Signed-off-by: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
---
 arch/s390/include/asm/cputime.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index b91e960..fee50dd 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -167,6 +167,22 @@ static inline clock_t cputime64_to_clock_t(cputime64_t cputime)
 	return clock;
 }
 
+/*
+ * Read out the current CPU's timer
+ *
+ * Returns an incrementing time stamp in ns.
+ */
+static inline u64 cpu_exec_time(int cpu_unused)
+{
+	u64 timer;
+       	asm volatile(
+		"	stpt	%0\n"	/* Store current cpu timer value */
+		: "=m" (timer));
+
+	return ((ULLONG_MAX - timer) * 1000) / 4096;
+}
+#define cpu_exec_time cpu_exec_time
+
 cputime64_t arch_cpu_idle_time(int cpu);
 
 #define arch_idle_time(cpu) arch_cpu_idle_time(cpu)
-- 
2.1.4
