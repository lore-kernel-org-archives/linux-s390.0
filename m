Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] s390: let exit_thread_runtime_instr accept a task
Date: Thu, 24 Mar 2016 13:57:17 +0100
Message-Id: <1458824240-29606-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We need to call exit_thread from copy_process in a fail path. Since
exit_thread on s390 calls exit_thread_runtime_instr, make it accept
task_struct as a parameter now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/s390/include/asm/runtime_instr.h | 2 +-
 arch/s390/kernel/process.c            | 2 +-
 arch/s390/kernel/runtime_instr.c      | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/runtime_instr.h b/arch/s390/include/asm/runtime_instr.h
index 402ad6df4897..6ecfadccd5f5 100644
--- a/arch/s390/include/asm/runtime_instr.h
+++ b/arch/s390/include/asm/runtime_instr.h
@@ -85,6 +85,6 @@ static inline void restore_ri_cb(struct runtime_instr_cb *cb_next,
 		load_runtime_instr_cb(&runtime_instr_empty_cb);
 }
 
-void exit_thread_runtime_instr(void);
+void exit_thread_runtime_instr(struct task_struct *task);
 
 #endif /* _RUNTIME_INSTR_H */
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 2bba7df4ac51..7fabc985a7dd 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -72,7 +72,7 @@ extern void kernel_thread_starter(void);
  */
 void exit_thread(void)
 {
-	exit_thread_runtime_instr();
+	exit_thread_runtime_instr(current);
 }
 
 void flush_thread(void)
diff --git a/arch/s390/kernel/runtime_instr.c b/arch/s390/kernel/runtime_instr.c
index fffa0e5462af..f76973888479 100644
--- a/arch/s390/kernel/runtime_instr.c
+++ b/arch/s390/kernel/runtime_instr.c
@@ -43,10 +43,8 @@ static void init_runtime_instr_cb(struct runtime_instr_cb *cb)
 	cb->valid = 1;
 }
 
-void exit_thread_runtime_instr(void)
+void exit_thread_runtime_instr(struct task_struct *task)
 {
-	struct task_struct *task = current;
-
 	if (!task->thread.ri_cb)
 		return;
 	disable_runtime_instr();
@@ -63,7 +61,7 @@ SYSCALL_DEFINE1(s390_runtime_instr, int, command)
 
 	if (command == S390_RUNTIME_INSTR_STOP) {
 		preempt_disable();
-		exit_thread_runtime_instr();
+		exit_thread_runtime_instr(current);
 		preempt_enable();
 		return 0;
 	}
-- 
2.7.4
