Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084453.013858935@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 28/32] [PATCH] add support for compressed kernels
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=127-kernel-compression.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add the "bzImage" compile target and the necessary code  to generate
compressed kernel images. The old style uncompressed "image" target
is preserved, a simple make will build them both.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig                       |    3 
 arch/s390/Makefile                      |   13 ++
 arch/s390/boot/Makefile                 |    8 +
 arch/s390/boot/compressed/Makefile      |   60 ++++++++++++
 arch/s390/boot/compressed/head31.S      |   51 ++++++++++
 arch/s390/boot/compressed/head64.S      |   48 +++++++++
 arch/s390/boot/compressed/misc.c        |  158 ++++++++++++++++++++++++++++++++
 arch/s390/boot/compressed/vmlinux.lds.S |   55 +++++++++++
 arch/s390/boot/compressed/vmlinux.scr   |   10 ++
 arch/s390/defconfig                     |    7 +
 arch/s390/kernel/Makefile               |    1 
 arch/s390/kernel/head.S                 |   41 ++++----
 arch/s390/kernel/head31.S               |   16 ++-
 arch/s390/kernel/head64.S               |   24 ++--
 arch/s390/kernel/sclp.S                 |   36 ++++++-
 15 files changed, 488 insertions(+), 43 deletions(-)

