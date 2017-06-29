From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:32 +0000
Subject: [CRIU][PATCH v2 04/17] s390:criu/arch/s390: Add s390 parts to criu
Message-Id: <20170629192445.55580-5-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/arch/s390/Makefile                       |  10 +
 criu/arch/s390/cpu.c                          | 158 ++++++++++++
 criu/arch/s390/crtools.c                      | 341 ++++++++++++++++++++++++++
 criu/arch/s390/include/asm/dump.h             |  12 +
 criu/arch/s390/include/asm/int.h              |   6 +
 criu/arch/s390/include/asm/parasite-syscall.h |   6 +
 criu/arch/s390/include/asm/parasite.h         |   7 +
 criu/arch/s390/include/asm/restore.h          |  29 +++
 criu/arch/s390/include/asm/restorer.h         |  65 +++++
 criu/arch/s390/include/asm/types.h            |  37 +++
 criu/arch/s390/include/asm/vdso.h             |  23 ++
 criu/arch/s390/restorer.c                     |  37 +++
 criu/arch/s390/sigframe.c                     |  20 ++
 criu/arch/s390/vdso-pie.c                     |  65 +++++
 14 files changed, 816 insertions(+)
 create mode 100644 criu/arch/s390/Makefile
 create mode 100644 criu/arch/s390/cpu.c
 create mode 100644 criu/arch/s390/crtools.c
 create mode 100644 criu/arch/s390/include/asm/dump.h
 create mode 100644 criu/arch/s390/include/asm/int.h
 create mode 100644 criu/arch/s390/include/asm/parasite-syscall.h
 create mode 100644 criu/arch/s390/include/asm/parasite.h
 create mode 100644 criu/arch/s390/include/asm/restore.h
 create mode 100644 criu/arch/s390/include/asm/restorer.h
 create mode 100644 criu/arch/s390/include/asm/types.h
 create mode 100644 criu/arch/s390/include/asm/vdso.h
 create mode 100644 criu/arch/s390/restorer.c
 create mode 100644 criu/arch/s390/sigframe.c
 create mode 100644 criu/arch/s390/vdso-pie.c

