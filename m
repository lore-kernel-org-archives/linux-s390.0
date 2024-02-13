Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA16225DE
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821268; cv=none; b=TMOtwJ9wwkVojuKlsXY/cx3GsxF0FCpb1TvbJOc96v5c5ju9DU/qiiUergQNDzMB+ExxEhtRCLAgOhOCpyWWvLgnq4juHutloRbb6Wtrz894en6lkYybra0rI7LhGRX9rWQ3PPOB9zHqSTioqQdFjeQCLARggUT8rMGyv5mv+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821268; c=relaxed/simple;
	bh=FAAEvT7RT9U1D8BVV1LDC3edOrtrbcOCUCV0LjosUFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8NyU4+UtblnlrcBLtFfkJsqxeABHFOsHTgxr4vemVd878p4c7O9k3I56Nb3+AyHMwNUandL5qPiKG7dU0B1W81JFYYbsmy/DNyBnLJSMAXj+Ayo0nNjBiVzUvQC8c2zKLHnZU4xzEEvpfcXagpARtv1AvASHf+Vtj6tycD4g4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VB2esC9H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VB2esC9H"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DABn84013389;
	Tue, 13 Feb 2024 10:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=E3+ScV1fwuM0jUxqG8lmHbMskMX+8ovFOobmW9JbrRk=;
 b=VB2esC9HKKI1xFscMo6r2UvgeSy6zuYEigC/mQnjkE9OLEq/s2VbaDIXX308e3mVlt41
 2TnNH4G2COxL9gfcMUliQJwTenycuYaCAKu/yasXd38QmMA+zS6Rtc9cBmTi9pfGZx9R
 O0aFOEAa1LW08yReM4N0vPWHCKRzmJNkq4ucgFDRvFrPIel3oWEbTjIC5Fs+EGU9aPSx
 YfW31/Otp9WY1/ZexHGZ8OgzbUhhyIR3ovjEdDr3v/S+P2FI38grL2FUN9ZoBxePktW2
 0JBBeUXhi/GIbXN4etIaIOK2XHlRi/HClV7sR4TS/y4CB4ECLMmds7Zw/+98lPhJC93x 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86f7gvuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAVZ48025548;
	Tue, 13 Feb 2024 10:47:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86f7gvu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAlQqk004287;
	Tue, 13 Feb 2024 10:47:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv070ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DAlUBO3736186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 10:47:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BBD2004B;
	Tue, 13 Feb 2024 10:47:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13C6F20040;
	Tue, 13 Feb 2024 10:47:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 10:47:30 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH 3/4] s390: Compile relocatable kernel without -fPIE
Date: Tue, 13 Feb 2024 11:47:06 +0100
Message-Id: <20240213104707.673053-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240213104707.673053-1-sumanthk@linux.ibm.com>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0pN7xL33a-1HpBT9JKmaM1isAEvyH4HL
X-Proofpoint-GUID: GhoPGzfgzxgVDZLvMCO24oOqLj9d3iYD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085

From: Josh Poimboeuf <jpoimboe@kernel.org>

On s390, currently kernel uses the '-fPIE' compiler flag for compiling
vmlinux.  This has a few problems:

  - It uses dynamic symbols (.dynsym), for which the linker refuses to
    allow more than 64k sections.  This can break features which use
    '-ffunction-sections' and '-fdata-sections', including kpatch-build
    [1] and Function Granular KASLR.

  - It unnecessarily uses GOT relocations, adding an extra layer of
    indirection for many memory accesses.

Instead of using '-fPIE', resolve all the relocations at link time and
then manually adjust any absolute relocations (R_390_64) during boot.

This is done by first telling the linker to preserve all relocations
during the vmlinux link.  (Note this is harmless: they are later
stripped in the vmlinux.bin link.)

Then use the 'relocs' tool to find all absolute relocations (R_390_64)
which apply to allocatable sections.  The offsets of those relocations
are saved in a special section which is then used to adjust the
relocations during boot.

(Note: For some reason, Clang occasionally creates a GOT reference, even
without '-fPIE'.  So Clang-compiled kernels have a GOT, which needs to
be adjusted.)

On my mostly-defconfig kernel, this reduces kernel text size by ~1.3%.

