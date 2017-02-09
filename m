Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] s390: Audit and remove any remaining unnecessary uses of module.h
Date: Thu, 9 Feb 2017 15:20:25 -0500
Message-ID: <20170209202025.8713-4-paul.gortmaker@windriver.com>
In-Reply-To: <20170209202025.8713-1-paul.gortmaker@windriver.com>
References: <20170209202025.8713-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.

This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.  The advantage
in doing so is that module.h itself sources about 15 other headers;
adding significantly to what we feed cpp, and it can obscure what
headers we are effectively using.

Since module.h was the source for init.h (for __init) and for
export.h (for EXPORT_SYMBOL) we consider each change instance
for the presence of either and replace as needed.  An instance
where module_param was used without moduleparam.h was also fixed,
as well as implicit use of ptrace.h and string.h headers.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/include/asm/livepatch.h | 2 +-
 arch/s390/kvm/kvm-s390.c          | 1 +
 arch/s390/lib/delay.c             | 2 +-
 arch/s390/lib/spinlock.c          | 2 +-
 arch/s390/lib/string.c            | 3 ++-
 arch/s390/lib/xor.c               | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index 2c1213785892..6de5c6cb0061 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -17,7 +17,7 @@
 #ifndef ASM_LIVEPATCH_H
 #define ASM_LIVEPATCH_H
 
-#include <linux/module.h>
+#include <asm/ptrace.h>
 
 static inline int klp_check_compiler_support(void)
 {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 502de74ea984..7ec5d86ca61a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -23,6 +23,7 @@
 #include <linux/kvm_host.h>
 #include <linux/mman.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 501dcd4ca4a0..92e90e40b6fb 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -9,7 +9,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/timex.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/irqflags.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e48a48ec24bc..03462326ca3e 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/smp.h>
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index f71d9f655970..4ee27339c792 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -9,7 +9,8 @@
 #define IN_ARCH_STRING_C 1
 
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/export.h>
 
 /*
  * Helper functions to find the end of a string
diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index 7d94e3ec34a9..b4fd05c36151 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/raid/xor.h>
 
 static void xor_xc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
-- 
2.11.0
