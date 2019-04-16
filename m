From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 4/5] nds32: Fix vDSO clock_getres()
Date: Tue, 16 Apr 2019 17:14:33 +0100
Message-ID: <20190416161434.32691-5-vincenzo.frascino@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190416161434.32691-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the nds32 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/nds32/include/asm/vdso_datapage.h | 1 +
 arch/nds32/kernel/vdso.c               | 1 +
 arch/nds32/kernel/vdso/gettimeofday.c  | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
index 79db5a12ca5e..34d80548297f 100644
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -20,6 +20,7 @@ struct vdso_data {
 	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
 	u32 cs_mult;		/* clocksource multiplier */
 	u32 cs_shift;		/* Cycle to nanosecond divisor (power of two) */
+	u32 hrtimer_res;	/* hrtimer resolution */
 
 	u64 cs_cycle_last;	/* last cycle value */
 	u64 cs_mask;		/* clocksource mask */
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
index 016f15891f6d..90bcae6f8554 100644
--- a/arch/nds32/kernel/vdso.c
+++ b/arch/nds32/kernel/vdso.c
@@ -220,6 +220,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->xtime_coarse_sec = tk->xtime_sec;
 	vdso_data->xtime_coarse_nsec = tk->tkr_mono.xtime_nsec >>
 	    tk->tkr_mono.shift;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	vdso_write_end(vdso_data);
 }
 
diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
index 038721af40e3..b02581891c33 100644
--- a/arch/nds32/kernel/vdso/gettimeofday.c
+++ b/arch/nds32/kernel/vdso/gettimeofday.c
@@ -208,6 +208,8 @@ static notrace int clock_getres_fallback(clockid_t _clk_id,
 
 notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
 {
+	struct vdso_data *vdata = __get_datapage();
+
 	if (res == NULL)
 		return 0;
 	switch (clk_id) {
@@ -215,7 +217,7 @@ notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
 	case CLOCK_MONOTONIC:
 	case CLOCK_MONOTONIC_RAW:
 		res->tv_sec = 0;
-		res->tv_nsec = CLOCK_REALTIME_RES;
+		res->tv_nsec = vdata->hrtimer_res;
 		break;
 	case CLOCK_REALTIME_COARSE:
 	case CLOCK_MONOTONIC_COARSE:
-- 
2.21.0
