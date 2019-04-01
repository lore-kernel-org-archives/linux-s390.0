From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 3/5] s390: Fix vDSO clock_getres()
Date: Mon,  1 Apr 2019 12:51:50 +0100
Message-ID: <20190401115152.32751-4-vincenzo.frascino@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401115152.32751-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the s390 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/s390/include/asm/vdso.h           |  1 +
 arch/s390/kernel/asm-offsets.c         |  2 +-
 arch/s390/kernel/time.c                |  1 +
 arch/s390/kernel/vdso32/clock_getres.S | 17 ++++++++++++-----
 arch/s390/kernel/vdso64/clock_getres.S | 15 ++++++++++-----
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 169d7604eb80..f3ba84fa9bd1 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -36,6 +36,7 @@ struct vdso_data {
 	__u32 tk_shift;			/* Shift used for xtime_nsec	0x60 */
 	__u32 ts_dir;			/* TOD steering direction	0x64 */
 	__u64 ts_end;			/* TOD steering end		0x68 */
+	__u32 hrtimer_res;		/* hrtimer resolution		0x70 */
 };
 
 struct vdso_per_cpu_data {
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 164bec175628..36db4a9ee703 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -75,6 +75,7 @@ int main(void)
 	OFFSET(__VDSO_TK_SHIFT, vdso_data, tk_shift);
 	OFFSET(__VDSO_TS_DIR, vdso_data, ts_dir);
 	OFFSET(__VDSO_TS_END, vdso_data, ts_end);
+	OFFSET(__VDSO_CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
 	OFFSET(__VDSO_ECTG_BASE, vdso_per_cpu_data, ectg_timer_base);
 	OFFSET(__VDSO_ECTG_USER, vdso_per_cpu_data, ectg_user_time);
 	OFFSET(__VDSO_CPU_NR, vdso_per_cpu_data, cpu_nr);
@@ -86,7 +87,6 @@ int main(void)
 	DEFINE(__CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(__CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(__CLOCK_THREAD_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID);
-	DEFINE(__CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 	DEFINE(__CLOCK_COARSE_RES, LOW_RES_NSEC);
 	BLANK();
 	/* idle data offsets */
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e8766beee5ad..8ea9db599d38 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -310,6 +310,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_data->tk_mult = tk->tkr_mono.mult;
 	vdso_data->tk_shift = tk->tkr_mono.shift;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++vdso_data->tb_update_count;
 }
diff --git a/arch/s390/kernel/vdso32/clock_getres.S b/arch/s390/kernel/vdso32/clock_getres.S
index eaf9cf1417f6..00fc50ad228c 100644
--- a/arch/s390/kernel/vdso32/clock_getres.S
+++ b/arch/s390/kernel/vdso32/clock_getres.S
@@ -18,20 +18,27 @@
 __kernel_clock_getres:
 	CFI_STARTPROC
 	basr	%r1,0
-	la	%r1,4f-.(%r1)
+10:	al	%r1,4f-10b(%r1)
+11:	l	%r4,__VDSO_UPD_COUNT+4(%r1)	/* load update counter */
+	tml	%r4,0x0001			/* pending update ? loop */
+	jnz	11b
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
+	cl	%r4,__VDSO_UPD_COUNT+4(%r1)	/* check update counter */
+	jne	11b
 	chi	%r2,__CLOCK_REALTIME
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC
 	je	0f
-	la	%r1,5f-4f(%r1)
+	basr	%r1,0
+	la	%r1,5f-.(%r1)
+	l	%r0,0(%r1)
 	chi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC_COARSE
 	jne	3f
 0:	ltr	%r3,%r3
 	jz	2f				/* res == NULL */
-1:	l	%r0,0(%r1)
-	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
+1:	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	st	%r0,4(%r3)			/* store tp->tv_usec */
 2:	lhi	%r2,0
 	br	%r14
@@ -39,6 +46,6 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-4:	.long	__CLOCK_REALTIME_RES
+4:	.long	_vdso_data - 10b
 5:	.long	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index 081435398e0a..1400a8df9802 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -17,12 +17,19 @@
 	.type  __kernel_clock_getres,@function
 __kernel_clock_getres:
 	CFI_STARTPROC
-	larl	%r1,4f
+	larl	%r1,3f
+	lg	%r0,0(%r1)
 	cghi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC_COARSE
 	je	0f
-	larl	%r1,3f
+	larl	%r1,_vdso_data
+11:	lg	%r4,__VDSO_UPD_COUNT(%r1)	/* load update counter */
+	tmll	%r4,0x0001			/* pending update ? loop */
+	jnz	11b
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
+	clg	%r4,__VDSO_UPD_COUNT(%r1)	/* check update counter */
+	jne	11b
 	cghi	%r2,__CLOCK_REALTIME
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC
@@ -36,7 +43,6 @@ __kernel_clock_getres:
 	jz	2f
 0:	ltgr	%r3,%r3
 	jz	1f				/* res == NULL */
-	lg	%r0,0(%r1)
 	xc	0(8,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	stg	%r0,8(%r3)			/* store tp->tv_usec */
 1:	lghi	%r2,0
@@ -45,6 +51,5 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-3:	.quad	__CLOCK_REALTIME_RES
-4:	.quad	__CLOCK_COARSE_RES
+3:	.quad	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
-- 
2.21.0