[1] https://github.com/dynup/kpatch/issues/1284
[2] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
[3] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html

Compiler consideration:

Gcc recently implemented an optimization [2] for loading symbols without
explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
symbols to reside on a 2-byte boundary, enabling the use of the larl
instruction. However, kernel linker scripts may still generate unaligned
symbols. To address this, a new -munaligned-symbols option has been
introduced [3] in recent gcc versions. This option has to be used with
future gcc versions.

Older Clang lacks support for handling unaligned symbols generated
by kernel linker scripts when the kernel is built without -fPIE. However,
future versions of Clang will include support for the -munaligned-symbols
option. When the support is unavailable, compile the kernel with -fPIE
to maintain the existing behavior.

In addition to it:
move vmlinux.relocs to safe relocation

When the kernel is built with CONFIG_KERNEL_UNCOMPRESSED, the entire
uncompressed vmlinux.bin is positioned in the bzImage decompressor
image at the default kernel LMA of 0x100000, enabling it to be executed
in-place. However, the size of .vmlinux.relocs could be large enough to
cause an overlap with the uncompressed kernel at the address 0x100000.
To address this issue, .vmlinux.relocs is positioned after the
.rodata.compressed in the bzImage. Nevertheless, in this configuration,
vmlinux.relocs will overlap with the .bss section of vmlinux.bin. To
overcome that, move vmlinux.relocs to a safe location before clearing
.bss and handling relocs.

[Rebased Josh Poimboeuf patches and move vmlinux.relocs
 to safe location: Sumanth Korikkar <sumanthk@linux.ibm.com>]
Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/s390/Kconfig                    | 15 ++++--
 arch/s390/Makefile                   |  8 ++-
 arch/s390/boot/.gitignore            |  1 +
 arch/s390/boot/Makefile              | 14 ++++-
 arch/s390/boot/boot.h                |  6 +++
 arch/s390/boot/startup.c             | 80 +++++++++++++++++++++++++---
 arch/s390/boot/vmlinux.lds.S         | 18 +++++++
 arch/s390/include/asm/physmem_info.h |  1 +
 arch/s390/kernel/vmlinux.lds.S       |  9 ++++
 9 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 771235aee6bf..0ab4c961c6ae 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -583,14 +583,23 @@ config RELOCATABLE
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded at an arbitrary address.
-	  The kernel is linked as a position-independent executable (PIE)
-	  and contains dynamic relocations which are processed early in the
-	  bootup process.
 	  The relocations make the kernel image about 15% larger (compressed
 	  10%), but are discarded at runtime.
 	  Note: this option exists only for documentation purposes, please do
 	  not remove it.
 
+config PIE_BUILD
+	def_bool CC_IS_CLANG && !$(cc-option,-munaligned-symbols)
+	help
+	  If the compiler is unable to generate code that can manage unaligned
+	  symbols, the kernel is linked as a position-independent executable
+	  (PIE) and includes dynamic relocations that are processed early
+	  during bootup.
+
+	  For kpatch functionality, it is recommended to build the kernel
+	  without the PIE_BUILD option. PIE_BUILD is only enabled when the
+	  compiler lacks proper support for handling unaligned symbols.
+
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
 	default y
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 994f9b3d575f..2a58e1864931 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -14,8 +14,14 @@ KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
+ifdef CONFIG_PIE_BUILD
 KBUILD_CFLAGS	+= -fPIE
 LDFLAGS_vmlinux	:= -pie -z notext
+else
+KBUILD_CFLAGS	+= $(call cc-option,-munaligned-symbols,)
+LDFLAGS_vmlinux	:= --emit-relocs --discard-none
+extra_tools	:= relocs
+endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
@@ -143,7 +149,7 @@ archheaders:
 
 archprepare:
 	$(Q)$(MAKE) $(build)=$(syscalls) kapi
-	$(Q)$(MAKE) $(build)=$(tools) kapi
+	$(Q)$(MAKE) $(build)=$(tools) kapi $(extra_tools)
 ifeq ($(KBUILD_EXTMOD),)
 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
 # In order to do that, we should use the archprepare target, but we can't since
