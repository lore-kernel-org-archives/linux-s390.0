Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 01/11] ARM: prevent tracing IPI_CPU_BACKTRACE
Date: Fri, 19 Apr 2019 18:47:44 +0900
Message-ID: <20190419094754.24667-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190419094744.q6QD1e0Q-hjGZYgzXvHnuuQl50LOgP3GUTOgIJ0_VhE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
  trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace. For clarification,
I'm also adding a two new code comments describing how this one
is special.

The warning appears to have shown up after patch e7273ff49acf
("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
changed the number assignment from '15' to '8', but as far as I can
tell has existed since the IPI tracepoints were first introduced.
If we decide to backport this patch to stable kernels, we probably
need to backport e7273ff49acf as well.

Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[yamada.masahiro@socionext.com: rebase on v5.0-rc1]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This is a long-standing issue, and
Arnd posted this patch two years ago:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409393.html

It is no longer applied, so I rebased it on top of the latest kernel.


Changes in v2: None

 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/smp.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23eaa6072..7a88f160b1fb 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index facd4240ca02..c93fe0f256de 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -70,6 +70,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -797,7 +801,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.17.1