Index: quilt-2.6/arch/s390/boot/compressed/head31.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/head31.S	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,51 @@
+/*
+ * Startup glue code to uncompress the kernel
+ *
+ * Copyright IBM Corp. 2010
+ *
+ *   Author(s):	Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/init.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include "sizes.h"
+
+__HEAD
+	.globl	startup_continue
+startup_continue:
+	basr	%r13,0			# get base
+.LPG1:
+	# setup stack
+	l	%r15,.Lstack-.LPG1(%r13)
+	ahi	%r15,-96
+	l	%r1,.Ldecompress-.LPG1(%r13)
+	basr	%r14,%r1
+	# setup registers for memory mover & branch to target
+	lr	%r4,%r2
+	l	%r2,.Loffset-.LPG1(%r13)
+	la	%r4,0(%r2,%r4)
+	l	%r3,.Lmvsize-.LPG1(%r13)
+	lr	%r5,%r3
+	# move the memory mover someplace safe
+	la	%r1,0x200
+	mvc	0(mover_end-mover,%r1),mover-.LPG1(%r13)
+	# decompress image is started at 0x11000
+	lr	%r6,%r2
+	br	%r1
+mover:
+	mvcle	%r2,%r4,0
+	jo	mover
+	br	%r6
+mover_end:
+
+	.align	8
+.Lstack:
+	.long	0x8000 + (1<<(PAGE_SHIFT+THREAD_ORDER))
+.Ldecompress:
+	.long	decompress_kernel
+.Loffset:
+	.long	0x11000
+.Lmvsize:
+	.long	SZ__bss_start
Index: quilt-2.6/arch/s390/boot/compressed/head64.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/head64.S	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,48 @@
+/*
+ * Startup glue code to uncompress the kernel
+ *
+ * Copyright IBM Corp. 2010
+ *
+ *   Author(s):	Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/init.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include "sizes.h"
+
+__HEAD
+	.globl	startup_continue
+startup_continue:
+	basr	%r13,0			# get base
+.LPG1:
+	# setup stack
+	lg	%r15,.Lstack-.LPG1(%r13)
+	aghi	%r15,-160
+	brasl	%r14,decompress_kernel
+	# setup registers for memory mover & branch to target
+	lgr	%r4,%r2
+	lg	%r2,.Loffset-.LPG1(%r13)
+	la	%r4,0(%r2,%r4)
+	lg	%r3,.Lmvsize-.LPG1(%r13)
+	lgr	%r5,%r3
+	# move the memory mover someplace safe
+	la	%r1,0x200
+	mvc	0(mover_end-mover,%r1),mover-.LPG1(%r13)
+	# decompress image is started at 0x11000
+	lgr	%r6,%r2
+	br	%r1
+mover:
+	mvcle	%r2,%r4,0
+	jo	mover
+	br	%r6
+mover_end:
+
+	.align	8
+.Lstack:
+	.quad	0x8000 + (1<<(PAGE_SHIFT+THREAD_ORDER))
+.Loffset:
+	.quad	0x11000
+.Lmvsize:
+	.quad	SZ__bss_start
Index: quilt-2.6/arch/s390/boot/compressed/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/Makefile	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,60 @@
+#
+# linux/arch/s390/boot/compressed/Makefile
+#
+# create a compressed vmlinux image from the original vmlinux
+#
+
+BITS := $(if $(CONFIG_64BIT),64,31)
+
+targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
+	   vmlinux.bin.lzma misc.o piggy.o sizes.h head$(BITS).o
+
+KBUILD_CFLAGS := -m$(BITS) -D__KERNEL__ $(LINUX_INCLUDE) -O2
+KBUILD_CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(call cc-option,-mpacked-stack)
+KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
+
+GCOV_PROFILE := n
+
+OBJECTS := $(addprefix $(objtree)/arch/s390/kernel/, head.o sclp.o ebcdic.o)
+OBJECTS += $(obj)/head$(BITS).o $(obj)/misc.o $(obj)/piggy.o
+
+LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS)
+	$(call if_changed,ld)
+	@:
+
+sed-sizes := -e 's/^\([0-9a-fA-F]*\) . \(__bss_start\|_end\)$$/\#define SZ\2 0x\1/p'
+
+quiet_cmd_sizes = GEN $@
+      cmd_sizes = $(NM) $< | sed -n $(sed-sizes) > $@
+
+$(obj)/sizes.h: vmlinux
+	$(call if_changed,sizes)
+
+AFLAGS_head$(BITS).o += -I$(obj)
+$(obj)/head$(BITS).o: $(obj)/sizes.h
+
+CFLAGS_misc.o += -I$(obj)
+$(obj)/misc.o: $(obj)/sizes.h
+
+OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
+$(obj)/vmlinux.bin: vmlinux
+	$(call if_changed,objcopy)
+
+vmlinux.bin.all-y := $(obj)/vmlinux.bin
+
+suffix-$(CONFIG_KERNEL_GZIP)  := gz
+suffix-$(CONFIG_KERNEL_BZIP2) := bz2
+suffix-$(CONFIG_KERNEL_LZMA)  := lzma
+
+$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
+	$(call if_changed,gzip)
+$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
+	$(call if_changed,bzip2)
+$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
+	$(call if_changed,lzma)
+
+LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y)
+	$(call if_changed,ld)
Index: quilt-2.6/arch/s390/boot/compressed/misc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/misc.c	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,158 @@
+/*
+ * Definitions and wrapper functions for kernel decompressor
+ *
+ * Copyright IBM Corp. 2010
+ *
+ * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <asm/uaccess.h>
+#include <asm/page.h>
+#include <asm/ipl.h>
+#include "sizes.h"
+
+/*
+ * gzip declarations
+ */
+#define STATIC static
+
+#undef memset
+#undef memcpy
+#undef memmove
+#define memzero(s, n) memset((s), 0, (n))
+
+/* Symbols defined by linker scripts */
+extern char input_data[];
+extern int input_len;
+extern int _text;
+extern int _end;
+
+static void error(char *m);
+
+static unsigned long free_mem_ptr;
+static unsigned long free_mem_end_ptr;
+
+#ifdef CONFIG_HAVE_KERNEL_BZIP2
+#define HEAP_SIZE	0x400000
+#else
+#define HEAP_SIZE	0x10000
+#endif
+
+#ifdef CONFIG_KERNEL_GZIP
+#include "../../../../lib/decompress_inflate.c"
+#endif
+
+#ifdef CONFIG_KERNEL_BZIP2
+#include "../../../../lib/decompress_bunzip2.c"
+#endif
+
+#ifdef CONFIG_KERNEL_LZMA
+#include "../../../../lib/decompress_unlzma.c"
+#endif
+
+extern _sclp_print_early(const char *);
+
+int puts(const char *s)
+{
+	_sclp_print_early(s);
+	return 0;
+}
+
+void *memset(void *s, int c, size_t n)
+{
+	char *xs;
+
+	if (c == 0)
+		return __builtin_memset(s, 0, n);
+
+	xs = (char *) s;
+	if (n > 0)
+		do {
+			*xs++ = c;
+		} while (--n > 0);
+	return s;
+}
+
+void *memcpy(void *__dest, __const void *__src, size_t __n)
+{
+	return __builtin_memcpy(__dest, __src, __n);
+}
+
+void *memmove(void *__dest, __const void *__src, size_t __n)
+{
+	char *d;
+	const char *s;
+
+	if (__dest <= __src)
+		return __builtin_memcpy(__dest, __src, __n);
+	d = __dest + __n;
+	s = __src + __n;
+	while (__n--)
+		*--d = *--s;
+	return __dest;
+}
+
+static void error(char *x)
+{
+	unsigned long long psw = 0x000a0000deadbeefULL;
+
+	puts("\n\n");
+	puts(x);
+	puts("\n\n -- System halted");
+
+	asm volatile("lpsw %0" : : "Q" (psw));
+}
+
+/*
+ * Safe guard the ipl parameter block against a memory area that will be
+ * overwritten. The validity check for the ipl parameter block is complex
+ * (see cio_get_iplinfo and ipl_save_parameters) but if the pointer to
+ * the ipl parameter block intersects with the passed memory area we can
+ * safely assume that we can read from that memory. In that case just copy
+ * the memory to IPL_PARMBLOCK_ORIGIN even if there is no ipl parameter
+ * block.
+ */
+static void check_ipl_parmblock(void *start, unsigned long size)
+{
+	void *src, *dst;
+
+	src = (void *)(unsigned long) S390_lowcore.ipl_parmblock_ptr;
+	if (src + PAGE_SIZE <= start || src >= start + size)
+		return;
+	dst = (void *) IPL_PARMBLOCK_ORIGIN;
+	memmove(dst, src, PAGE_SIZE);
+	S390_lowcore.ipl_parmblock_ptr = IPL_PARMBLOCK_ORIGIN;
+}
+
+unsigned long decompress_kernel(void)
+{
+	unsigned long output_addr;
+	unsigned char *output;
+
+	free_mem_ptr = (unsigned long)&_end;
+	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+	output = (unsigned char *) ((free_mem_end_ptr + 4095UL) & -4096UL);
+
+	check_ipl_parmblock((void *) 0, (unsigned long) output + SZ__bss_start);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * Move the initrd right behind the end of the decompressed
+	 * kernel image.
+	 */
+	if (INITRD_START && INITRD_SIZE &&
+	    INITRD_START < (unsigned long) output + SZ__bss_start) {
+		check_ipl_parmblock(output + SZ__bss_start,
+				    INITRD_START + INITRD_SIZE);
+		memmove(output + SZ__bss_start,
+			(void *) INITRD_START, INITRD_SIZE);
+		INITRD_START = (unsigned long) output + SZ__bss_start;
+	}
+#endif
+
+	puts("Uncompressing Linux... ");
+	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+	puts("Ok, booting the kernel.\n");
+	return (unsigned long) output;
+}
+
Index: quilt-2.6/arch/s390/boot/compressed/vmlinux.lds.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/vmlinux.lds.S	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,55 @@
+#include <asm-generic/vmlinux.lds.h>
+
+#ifdef CONFIG_64BIT
+OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
+OUTPUT_ARCH(s390:64-bit)
+#else
+OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
+OUTPUT_ARCH(s390)
+#endif
+
+ENTRY(startup)
+
+SECTIONS
+{
+	/* Be careful parts of head_64.S assume startup_32 is at
+	 * address 0.
+	 */
+	. = 0;
+	.head.text : {
+		_head = . ;
+		HEAD_TEXT
+		_ehead = . ;
+	}
+	.rodata.compressed : {
+		*(.rodata.compressed)
+	}
+	.text :	{
+		_text = .;	/* Text */
+		*(.text)
+		*(.text.*)
+		_etext = . ;
+	}
+	.rodata : {
+		_rodata = . ;
+		*(.rodata)	 /* read-only data */
+		*(.rodata.*)
+		_erodata = . ;
+	}
+	.data :	{
+		_data = . ;
+		*(.data)
+		*(.data.*)
+		_edata = . ;
+	}
+	. = ALIGN(256);
+	.bss : {
+		_bss = . ;
+		*(.bss)
+		*(.bss.*)
+		*(COMMON)
+		. = ALIGN(8);	/* For convenience during zeroing */
+		_ebss = .;
+	}
+	_end = .;
+}
Index: quilt-2.6/arch/s390/boot/compressed/vmlinux.scr
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/arch/s390/boot/compressed/vmlinux.scr	2010-02-24 09:44:28.000000000 +0100
@@ -0,0 +1,10 @@
+SECTIONS
+{
+  .rodata.compressed : {
+	input_len = .;
+	LONG(input_data_end - input_data) input_data = .;
+	*(.data)
+	output_len = . - 4;
+	input_data_end = .;
+	}
+}
Index: quilt-2.6/arch/s390/boot/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/boot/Makefile	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/boot/Makefile	2010-02-24 09:44:28.000000000 +0100
@@ -9,10 +9,18 @@
 EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I.
 
 targets := image
