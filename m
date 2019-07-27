Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387557AbfG0Jp1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 27 Jul 2019 05:45:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6R9h9hZ074918
        for <linux-s390@vger.kernel.org>; Sat, 27 Jul 2019 05:45:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u0jtdj746-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 27 Jul 2019 05:45:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 27 Jul 2019 10:45:23 +0100
Date: Sat, 27 Jul 2019 11:45:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.3-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20190727094517.GA9501@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-3

for you to fetch changes up to 98abe0227827f45cddb21875b2ffa9aeca3848b3:

  MAINTAINERS: vfio-ccw: Remove myself as the maintainer (2019-07-26 13:36:26 +0200)

----------------------------------------------------------------
s390 updates for 5.3-rc2

 - Add ABI to kernel image file which allows e.g. the file utility to figure
   out the kernel version.

 - Wire up clone3 system call.

 - Add support for kasan bitops instrumentation.

 - uapi header cleanup: use __u{16,32,64} instead of uint{16,32,64}_t.

 - Provide proper ARCH_ZONE_DMA_BITS so the s390 DMA zone is correctly defined
   with 2 GB instead of the default value of 1 MB.

 - Farhan Ali leaves the group of vfio-ccw maintainers.

 - Various small vfio-ccw fixes.

 - Add missing locking for airq_areas array in virtio code.

 - Minor qdio improvements.

----------------------------------------------------------------
Christophe JAILLET (1):
      s390/hypfs: fix a typo in the name of a function

Cornelia Huck (1):
      Documentation: fix vfio-ccw doc

Farhan Ali (6):
      vfio-ccw: Fix misleading comment when setting orb.cmd.c64
      vfio-ccw: Fix memory leak and don't call cp_free in cp_init
      vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
      vfio-ccw: Don't call cp_free if we are processing a channel program
      vfio-ccw: Update documentation for csch/hsch
      MAINTAINERS: vfio-ccw: Remove myself as the maintainer

Halil Pasic (2):
      s390/dma: provide proper ARCH_ZONE_DMA_BITS value
      virtio/s390: fix race on airq_areas[]

Heiko Carstens (2):
      Merge tag 'vfio-ccw-20190717-2' of https://git.kernel.org/.../kvms390/vfio-ccw into fixes
      kbuild: enable arch/s390/include/uapi/asm/zcrypt.h for uapi header test

Julian Wiedmann (2):
      s390/qdio: add sanity checks to the fast-requeue path
      s390/qdio: restrict QAOB usage to IQD unicast queues

Masahiro Yamada (1):
      s390: use __u{16,32,64} instead of uint{16,32,64}_t in uapi header

Vasily Gorbik (5):
      s390: enable detection of kernel version from bzImage
      s390: wire up clone3 system call
      s390/bitops: make test functions return bool
      s390/kasan: add bitops instrumentation
      s390/mm: use shared variables for sysctl range check

 Documentation/s390/vfio-ccw.rst       | 31 +++++++++++++--
 MAINTAINERS                           |  1 -
 arch/s390/boot/Makefile               |  2 +-
 arch/s390/boot/boot.h                 |  1 +
 arch/s390/boot/head.S                 |  1 +
 arch/s390/boot/version.c              |  7 ++++
 arch/s390/hypfs/hypfs_vm.c            |  4 +-
 arch/s390/include/asm/bitops.h        | 73 +++++++++++++++++++----------------
 arch/s390/include/asm/page.h          |  2 +
 arch/s390/include/asm/setup.h         |  4 +-
 arch/s390/include/asm/unistd.h        |  1 +
 arch/s390/include/uapi/asm/zcrypt.h   | 35 +++++++++--------
 arch/s390/kernel/syscalls/syscall.tbl |  2 +-
 arch/s390/mm/pgalloc.c                |  6 +--
 drivers/s390/cio/qdio_main.c          | 24 ++++++------
 drivers/s390/cio/vfio_ccw_cp.c        | 28 ++++++++------
 drivers/s390/cio/vfio_ccw_drv.c       |  2 +-
 drivers/s390/virtio/virtio_ccw.c      |  4 ++
 usr/include/Makefile                  |  4 --
 19 files changed, 140 insertions(+), 92 deletions(-)
 create mode 100644 arch/s390/boot/version.c

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index 1e210c6..fca9c4f 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -180,6 +180,13 @@ The process of how these work together.
    add it to an iommu_group and a vfio_group. Then we could pass through
    the mdev to a guest.
 
