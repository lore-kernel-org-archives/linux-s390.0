Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] s390/crash: Fix KEXEC_NOTE_BYTES definition
Date: Fri,  9 Jun 2017 10:17:05 +0800
Message-Id: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: akpm@linux-foundation.org, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, Dave Anderson <anderson@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

S390 KEXEC_NOTE_BYTES is not used by note_buf_t as before, which
is now defined as follows:
    typedef u32 note_buf_t[CRASH_CORE_NOTE_BYTES/4];
It was changed by the CONFIG_CRASH_CORE feature.

This patch gets rid of all the old KEXEC_NOTE_BYTES stuff, and
renames KEXEC_NOTE_BYTES to CRASH_CORE_NOTE_BYTES for S390.

Fixes: 692f66f26a4c ("crash: move crashkernel parsing and vmcore related code under CONFIG_CRASH_CORE")
Cc: Dave Young <dyoung@redhat.com>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/s390/include/asm/kexec.h |  2 +-
 include/linux/crash_core.h    |  7 +++++++
 include/linux/kexec.h         | 11 +----------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 2f924bc..352deb8 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -47,7 +47,7 @@
  * Seven notes plus zero note at the end: prstatus, fpregset, timer,
  * tod_cmp, tod_reg, control regs, and prefix
  */
-#define KEXEC_NOTE_BYTES \
+#define CRASH_CORE_NOTE_BYTES \
 	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
 	 ALIGN(sizeof("CORE"), 4) * 7 + \
 	 ALIGN(sizeof(struct elf_prstatus), 4) + \
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index e9de6b4..dbc6e5c 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -10,9 +10,16 @@
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
 
+/*
+ * The per-cpu notes area is a list of notes terminated by a "NULL"
+ * note header.  For kdump, the code in vmcore.c runs in the context
+ * of the second kernel to combine them into one note.
+ */
+#ifndef CRASH_CORE_NOTE_BYTES
 #define CRASH_CORE_NOTE_BYTES	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
 				     CRASH_CORE_NOTE_NAME_BYTES +	\
 				     CRASH_CORE_NOTE_DESC_BYTES)
+#endif
 
 #define VMCOREINFO_BYTES	   PAGE_SIZE
 #define VMCOREINFO_NOTE_NAME	   "VMCOREINFO"
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3ea8275..133df03 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -14,7 +14,6 @@
 
 #if !defined(__ASSEMBLY__)
 
-#include <linux/crash_core.h>
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
@@ -25,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <asm/kexec.h>
+#include <linux/crash_core.h>
 
 /* Verify architecture specific macros are defined */
 
@@ -63,15 +63,6 @@
 #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
 
 /*
- * The per-cpu notes area is a list of notes terminated by a "NULL"
- * note header.  For kdump, the code in vmcore.c runs in the context
- * of the second kernel to combine them into one note.
- */
-#ifndef KEXEC_NOTE_BYTES
-#define KEXEC_NOTE_BYTES	CRASH_CORE_NOTE_BYTES
-#endif
-
-/*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
  */
-- 
1.8.3.1