+targets += bzImage
+subdir- := compressed
 
 $(obj)/image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
+$(obj)/bzImage: $(obj)/compressed/vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/compressed/vmlinux: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
+
 install: $(CONFIGURE) $(obj)/image
 	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
 	      System.map Kerntypes "$(INSTALL_PATH)"
Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/defconfig	2010-02-24 09:44:28.000000000 +0100
@@ -36,6 +36,13 @@
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_BZIP2=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_BZIP2 is not set
+# CONFIG_KERNEL_LZMA is not set
+# CONFIG_KERNEL_LZO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig	2010-02-24 09:44:27.000000000 +0100
+++ quilt-2.6/arch/s390/Kconfig	2010-02-24 09:44:28.000000000 +0100
@@ -98,6 +98,9 @@
 	select HAVE_ARCH_TRACEHOOK
 	select INIT_ALL_POSSIBLE
 	select HAVE_PERF_EVENTS
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_LZMA
 	select ARCH_INLINE_SPIN_TRYLOCK
 	select ARCH_INLINE_SPIN_TRYLOCK_BH
 	select ARCH_INLINE_SPIN_LOCK
Index: quilt-2.6/arch/s390/kernel/head31.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head31.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head31.S	2010-02-24 09:44:28.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * arch/s390/kernel/head31.S
  *