+
+VFIO-CCW Regions
+----------------
+
+The vfio-ccw driver exposes MMIO regions to accept requests from and return
+results to userspace.
+
 vfio-ccw I/O region
 -------------------
 
@@ -205,6 +212,25 @@ irb_area stores the I/O result.
 
 ret_code stores a return code for each access of the region.
 
+This region is always available.
+
+vfio-ccw cmd region
+-------------------
+
+The vfio-ccw cmd region is used to accept asynchronous instructions
+from userspace::
+
+  #define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+  #define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+  struct ccw_cmd_region {
+         __u32 command;
+         __u32 ret_code;
+  } __packed;
+
+This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
+
+Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
+
 vfio-ccw operation details
 --------------------------
 
@@ -306,9 +332,8 @@ Together with the corresponding work in QEMU, we can bring the passed
 through DASD/ECKD device online in a guest now and use it as a block
 device.
 
-While the current code allows the guest to start channel programs via
-START SUBCHANNEL, support for HALT SUBCHANNEL or CLEAR SUBCHANNEL is
-not yet implemented.
+The current code allows the guest to start channel programs via
+START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
 
 vfio-ccw supports classic (command mode) channel I/O only. Transport
 mode (HPF) is not supported.
diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e..82d9e1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13947,7 +13947,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
 
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
-M:	Farhan Ali <alifm@linux.ibm.com>
 M:	Eric Farman <farman@linux.ibm.com>
 R:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 7cba96e..4cf0bdd 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -36,7 +36,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
 obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
-obj-y	+= ctype.o text_dma.o
+obj-y	+= version.o ctype.o text_dma.o
 obj-$(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)	+= uv.o
 obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
diff --git a/arch/s390/boot/boot.h b/arch/s390/boot/boot.h
index ad57c22..082905d 100644
--- a/arch/s390/boot/boot.h
+++ b/arch/s390/boot/boot.h
@@ -12,6 +12,7 @@ void print_missing_facilities(void);
 unsigned long get_random_base(unsigned long safe_addr);
 
 extern int kaslr_enabled;
+extern const char kernel_version[];
 
 unsigned long read_ipl_report(unsigned long safe_offset);
 
diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index 028aab0..2087bed 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -361,6 +361,7 @@ ENTRY(startup_kdump)
 	.quad	0			# INITRD_SIZE
 	.quad	0			# OLDMEM_BASE
 	.quad	0			# OLDMEM_SIZE
+	.quad	kernel_version		# points to kernel version string
 
 	.org	COMMAND_LINE
 	.byte	"root=/dev/ram0 ro"
diff --git a/arch/s390/boot/version.c b/arch/s390/boot/version.c
new file mode 100644
index 0000000..d32e58bd
--- /dev/null
+++ b/arch/s390/boot/version.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <generated/utsrelease.h>
+#include <generated/compile.h>
+#include "boot.h"
+
+const char kernel_version[] = UTS_RELEASE
+	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION;
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 42f2375..e1fcc03 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -118,7 +118,7 @@ do { \
 		return PTR_ERR(rc); \
 } while(0)
 
-static int hpyfs_vm_create_guest(struct dentry *systems_dir,
+static int hypfs_vm_create_guest(struct dentry *systems_dir,
 				 struct diag2fc_data *data)
 {
 	char guest_name[NAME_LEN + 1] = {};
@@ -219,7 +219,7 @@ int hypfs_vm_create_files(struct dentry *root)
 	}
 
 	for (i = 0; i < count; i++) {
-		rc = hpyfs_vm_create_guest(dir, &(data[i]));
+		rc = hypfs_vm_create_guest(dir, &(data[i]));
 		if (rc)
 			goto failed;
 	}
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 9900d655..b8833ac 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -35,6 +35,7 @@
 
 #include <linux/typecheck.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 #include <asm/atomic_ops.h>
 #include <asm/barrier.h>
 
@@ -55,7 +56,7 @@ __bitops_byte(unsigned long nr, volatile unsigned long *ptr)
 	return ((unsigned char *)ptr) + ((nr ^ (BITS_PER_LONG - 8)) >> 3);
 }
 
-static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch_set_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long mask;
@@ -76,7 +77,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
 	__atomic64_or(mask, (long *)addr);
 }
 
-static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch_clear_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long mask;
@@ -97,7 +98,8 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	__atomic64_and(mask, (long *)addr);
 }
 
-static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch_change_bit(unsigned long nr,
+				   volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long mask;
@@ -118,8 +120,8 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
 	__atomic64_xor(mask, (long *)addr);
 }
 
