From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 2/5] powerpc: Fix vDSO clock_getres()
Date: Mon,  1 Apr 2019 12:51:49 +0100
Message-ID: <20190401115152.32751-3-vincenzo.frascino@arm.com>
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

Fix the powerpc vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/powerpc/include/asm/vdso_datapage.h  |  2 ++
 arch/powerpc/kernel/asm-offsets.c         |  2 +-
 arch/powerpc/kernel/time.c                |  1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S | 22 +++++++++++++++-------
 arch/powerpc/kernel/vdso64/gettimeofday.S | 22 +++++++++++++++-------
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 1afe90ade595..4ae43fc77fe9 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -86,6 +86,7 @@ struct vdso_data {
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 hrtimer_res;		/* hrtimer resolution */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
@@ -107,6 +108,7 @@ struct vdso_data {
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 hrtimer_res;		/* hrtimer resolution */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 	__u32 dcache_block_size;	/* L1 d-cache block size     */
 	__u32 icache_block_size;	/* L1 i-cache block size     */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 86a61e5f8285..52e4b98a8492 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -383,6 +383,7 @@ int main(void)
 	OFFSET(WTOM_CLOCK_NSEC, vdso_data, wtom_clock_nsec);
 	OFFSET(STAMP_XTIME, vdso_data, stamp_xtime);
 	OFFSET(STAMP_SEC_FRAC, vdso_data, stamp_sec_fraction);
+	OFFSET(CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_data, icache_block_size);
 	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_data, dcache_block_size);
 	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_data, icache_log_block_size);
@@ -413,7 +414,6 @@ int main(void)
 	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc0503ef9c9c..62c04a6746d8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -955,6 +955,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->wtom_clock_nsec = tk->wall_to_monotonic.tv_nsec;
 	vdso_data->stamp_xtime = xt;
 	vdso_data->stamp_sec_fraction = frac_sec;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++(vdso_data->tb_update_count);
 }
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 1e0bc5955a40..b21630079496 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -160,14 +160,21 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
-	li	r3,0
-	cmpli	cr0,r4,0
+	mflr	r12
+  .cfi_register lr,r12
+	mr	r11,r4
+	bl	__get_datapage@local
+	lwz	r5,CLOCK_REALTIME_RES(r3)
+	li	r4,0
+	cmplwi	r11,0		/* check if res is NULL */
+	beq	1f
+
+	stw	r4,TSPC32_TV_SEC(r11)
+	stw	r5,TSPC32_TV_NSEC(r11)
+
+1:	mtlr	r12
 	crclr	cr0*4+so
-	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
-	stw	r3,TSPC32_TV_SEC(r4)
-	stw	r5,TSPC32_TV_NSEC(r4)
+	li	r3,0
 	blr
 
 	/*
@@ -175,6 +182,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	 */
 99:
 	li	r0,__NR_clock_getres
+  .cfi_restore lr
 	sc
 	blr
   .cfi_endproc
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a4ed9edfd5f0..a7e49bddd475 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -190,14 +190,21 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
-	li	r3,0
-	cmpldi	cr0,r4,0
+	mflr	r12
+  .cfi_register lr,r12
+	mr	r11, r4
+	bl	V_LOCAL_FUNC(__get_datapage)
+	lwz	r5,CLOCK_REALTIME_RES(r3)
+	li	r4,0
+	cmpldi	r11,0		/* check if res is NULL */
+	beq	1f
+
+	std	r4,TSPC64_TV_SEC(r11)
+	std	r5,TSPC64_TV_NSEC(r11)
+
+1:	mtlr	r12
 	crclr	cr0*4+so
-	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
-	std	r3,TSPC64_TV_SEC(r4)
-	std	r5,TSPC64_TV_NSEC(r4)
+	li	r3,0
 	blr
 
 	/*
@@ -205,6 +212,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	 */
 99:
 	li	r0,__NR_clock_getres
+  .cfi_restore lr
 	sc
 	blr
   .cfi_endproc
-- 
2.21.0
