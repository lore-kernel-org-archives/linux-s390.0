Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231837AbhBINvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:31 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 3/8] RFC: s390x: Define STACK_FRAME_INT_SIZE macro
Date: Tue,  9 Feb 2021 08:49:20 -0500
Message-Id: <20210209134925.22248-4-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

Using sizeof is safer than using magic constants. However, it doesn't
really fit into asm-offsets.h as it's not an offset so I'm happy to
receive suggestions on where to put it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm-offsets.c | 1 +
 s390x/macros.S          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
index a8942395..8eeb6dea 100644
--- a/lib/s390x/asm-offsets.c
+++ b/lib/s390x/asm-offsets.c
@@ -86,6 +86,7 @@ int main(void)
 	OFFSET(STACK_FRAME_INT_CR0, stack_frame_int, cr0);
 	OFFSET(STACK_FRAME_INT_GRS0, stack_frame_int, grs0);
 	OFFSET(STACK_FRAME_INT_GRS1, stack_frame_int, grs1);
+	DEFINE(STACK_FRAME_INT_SIZE, sizeof(struct stack_frame_int));
 
 	return 0;
 }
diff --git a/s390x/macros.S b/s390x/macros.S
index 1c8a0f7c..9810d2ff 100644
--- a/s390x/macros.S
+++ b/s390x/macros.S
@@ -43,14 +43,14 @@
 /* Save registers on the stack (r15), so we can have stacked interrupts. */
 	.macro SAVE_REGS_STACK
 	/* Allocate a full stack frame */
-	slgfi   %r15, 32 * 8 + 4 * 8
+	slgfi   %r15, STACK_FRAME_INT_SIZE
 	/* Store registers r0 to r14 on the stack */
 	stmg    %r2, %r15, STACK_FRAME_INT_GRS0(%r15)
 	stg     %r0, STACK_FRAME_INT_GRS1(%r15)
 	stg     %r1, STACK_FRAME_INT_GRS1 + 8(%r15)
 	/* Store the gr15 value before we allocated the new stack */
 	lgr     %r0, %r15
-	algfi   %r0, 32 * 8 + 4 * 8
+	algfi   %r0, STACK_FRAME_INT_SIZE
 	stg     %r0, 13 * 8 + STACK_FRAME_INT_GRS0(%r15)
 	stg     %r0, STACK_FRAME_INT_BACKCHAIN(%r15)
 	/*
-- 
2.25.1
