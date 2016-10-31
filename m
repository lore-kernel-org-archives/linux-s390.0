Return-Path: <sgruszka@redhat.com>
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 1/4] cputime/powerpc: remove cputime_last_delta global variable
Date: Mon, 31 Oct 2016 13:36:26 +0100
Message-Id: <1477917389-11341-2-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Since commit:

cf9efce0ce313 ("powerpc: Account time using timebase rather than PURR")

cputime_last_delta is not initialized to other value than 0, hence it's
not used except zero check and cputime_to_scaled() just returns
the argument.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 arch/powerpc/include/asm/cputime.h |    7 -------
 arch/powerpc/kernel/time.c         |    2 --
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 4f60db0..9f5dcf7 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -46,8 +46,6 @@ static inline void setup_cputime_one_jiffy(void) { }
  * Convert cputime <-> jiffies
  */
 extern u64 __cputime_jiffies_factor;
-DECLARE_PER_CPU(unsigned long, cputime_last_delta);
-DECLARE_PER_CPU(unsigned long, cputime_scaled_last_delta);
 
 static inline unsigned long cputime_to_jiffies(const cputime_t ct)
 {
@@ -58,11 +56,6 @@ static inline unsigned long cputime_to_jiffies(const cputime_t ct)
  * the last scaled to real ratio */
 static inline cputime_t cputime_to_scaled(const cputime_t ct)
 {
-	if (cpu_has_feature(CPU_FTR_SPURR) &&
-	    __this_cpu_read(cputime_last_delta))
-		return (__force u64) ct *
-			__this_cpu_read(cputime_scaled_last_delta) /
-			__this_cpu_read(cputime_last_delta);
 	return ct;
 }
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc3f7d0..8105198 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -164,8 +164,6 @@ struct clock_event_device decrementer_clockevent = {
 EXPORT_SYMBOL(__cputime_sec_factor);
 u64 __cputime_clockt_factor;
 EXPORT_SYMBOL(__cputime_clockt_factor);
-DEFINE_PER_CPU(unsigned long, cputime_last_delta);
-DEFINE_PER_CPU(unsigned long, cputime_scaled_last_delta);
 
 cputime_t cputime_one_jiffy;
 
-- 
1.7.1
