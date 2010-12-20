Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20101220130629.823952802@linux.vnet.ibm.com>
Date: Mon, 20 Dec 2010 14:05:44 +0100
From: graalfs@linux.vnet.ibm.com
Subject: [patch 3/4] This patch introduces a new oprofile sample add function (oprofile_add_ext_hw_sample)
References: <20101220130541.446049933@linux.vnet.ibm.com>
Content-Disposition: inline; filename=oprofile_worker.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: graalfs@linux.vnet.ibm.com

This patch introduces a new oprofile sample add function (oprofile_add_ext_hw_sample)
that can also take task_struct as an argument, which is used by the hwsampler kernel module 
when copying hardware samples to OProfile buffers.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/oprofile/cpu_buffer.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/oprofile/cpu_buffer.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/cpu_buffer.c
+++ linux-2.6/drivers/oprofile/cpu_buffer.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/oprofile.h>
 #include <linux/errno.h>
+#include <linux/module.h>
 
 #include "event_buffer.h"
 #include "cpu_buffer.h"
@@ -258,8 +259,10 @@ op_add_sample(struct oprofile_cpu_buffer
  */
 static int
 log_sample(struct oprofile_cpu_buffer *cpu_buf, unsigned long pc,
-	   unsigned long backtrace, int is_kernel, unsigned long event)
+	unsigned long backtrace, int is_kernel, unsigned long event,
+	struct task_struct *task)
 {
+	struct task_struct *tsk = task ? task : current;
 	cpu_buf->sample_received++;
 
 	if (pc == ESCAPE_CODE) {
@@ -267,7 +270,7 @@ log_sample(struct oprofile_cpu_buffer *c
 		return 0;
 	}
 
-	if (op_add_code(cpu_buf, backtrace, is_kernel, current))
+	if (op_add_code(cpu_buf, backtrace, is_kernel, tsk))
 		goto fail;
 
 	if (op_add_sample(cpu_buf, pc, event))
@@ -292,7 +295,8 @@ static inline void oprofile_end_trace(st
 
 static inline void
 __oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs,
-			  unsigned long event, int is_kernel)
+			  unsigned long event, int is_kernel,
+			  struct task_struct *task)
 {
 	struct oprofile_cpu_buffer *cpu_buf = &__get_cpu_var(op_cpu_buffer);
 	unsigned long backtrace = oprofile_backtrace_depth;
@@ -301,7 +305,7 @@ __oprofile_add_ext_sample(unsigned long
 	 * if log_sample() fail we can't backtrace since we lost the
 	 * source of this event
 	 */
-	if (!log_sample(cpu_buf, pc, backtrace, is_kernel, event))
+	if (!log_sample(cpu_buf, pc, backtrace, is_kernel, event, task))
 		/* failed */
 		return;
 
@@ -316,9 +320,17 @@ __oprofile_add_ext_sample(unsigned long
 void oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs,
 			     unsigned long event, int is_kernel)
 {
-	__oprofile_add_ext_sample(pc, regs, event, is_kernel);
+	__oprofile_add_ext_sample(pc, regs, event, is_kernel, NULL);
 }
 
+void oprofile_add_ext_hw_sample(unsigned long pc, struct pt_regs * const regs,
+				unsigned long event, int is_kernel,
+				struct task_struct *task)
+{
+	__oprofile_add_ext_sample(pc, regs, event, is_kernel, task);
+}
+EXPORT_SYMBOL_GPL(oprofile_add_ext_hw_sample);
+
 void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
 {
 	int is_kernel;
@@ -332,7 +344,7 @@ void oprofile_add_sample(struct pt_regs
 		pc = ESCAPE_CODE; /* as this causes an early return. */
 	}
 
-	__oprofile_add_ext_sample(pc, regs, event, is_kernel);
+	__oprofile_add_ext_sample(pc, regs, event, is_kernel, NULL);
 }
 
 /*
@@ -403,7 +415,7 @@ int oprofile_write_commit(struct op_entr
 void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event)
 {
 	struct oprofile_cpu_buffer *cpu_buf = &__get_cpu_var(op_cpu_buffer);
-	log_sample(cpu_buf, pc, 0, is_kernel, event);
+	log_sample(cpu_buf, pc, 0, is_kernel, event, NULL);
 }
 
 void oprofile_add_trace(unsigned long pc)