-static inline int
-test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch_test_and_set_bit(unsigned long nr,
+					 volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long old, mask;
@@ -129,8 +131,8 @@ test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (old & mask) != 0;
 }
 
-static inline int
-test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch_test_and_clear_bit(unsigned long nr,
+					   volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long old, mask;
@@ -140,8 +142,8 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (old & ~mask) != 0;
 }
 
-static inline int
-test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch_test_and_change_bit(unsigned long nr,
+					    volatile unsigned long *ptr)
 {
 	unsigned long *addr = __bitops_word(nr, ptr);
 	unsigned long old, mask;
@@ -151,30 +153,31 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (old & mask) != 0;
 }
 
-static inline void __set_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch___set_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 
 	*addr |= 1 << (nr & 7);
 }
 
-static inline void 
-__clear_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch___clear_bit(unsigned long nr,
+				    volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 
 	*addr &= ~(1 << (nr & 7));
 }
 
-static inline void __change_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline void arch___change_bit(unsigned long nr,
+				     volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 
 	*addr ^= 1 << (nr & 7);
 }
 
-static inline int
-__test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch___test_and_set_bit(unsigned long nr,
+					   volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 	unsigned char ch;
@@ -184,8 +187,8 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (ch >> (nr & 7)) & 1;
 }
 
-static inline int
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch___test_and_clear_bit(unsigned long nr,
+					     volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 	unsigned char ch;
@@ -195,8 +198,8 @@ __test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (ch >> (nr & 7)) & 1;
 }
 
-static inline int
-__test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline bool arch___test_and_change_bit(unsigned long nr,
+					      volatile unsigned long *ptr)
 {
 	unsigned char *addr = __bitops_byte(nr, ptr);
 	unsigned char ch;
@@ -206,7 +209,8 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
 	return (ch >> (nr & 7)) & 1;
 }
 
-static inline int test_bit(unsigned long nr, const volatile unsigned long *ptr)
+static inline bool arch_test_bit(unsigned long nr,
+				 const volatile unsigned long *ptr)
 {
 	const volatile unsigned char *addr;
 
@@ -215,28 +219,30 @@ static inline int test_bit(unsigned long nr, const volatile unsigned long *ptr)
 	return (*addr >> (nr & 7)) & 1;
 }
 
-static inline int test_and_set_bit_lock(unsigned long nr,
-					volatile unsigned long *ptr)
+static inline bool arch_test_and_set_bit_lock(unsigned long nr,
+					      volatile unsigned long *ptr)
 {
-	if (test_bit(nr, ptr))
+	if (arch_test_bit(nr, ptr))
 		return 1;
-	return test_and_set_bit(nr, ptr);
+	return arch_test_and_set_bit(nr, ptr);
 }
 
-static inline void clear_bit_unlock(unsigned long nr,
-				    volatile unsigned long *ptr)
+static inline void arch_clear_bit_unlock(unsigned long nr,
+					 volatile unsigned long *ptr)
 {
 	smp_mb__before_atomic();
-	clear_bit(nr, ptr);
+	arch_clear_bit(nr, ptr);
 }
 
-static inline void __clear_bit_unlock(unsigned long nr,
-				      volatile unsigned long *ptr)
+static inline void arch___clear_bit_unlock(unsigned long nr,
+					   volatile unsigned long *ptr)
 {
 	smp_mb();
-	__clear_bit(nr, ptr);
+	arch___clear_bit(nr, ptr);
 }
 
+#include <asm-generic/bitops-instrumented.h>
+
 /*
  * Functions which use MSB0 bit numbering.
  * The bits are numbered:
@@ -261,7 +267,8 @@ static inline void clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
 	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
 }
 
-static inline int test_and_clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
+static inline bool test_and_clear_bit_inv(unsigned long nr,
+					  volatile unsigned long *ptr)
 {
 	return test_and_clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
 }
@@ -276,8 +283,8 @@ static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr
 	return __clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
 }
 
-static inline int test_bit_inv(unsigned long nr,
-			       const volatile unsigned long *ptr)
+static inline bool test_bit_inv(unsigned long nr,
+				const volatile unsigned long *ptr)
 {
 	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
 }
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index a4d3809..823578c 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -177,6 +177,8 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define ARCH_ZONE_DMA_BITS	31
+
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 82deb8f..c5cfff7 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -54,6 +54,7 @@
 #define INITRD_SIZE_OFFSET	0x10410
 #define OLDMEM_BASE_OFFSET	0x10418
 #define OLDMEM_SIZE_OFFSET	0x10420
+#define KERNEL_VERSION_OFFSET	0x10428
 #define COMMAND_LINE_OFFSET	0x10480
 
 #ifndef __ASSEMBLY__
@@ -74,7 +75,8 @@ struct parmarea {
 	unsigned long initrd_size;			/* 0x10410 */
 	unsigned long oldmem_base;			/* 0x10418 */
 	unsigned long oldmem_size;			/* 0x10420 */