- * Copyright (C) IBM Corp. 2005,2006
+ * Copyright (C) IBM Corp. 2005,2010
  *
  *   Author(s):	Hartmut Penner <hp@de.ibm.com>
  *		Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -10,13 +10,19 @@
  *
  */
 
-	.org	0x11000
+#include <linux/init.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
 
+__HEAD
+	.globl	startup_continue
 startup_continue:
 	basr	%r13,0			# get base
 .LPG1:
 
-	mvi	__LC_AR_MODE_ID,0	# set ESA flag (mode 0)
+	l	%r1,.Lbase_cc-.LPG1(%r13)
+	mvc	0(8,%r1),__LC_LAST_UPDATE_CLOCK
 	lctl	%c0,%c15,.Lctl-.LPG1(%r13) # load control registers
 	l	%r12,.Lparmaddr-.LPG1(%r13) # pointer to parameter area
 					# move IPL device to lowcore
@@ -69,10 +75,12 @@
 .Lduald:.rept	8
 	.long	0x80000000,0,0,0	# invalid access-list entries
 	.endr
+.Lbase_cc:
+	.long	sched_clock_base_cc
 
-	.org	0x12000
 	.globl	_ehead
 _ehead:
+
 #ifdef CONFIG_SHARED_KERNEL
 	.org	0x100000
 #endif
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head64.S	2010-02-24 09:44:28.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * arch/s390/kernel/head64.S
  *
