Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhBINve (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:34 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 6/8] s390x: Print more information on program exceptions
Date: Tue,  9 Feb 2021 08:49:23 -0500
Message-Id: <20210209134925.22248-7-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

Currently we only get a single line of output if a test runs in a
unexpected program exception. Let's also print the general registers
to give soem more context.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/interrupt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 49f98759..1686551a 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -115,6 +115,21 @@ static void fixup_pgm_int(struct stack_frame_int *stack)
 	/* suppressed/terminated/completed point already at the next address */
 }
 
+static void print_int_regs(struct stack_frame_int *stack)
+{
+	printf("\n");
+	printf("GPRS:\n");
+	printf("%016lx %016lx %016lx %016lx\n",
+	       stack->grs1[0], stack->grs1[1], stack->grs0[0], stack->grs0[1]);
+	printf("%016lx %016lx %016lx %016lx\n",
+	       stack->grs0[2], stack->grs0[3], stack->grs0[4], stack->grs0[5]);
+	printf("%016lx %016lx %016lx %016lx\n",
+	       stack->grs0[6], stack->grs0[7], stack->grs0[8], stack->grs0[9]);
+	printf("%016lx %016lx %016lx %016lx\n",
+	       stack->grs0[10], stack->grs0[11], stack->grs0[12], stack->grs0[13]);
+	printf("\n");
+}
+
 static void print_pgm_info(struct stack_frame_int *stack)
 
 {
@@ -122,6 +137,7 @@ static void print_pgm_info(struct stack_frame_int *stack)
 	printf("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
 	       lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
 	       lc->pgm_int_id);
+	print_int_regs(stack);
 	dump_stack();
 	report_summary();
 	abort();
@@ -132,6 +148,7 @@ void handle_pgm_int(struct stack_frame_int *stack)
 	if (!pgm_int_expected) {
 		/* Force sclp_busy to false, otherwise we will loop forever */
 		sclp_handle_ext();
+		print_pgm_info(stack);
 		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
 			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
 			     lc->pgm_int_id);
-- 
2.25.1