diff --git a/arch/s390/boot/.gitignore b/arch/s390/boot/.gitignore
index f56591bc0897..f5ef099e2fd3 100644
--- a/arch/s390/boot/.gitignore
+++ b/arch/s390/boot/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 image
 bzImage
+relocs.S
 section_cmp.*
 vmlinux
 vmlinux.lds
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index ace0bda1ad24..8cea8c7f82cf 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -37,7 +37,8 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
 obj-y	:= head.o als.o startup.o physmem_info.o ipl_parm.o ipl_report.o vmem.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
-obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o machine_kexec_reloc.o
+obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o
+obj-y	+= $(if $(CONFIG_PIE_BUILD),machine_kexec_reloc.o,relocs.o)
 obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+= uv.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 obj-y	+= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
@@ -48,6 +49,9 @@ targets	:= bzImage section_cmp.boot.data section_cmp.boot.preserved.data $(obj-y
 targets	+= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
 targets += vmlinux.bin.zst info.bin syms.bin vmlinux.syms $(obj-all)
+ifndef CONFIG_PIE_BUILD
+targets += relocs.S
+endif
 
 OBJECTS := $(addprefix $(obj)/,$(obj-y))
 OBJECTS_ALL := $(addprefix $(obj)/,$(obj-all))
@@ -106,6 +110,14 @@ OBJCOPYFLAGS_vmlinux.bin := -O binary --remove-section=.comment --remove-section
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
+ifndef CONFIG_PIE_BUILD
+CMD_RELOCS=arch/s390/tools/relocs
+quiet_cmd_relocs = RELOCS $@
+	cmd_relocs = $(CMD_RELOCS) $< > $@
+$(obj)/relocs.S: vmlinux FORCE
+	$(call if_changed,relocs)
+endif
+
 suffix-$(CONFIG_KERNEL_GZIP)  := .gz
 suffix-$(CONFIG_KERNEL_BZIP2) := .bz2
 suffix-$(CONFIG_KERNEL_LZ4)  := .lz4
diff --git a/arch/s390/boot/boot.h b/arch/s390/boot/boot.h
index 222c6886acf6..8943d5be7ca2 100644
--- a/arch/s390/boot/boot.h
+++ b/arch/s390/boot/boot.h
@@ -25,9 +25,14 @@ struct vmlinux_info {
 	unsigned long bootdata_size;
 	unsigned long bootdata_preserved_off;
 	unsigned long bootdata_preserved_size;
+#ifdef CONFIG_PIE_BUILD
 	unsigned long dynsym_start;
 	unsigned long rela_dyn_start;
 	unsigned long rela_dyn_end;
+#else
+	unsigned long got_off;
+	unsigned long got_size;
+#endif
 	unsigned long amode31_size;
 	unsigned long init_mm_off;
 	unsigned long swapper_pg_dir_off;
@@ -83,6 +88,7 @@ extern unsigned long vmalloc_size;
 extern int vmalloc_size_set;
 extern char __boot_data_start[], __boot_data_end[];
 extern char __boot_data_preserved_start[], __boot_data_preserved_end[];
+extern int __vmlinux_relocs_64_start[], __vmlinux_relocs_64_end[];
 extern char _decompressor_syms_start[], _decompressor_syms_end[];
 extern char _stack_start[], _stack_end[];
 extern char _end[], _decompressor_end[];
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 9cc76e631759..cb0d89801c43 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -141,7 +141,8 @@ static void copy_bootdata(void)
 	memcpy((void *)vmlinux.bootdata_preserved_off, __boot_data_preserved_start, vmlinux.bootdata_preserved_size);
 }
 
-static void handle_relocs(unsigned long offset)
+#ifdef CONFIG_PIE_BUILD
+static void kaslr_adjust_relocs(unsigned long min_addr, unsigned long offset)
 {
 	Elf64_Rela *rela_start, *rela_end, *rela;
 	int r_type, r_sym, rc;
@@ -172,6 +173,62 @@ static void handle_relocs(unsigned long offset)
 	}
 }
 