diff --git a/criu/arch/s390/Makefile b/criu/arch/s390/Makefile
new file mode 100644
index 0000000..ff0a712
--- /dev/null
+++ b/criu/arch/s390/Makefile
@@ -0,0 +1,10 @@
+builtin-name		:= crtools.built-in.o
+
+ccflags-y		+= -iquote $(obj)/include
+ccflags-y		+= -iquote criu/include -iquote include
+ccflags-y		+= $(COMPEL_UAPI_INCLUDES)
+ldflags-y		+= -r
+
+obj-y			+= cpu.o
+obj-y			+= crtools.o
+obj-y			+= sigframe.o
diff --git a/criu/arch/s390/cpu.c b/criu/arch/s390/cpu.c
new file mode 100644
index 0000000..0c32de5
--- /dev/null
+++ b/criu/arch/s390/cpu.c
@@ -0,0 +1,158 @@
+#undef	LOG_PREFIX
+#define LOG_PREFIX "cpu: "
+
+#include <sys/auxv.h>
+#include <errno.h>
+
+#include "asm/types.h"
+
+#include "cr_options.h"
+#include "image.h"
+#include "util.h"
+#include "log.h"
+#include "cpu.h"
+
+#include "protobuf.h"
+#include "images/cpuinfo.pb-c.h"
+
+static compel_cpuinfo_t rt_cpuinfo;
+
+static const char *hwcap_str1[64] = {
+	"HWCAP_S390_ESAN3",
+	"HWCAP_S390_ZARCH",
+	"HWCAP_S390_STFLE",
+	"HWCAP_S390_MSA",
+	"HWCAP_S390_LDISP",
+	"HWCAP_S390_EIMM",
+	"HWCAP_S390_DFP",
+	"HWCAP_S390_HPAGE",
+	"HWCAP_S390_ETF3EH",
+	"HWCAP_S390_HIGH_GPRS",
+	"HWCAP_S390_TE",
+	"HWCAP_S390_VXRS",
+	"HWCAP_S390_VXRS_BCD",
+	"HWCAP_S390_VXRS_EXT",
+};
+static const char *hwcap_str2[64] = { };
+
+static const char **hwcap_str[2] = { hwcap_str1, hwcap_str2 };
+
+static void print_hwcaps(const char *msg, unsigned long hwcap[2])
+{
+	int nr, cap;
+
+	pr_debug("%s: Capabilities: %016lx %016lx\n", msg, hwcap[0], hwcap[1]);
+	for (nr = 0; nr < 2; nr++) {
+		for (cap = 0; cap < 64; cap++) {
+			if (!(hwcap[nr] & (1 << cap)))
+				continue;
+			if (hwcap_str[nr][cap])
+				pr_debug("%s\n", hwcap_str[nr][cap]);
+			else
+				pr_debug("Capability %d/0x%x\n", nr, 1 << cap);
+		}
+	}
+}
+
+int cpu_init(void)
+{
+	int ret;
+
+	ret = compel_cpuid(&rt_cpuinfo);
+	print_hwcaps("Host (init)", rt_cpuinfo.hwcap);
+	return ret;
+}
+
+int cpu_dump_cpuinfo(void)
+{
+	CpuinfoS390Entry cpu_s390_info = CPUINFO_S390_ENTRY__INIT;
+	CpuinfoS390Entry *cpu_s390_info_ptr = &cpu_s390_info;
+	CpuinfoEntry cpu_info = CPUINFO_ENTRY__INIT;
+	struct cr_img *img;
+	int ret = -1;
+
+	img = open_image(CR_FD_CPUINFO, O_DUMP);
+	if (!img)
+	return -1;
+
+	cpu_info.s390_entry = &cpu_s390_info_ptr;
+	cpu_info.n_s390_entry = 1;
+
+	cpu_s390_info.n_hwcap = 2;
+	cpu_s390_info.hwcap = rt_cpuinfo.hwcap;
+
+	ret = pb_write_one(img, &cpu_info, PB_CPUINFO);
+
+	close_image(img);
+	return ret;
+}
+
+int cpu_validate_cpuinfo(void)
+{
+	CpuinfoS390Entry *cpu_s390_entry;
+	CpuinfoEntry *cpu_info;
+	struct cr_img *img;
+	int cap, nr, ret;
+
+	img = open_image(CR_FD_CPUINFO, O_RSTR);
+	if (!img)
+		return -1;
+
+	ret = 0;
+	if (pb_read_one(img, &cpu_info, PB_CPUINFO) < 0)
+		goto error;
+
+	if (cpu_info->n_s390_entry != 1) {
+		pr_err("No S390 related entry in image");
+		goto error;
+	}
+	cpu_s390_entry = cpu_info->s390_entry[0];
+
+	if (cpu_s390_entry->n_hwcap != 2) {
+		pr_err("Hardware capabilities information missing\n");
+		ret = -1;
+		goto error;
+	}
+
+	print_hwcaps("Host", rt_cpuinfo.hwcap);
+	print_hwcaps("Image", cpu_s390_entry->hwcap);
+
+	for (nr = 0; nr < 2; nr++) {
+		for (cap = 0; cap < 64; cap++) {
+			if (!(cpu_s390_entry->hwcap[nr] & (1 << cap)))
+				continue;
+			if (rt_cpuinfo.hwcap[nr] & (1 << cap))
+				continue;
+			if (hwcap_str[nr][cap])
+				pr_err("CPU Feature %s not supported on host\n",
+				       hwcap_str[nr][cap]);
+			else
+				pr_err("CPU Feature %d/%x not supported on host\n",
+				       nr, 1 << cap);
+			ret = -1;
+		}
+	}
+	if (ret == -1)
+		pr_err("See also: /usr/include/bits/hwcap.h\n");
+error:
+	close_image(img);
+	return ret;
+}
+
+int cpuinfo_dump(void)
+{
+	if (cpu_init())
+		return -1;
+	if (cpu_dump_cpuinfo())
+		return -1;
+	return 0;
+}
+
+int cpuinfo_check(void)
+{
+	if (cpu_init())
+		return 1;
+	if (cpu_validate_cpuinfo())
+		return 1;
+	return 0;
+}
diff --git a/criu/arch/s390/crtools.c b/criu/arch/s390/crtools.c
new file mode 100644
index 0000000..4bd21ec
--- /dev/null
+++ b/criu/arch/s390/crtools.c
@@ -0,0 +1,341 @@
+#include <string.h>
+#include <unistd.h>
+#include <elf.h>
+#include <sys/user.h>
+#include <asm/unistd.h>
+#include <sys/uio.h>
+
+#include "types.h"
+#include <compel/asm/fpu.h>
+#include "asm/restorer.h"
+#include "asm/dump.h"
+
+#include "cr_options.h"
+#include "common/compiler.h"
+#include <compel/ptrace.h>
+#include "parasite-syscall.h"
+#include "log.h"
+#include "util.h"
+#include "cpu.h"
+#include <compel/compel.h>
+
+#include "protobuf.h"
+#include "images/core.pb-c.h"
+#include "images/creds.pb-c.h"
+
+/*
+ * Print general purpose and access registers
+ */
+static void print_core_gpregs(const char *msg, UserS390RegsEntry *gpregs)
+{
+	int i;
+
+	pr_debug("%s: General purpose registers\n", msg);
+	pr_debug("       psw %016lx %016lx\n",
+		 gpregs->psw_mask, gpregs->psw_addr);
+	pr_debug(" orig_gpr2 %016lx\n", gpregs->orig_gpr2);
+	for (i = 0; i < 16; i++)
+		pr_debug("       g%02d %016lx\n", i, gpregs->gprs[i]);
+	for (i = 0; i < 16; i++)
+		pr_debug("       a%02d %08x\n", i, gpregs->acrs[i]);
+}
+
+/*
+ * Print floating point and vector registers
+ */
+static void print_core_fp_regs(const char *msg, CoreEntry *core)
+{
+	UserS390VxrsHighEntry *vxrs_high;
+	UserS390VxrsLowEntry *vxrs_low;
+	UserS390FpregsEntry *fpregs;
+	int i;
+
+	vxrs_high = CORE_THREAD_ARCH_INFO(core)->vxrs_high;
+	vxrs_low = CORE_THREAD_ARCH_INFO(core)->vxrs_low;
+	fpregs = CORE_THREAD_ARCH_INFO(core)->fpregs;
+
+	pr_debug("%s: Floating point registers\n", msg);
+	pr_debug("       fpc %08x\n", fpregs->fpc);
+	for (i = 0; i < 16; i++)
+		pr_debug("       f%02d %016lx\n", i, fpregs->fprs[i]);
+	if (!vxrs_low) {
+		pr_debug("       No VXRS\n");
+		return;
+	}
+	for (i = 0; i < 16; i++)
+		pr_debug("  vx_low%02d %016lx\n", i, vxrs_low->regs[i]);
+	for (i = 0; i < 32; i += 2)
+		pr_debug(" vx_high%02d %016lx %016lx\n", i / 2,
+			 vxrs_high->regs[i], vxrs_high->regs[i + 1]);
+}
+
+/*
+ * Allocate VxrsLow registers
+ */
+static UserS390VxrsLowEntry *allocate_vxrs_low_regs(void)
+{
+	UserS390VxrsLowEntry *vxrs_low;
+
+	vxrs_low = xmalloc(sizeof(*vxrs_low));
+	if (!vxrs_low)
+		return NULL;
+	user_s390_vxrs_low_entry__init(vxrs_low);
+
+	vxrs_low->n_regs = 16;
+	vxrs_low->regs = xzalloc(16 * sizeof(uint64_t));
+	if (!vxrs_low->regs)
+		goto fail_free_vxrs_low;
+	return vxrs_low;
+
+fail_free_vxrs_low:
+	xfree(vxrs_low);
+	return NULL;
+}
+
+/*
+ * Free VxrsLow registers
+ */
+static void free_vxrs_low_regs(UserS390VxrsLowEntry *vxrs_low)
+{
+	if (vxrs_low) {
+		xfree(vxrs_low->regs);
+		xfree(vxrs_low);
+	}
+}
+
+/*
+ * Allocate VxrsHigh registers
+ */
+static UserS390VxrsHighEntry *allocate_vxrs_high_regs(void)
+{
+	UserS390VxrsHighEntry *vxrs_high;
+
+	vxrs_high = xmalloc(sizeof(*vxrs_high));
+	if (!vxrs_high)
+		return NULL;
+	user_s390_vxrs_high_entry__init(vxrs_high);
+
+	vxrs_high->n_regs = 32;
+	vxrs_high->regs = xzalloc(32 * sizeof(uint64_t));
+	if (!vxrs_high->regs)
+		goto fail_free_vxrs_high;
+	return vxrs_high;
+
+fail_free_vxrs_high:
+	xfree(vxrs_high);
+	return NULL;
+}
+
+/*
+ * Free VxrsHigh registers
+ */
+static void free_vxrs_high_regs(UserS390VxrsHighEntry *vxrs_high)
+{
+	if (vxrs_high) {
+		xfree(vxrs_high->regs);
+		xfree(vxrs_high);
+	}
+}
+
+/*
+ * Copy internal structures into Google Protocol Buffers
+ */
+int save_task_regs(void *arg, user_regs_struct_t *u, user_fpregs_struct_t *f)
+{
+	UserS390VxrsHighEntry *vxrs_high;
+	UserS390VxrsLowEntry *vxrs_low;
+	UserS390FpregsEntry *fpregs;
+	UserS390RegsEntry *gpregs;
+	CoreEntry *core = arg;
+
+	gpregs = CORE_THREAD_ARCH_INFO(core)->gpregs;
+	fpregs = CORE_THREAD_ARCH_INFO(core)->fpregs;
+
+	/* Vector registers */
+	if (f->flags & USER_FPREGS_VXRS) {
+		vxrs_low = allocate_vxrs_low_regs();
+		if (!vxrs_low)
+			return -1;
+		vxrs_high = allocate_vxrs_high_regs();
+		if (!vxrs_high) {
+			free_vxrs_low_regs(vxrs_low);
+			return -1;
+		}
+		memcpy(vxrs_low->regs, &f->vxrs_low, sizeof(f->vxrs_low));
+		memcpy(vxrs_high->regs, &f->vxrs_high, sizeof(f->vxrs_high));
+		CORE_THREAD_ARCH_INFO(core)->vxrs_low = vxrs_low;
+		CORE_THREAD_ARCH_INFO(core)->vxrs_high = vxrs_high;
+	}
+	/* General purpose registers */
+	memcpy(gpregs->gprs, u->prstatus.gprs, sizeof(u->prstatus.gprs));
+	gpregs->psw_mask = u->prstatus.psw.mask;
+	gpregs->psw_addr = u->prstatus.psw.addr;
+	/* Access registers */
+	memcpy(gpregs->acrs, u->prstatus.acrs, sizeof(u->prstatus.acrs));
+	/* System call */
+	gpregs->system_call = u->system_call;
+	/* Floating point registers */
+	fpregs->fpc = f->prfpreg.fpc;
+	memcpy(fpregs->fprs, f->prfpreg.fprs, sizeof(f->prfpreg.fprs));
+	return 0;
+}
+
+/*
+ * Copy general and access registers to signal frame
+ */
+int restore_gpregs(struct rt_sigframe *f, UserS390RegsEntry *src)
+{
+	_sigregs *dst = &f->uc.uc_mcontext;
+
+	dst->regs.psw.mask = src->psw_mask;
+	dst->regs.psw.addr = src->psw_addr;
+	memcpy(dst->regs.gprs, src->gprs, sizeof(dst->regs.gprs));
+	memcpy(dst->regs.acrs, src->acrs, sizeof(dst->regs.acrs));
+
+	print_core_gpregs("restore_gpregs_regs", src);
+	return 0;
+}
+
+/*
+ * Copy floating point and vector registers to mcontext
+ */
+int restore_fpu(struct rt_sigframe *f, CoreEntry *core)
+{
+	UserS390VxrsHighEntry *vxrs_high;
+	UserS390VxrsLowEntry *vxrs_low;
+	UserS390FpregsEntry *fpregs;
+	_sigregs *dst = &f->uc.uc_mcontext;
+	_sigregs_ext *dst_ext = &f->uc.uc_mcontext_ext;
+
+	fpregs = CORE_THREAD_ARCH_INFO(core)->fpregs;
+	vxrs_high = CORE_THREAD_ARCH_INFO(core)->vxrs_high;
+	vxrs_low = CORE_THREAD_ARCH_INFO(core)->vxrs_low;
+
+	dst->fpregs.fpc = fpregs->fpc;
+	memcpy(dst->fpregs.fprs, fpregs->fprs, sizeof(dst->fpregs.fprs));
+	if (vxrs_low) {
+		memcpy(&dst_ext->vxrs_low, vxrs_low->regs,
+		       sizeof(dst_ext->vxrs_low));
+		memcpy(&dst_ext->vxrs_high, vxrs_high->regs,
+		       sizeof(dst_ext->vxrs_high));
+	}
+	print_core_fp_regs("restore_fp_regs", core);
+	return 0;
+}
+
+/*
+ * Allocate floating point registers
+ */
+static UserS390FpregsEntry *allocate_fp_regs(void)
+{
+	UserS390FpregsEntry *fpregs;
+
+	fpregs = xmalloc(sizeof(*fpregs));
+	if (!fpregs)
+		return NULL;
+	user_s390_fpregs_entry__init(fpregs);
+
+	fpregs->n_fprs = 16;
+	fpregs->fprs = xzalloc(16 * sizeof(uint64_t));
+	if (!fpregs->fprs)
+		goto fail_free_fpregs;
+	return fpregs;
+
+fail_free_fpregs:
+	xfree(fpregs);
+	return NULL;
+}
+
+/*
+ * Free floating point registers
+ */
+static void free_fp_regs(UserS390FpregsEntry *fpregs)
+{
+	xfree(fpregs->fprs);
+	xfree(fpregs);
+}
+
+/*
+ * Allocate general purpose and access registers
+ */
+static UserS390RegsEntry *allocate_gp_regs(void)
+{
+	UserS390RegsEntry *gpregs;
+
+	gpregs = xmalloc(sizeof(*gpregs));
+	if (!gpregs)
+		return NULL;
+	user_s390_regs_entry__init(gpregs);
+
+	gpregs->n_gprs = 16;
+	gpregs->gprs = xzalloc(16 * sizeof(uint64_t));
+	if (!gpregs->gprs)
+		goto fail_free_gpregs;
+
+	gpregs->n_acrs = 16;
+	gpregs->acrs = xzalloc(16 * sizeof(uint32_t));
+	if (!gpregs->acrs)
+		goto fail_free_gprs;
+	return gpregs;
+
+fail_free_gprs:
+	xfree(gpregs->gprs);
+fail_free_gpregs:
+	xfree(gpregs);
+	return NULL;
+}
+
+/*
+ * Free general purpose and access registers
+ */
+static void free_gp_regs(UserS390RegsEntry *gpregs)
+{
+	xfree(gpregs->gprs);
+	xfree(gpregs->acrs);
+	xfree(gpregs);
+}
+
+/*
+ * Allocate thread info
+ */
+int arch_alloc_thread_info(CoreEntry *core)
+{
+	ThreadInfoS390 *ti_s390;
+
+	ti_s390 = xmalloc(sizeof(*ti_s390));
+	if (!ti_s390)
+		return -1;
+
+	thread_info_s390__init(ti_s390);
+
+	ti_s390->gpregs = allocate_gp_regs();
+	if (!ti_s390->gpregs)
+		goto fail_free_ti_s390;
+	ti_s390->fpregs = allocate_fp_regs();
+	if (!ti_s390->fpregs)
+		goto fail_free_gp_regs;
+
+	CORE_THREAD_ARCH_INFO(core) = ti_s390;
+	return 0;
+
+fail_free_gp_regs:
+	free_gp_regs(ti_s390->gpregs);
+fail_free_ti_s390:
+	xfree(ti_s390);
+	return -1;
+}
+
+/*
+ * Free thread info
+ */
+void arch_free_thread_info(CoreEntry *core)
+{
+	if (!CORE_THREAD_ARCH_INFO(core))
+		return;
+	free_gp_regs(CORE_THREAD_ARCH_INFO(core)->gpregs);
+	free_fp_regs(CORE_THREAD_ARCH_INFO(core)->fpregs);
+	free_vxrs_low_regs(CORE_THREAD_ARCH_INFO(core)->vxrs_low);
+	free_vxrs_high_regs(CORE_THREAD_ARCH_INFO(core)->vxrs_high);
+	xfree(CORE_THREAD_ARCH_INFO(core));
+	CORE_THREAD_ARCH_INFO(core) = NULL;
+}
diff --git a/criu/arch/s390/include/asm/dump.h b/criu/arch/s390/include/asm/dump.h
new file mode 100644
index 0000000..53aaac9
--- /dev/null
+++ b/criu/arch/s390/include/asm/dump.h
@@ -0,0 +1,12 @@
+#ifndef __CR_ASM_DUMP_H__
+#define __CR_ASM_DUMP_H__
+
+int save_task_regs(void *arg, user_regs_struct_t *u, user_fpregs_struct_t *f);
+int arch_alloc_thread_info(CoreEntry *core);
+void arch_free_thread_info(CoreEntry *core);
+
+static inline void core_put_tls(CoreEntry *core, tls_t tls) { }
+
+#define get_task_futex_robust_list_compat(pid, info) -1
+
+#endif
diff --git a/criu/arch/s390/include/asm/int.h b/criu/arch/s390/include/asm/int.h
new file mode 100644
index 0000000..642804e
--- /dev/null
+++ b/criu/arch/s390/include/asm/int.h
@@ -0,0 +1,6 @@
+#ifndef __CR_ASM_INT_H__
+#define __CR_ASM_INT_H__
+
+#include "asm-generic/int.h"
+
+#endif /* __CR_ASM_INT_H__ */
diff --git a/criu/arch/s390/include/asm/parasite-syscall.h b/criu/arch/s390/include/asm/parasite-syscall.h
new file mode 100644
index 0000000..6008c37
--- /dev/null
+++ b/criu/arch/s390/include/asm/parasite-syscall.h
@@ -0,0 +1,6 @@
+#ifndef __CR_ASM_PARASITE_SYSCALL_H__
+#define __CR_ASM_PARASITE_SYSCALL_H__
+
+struct parasite_ctl;
+
+#endif
diff --git a/criu/arch/s390/include/asm/parasite.h b/criu/arch/s390/include/asm/parasite.h
new file mode 100644
index 0000000..0b02689
--- /dev/null
+++ b/criu/arch/s390/include/asm/parasite.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_PARASITE_H__
+#define __ASM_PARASITE_H__
+
+/* TLS is accessed through %a01, which is already processed */
+static inline void arch_get_tls(tls_t *ptls) { (void)ptls; }
+
+#endif
diff --git a/criu/arch/s390/include/asm/restore.h b/criu/arch/s390/include/asm/restore.h
new file mode 100644
index 0000000..96358ff
--- /dev/null
+++ b/criu/arch/s390/include/asm/restore.h
@@ -0,0 +1,29 @@
+#ifndef __CR_ASM_RESTORE_H__
+#define __CR_ASM_RESTORE_H__
+
+#include "asm/restorer.h"
+
+#include "images/core.pb-c.h"
+
+/*
+ * Load stack to %r15, return address in %r14 and argument 1 into %r2
+ */
+#define JUMP_TO_RESTORER_BLOB(new_sp, restore_task_exec_start,		\
+			      task_args)				\
+	asm volatile(							\
+		"lgr	%%r15,%0\n"					\
+		"lgr	%%r14,%1\n"					\
+		"lgr	%%r2,%2\n"					\
+		"basr	%%r14,%%r14\n"					\
+		:							\
+		: "d" (new_sp),						\
+		  "d"((unsigned long)restore_task_exec_start),		\
+		  "d" (task_args)					\
+		: "2", "14", "15", "memory")
+
+/* There is nothing to do since TLS is accessed through %a01 */
+#define core_get_tls(pcore, ptls)
+
+int restore_fpu(struct rt_sigframe *sigframe, CoreEntry *core);
+
+#endif
diff --git a/criu/arch/s390/include/asm/restorer.h b/criu/arch/s390/include/asm/restorer.h
new file mode 100644
index 0000000..0fd23cf
--- /dev/null
+++ b/criu/arch/s390/include/asm/restorer.h
@@ -0,0 +1,65 @@
+#ifndef __CR_ASM_RESTORER_H__
+#define __CR_ASM_RESTORER_H__
+
+#include <asm/ptrace.h>
+#include <asm/types.h>
+
+#include "asm/types.h"
+
+#include "sigframe.h"
+
+/*
+ * Clone trampoline - see glibc sysdeps/unix/sysv/linux/s390/s390-64/clone.S
+ */
+#define RUN_CLONE_RESTORE_FN(ret, clone_flags, new_sp, parent_tid,	\
+			     thread_args, clone_restore_fn)		\
+	asm volatile(							\
+	"lgr	%%r0,%6\n"	/* Save thread_args in %r0 */		\
+	"lgr	%%r1,%5\n"	/* Save clone_restore_fn in %r1 */	\
+	"lgr	%%r2,%2\n"	/* Parm 1: new_sp (child stack) */	\
+	"lgr	%%r3,%1\n"	/* Parm 2: clone_flags */		\
+	"lgr	%%r4,%3\n"	/* Parm 3: &parent_tid */		\
+	"lgr	%%r5,%4\n"	/* Parm 4: &thread_args[i].pid */	\
+	"lghi	%%r6,0\n"	/* Parm 5: tls = 0 */			\
+	"svc	"__stringify(__NR_clone)"\n"				\
+	"ltgr	%0,%%r2\n"	/* Set and check "ret" */		\
+	"jnz	0f\n"		/* ret != 0: Continue caller */		\
+	"lgr	%%r2,%%r0\n"	/* Parm 1: &thread_args */		\
+	"aghi	%%r15,-160\n"	/* Prepare stack frame */		\
+	"xc	0(8,%%r15),0(%%r15)\n"					\
+	"basr	%%r14,%%r1\n"	/* Jump to clone_restore_fn() */	\
+	"j	.+2\n"		/* BUG(): Force PGM check */		\
+"0:\n"				/* Continue caller */			\
+	: "=d"(ret)							\
+	: "d"(clone_flags),						\
+	  "a"(new_sp),							\
+	  "d"(&parent_tid),						\
+	  "d"(&thread_args[i].pid),					\
+	  "d"(clone_restore_fn),					\
+	  "d"(&thread_args[i])						\
+	: "0", "1", "2", "3", "4", "5", "6", "cc", "memory")
+
+#define kdat_compatible_cr()			0
+
+int restore_gpregs(struct rt_sigframe *f, UserS390RegsEntry *r);
+int restore_nonsigframe_gpregs(UserS390RegsEntry *r);
+
+unsigned long sys_shmat(int shmid, const void *shmaddr, int shmflg);
+unsigned long sys_mmap(void *addr, unsigned long len, unsigned long prot,
+		       unsigned long flags, unsigned long fd,
+		       unsigned long offset);
+
+static inline void restore_tls(tls_t *ptls) { (void)ptls; }
+static inline void *alloc_compat_syscall_stack(void) { return NULL; }
+static inline void free_compat_syscall_stack(void *stack32) { }
+static inline int arch_compat_rt_sigaction(void *stack, int sig, void *act)
+{
+	return -1;
+}
+
+static inline int set_compat_robust_list(uint32_t head_ptr, uint32_t len)
+{
+	return -1;
+}
+
+#endif /*__CR_ASM_RESTORER_H__*/
diff --git a/criu/arch/s390/include/asm/types.h b/criu/arch/s390/include/asm/types.h
new file mode 100644
index 0000000..4f36c13
--- /dev/null
+++ b/criu/arch/s390/include/asm/types.h
@@ -0,0 +1,37 @@
+#ifndef _UAPI_S390_TYPES_H
+#define _UAPI_S390_TYPES_H
+
+#include <stdbool.h>
+#include <signal.h>
+#include "images/core.pb-c.h"
+
+#include "page.h"
+#include "bitops.h"
+#include "asm/int.h"
+
+#include <compel/plugins/std/asm/syscall-types.h>
+
+typedef UserS390RegsEntry UserRegsEntry;
+
+#define CORE_ENTRY__MARCH CORE_ENTRY__MARCH__S390
+
+#define core_is_compat(core)                  false
+
+#define CORE_THREAD_ARCH_INFO(core) core->ti_s390
+
+static inline u64 encode_pointer(void *p) { return (u64) p; }
+static inline void *decode_pointer(u64 v) { return (void *) v; }
+
+/*
+ * See also:
+ *   * arch/s390/include/uapi/asm/auxvec.h
+ *   * include/linux/auxvec.h
+ */
+#define AT_VECTOR_SIZE_BASE	20
+#define AT_VECTOR_SIZE_ARCH	1
+#define AT_VECTOR_SIZE		(2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
+
+typedef uint64_t auxv_t;
+typedef uint64_t tls_t;
+
+#endif /* _UAPI_S390_TYPES_H */
diff --git a/criu/arch/s390/include/asm/vdso.h b/criu/arch/s390/include/asm/vdso.h
new file mode 100644
index 0000000..63e7e04
--- /dev/null
+++ b/criu/arch/s390/include/asm/vdso.h
@@ -0,0 +1,23 @@
+#ifndef __CR_ASM_VDSO_H__
+#define __CR_ASM_VDSO_H__
+
+#include "asm/int.h"
+#include "asm-generic/vdso.h"
+
+/*
+ * This is a minimal amount of symbols
+ * we should support at the moment.
+ */
+#define VDSO_SYMBOL_MAX	4
+
+/*
+ * This definition is used in pie/util-vdso.c to initialize the vdso symbol
+ * name string table 'vdso_symbols'
+ */
+#define ARCH_VDSO_SYMBOLS				\
+	"__kernel_gettimeofday",			\
+	"__kernel_clock_gettime",			\
+	"__kernel_clock_getres",			\
+	"__kernel_getcpu"
+
+#endif /* __CR_ASM_VDSO_H__ */
diff --git a/criu/arch/s390/restorer.c b/criu/arch/s390/restorer.c
new file mode 100644
index 0000000..3823fda
--- /dev/null
+++ b/criu/arch/s390/restorer.c
@@ -0,0 +1,37 @@
+#include <unistd.h>
+
+#include "restorer.h"
+#include "asm/restorer.h"
+#include <compel/asm/fpu.h>
+
+#include <compel/plugins/std/syscall.h>
+#include "log.h"
+
+/*
+ * All registers are restored by sigreturn - nothing to do here
+ */
+int restore_nonsigframe_gpregs(UserS390RegsEntry *r)
+{
+	return 0;
+}
+
+/*
+ * Call underlying ipc system call for shmat
+ */
+unsigned long sys_shmat(int shmid, const void *shmaddr, int shmflg)
+{
+	unsigned long raddr;
+	int ret;
+
+	ret = sys_ipc(21 /*SHMAT */,
+		      shmid,			/* first		*/
+		      shmflg,			/* second		*/
+		      (unsigned long)&raddr,	/* third		*/
+		      shmaddr,			/* ptr			*/
+		      0				/* fifth not used	*/);
+
+	if (ret)
+		raddr = (unsigned long) ret;
+
+	return raddr;
+}
diff --git a/criu/arch/s390/sigframe.c b/criu/arch/s390/sigframe.c
new file mode 100644
index 0000000..03f206a
--- /dev/null
+++ b/criu/arch/s390/sigframe.c
@@ -0,0 +1,20 @@
+#include <stdlib.h>
+#include <stdint.h>
+
+#include "asm/sigframe.h"
+#include "asm/types.h"
+
+#include "log.h"
+
+/*
+ * Nothing to do since we don't have any pointers to adjust
+ * in the signal frame.
+ *
+ * - sigframe : Pointer to local signal frame
+ * - rsigframe: Pointer to remote signal frame of inferior
+ */
+int sigreturn_prep_fpu_frame(struct rt_sigframe *sigframe,
+			     struct rt_sigframe *rsigframe)
+{
+	return 0;
+}
diff --git a/criu/arch/s390/vdso-pie.c b/criu/arch/s390/vdso-pie.c
new file mode 100644
index 0000000..0667668
--- /dev/null
+++ b/criu/arch/s390/vdso-pie.c
@@ -0,0 +1,65 @@
+#include <unistd.h>
+
+#include "asm/types.h"
+
+#include <compel/plugins/std/string.h>
+#include <compel/plugins/std/syscall.h>
+#include "parasite-vdso.h"
+#include "log.h"
+#include "common/bug.h"
+
+#ifdef LOG_PREFIX
+# undef LOG_PREFIX
+#endif
+#define LOG_PREFIX "vdso: "
+
+/*
+ * Trampoline instruction sequence
+ */
+typedef struct {
+	u8	larl[6];	/* Load relative address of imm64 */
+	u8	lg[6];		/* Load %r1 with imm64 */
+	u8	br[2];		/* Branch to %r1 */
+	u64	addr;		/* Jump address */
+	u32	guards;		/* Guard bytes */
+} __packed jmp_t;
+
+/*
+ * Trampoline template: Use %r1 to jump
+ */
+jmp_t jmp = {
+	/* larl %r1,e (addr) */
+	.larl		= {0xc0, 0x10, 0x00, 0x00, 0x00, 0x07},
+	/* lg   %r1,0(%r1) */
+	.lg		= {0xe3, 0x10, 0x10, 0x00, 0x00, 0x04},
+	/* br   %r1 */
+	.br		= {0x07, 0xf1},
+	.guards		= 0xcccccccc,
+};
+
+/*
+ * Insert trampoline code into old vdso entry points to
+ * jump to new vdso functions.
+ */
+int vdso_redirect_calls(unsigned long base_to, unsigned long base_from,
+			struct vdso_symtable *to, struct vdso_symtable *from,
+			bool __always_unused compat_vdso)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(to->symbols); i++) {
+		if (vdso_symbol_empty(&from->symbols[i]))
+			continue;
+
+		pr_debug("jmp: %s: %lx/%lx -> %lx/%lx (index %d)\n",
+			 from->symbols[i].name, base_from,
+			 from->symbols[i].offset,
+			 base_to, to->symbols[i].offset, i);
+
+		jmp.addr = base_to + to->symbols[i].offset;
+		memcpy((void *)(base_from + from->symbols[i].offset), &jmp,
+		       sizeof(jmp));
+	}
+
+	return 0;
+}
-- 
2.7.4