-	char pad1[0x10480 - 0x10428];			/* 0x10428 - 0x10480 */
+	unsigned long kernel_version;			/* 0x10428 */
+	char pad1[0x10480 - 0x10430];			/* 0x10430 - 0x10480 */
 	char command_line[ARCH_COMMAND_LINE_SIZE];	/* 0x10480 */
 };
 
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index b675568..9e9f75e 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -34,5 +34,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_S390_UNISTD_H_ */
diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 494c34c..8c5755f 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -20,6 +20,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /* Name of the zcrypt device driver. */
 #define ZCRYPT_NAME "zcrypt"
@@ -160,17 +161,17 @@ struct ica_xcRB {
  * @payload_len:	Payload length
  */
 struct ep11_cprb {
-	uint16_t	cprb_len;
+	__u16		cprb_len;
 	unsigned char	cprb_ver_id;
 	unsigned char	pad_000[2];
 	unsigned char	flags;
 	unsigned char	func_id[2];
-	uint32_t	source_id;
-	uint32_t	target_id;
-	uint32_t	ret_code;
-	uint32_t	reserved1;
-	uint32_t	reserved2;
-	uint32_t	payload_len;
+	__u32		source_id;
+	__u32		target_id;
+	__u32		ret_code;
+	__u32		reserved1;
+	__u32		reserved2;
+	__u32		payload_len;
 } __attribute__((packed));
 
 /**
@@ -179,8 +180,8 @@ struct ep11_cprb {
  * @dom_id:	Usage domain id
  */
 struct ep11_target_dev {
-	uint16_t ap_id;
-	uint16_t dom_id;
+	__u16 ap_id;
+	__u16 dom_id;
 };
 
 /**
@@ -195,14 +196,14 @@ struct ep11_target_dev {
  * @resp:		Addr to response block
  */
 struct ep11_urb {
-	uint16_t		targets_num;
-	uint64_t		targets;
-	uint64_t		weight;
-	uint64_t		req_no;
-	uint64_t		req_len;
-	uint64_t		req;
-	uint64_t		resp_len;
-	uint64_t		resp;
+	__u16		targets_num;
+	__u64		targets;
+	__u64		weight;
+	__u64		req_no;
+	__u64		req_len;
+	__u64		req;
+	__u64		resp_len;
+	__u64		resp;
 } __attribute__((packed));
 
 /**
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a90d3e9..3054e9c0 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -437,4 +437,4 @@
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
-# 435 reserved for clone3
+435  common	clone3			sys_clone3			sys_clone3
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 99e0621..54fcdf6 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -17,8 +17,6 @@
 
 #ifdef CONFIG_PGSTE
 
-static int page_table_allocate_pgste_min = 0;
-static int page_table_allocate_pgste_max = 1;
 int page_table_allocate_pgste = 0;
 EXPORT_SYMBOL(page_table_allocate_pgste);
 
@@ -29,8 +27,8 @@ static struct ctl_table page_table_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &page_table_allocate_pgste_min,
-		.extra2		= &page_table_allocate_pgste_max,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{ }
 };
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 730c4e6..4142c85 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -319,9 +319,7 @@ static int qdio_siga_output(struct qdio_q *q, unsigned int *busy_bit,
 	int retries = 0, cc;
 	unsigned long laob = 0;
 
-	WARN_ON_ONCE(aob && ((queue_type(q) != QDIO_IQDIO_QFMT) ||
-			     !q->u.out.use_cq));
-	if (q->u.out.use_cq && aob != 0) {
+	if (aob) {
 		fc = QDIO_SIGA_WRITEQ;
 		laob = aob;
 	}
@@ -621,9 +619,6 @@ static inline unsigned long qdio_aob_for_buffer(struct qdio_output_q *q,
 {
 	unsigned long phys_aob = 0;
 
-	if (!q->use_cq)
-		return 0;
-
 	if (!q->aobs[bufnr]) {
 		struct qaob *aob = qdio_allocate_aob();
 		q->aobs[bufnr] = aob;
@@ -1308,6 +1303,8 @@ static void qdio_detect_hsicq(struct qdio_irq *irq_ptr)
 
 	for_each_output_queue(irq_ptr, q, i) {
 		if (use_cq) {
+			if (multicast_outbound(q))
+				continue;
 			if (qdio_enable_async_operation(&q->u.out) < 0) {
 				use_cq = 0;
 				continue;
@@ -1553,18 +1550,19 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 		/* One SIGA-W per buffer required for unicast HSI */
 		WARN_ON_ONCE(count > 1 && !multicast_outbound(q));
 
-		phys_aob = qdio_aob_for_buffer(&q->u.out, bufnr);
+		if (q->u.out.use_cq)
+			phys_aob = qdio_aob_for_buffer(&q->u.out, bufnr);
 
 		rc = qdio_kick_outbound_q(q, phys_aob);
 	} else if (need_siga_sync(q)) {
 		rc = qdio_siga_sync_q(q);
+	} else if (count < QDIO_MAX_BUFFERS_PER_Q &&
+		   get_buf_state(q, prev_buf(bufnr), &state, 0) > 0 &&
+		   state == SLSB_CU_OUTPUT_PRIMED) {
+		/* The previous buffer is not processed yet, tack on. */
+		qperf_inc(q, fast_requeue);
 	} else {
-		/* try to fast requeue buffers */
-		get_buf_state(q, prev_buf(bufnr), &state, 0);
-		if (state != SLSB_CU_OUTPUT_PRIMED)
-			rc = qdio_kick_outbound_q(q, 0);
-		else
-			qperf_inc(q, fast_requeue);
+		rc = qdio_kick_outbound_q(q, 0);
 	}
 
 	/* in case of SIGA errors we must process the error immediately */
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 1d4c893..3645d17 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -72,8 +72,10 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
 				  sizeof(*pa->pa_iova_pfn) +
 				  sizeof(*pa->pa_pfn),
 				  GFP_KERNEL);
