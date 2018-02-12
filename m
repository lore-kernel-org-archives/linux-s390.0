Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 15/17] s390/kexec_file: Add image loader
Date: Mon, 12 Feb 2018 11:07:52 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-16-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add an image loader for kexec_file_load. For simplicity first skip crash
support. The functions defined in machine_kexec_file will later be shared
with the ELF loader.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kexec.h         | 22 ++++++++++
 arch/s390/kernel/Makefile             |  2 +-
 arch/s390/kernel/kexec_image.c        | 80 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/machine_kexec_file.c | 73 ++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kernel/kexec_image.c

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 1d708a419326..532f5e4f198f 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -46,4 +46,26 @@
 static inline void crash_setup_regs(struct pt_regs *newregs,
 					struct pt_regs *oldregs) { }
 
+struct kimage;
+struct s390_load_data {
+	/* Pointer to the kernel buffer. Used to register cmdline etc.. */
+	void *kernel_buf;
+
+	/* Total size of loaded segments in memory. Used as an offset. */
+	size_t memsz;
+
+	/* Load address of initrd. Used to register INITRD_START in kernel. */
+	unsigned long initrd_load_addr;
+};
+
+int kexec_file_add_purgatory(struct kimage *image,
+			     struct s390_load_data *data);
+int kexec_file_add_initrd(struct kimage *image,
+			  struct s390_load_data *data,
+			  char *initrd, unsigned long initrd_len);
+void kexec_file_update_kernel(struct kimage *iamge,
+			      struct s390_load_data *data);
+
+extern const struct kexec_file_ops s390_kexec_image_ops;
+
 #endif /*_S390_KEXEC_H */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 496d4711c186..58a590709cc3 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -60,7 +60,7 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o als.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
-obj-y	+= machine_kexec_file.o
+obj-y	+= machine_kexec_file.o kexec_image.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
new file mode 100644
index 000000000000..83cf5a9be3a4
--- /dev/null
+++ b/arch/s390/kernel/kexec_image.c
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Image loader for kexec_file_load system call.
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
+static int kexec_file_add_image_kernel(struct kimage *image,
+				       struct s390_load_data *data,
+				       char *kernel, unsigned long kernel_len)
+{
+	struct kexec_buf buf;
+	int ret;
+
+	buf.image = image;
+
+	buf.buffer = kernel + STARTUP_NORMAL_OFFSET;
+	buf.bufsz = kernel_len - STARTUP_NORMAL_OFFSET;
+
+	buf.mem = STARTUP_NORMAL_OFFSET;
+	buf.memsz = buf.bufsz;
+
+	ret = kexec_add_buffer(&buf);
+
+	data->kernel_buf = kernel;
+	data->memsz += buf.memsz + STARTUP_NORMAL_OFFSET;
+
+	return ret;
+}
+
+static void *s390_image_load(struct kimage *image,
+			     char *kernel, unsigned long kernel_len,
+			     char *initrd, unsigned long initrd_len,
+			     char *cmdline, unsigned long cmdline_len)
+{
+	struct s390_load_data data = {0};
+	int ret;
+
+	/* We don't support crash kernels yet. */
+	if (image->type == KEXEC_TYPE_CRASH)
+		return ERR_PTR(-ENOTSUPP);
+
+	ret = kexec_file_add_image_kernel(image, &data, kernel, kernel_len);
+	if (ret)
+		return ERR_PTR(ret);
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
+static int s390_image_probe(const char *buf, unsigned long len)
+{
+	/* Can't reliably tell if an image is valid.  Therefore give the
+	 * user whatever he wants.
+	 */
+	return 0;
+}
+
+const struct kexec_file_ops s390_kexec_image_ops = {
+	.probe = s390_image_probe,
+	.load = s390_image_load,
+};
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index e6928cbed524..052640220361 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -12,9 +12,82 @@
 #include <asm/setup.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&s390_kexec_image_ops,
 	NULL,
 };
 
+void kexec_file_update_kernel(struct kimage *image,
+			      struct s390_load_data *data)
+{
+	unsigned long *loc;
+
+	/* Callers guarantee cmdline to be \0-terminated and
+	 * cmdline_len < ARCH_COMMAND_LINE_SIZE.
+	 */
+	if (image->cmdline_buf_len)
+		memcpy(data->kernel_buf + COMMAND_LINE_OFFSET,
+		       image->cmdline_buf, image->cmdline_buf_len);
+
+	if (image->initrd_buf) {
+		loc = (unsigned long *)(data->kernel_buf + INITRD_START_OFFSET);
+		*loc = data->initrd_load_addr;
+
+		loc = (unsigned long *)(data->kernel_buf + INITRD_SIZE_OFFSET);
+		*loc = image->initrd_buf_len;
+	}
+}
+
+static int kexec_file_update_purgatory(struct kimage *image)
+{
+	u64 entry, type;
+	int ret;
+
+	entry = STARTUP_NORMAL_OFFSET;
+	ret = kexec_purgatory_get_set_symbol(image, "kernel_entry", &entry,
+					     sizeof(entry), false);
+	return ret;
+}
+
+int kexec_file_add_purgatory(struct kimage *image, struct s390_load_data *data)
+{
+	struct kexec_buf buf;
+	int ret;
+
+	buf.image = image;
+
+	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
+	buf.mem = data->memsz;
+
+	ret = kexec_load_purgatory(image, &buf);
+	if (ret)
+		return ret;
+
+	ret = kexec_file_update_purgatory(image);
+	return ret;
+}
+
+int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
+			  char *initrd, unsigned long initrd_len)
+{
+	struct kexec_buf buf;
+	int ret;
+
+	buf.image = image;
+
+	buf.buffer = initrd;
+	buf.bufsz = initrd_len;
+
+	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
+	buf.mem = data->memsz;
+	buf.memsz = buf.bufsz;
+
+	data->initrd_load_addr = buf.mem;
+	data->memsz += buf.memsz;
+
+	ret = kexec_add_buffer(&buf);
+	return ret;
+}
+
 /*
  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
  * and provide kbuf->mem by hand.
-- 
2.13.5
