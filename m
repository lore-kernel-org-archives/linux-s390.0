Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 17/17] s390/kexec_file: Add ELF loader
Date: Mon, 12 Feb 2018 11:07:54 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-18-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add an ELF loader for kexec_file. The main task here is to do proper sanity
checks on the ELF file. Basically all other functionality was already
implemented for the image loader.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kexec.h         |   1 +
 arch/s390/kernel/Makefile             |   2 +-
 arch/s390/kernel/kexec_elf.c          | 149 ++++++++++++++++++++++++++++++++++
 arch/s390/kernel/machine_kexec_file.c |   1 +
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kernel/kexec_elf.c

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 532f5e4f198f..e450b82e2716 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -67,5 +67,6 @@ void kexec_file_update_kernel(struct kimage *iamge,
 			      struct s390_load_data *data);
 
 extern const struct kexec_file_ops s390_kexec_image_ops;
+extern const struct kexec_file_ops s390_kexec_elf_ops;
 
 #endif /*_S390_KEXEC_H */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 58a590709cc3..66d7b432c2a8 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -60,7 +60,7 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o als.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
-obj-y	+= machine_kexec_file.o kexec_image.o
+obj-y	+= machine_kexec_file.o kexec_image.o kexec_elf.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
new file mode 100644
index 000000000000..919ab2f1256f
--- /dev/null
+++ b/arch/s390/kernel/kexec_elf.c
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ELF loader for kexec_file_load system call.
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <asm/setup.h>
+
+static int kexec_file_add_elf_kernel(struct kimage *image,
+				     struct s390_load_data *data,
+				     char *kernel, unsigned long kernel_len)
+{
+	struct kexec_buf buf;
+	const Elf_Ehdr *ehdr;
+	const Elf_Phdr *phdr;
+	int i, ret;
+
+	ehdr = (Elf_Ehdr *)kernel;
+	buf.image = image;
+
+	phdr = (void *)ehdr + ehdr->e_phoff;
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		buf.buffer = kernel + phdr->p_offset;
+		buf.bufsz = phdr->p_filesz;
+
+		buf.mem = ALIGN(phdr->p_paddr, phdr->p_align);
+		buf.memsz = phdr->p_memsz;
+
+		if (phdr->p_paddr == 0) {
+			data->kernel_buf = buf.buffer;
+			data->memsz += STARTUP_NORMAL_OFFSET;
+
+			buf.buffer += STARTUP_NORMAL_OFFSET;
+			buf.bufsz -= STARTUP_NORMAL_OFFSET;
+
+			buf.mem += STARTUP_NORMAL_OFFSET;
+			buf.memsz -= STARTUP_NORMAL_OFFSET;
+		}
+
+		if (image->type == KEXEC_TYPE_CRASH)
+			buf.mem += crashk_res.start;
+
+		ret = kexec_add_buffer(&buf);
+		if (ret)
+			return ret;
+
+		data->memsz += buf.memsz;
+	}
+
+	return 0;
+}
+
+static void *s390_elf_load(struct kimage *image,
+			   char *kernel, unsigned long kernel_len,
+			   char *initrd, unsigned long initrd_len,
+			   char *cmdline, unsigned long cmdline_len)
+{
+	struct s390_load_data data = {0};
+	const Elf_Ehdr *ehdr;
+	const Elf_Phdr *phdr;
+	size_t size;
+	int i, ret;
+
+	/* image->fobs->probe already checked for valid ELF magic number. */
+	ehdr = (Elf_Ehdr *)kernel;
+
+	if (ehdr->e_type != ET_EXEC ||
+	    ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
+	    !elf_check_arch(ehdr))
+		return ERR_PTR(-EINVAL);
+
+	if (!ehdr->e_phnum || ehdr->e_phentsize != sizeof(Elf_Phdr))
+		return ERR_PTR(-EINVAL);
+
+	size = ehdr->e_ehsize + ehdr->e_phoff;
+	size += ehdr->e_phentsize * ehdr->e_phnum;
+	if (size > kernel_len)
+		return ERR_PTR(-EINVAL);
+
+	phdr = (void *)ehdr + ehdr->e_phoff;
+	size = ALIGN(size, phdr->p_align);
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		if (phdr->p_type == PT_INTERP)
+			return ERR_PTR(-EINVAL);
+
+		if (phdr->p_offset > kernel_len)
+			return ERR_PTR(-EINVAL);
+
+		size += ALIGN(phdr->p_filesz, phdr->p_align);
+	}
+
+	if (size > kernel_len)
+		return ERR_PTR(-EINVAL);
+
+	ret = kexec_file_add_elf_kernel(image, &data, kernel, kernel_len);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!data.memsz)
+		return ERR_PTR(-EINVAL);
+
+	if (initrd) {
+		ret = kexec_file_add_initrd(image, &data, initrd, initrd_len);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = kexec_file_add_purgatory(image, &data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	kexec_file_update_kernel(image, &data);
+
+	return NULL;
+}
+
+static int s390_elf_probe(const char *buf, unsigned long len)
+{
+	const Elf_Ehdr *ehdr;
+
+	if (len < sizeof(Elf_Ehdr))
+		return -ENOEXEC;
+
+	ehdr = (Elf_Ehdr *)buf;
+
+	/* Only check the ELF magic number here and do proper validity check
+	 * in the loader. Any check here that fails would send the erroneous
+	 * ELF file to the image loader that does not care what it gets.
+	 * (Most likely) causing behavior not intended by the user.
+	 */
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
+		return -ENOEXEC;
+
+	return 0;
+}
+
+const struct kexec_file_ops s390_kexec_elf_ops = {
+	.probe = s390_elf_probe,
+	.load = s390_elf_load,
+};
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 050ceab746ec..8938e0eca4b0 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -12,6 +12,7 @@
 #include <asm/setup.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&s390_kexec_elf_ops,
 	&s390_kexec_image_ops,
 	NULL,
 };
-- 
2.13.5
