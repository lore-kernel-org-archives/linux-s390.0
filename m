From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 09/14] s390: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:42 -0400
Message-ID: <20160725034247.109173-10-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

The additions of uaccess.h are to deal with implict includes like:

arch/s390/kernel/traps.c: In function 'do_report_trap':
arch/s390/kernel/traps.c:56:4: error: implicit declaration of function 'extable_fixup' [-Werror=implicit-function-declaration]
arch/s390/kernel/traps.c: In function 'illegal_op':
arch/s390/kernel/traps.c:173:3: error: implicit declaration of function 'get_user' [-Werror=implicit-function-declaration]

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/kernel/early.c   | 2 +-
 arch/s390/kernel/kprobes.c | 2 ++
 arch/s390/kernel/traps.c   | 3 ++-
 arch/s390/mm/fault.c       | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 717b03aa16b5..2374c5b46bbc 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -13,7 +13,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/lockdep.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/pfn.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 250f5972536a..4871c7c3ccde 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -26,12 +26,14 @@
 #include <linux/stop_machine.h>
 #include <linux/kdebug.h>
 #include <linux/uaccess.h>
+#include <linux/extable.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/hardirq.h>
 #include <linux/ftrace.h>
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
+#include <asm/uaccess.h>
 #include <asm/dis.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index dd97a3e8a34a..d0539f76fd24 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -14,11 +14,12 @@
  */
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <asm/uaccess.h>
 #include <asm/fpu/api.h>
 #include "entry.h"
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a58bca62a93b..cca73881e672 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -24,7 +24,7 @@
 #include <linux/kdebug.h>
 #include <linux/init.h>
 #include <linux/console.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/hardirq.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
-- 
2.8.4