- * Copyright (C) IBM Corp. 1999,2006
+ * Copyright (C) IBM Corp. 1999,2010
  *
  *   Author(s):	Hartmut Penner <hp@de.ibm.com>
  *		Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -10,18 +10,17 @@
  *
  */
 
-	.org	0x11000
+#include <linux/init.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
 
+__HEAD
+	.globl	startup_continue
 startup_continue:
-	basr	%r13,0			# get base
-.LPG1:	sll	%r13,1			# remove high order bit
-	srl	%r13,1
-	mvi	__LC_AR_MODE_ID,1	# set esame flag
-	slr	%r0,%r0 		# set cpuid to zero
-	lhi	%r1,2			# mode 2 = esame (dump)
-	sigp	%r1,%r0,0x12		# switch to esame mode
-	sam64				# switch to 64 bit mode
-	llgfr	%r13,%r13		# clear high-order half of base reg
+	larl	%r1,sched_clock_base_cc
+	mvc	0(8,%r1),__LC_LAST_UPDATE_CLOCK
+	larl	%r13,.LPG1		# get base
 	lmh	%r0,%r15,.Lzero64-.LPG1(%r13)	# clear high-order half
 	lctlg	%c0,%c15,.Lctl-.LPG1(%r13)	# load control registers
 	lg	%r12,.Lparmaddr-.LPG1(%r13)	# pointer to parameter area
@@ -46,6 +45,7 @@
 	lpswe	.Lentry-.LPG1(13)	# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	16
+.LPG1:
 .Lentry:.quad	0x0000000180000000,_stext
 .Lctl:	.quad	0x04350002		# cr0: various things
 	.quad	0			# cr1: primary space segment table
@@ -78,9 +78,9 @@
 	.long	0x80000000,0,0,0	# invalid access-list entries
 	.endr
 
-	.org	0x12000
 	.globl	_ehead
 _ehead:
+
 #ifdef CONFIG_SHARED_KERNEL
 	.org	0x100000
 #endif
Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S	2010-02-24 09:44:28.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head.S	2010-02-24 09:44:28.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Copyright IBM Corp. 1999,2009
+ * Copyright IBM Corp. 1999,2010
  *
  *    Author(s): Hartmut Penner <hp@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -22,11 +22,9 @@
  */
 
 #include <linux/init.h>
-#include <asm/setup.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
-#include <asm/cpu.h>
 
 #ifdef CONFIG_64BIT
 #define ARCH_OFFSET	4
@@ -450,16 +448,15 @@
 # or linload or SALIPL
 #
 	.org	0x10000
-startup:basr	%r13,0			# get base
+	.globl	startup
+startup:
+	basr	%r13,0			# get base
 .LPG0:
 	xc	0x200(256),0x200	# partially clear lowcore
 	xc	0x300(256),0x300
-	l	%r1,5f-.LPG0(%r13)
-	stck	0(%r1)
-	spt	6f-.LPG0(%r13)
-	mvc	__LC_LAST_UPDATE_CLOCK(8),0(%r1)
-	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
-	mvc	__LC_EXIT_TIMER(8),5f-.LPG0(%r13)
+	stck	__LC_LAST_UPDATE_CLOCK
+	spt	5f-.LPG0(%r13)
+	mvc	__LC_LAST_UPDATE_TIMER(8),5f-.LPG0(%r13)
 #ifndef CONFIG_MARCH_G5
 	# check capabilities against MARCH_{G5,Z900,Z990,Z9_109,Z10}
 	xc	__LC_STFL_FAC_LIST(8),__LC_STFL_FAC_LIST
@@ -477,7 +474,6 @@
 	cl	%r0,2f+12-.LPG0(%r13)
 	je	3f
 1:	l	%r15,.Lstack-.LPG0(%r13)
