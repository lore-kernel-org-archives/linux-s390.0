From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 1/5] arm64: Fix vDSO clock_getres()
Date: Mon,  1 Apr 2019 12:51:48 +0100
Message-ID: <20190401115152.32751-2-vincenzo.frascino@arm.com>
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

Fix the arm64 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso_datapage.h |  1 +
 arch/arm64/kernel/asm-offsets.c        |  2 +-
 arch/arm64/kernel/vdso.c               |  2 ++
 arch/arm64/kernel/vdso/gettimeofday.S  | 25 ++++++++++++++-----------
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index 2b9a63771eda..f89263c8e11a 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -38,6 +38,7 @@ struct vdso_data {
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
+	__u32 hrtimer_res;
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7f40dcbdd51d..e10e2a5d9ddc 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -94,7 +94,7 @@ int main(void)
   DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
   DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
   DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	MONOTONIC_RES_NSEC);
+  DEFINE(CLOCK_REALTIME_RES,	offsetof(struct vdso_data, hrtimer_res));
   DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
   DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
   DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..47ba72345739 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 	}
 
+	vdso_data->hrtimer_res			= hrtimer_resolution;
+
 	smp_wmb();
 	++vdso_data->tb_seq_count;
 }
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..7a2cd2f8e13a 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -296,32 +296,35 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
+	adr	vdso_data, _vdso_data
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
+	b.ne	2f
 
-	ldr	x2, 5f
-	b	2f
-1:
+1:	/* Get hrtimer_res */
+	seqcnt_acquire
+	syscall_check fail=5f
+	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
+	seqcnt_check fail=1b
+	b	3f
+2:
 	cmp	w0, #CLOCK_REALTIME_COARSE
 	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
+	b.ne	5f
 	ldr	x2, 6f
-2:
-	cbz	x1, 3f
+3:
+	cbz	x1, 4f
 	stp	xzr, x2, [x1]
 
-3:	/* res == NULL. */
+4:	/* res == NULL. */
 	mov	w0, wzr
 	ret
 
-4:	/* Syscall fallback. */
+5:	/* Syscall fallback. */
 	mov	x8, #__NR_clock_getres
 	svc	#0
 	ret
-5:
-	.quad	CLOCK_REALTIME_RES
 6:
 	.quad	CLOCK_COARSE_RES
 	.cfi_endproc
-- 
2.21.0
