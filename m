From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Date: Tue, 04 Mar 2014 23:15:40 +0000
Subject: [tip:irq/core] s390: Do not rely on magic indirect includes
Message-Id: <tip-257ceab7456bd2a2657fd1c689384cabc95e3d30@git.kernel.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit-ID:  257ceab7456bd2a2657fd1c689384cabc95e3d30
Gitweb:     http://git.kernel.org/tip/257ceab7456bd2a2657fd1c689384cabc95e3d30
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 4 Mar 2014 23:57:29 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 4 Mar 2014 23:57:29 +0100

s390: Do not rely on magic indirect includes

commit: 8f945a33 (genirq: Move kstat_incr_irqs_this_cpu() to core)
unearthed the following:

   arch/s390/kernel/irq.c: In function 'init_IRQ':
>> arch/s390/kernel/irq.c:93:2: error: implicit declaration of function 'irq_reserve_irqs'
[-Werror=implicit-function-declaration]
....
   cc1: some warnings being treated as errors
--
   drivers/s390/cio/cio.c: In function 'init_cio_interrupts':
>> drivers/s390/cio/cio.c:594:2: error: implicit declaration of function
'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
[-Werror=implicit-function-declaration]
....
   cc1: some warnings being treated as errors

The reason is that those files require linux/irq.h and magically
pulled that in via linux/kernel_stat.h

The commit above got rid of the pointless include of linux/irq.h in
linux/kernel_stat.h and therefor broke the build.

Include linux/irq.h

Reported-by: fengguang.wu@intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: s390 <linux-s390@vger.kernel.org>
---
 arch/s390/kernel/irq.c | 1 +
 drivers/s390/cio/cio.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index bb27a26..a770be9 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/cputime.h>
 #include <asm/lowcore.h>
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index f711f0b..5829ddc 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
