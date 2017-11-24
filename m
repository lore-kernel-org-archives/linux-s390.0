Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/12] s390: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:38 +0100
Message-Id: <20171124140043.10062-8-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the remaining arch/s390/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Makefile                | 1 +
 arch/s390/boot/install.sh         | 1 +
 arch/s390/hypfs/inode.c           | 1 +
 arch/s390/include/asm/cpu_mf.h    | 1 +
 arch/s390/include/asm/kprobes.h   | 1 +
 arch/s390/include/asm/kvm_host.h  | 1 +
 arch/s390/include/asm/kvm_para.h  | 1 +
 arch/s390/include/asm/livepatch.h | 1 +
 arch/s390/include/asm/syscall.h   | 1 +
 arch/s390/include/asm/sysinfo.h   | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 6b3f41985f28..ffd95861f9ac 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # s390/Makefile
 #
diff --git a/arch/s390/boot/install.sh b/arch/s390/boot/install.sh
index aed3069699bd..32a9367b9bf0 100644
--- a/arch/s390/boot/install.sh
+++ b/arch/s390/boot/install.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 #
 # arch/s390x/boot/install.sh
 #
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index cf8a2d92467f..05d62cdb78b5 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  *    Hypervisor filesystem for Linux on s390.
  *
diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index 792cda339af1..a9ba5e322bf3 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * CPU-measurement facilities
  *
diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 921391f2341e..396b065ebb2c 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifndef _ASM_S390_KPROBES_H
 #define _ASM_S390_KPROBES_H
 /*
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f3a9b5a445b6..66efb2979351 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * definition for kernel virtual machines on s390
  *
diff --git a/arch/s390/include/asm/kvm_para.h b/arch/s390/include/asm/kvm_para.h
index 41393052ac57..2c623bf5c095 100644
--- a/arch/s390/include/asm/kvm_para.h
+++ b/arch/s390/include/asm/kvm_para.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * definition for paravirtual devices on s390
  *
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index 6de5c6cb0061..d1f97fafcc20 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * livepatch.h - s390-specific Kernel Live Patching Core
  *
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 6bc941be6921..4d6463eb7a2d 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Access to user system call parameters and results
  *
diff --git a/arch/s390/include/asm/sysinfo.h b/arch/s390/include/asm/sysinfo.h
index a702cb9d4269..c2137e7d9310 100644
--- a/arch/s390/include/asm/sysinfo.h
+++ b/arch/s390/include/asm/sysinfo.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * definition for store system information stsi
  *
-- 
2.15.0
