From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] s390/sthyi: add s390_sthyi system call
Date: Fri, 10 Nov 2017 09:00:07 +0100
Message-ID: <20171110080013.111004-4-borntraeger@de.ibm.com>
References: <20171110080013.111004-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171110080013.111004-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

Add a syscall of s390_sthyi to implement STHYI instruction in LPAR
which reuses the implementation for KVM by Janosch Frank -
commit 95ca2cb57985 ("KVM: s390: Add sthyi emulation").

STHYI(Store Hypervisor Information) is an emulated z/VM instruction that
provides a guest with basic information about the layers it is running
on. This includes information about the cpu configuration of both the
machine and the lpar, as well as their names, machine model and
machine type. This information enables an application to determine the
maximum capacity of CPs and IFLs available to software.

For the arguments of s390_sthyi, code shall be 0 and flags is reserved for
future use, info is the output argument to store the required hypervisor
info.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/uapi/asm/sthyi.h  |  6 ++++++
 arch/s390/include/uapi/asm/unistd.h |  3 ++-
 arch/s390/kernel/compat_wrapper.c   |  1 +
 arch/s390/kernel/entry.h            |  1 +
 arch/s390/kernel/sthyi.c            | 33 ++++++++++++++++++++++++++++++++-
 arch/s390/kernel/syscalls.S         |  1 +
 6 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/sthyi.h

diff --git a/arch/s390/include/uapi/asm/sthyi.h b/arch/s390/include/uapi/asm/sthyi.h
new file mode 100644
index 0000000..ec113db
--- /dev/null
+++ b/arch/s390/include/uapi/asm/sthyi.h
@@ -0,0 +1,6 @@
+#ifndef _UAPI_ASM_STHYI_H
+#define _UAPI_ASM_STHYI_H
+
+#define STHYI_FC_CP_IFL_CAP	0
+
+#endif /* _UAPI_ASM_STHYI_H */
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index ea42290..61c64f5 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -315,7 +315,8 @@
 #define __NR_pwritev2		377
 #define __NR_s390_guarded_storage	378
 #define __NR_statx		379
-#define NR_syscalls 380
+#define __NR_s390_sthyi		380
+#define NR_syscalls 381
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 986642a..eb0b17e 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -180,3 +180,4 @@ COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
 COMPAT_SYSCALL_WRAP6(copy_file_range, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
 COMPAT_SYSCALL_WRAP2(s390_guarded_storage, int, command, struct gs_cb *, gs_cb);
 COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
+COMPAT_SYSCALL_WRAP4(s390_sthyi, unsigned long, code, void __user *, info, u64 __user *, rc, unsigned long, flags);
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index dbf5f7e..bb5301e 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -77,6 +77,7 @@ long sys_s390_runtime_instr(int command, int signum);
 long sys_s390_guarded_storage(int command, struct gs_cb __user *);
 long sys_s390_pci_mmio_write(unsigned long, const void __user *, size_t);
 long sys_s390_pci_mmio_read(unsigned long, void __user *, size_t);
+long sys_s390_sthyi(unsigned long function_code, void __user *buffer, u64 __user *return_code, unsigned long flags);
 
 DECLARE_PER_CPU(u64, mt_cycles[8]);
 
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 27e3c3d..12981e1 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -11,13 +11,16 @@
 #include <linux/errno.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
-
+#include <linux/syscalls.h>
+#include <linux/mutex.h>
 #include <asm/asm-offsets.h>
 #include <asm/sclp.h>
 #include <asm/diag.h>
 #include <asm/sysinfo.h>
 #include <asm/ebcdic.h>
 #include <asm/facility.h>
+#include <asm/sthyi.h>
+#include "entry.h"
 
 #define DED_WEIGHT 0xffff
 /*
@@ -484,3 +487,31 @@ int sthyi_fill(void *dst, u64 *rc)
 	return r;
 }
 EXPORT_SYMBOL_GPL(sthyi_fill);
+
+SYSCALL_DEFINE4(s390_sthyi, unsigned long, function_code, void __user *, buffer,
+		u64 __user *, return_code, unsigned long, flags)
+{
+	u64 sthyi_rc;
+	void *info;
+	int r;
+
+	if (flags)
+		return -EINVAL;
+	if (function_code != STHYI_FC_CP_IFL_CAP)
+		return -EOPNOTSUPP;
+	info = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	r = sthyi_fill(info, &sthyi_rc);
+	if (r < 0)
+		goto out;
+	if (return_code && put_user(sthyi_rc, return_code)) {
+		r = -EFAULT;
+		goto out;
+	}
+	if (copy_to_user(buffer, info, PAGE_SIZE))
+		r = -EFAULT;
+out:
+	free_page((unsigned long)info);
+	return r;
+}
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 54fce7b..0fb407e 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -388,3 +388,4 @@ SYSCALL(sys_preadv2,compat_sys_preadv2)
 SYSCALL(sys_pwritev2,compat_sys_pwritev2)
 SYSCALL(sys_s390_guarded_storage,compat_sys_s390_guarded_storage) /* 378 */
 SYSCALL(sys_statx,compat_sys_statx)
+SYSCALL(sys_s390_sthyi,compat_sys_s390_sthyi)
-- 
2.9.4
