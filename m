Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110727125807.529303146@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:05 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-control-limit.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
the kdump kexec case. Therefore this patch introduces a new macro
KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
KEXEC_CRASH_CONTROL_MEMORY_LIMIT.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/linux/kexec.h |    4 ++++
 kernel/kexec.c        |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,10 @@
 #error KEXEC_ARCH not defined
 #endif
 
+#ifndef KEXEC_CRASH_CONTROL_MEMORY_LIMIT
+#define KEXEC_CRASH_CONTROL_MEMORY_LIMIT KEXEC_CONTROL_MEMORY_LIMIT
+#endif
+
 #define KEXEC_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define KEXEC_CORE_NOTE_NAME "CORE"
 #define KEXEC_CORE_NOTE_NAME_BYTES ALIGN(sizeof(KEXEC_CORE_NOTE_NAME), 4)
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -498,7 +498,7 @@ static struct page *kimage_alloc_crash_c
 	while (hole_end <= crashk_res.end) {
 		unsigned long i;
 
-		if (hole_end > KEXEC_CONTROL_MEMORY_LIMIT)
+		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
 			break;
 		if (hole_end > crashk_res.end)
 			break;