+static void kaslr_adjust_got(unsigned long offset) {}
+static void rescue_relocs(void) {}
+static void free_relocs(void) {}
+#else
+int *vmlinux_relocs_64_start;
+int *vmlinux_relocs_64_end;
+
+static void rescue_relocs(void)
+{
+	unsigned long size, nrelocs;
+
+	nrelocs = __vmlinux_relocs_64_end - __vmlinux_relocs_64_start;
+	size = nrelocs * sizeof(uint32_t);
+	vmlinux_relocs_64_start = (void *)physmem_alloc_top_down(RR_RELOC, size, 0);
+	memmove(vmlinux_relocs_64_start, (void *)__vmlinux_relocs_64_start, size);
+	vmlinux_relocs_64_end = vmlinux_relocs_64_start + nrelocs;
+}
+
+static void free_relocs(void)
+{
+	physmem_free(RR_RELOC);
+}
+
+static void kaslr_adjust_relocs(unsigned long min_addr, unsigned long offset)
+{
+	int *reloc;
+	unsigned long max_addr = min_addr + vmlinux.image_size;
+	long loc;
+
+	/* Adjust R_390_64 relocations */
+	for (reloc = vmlinux_relocs_64_start;
+		reloc < vmlinux_relocs_64_end && *reloc;
+		reloc++) {
+		loc = (long)*reloc + offset;
+		if (loc < min_addr || loc > max_addr)
+			error("64-bit relocation outside of kernel!\n");
+		*(u64 *)loc += offset;
+	}
+}
+
+static void kaslr_adjust_got(unsigned long offset)
+{
+	u64 *entry;
+
+	/*
+	 * Even without -fPIE, Clang still uses a global offset table for some
+	 * reason.  Adjust the GOT entries.
+	 */
+	for (entry = (u64 *)vmlinux.got_off;
+	     entry < (u64 *)(vmlinux.got_off + vmlinux.got_size);
+	     entry++) {
+		*entry += offset;
+	}
+}
+#endif
+
 /*
  * Merge information from several sources into a single ident_map_size value.
  * "ident_map_size" represents the upper limit of physical memory we may ever
@@ -299,14 +356,18 @@ static void setup_vmalloc_size(void)
 	vmalloc_size = max(size, vmalloc_size);
 }
 
-static void offset_vmlinux_info(unsigned long offset)
+static void kaslr_adjust_vmlinux_info(unsigned long offset)
 {
 	*(unsigned long *)(&vmlinux.entry) += offset;
 	vmlinux.bootdata_off += offset;
 	vmlinux.bootdata_preserved_off += offset;
+#ifdef CONFIG_PIE_BUILD
 	vmlinux.rela_dyn_start += offset;
 	vmlinux.rela_dyn_end += offset;
 	vmlinux.dynsym_start += offset;
+#else
+	vmlinux.got_off += offset;
+#endif
 	vmlinux.init_mm_off += offset;
 	vmlinux.swapper_pg_dir_off += offset;
 	vmlinux.invalid_pg_dir_off += offset;
@@ -361,6 +422,7 @@ void startup_kernel(void)
 	detect_physmem_online_ranges(max_physmem_end);
 	save_ipl_cert_comp_list();
 	rescue_initrd(safe_addr, ident_map_size);
+	rescue_relocs();
 
 	if (kaslr_enabled()) {
 		vmlinux_lma = randomize_within_range(vmlinux.image_size + vmlinux.bss_size,
@@ -368,7 +430,7 @@ void startup_kernel(void)
 						     ident_map_size);
 		if (vmlinux_lma) {
 			__kaslr_offset = vmlinux_lma - vmlinux.default_lma;
-			offset_vmlinux_info(__kaslr_offset);
+			kaslr_adjust_vmlinux_info(__kaslr_offset);
 		}
 	}
 	vmlinux_lma = vmlinux_lma ?: vmlinux.default_lma;
@@ -393,18 +455,20 @@ void startup_kernel(void)
 	/*
 	 * The order of the following operations is important:
 	 *
-	 * - handle_relocs() must follow clear_bss_section() to establish static
+	 * - kaslr_adjust_relocs() must follow clear_bss_section() to establish static
 	 *   memory references to data in .bss to be used by setup_vmem()
 	 *   (i.e init_mm.pgd)
 	 *
-	 * - setup_vmem() must follow handle_relocs() to be able using
+	 * - setup_vmem() must follow kaslr_adjust_relocs() to be able using
 	 *   static memory references to data in .bss (i.e init_mm.pgd)
 	 *
-	 * - copy_bootdata() must follow setup_vmem() to propagate changes to
-	 *   bootdata made by setup_vmem()
+	 * - copy_bootdata() must follow setup_vmem() to propagate changes
+	 *   to bootdata made by setup_vmem()
 	 */
 	clear_bss_section(vmlinux_lma);