-	if (unlikely(!pa->pa_iova_pfn))
+	if (unlikely(!pa->pa_iova_pfn)) {
+		pa->pa_nr = 0;
 		return -ENOMEM;
+	}
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
 	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
@@ -421,7 +423,7 @@ static int ccwchain_loop_tic(struct ccwchain *chain,
 static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 {
 	struct ccwchain *chain;
-	int len;
+	int len, ret;
 
 	/* Copy 2K (the most we support today) of possible CCWs */
 	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
@@ -448,7 +450,12 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	memcpy(chain->ch_ccw, cp->guest_cp, len * sizeof(struct ccw1));
 
 	/* Loop for tics on this new chain. */
-	return ccwchain_loop_tic(chain, cp);
+	ret = ccwchain_loop_tic(chain, cp);
+
+	if (ret)
+		ccwchain_free(chain);
+
+	return ret;
 }
 
 /* Loop for TICs. */
@@ -642,17 +649,16 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 
 	/* Build a ccwchain for the first CCW segment */
 	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
-	if (ret)
-		cp_free(cp);
-
-	/* It is safe to force: if not set but idals used
-	 * ccwchain_calc_length returns an error.
-	 */
-	cp->orb.cmd.c64 = 1;
 
-	if (!ret)
+	if (!ret) {
 		cp->initialized = true;
 
+		/* It is safe to force: if it was not set but idals used
+		 * ccwchain_calc_length would have returned an error.
+		 */
+		cp->orb.cmd.c64 = 1;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 2b90a5e..9208c0e 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -88,7 +88,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final)
+		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
 			cp_free(&private->cp);
 	}
 	mutex_lock(&private->io_mutex);
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1a55e59..957889a 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -145,6 +145,8 @@ struct airq_info {
 	struct airq_iv *aiv;
 };
 static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
+static DEFINE_MUTEX(airq_areas_lock);
+
 static u8 *summary_indicators;
 
 static inline u8 *get_summary_indicator(struct airq_info *info)
@@ -265,9 +267,11 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 	unsigned long bit, flags;
 
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
+		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
 			airq_areas[i] = new_airq_info(i);
 		info = airq_areas[i];
+		mutex_unlock(&airq_areas_lock);
 		if (!info)
 			return 0;
 		write_lock_irqsave(&info->lock, flags);
diff --git a/usr/include/Makefile b/usr/include/Makefile
index aa316d9..1fb6abe 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -101,10 +101,6 @@ ifeq ($(SRCARCH),riscv)
 header-test- += linux/bpf_perf_event.h
 endif
 
-ifeq ($(SRCARCH),s390)
-header-test- += asm/zcrypt.h
-endif
-
 ifeq ($(SRCARCH),sparc)
 header-test- += asm/stat.h
 header-test- += asm/uctx.h