-	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union+THREAD_SIZE
 	ahi	%r15,-96
 	la	%r2,.Lals_string-.LPG0(%r13)
 	l	%r3,.Lsclp_print-.LPG0(%r13)
@@ -488,7 +484,7 @@
 .Lsclp_print:
 	.long	_sclp_print_early
 .Lstack:
-	.long	init_thread_union
+	.long	0x8000 + (1<<(PAGE_SHIFT+THREAD_ORDER))
 	.align 16
 2:	.long	0x000a0000,0x8badcccc
 #if defined(CONFIG_64BIT)
@@ -515,13 +511,22 @@
 3:
 #endif
 
+#ifdef CONFIG_64BIT
+	mvi	__LC_AR_MODE_ID,1	# set esame flag
+	slr	%r0,%r0 		# set cpuid to zero
+	lhi	%r1,2			# mode 2 = esame (dump)
+	sigp	%r1,%r0,0x12		# switch to esame mode
+	sam64				# switch to 64 bit mode
+	jg	startup_continue
+#else
+	mvi	__LC_AR_MODE_ID,0	# set ESA flag (mode 0)
 	l	%r13,4f-.LPG0(%r13)
 	b	0(%r13)
-	.align	4
+	.align	8
 4:	.long	startup_continue
-5:	.long	sched_clock_base_cc
+#endif
 	.align	8
-6:	.long	0x7fffffff,0xffffffff
+5:	.long	0x7fffffff,0xffffffff
 
 #
 # params at 10400 (setup.h)
@@ -535,8 +540,4 @@
 	.byte	"root=/dev/ram0 ro"
 	.byte	0
 
-#ifdef CONFIG_64BIT
-#include "head64.S"
-#else
-#include "head31.S"
-#endif
+	.org	0x11000
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/Makefile	2010-02-24 09:44:28.000000000 +0100
@@ -29,6 +29,7 @@
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
 
 extra-y				+= head.o init_task.o vmlinux.lds
+extra-y				+= $(if $(CONFIG_64BIT),head64.o,head31.o)
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o topology.o
Index: quilt-2.6/arch/s390/kernel/sclp.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/sclp.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/sclp.S	2010-02-24 09:44:28.000000000 +0100
@@ -9,8 +9,10 @@
  */
 
 LC_EXT_NEW_PSW		= 0x58			# addr of ext int handler
+LC_EXT_NEW_PSW_64	= 0x1b0			# addr of ext int handler 64 bit
 LC_EXT_INT_PARAM	= 0x80			# addr of ext int parameter
 LC_EXT_INT_CODE		= 0x86			# addr of ext int code
+LC_AR_MODE_ID		= 0xa3
 
 #
 # Subroutine which waits synchronously until either an external interruption
@@ -30,8 +32,16 @@
 .LbaseS1:
 	ahi	%r15,-96			# create stack frame
 	la	%r8,LC_EXT_NEW_PSW		# register int handler
-	mvc	.LoldpswS1-.LbaseS1(8,%r13),0(%r8)
-	mvc	0(8,%r8),.LextpswS1-.LbaseS1(%r13)
+	la	%r9,.LextpswS1-.LbaseS1(%r13)
+#ifdef CONFIG_64BIT
+	tm	LC_AR_MODE_ID,1
+	jno	.Lesa1
+	la	%r8,LC_EXT_NEW_PSW_64		# register int handler 64 bit
+	la	%r9,.LextpswS1_64-.LbaseS1(%r13)
+.Lesa1:
+#endif
+	mvc	.LoldpswS1-.LbaseS1(16,%r13),0(%r8)
+	mvc	0(16,%r8),0(%r9)
 	lhi	%r6,0x0200			# cr mask for ext int (cr0.54)
 	ltr	%r2,%r2
 	jz	.LsetctS1
@@ -64,15 +74,19 @@
 .LtimeoutS1:
 	lctl	%c0,%c0,.LctlS1-.LbaseS1(%r13)	# restore interrupt setting
 	# restore old handler
