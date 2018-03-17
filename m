From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] s390: Use asm/compat.h instead of linux/compat.h
Date: Sat, 17 Mar 2018 16:09:57 -0700
Message-ID: <20180317230957.12174-1-deepa.kernel@gmail.com>
References: <CAK8P3a3Vf-ubqgdH67HE6LEfR=Vg6ZCf6+77qE+ZrwUocLCWTQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3Vf-ubqgdH67HE6LEfR=Vg6ZCf6+77qE+ZrwUocLCWTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Cc: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Include asm/compat.h directly for uses of compat_ptr.
This includes the compat defines when CONFIG_COMPAT is
not on.

Also make compat data structure definitions conditional on
CONFIG_COMPAT, to remove circular include dependencies in
elf.h

Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 arch/s390/hypfs/hypfs_sprp.c      | 1 +
 arch/s390/include/asm/compat.h    | 1 +
 arch/s390/include/asm/elf.h       | 2 ++
 arch/s390/kvm/priv.c              | 2 +-
 arch/s390/pci/pci_clp.c           | 1 +
 drivers/s390/block/dasd_ioctl.c   | 2 +-
 drivers/s390/char/fs3270.c        | 2 +-
 drivers/s390/char/sclp_ctl.c      | 1 +
 drivers/s390/char/vmcp.c          | 1 +
 drivers/s390/cio/chsc_sch.c       | 2 +-
 drivers/s390/net/qeth_core_main.c | 2 +-
 11 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index 5d85a039391c..d800b8067042 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -7,6 +7,7 @@
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
+#include <asm/compat.h>
 #include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 501aaff85304..1832d98c9328 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -4,6 +4,7 @@
 /*
  * Architecture specific compatibility types
  */
+#include <linux/compat_time.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 7d22a474a040..e572ae613b19 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -134,8 +134,10 @@
 typedef s390_fp_regs elf_fpregset_t;
 typedef s390_regs elf_gregset_t;
 
+#ifdef CONFIG_COMPAT
 typedef s390_fp_regs compat_elf_fpregset_t;
 typedef s390_compat_regs compat_elf_gregset_t;
+#endif
 
 #include <linux/sched/mm.h>	/* for task_struct */
 #include <asm/mmu_context.h>
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a3bce0e84346..b7e6d81547bd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -11,7 +11,7 @@
 #include <linux/kvm.h>
 #include <linux/gfp.h>
 #include <linux/errno.h>
-#include <linux/compat.h>
+#include <asm/compat.h>
 #include <linux/mm_types.h>
 
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 19b2d2a9b43d..4b6fe97823b7 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -9,6 +9,7 @@
 #define KMSG_COMPONENT "zpci"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <asm/compat.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 2016e0ed5865..288fa9d4d105 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -13,7 +13,7 @@
 #define KMSG_COMPONENT "dasd"
 
 #include <linux/interrupt.h>
-#include <linux/compat.h>
+#include <asm/compat.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/blkpg.h>
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 16a4e8528bbc..cf4a26c6f76d 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -12,7 +12,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/compat.h>
+#include <asm/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/module.h>
 #include <linux/list.h>
diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index 248b5db3eaa8..bd0d9e5cabd7 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -7,6 +7,7 @@
  * Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
  */
 
+#include <asm/compat.h>
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 948ce82a7725..0a153741ea88 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -14,6 +14,7 @@
 
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <asm/compat.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 8d9f36625ba5..3a541e694cb1 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/slab.h>
-#include <linux/compat.h>
+#include <asm/compat.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d3529ef6e0f7..adde6b30bad6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -10,7 +10,7 @@
 #define KMSG_COMPONENT "qeth"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <linux/compat.h>
+#include <asm/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
-- 
2.14.1
