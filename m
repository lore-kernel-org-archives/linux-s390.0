From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Sat, 14 May 2016 15:49:50 +0300
Message-ID: <20160514124950.GA27841@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <2733875.IzutTZKHMc@wuerfel>
 <57347BD4.8010105@huawei.com>
 <4521594.dSmlmmAdFg@wuerfel>
 <20160512131948.GA30205@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512131948.GA30205@yury-N73SV>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, jan.dakinevich@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 12, 2016 at 04:19:48PM +0300, Yury Norov wrote:

[...]

> > I think that's a good idea. The function used to be slightly different
> > for each architecture, but now it seems we have a significant number
> > of identical implementations that we could just merge them together
> > into one.
> > 
> > sys_mmap_pgoff was originally introduced as the common implementation
> > and it reduced the amount of duplication a lot, but as its units
> > are based on PAGE_SIZE rather than hardwired 4096 bytes, it's
> > not as useful.
> > 
> 
> microblaze and mips (twice) are doing like this. And aarh32 as well,
> in arch/arm64/kernel/entry32.S
> 
> In previous submissions it was a patch that shares aarch32 code to
> ilp32. If we decided turn around again, I think, we'd pick up that patch.
> 
> The other option is to make this hack generic, as so many arches use it.

Hi again,

I picked up that old patch from Jan, and found that it doesn't delouse
addr and length, which is wrong for ilp32. So now I think we'd pick
Bamvor version.

Jan's patch (rebased) is attached for reference.

Yury.


From 02ad258662c40d457ac041634e67e1cbdbb800f3 Mon Sep 17 00:00:00 2001
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Date: Tue, 3 Nov 2015 02:30:41 +0300
Subject: ilp32: common 32-bit wrappers

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9dfdf86..2319042 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -30,6 +30,7 @@ arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   ../../arm/kernel/opcodes.o binfmt_elf32.o
 arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_COMPAT)		+= entry32-common.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
diff --git a/arch/arm64/kernel/entry32-common.S b/arch/arm64/kernel/entry32-common.S
new file mode 100644
index 0000000..1a0abe3
--- /dev/null
+++ b/arch/arm64/kernel/entry32-common.S
@@ -0,0 +1,23 @@
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/page.h>
+
+/*
+ * Note: off_4k (w5) is always in units of 4K. If we can't do the
+ * requested offset because it is not page-aligned, we return -EINVAL.
+ */
+ENTRY(compat_sys_mmap2_wrapper)
+#if PAGE_SHIFT > 12
+	tst	w5, #~PAGE_MASK >> 12
+	b.ne	1f
+	lsr	w5, w5, #PAGE_SHIFT - 12
+#endif
+	b	sys_mmap_pgoff
+1:	mov	x0, #-EINVAL
+	ret
+ENDPROC(compat_sys_mmap2_wrapper)
+
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index f332d5d..58cb5b0 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -55,21 +55,6 @@ ENTRY(compat_sys_fstatfs64_wrapper)
 ENDPROC(compat_sys_fstatfs64_wrapper)
 
 /*
- * Note: off_4k (w5) is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-ENTRY(compat_sys_mmap2_wrapper)
-#if PAGE_SHIFT > 12
-	tst	w5, #~PAGE_MASK >> 12
-	b.ne	1f
-	lsr	w5, w5, #PAGE_SHIFT - 12
-#endif
-	b	sys_mmap_pgoff
-1:	mov	x0, #-EINVAL
-	ret
-ENDPROC(compat_sys_mmap2_wrapper)
-
-/*
  * Wrappers for AArch32 syscalls that either take 64-bit parameters
  * in registers or that take 32-bit parameters which require sign
  * extension.
