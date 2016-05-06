From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
Date: Fri, 6 May 2016 17:00:22 +0300
Message-ID: <20160506140022.GA18587@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel>
 <57288660.9030607@huawei.com>
 <57289C75.50904@huawei.com>
 <20160504214949.GA28217@yury-N73SV>
 <CA+=Sn1ngpaJWHpGDmU+kXBkz56SO+XDW2qzMMLAbbBWnaB0eqw@mail.gmail.com>
 <572AAED2.7050604@huawei.com>
 <CA+=Sn1mNdd+Xy5QL5ScRyZOCWwKkG6o1Pb50sFPuiKX=0Z2B1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+=Sn1mNdd+Xy5QL5ScRyZOCWwKkG6o1Pb50sFPuiKX=0Z2B1w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Pinski <pinskia@gmail.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, "Joseph S. Myers" <joseph@codesourcery.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, christoph.muellner@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hello colleagues,

After all comments, VDSO fix looks like this for me.

Note I renamed Andrew's ZERO macro to DELOUSE, as
there already is __SC_DELOUSE which does the same,
but in C, not asm.

Like Bamvor, I'm not sure how we'd apply this patch - 
standalone or meld to VDSO. I think, VDSO patch is too
big and bad-structurized, and if I find how to refactor
it, I'll incorporate this fix.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/asm-offsets.c               |  7 +++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  2 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 20 +++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index e229525..fcfd087 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -101,6 +101,13 @@ int main(void)
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
   DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
   BLANK();
+#ifdef CONFIG_ARM64_ILP32
+  DEFINE(COMPAT_TVAL_TV_SEC,	offsetof(struct compat_timeval, tv_sec));
+  DEFINE(COMPAT_TVAL_TV_USEC,	offsetof(struct compat_timeval, tv_usec));
+  DEFINE(COMPAT_TSPEC_TV_SEC,	offsetof(struct compat_timespec, tv_sec));
+  DEFINE(COMPAT_TSPEC_TV_NSEC,	offsetof(struct compat_timespec, tv_nsec));
+  BLANK();
+#endif
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
index ddc63fd..d182a8d 100644
--- a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
+++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
@@ -79,7 +79,7 @@ PHDRS
  */
 VERSION
 {
-	LINUX_2.6 {
+	LINUX_2.6.39 {
 	global:
 		__kernel_rt_sigreturn;
 		__kernel_gettimeofday;
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index efa79e8..a2d8a70 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -25,6 +25,16 @@
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
 
+#ifdef __LP64__
+#define PTR_REG(n)	x##n
+#define OFFSET(n)	n
+#define DELOUSE(n)
+#else
+#define PTR_REG(n)	w##n
+#define OFFSET(n)	COMPAT_##n
+#define DELOUSE(n)	mov     w##n, w##n
+#endif
+
 vdso_data	.req	x6
 use_syscall	.req	w7
 seqcnt		.req	w8
@@ -51,6 +61,8 @@ seqcnt		.req	w8
 /* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
 ENTRY(__kernel_gettimeofday)
 	.cfi_startproc
+	DELOUSE(0)
+	DELOUSE(1)
 	mov	x2, x30
 	.cfi_register x30, x2
 
@@ -68,7 +80,7 @@ ENTRY(__kernel_gettimeofday)
 	mov	x13, #1000
 	lsl	x13, x13, x12
 	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
+	stp	PTR_REG(10), PTR_REG(11), [x0, #OFFSET(TVAL_TV_SEC)]
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
@@ -88,6 +100,7 @@ ENDPROC(__kernel_gettimeofday)
 /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
 ENTRY(__kernel_clock_gettime)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	2f
@@ -159,7 +172,7 @@ ENTRY(__kernel_clock_gettime)
 
 6:	/* Store to the user timespec. */
 	lsr	x11, x11, x12
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
+	stp	PTR_REG(10), PTR_REG(11), [x1, #OFFSET(TSPEC_TV_SEC)]
 	mov	x0, xzr
 	ret
 7:
@@ -174,6 +187,7 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	1f
@@ -187,7 +201,7 @@ ENTRY(__kernel_clock_getres)
 	ldr	x2, 6f
 2:
 	cbz	w1, 3f
-	stp	xzr, x2, [x1]
+	stp	PTR_REG(zr), PTR_REG(2), [x1]
 
 3:	/* res == NULL. */
 	mov	w0, wzr
-- 
2.5.0
