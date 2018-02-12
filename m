Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
Date: Mon, 12 Feb 2018 11:07:51 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch adds the kexec_file_load system call to s390 as well as the arch
specific functions common code requires to work. Loaders for the different
file types will be added later.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/s390/Kconfig                     |   4 +
 arch/s390/kernel/Makefile             |   1 +
 arch/s390/kernel/compat_wrapper.c     |   1 +
 arch/s390/kernel/machine_kexec_file.c | 174 ++++++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls/syscall.tbl |   1 +
 5 files changed, 181 insertions(+)
 create mode 100644 arch/s390/kernel/machine_kexec_file.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0105ce28e246..baffd88109a5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -51,6 +51,10 @@ config KEXEC
 	def_bool y
 	select KEXEC_CORE
 
+config KEXEC_FILE
+	def_bool y
+	select KEXEC_CORE
+
 config AUDIT_ARCH
 	def_bool y
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 909bce65cb2b..496d4711c186 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -60,6 +60,7 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o als.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
+obj-y	+= machine_kexec_file.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 11e9d8b5c1b0..607c5e9fba3d 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -182,3 +182,4 @@ COMPAT_SYSCALL_WRAP6(copy_file_range, int, fd_in, loff_t __user *, off_in, int,
 COMPAT_SYSCALL_WRAP2(s390_guarded_storage, int, command, struct gs_cb *, gs_cb);
 COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
 COMPAT_SYSCALL_WRAP4(s390_sthyi, unsigned long, code, void __user *, info, u64 __user *, rc, unsigned long, flags);
+COMPAT_SYSCALL_WRAP5(kexec_file_load, int, kernel_fd, int, initrd_fd, unsigned long, cmdline_len, const char __user *, cmdline_ptr, unsigned long, flags)
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..e6928cbed524
--- /dev/null
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * s390 code for kexec_file_load system call
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
+ */
+
+#include <linux/elf.h>
+#include <linux/kexec.h>
+#include <asm/setup.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL,
+};
+
+/*
+ * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
+ * and provide kbuf->mem by hand.
+ */
+int arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *))
+{
+	return 1;
+}
+
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab)
+{
+	Elf_Rela *relas;
+	int i;
+
+	relas = (void *)pi->ehdr + relsec->sh_offset;
+
+	for (i = 0; i < relsec->sh_size / sizeof(*relas); i++) {
+		const Elf_Sym *sym;	/* symbol to relocate */
+		unsigned long addr;	/* final location after relocation */
+		unsigned long val;	/* relocated symbol value */
+		void *loc;		/* tmp location to modify */
+
+		sym = (void *)pi->ehdr + symtab->sh_offset;
+		sym += ELF64_R_SYM(relas[i].r_info);
+
+		if (sym->st_shndx == SHN_UNDEF)
+			return -ENOEXEC;
+
+		if (sym->st_shndx == SHN_COMMON)
+			return -ENOEXEC;
+
+		if (sym->st_shndx >= pi->ehdr->e_shnum &&
+		    sym->st_shndx != SHN_ABS)
+			return -ENOEXEC;
+
+		loc = pi->purgatory_buf;
+		loc += section->sh_offset;
+		loc += relas[i].r_offset;
+
+		val = sym->st_value;
+		if (sym->st_shndx != SHN_ABS)
+			val += pi->sechdrs[sym->st_shndx].sh_addr;
+		val += relas[i].r_addend;
+
+		addr = section->sh_addr + relas[i].r_offset;
+
+		switch (ELF64_R_TYPE(relas[i].r_info)) {
+		case R_390_8:		/* Direct 8 bit.   */
+			*(u8 *)loc = val;
+			break;
+		case R_390_12:		/* Direct 12 bit.  */
+			*(u16 *)loc &= 0xf000;
+			*(u16 *)loc |= val & 0xfff;
+			break;
+		case R_390_16:		/* Direct 16 bit.  */
+			*(u16 *)loc = val;
+			break;
+		case R_390_20:		/* Direct 20 bit.  */
+			*(u32 *)loc &= 0xf00000ff;
+			*(u32 *)loc |= (val & 0xfff) << 16;	/* DL */
+			*(u32 *)loc |= (val & 0xff000) >> 4;	/* DH */
+			break;
+		case R_390_32:		/* Direct 32 bit.  */
+			*(u32 *)loc = val;
+			break;
+		case R_390_64:		/* Direct 64 bit.  */
+			*(u64 *)loc = val;
+			break;
+		case R_390_PC16:	/* PC relative 16 bit.  */
+			*(u16 *)loc = (val - addr);
+			break;
+		case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
+			*(u16 *)loc = (val - addr) >> 1;
+			break;
+		case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+			*(u32 *)loc = (val - addr) >> 1;
+			break;
+		case R_390_PC32:	/* PC relative 32 bit.  */
+			*(u32 *)loc = (val - addr);
+			break;
+		case R_390_PC64:	/* PC relative 64 bit.  */
+			*(u64 *)loc = (val - addr);
+			break;
+		default:
+			break;
+		}
+	}
+	return 0;
+}
+
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len)
+{
+	struct kexec_file_ops *fops;
+	int i, ret;
+
+	/* A kernel must be at least large enough to contain head.S. During
+	 * load memory in head.S will be accessed, e.g. to register the next
+	 * command line. If the next kernel were smaller the current kernel
+	 * will panic at load.
+	 *
+	 * 0x11000 = sizeof(head.S)
+	 */
+	if (buf_len < 0x11000)
+		return -ENOEXEC;
+
+	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
+		fops = kexec_file_loaders[i];
+		if (!fops || !fops->probe)
+			continue;
+
+		ret = fops->probe(buf, buf_len);
+		if (!ret) {
+			image->fops = fops;
+			return ret;
+		}
+	}
+
+	return -ENOEXEC;
+}
+
+void *arch_kexec_kernel_image_load(struct kimage *image)
+{
+	if (!image->fops || !image->fops->load)
+		return ERR_PTR(-ENOEXEC);
+
+	if (image->cmdline_buf_len >= ARCH_COMMAND_LINE_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	return image->fops->load(image, image->kernel_buf,
+				 image->kernel_buf_len, image->initrd_buf,
+				 image->initrd_buf_len, image->cmdline_buf,
+				 image->cmdline_buf_len);
+}
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	if (!image->fops || !image->fops->cleanup)
+		return 0;
+
+	return image->fops->cleanup(image->image_loader_data);
+}
+
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
+				 unsigned long kernel_len)
+{
+	if (!image->fops || !image->fops->verify_sig)
+		return -EKEYREJECTED;
+
+	return image->fops->verify_sig(kernel, kernel_len);
+}
+#endif /* CONFIG_KEXEC_VERIFY_SIG */
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index b38d48464368..8b210ead7956 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -388,3 +388,4 @@
 378  common	s390_guarded_storage	sys_s390_guarded_storage	compat_sys_s390_guarded_storage
 379  common	statx			sys_statx			compat_sys_statx
 380  common	s390_sthyi		sys_s390_sthyi			compat_sys_s390_sthyi
+381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
-- 
2.13.5