-	handle_relocs(__kaslr_offset);
+	kaslr_adjust_relocs(vmlinux_lma, __kaslr_offset);
+	kaslr_adjust_got(__kaslr_offset);
+	free_relocs();
 	setup_vmem(asce_limit);
 	copy_bootdata();
 
diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 806bca35e3f1..70d7eba61639 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -110,6 +110,24 @@ SECTIONS
 		_compressed_end = .;
 	}
 
+#ifndef CONFIG_PIE_BUILD
+	/*
+	 * When the kernel is built with CONFIG_KERNEL_UNCOMPRESSED, the entire
+	 * uncompressed vmlinux.bin is positioned in the bzImage decompressor
+	 * image at the default kernel LMA of 0x100000, enabling it to be
+	 * executed in-place. However, the size of .vmlinux.relocs could be
+	 * large enough to cause an overlap with the uncompressed kernel at the
+	 * address 0x100000. To address this issue, .vmlinux.relocs is
+	 * positioned after the .rodata.compressed.
+	 */
+	. = ALIGN(4);
+	.vmlinux.relocs : {
+		__vmlinux_relocs_64_start = .;
+		*(.vmlinux.relocs_64)
+		__vmlinux_relocs_64_end = .;
+	}
+#endif
+
 #define SB_TRAILER_SIZE 32
 	/* Trailer needed for Secure Boot */
 	. += SB_TRAILER_SIZE; /* make sure .sb.trailer does not overwrite the previous section */
diff --git a/arch/s390/include/asm/physmem_info.h b/arch/s390/include/asm/physmem_info.h
index 9e41a74fce9a..e747b067f8db 100644
--- a/arch/s390/include/asm/physmem_info.h
+++ b/arch/s390/include/asm/physmem_info.h
@@ -22,6 +22,7 @@ enum reserved_range_type {
 	RR_DECOMPRESSOR,
 	RR_INITRD,
 	RR_VMLINUX,
+	RR_RELOC,
 	RR_AMODE31,
 	RR_IPLREPORT,
 	RR_CERT_COMP_LIST,
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index ae14dfb98266..cb052ce302bd 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -63,7 +63,9 @@ SECTIONS
 		*(.data.rel.ro .data.rel.ro.*)
 	}
 	.got : {
+		__got_start = .;
 		*(.got)
+		__got_end = .;
 	}
 
 	. = ALIGN(PAGE_SIZE);
@@ -190,6 +192,7 @@ SECTIONS
 
 	PERCPU_SECTION(0x100)
 
+#ifdef CONFIG_PIE_BUILD
 	.dynsym ALIGN(8) : {
 		__dynsym_start = .;
 		*(.dynsym)
@@ -206,6 +209,7 @@ SECTIONS
 	.dynstr ALIGN(8) : {
 		*(.dynstr)
 	}
+#endif
 	.hash ALIGN(8) : {
 		*(.hash)
 	}
@@ -235,9 +239,14 @@ SECTIONS
 		QUAD(__boot_data_preserved_start)		/* bootdata_preserved_off */
 		QUAD(__boot_data_preserved_end -
 		     __boot_data_preserved_start)		/* bootdata_preserved_size */
+#ifdef CONFIG_PIE_BUILD
 		QUAD(__dynsym_start)				/* dynsym_start */
 		QUAD(__rela_dyn_start)				/* rela_dyn_start */
 		QUAD(__rela_dyn_end)				/* rela_dyn_end */
+#else
+		QUAD(__got_start)				/* got_off */
+		QUAD(__got_end - __got_start)			/* got_size */
+#endif
 		QUAD(_eamode31 - _samode31)			/* amode31_size */
 		QUAD(init_mm)
 		QUAD(swapper_pg_dir)
-- 
2.40.1

