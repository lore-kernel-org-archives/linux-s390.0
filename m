Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] s390: mm: Audit and remove any unnecessary uses of module.h
Date: Thu, 9 Feb 2017 15:20:24 -0500
Message-ID: <20170209202025.8713-3-paul.gortmaker@windriver.com>
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
as well as an implict use of asm/elf.h header.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/mm/cmm.c             | 1 +
 arch/s390/mm/dump_pagetables.c | 1 -
 arch/s390/mm/extmem.c          | 2 +-
 arch/s390/mm/mem_detect.c      | 1 -
 arch/s390/mm/mmap.c            | 2 +-
 arch/s390/mm/pageattr.c        | 1 -
 arch/s390/mm/vmem.c            | 2 +-
 7 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 79ddd580d605..829c63dbc81a 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/sysctl.h>
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 5a46b1d7e578..145a0ccb5845 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -1,6 +1,5 @@
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 91af69f1dce5..9f118629b55f 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -14,7 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/bootmem.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
diff --git a/arch/s390/mm/mem_detect.c b/arch/s390/mm/mem_detect.c
index 185e70d3e153..e58dca05b962 100644
--- a/arch/s390/mm/mem_detect.c
+++ b/arch/s390/mm/mem_detect.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index eb9df2822da1..7ae1282d5be9 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -26,11 +26,11 @@
 #include <linux/personality.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/module.h>
 #include <linux/random.h>
 #include <linux/compat.h>
 #include <linux/security.h>
 #include <asm/pgalloc.h>
+#include <asm/elf.h>
 
 static unsigned long stack_maxrandom_size(void)
 {
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index a1543b74ee00..fc5dc33bb141 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -3,7 +3,6 @@
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
 #include <linux/hugetlb.h>
-#include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 #include <asm/facility.h>
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 253046344b3c..60d38993f232 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -6,7 +6,7 @@
 #include <linux/bootmem.h>
 #include <linux/pfn.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
-- 
2.11.0