-	mvc	0(8,%r8),.LoldpswS1-.LbaseS1(%r13)
+	mvc	0(16,%r8),.LoldpswS1-.LbaseS1(%r13)
 	lm	%r6,%r15,120(%r15)		# restore registers
 	br	%r14				# return to caller
 
 	.align	8
 .LoldpswS1:
-	.long	0, 0				# old ext int PSW
+	.long	0, 0, 0, 0			# old ext int PSW
 .LextpswS1:
 	.long	0x00080000, 0x80000000+.LwaitS1	# PSW to handle ext int
+#ifdef CONFIG_64BIT
+.LextpswS1_64:
+	.quad	0x0000000180000000, .LwaitS1	# PSW to handle ext int, 64 bit
+#endif
 .LwaitpswS1:
 	.long	0x010a0000, 0x00000000+.LloopS1	# PSW to wait for ext int
 .LtimeS1:
@@ -250,6 +264,13 @@
 _sclp_print_early:
 	stm	%r6,%r15,24(%r15)		# save registers
 	ahi	%r15,-96			# create stack frame
+#ifdef CONFIG_64BIT
+	tm	LC_AR_MODE_ID,1
+	jno	.Lesa2
+	ahi	%r15,-80
+	stmh	%r6,%r15,96(%r15)		# store upper register halves
+.Lesa2:
+#endif
 	lr	%r10,%r2			# save string pointer
 	lhi	%r2,0
 	bras	%r14,_sclp_setup		# enable console
@@ -262,6 +283,13 @@
 	lhi	%r2,1
 	bras	%r14,_sclp_setup		# disable console
 .LendS5:
+#ifdef CONFIG_64BIT
+	tm	LC_AR_MODE_ID,1
+	jno	.Lesa3
+	lmh	%r6,%r15,96(%r15)		# store upper register halves
+	ahi	%r15,80
+.Lesa3:
+#endif
 	lm	%r6,%r15,120(%r15)		# restore registers
 	br	%r14
 
Index: quilt-2.6/arch/s390/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/Makefile	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/Makefile	2010-02-24 09:44:28.000000000 +0100
@@ -14,6 +14,7 @@
 #
 
 ifndef CONFIG_64BIT
+LD_BFD		:= elf32-s390
 LDFLAGS		:= -m elf_s390
 KBUILD_CFLAGS	+= -m31
 KBUILD_AFLAGS	+= -m31
@@ -21,6 +22,7 @@
 STACK_SIZE	:= 8192
 CHECKFLAGS	+= -D__s390__ -msize-long
 else
+LD_BFD		:= elf64-s390
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
 KBUILD_CFLAGS	+= -m64
@@ -30,6 +32,8 @@
 CHECKFLAGS	+= -D__s390__ -D__s390x__
 endif
 
+export LD_BFD
+
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
@@ -85,7 +89,9 @@
 OBJCOPYFLAGS	:= -O binary
 LDFLAGS_vmlinux := -e start
 
-head-y		:= arch/s390/kernel/head.o arch/s390/kernel/init_task.o
+head-y		:= arch/s390/kernel/head.o
+head-y		+= arch/s390/kernel/$(if $(CONFIG_64BIT),head64.o,head31.o)
+head-y		+= arch/s390/kernel/init_task.o
 
 core-y		+= arch/s390/mm/ arch/s390/kernel/ arch/s390/crypto/ \
 		   arch/s390/appldata/ arch/s390/hypfs/ arch/s390/kvm/
@@ -99,12 +105,12 @@
 
 boot		:= arch/s390/boot
 
-all: image
+all: image bzImage
 
 install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-image: vmlinux
+image bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zfcpdump:
@@ -116,4 +122,5 @@
 # Don't use tabs in echo arguments
 define archhelp
   echo  '* image           - Kernel image for IPL ($(boot)/image)'
+  echo	'* bzImage         - Compressed kernel image for IPL ($(boot)/bzImage)'
 endef
