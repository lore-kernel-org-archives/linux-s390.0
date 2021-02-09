Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10634 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhBINvd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:33 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 5/8] s390x: Provide preliminary backtrace support
Date: Tue,  9 Feb 2021 08:49:22 -0500
Message-Id: <20210209134925.22248-6-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

After the stack changes we can finally use -mbackchain and have a
working backtrace.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/interrupt.c | 12 ++++++++++++
 lib/s390x/stack.c     | 20 ++++++++++++++------
 s390x/Makefile        |  1 +
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 94a2cf9c..49f98759 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -115,6 +115,18 @@ static void fixup_pgm_int(struct stack_frame_int *stack)
 	/* suppressed/terminated/completed point already at the next address */
 }
 
+static void print_pgm_info(struct stack_frame_int *stack)
+
+{
+	printf("\n");
+	printf("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
+	       lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
+	       lc->pgm_int_id);
+	dump_stack();
+	report_summary();
+	abort();
+}
+
 void handle_pgm_int(struct stack_frame_int *stack)
 {
 	if (!pgm_int_expected) {
diff --git a/lib/s390x/stack.c b/lib/s390x/stack.c
index 0fcd1afb..4cf80dae 100644
--- a/lib/s390x/stack.c
+++ b/lib/s390x/stack.c
@@ -3,24 +3,32 @@
  * s390x stack implementation
  *
  * Copyright (c) 2017 Red Hat Inc
+ * Copyright 2021 IBM Corp
  *
  * Authors:
  *  Thomas Huth <thuth@redhat.com>
  *  David Hildenbrand <david@redhat.com>
+ *  Janosch Frank <frankja@de.ibm.com>
  */
 #include <libcflat.h>
 #include <stack.h>
+#include <asm/arch_def.h>
 
 int backtrace_frame(const void *frame, const void **return_addrs, int max_depth)
 {
-	printf("TODO: Implement backtrace_frame(%p, %p, %d) function!\n",
-	       frame, return_addrs, max_depth);
-	return 0;
+	int depth = 0;
+	struct stack_frame *stack = (struct stack_frame *)frame;
+
+	for (depth = 0; stack && depth < max_depth; depth++) {
+		return_addrs[depth] = (void *)stack->grs[8];
+		stack = stack->back_chain;
+	}
+
+	return depth;
 }
 
 int backtrace(const void **return_addrs, int max_depth)
 {
-	printf("TODO: Implement backtrace(%p, %d) function!\n",
-	       return_addrs, max_depth);
-	return 0;
+	return backtrace_frame(__builtin_frame_address(0),
+			       return_addrs, max_depth);
 }
diff --git a/s390x/Makefile b/s390x/Makefile
index f3b0fccf..20bb5683 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -39,6 +39,7 @@ CFLAGS += -ffreestanding
 CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
 CFLAGS += -O2
 CFLAGS += -march=zEC12
+CFLAGS += -mbackchain
 CFLAGS += -fno-delete-null-pointer-checks
 LDFLAGS += -nostdlib -Wl,--build-id=none
 
-- 
2.25.1
