Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 Jan 2017 13:37:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] two bug fixes for 4.10-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170102133703.3895157a@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Two bug fixes for 4.10-rc3

Heiko Carstens (1):
      s390/kbuild: enable modversions for symbols exported from asm

Martin Schwidefsky (1):
      s390/vtime: correct system time accounting

 arch/s390/include/asm/asm-prototypes.h | 8 ++++++++
 arch/s390/kernel/vtime.c               | 8 ++++----
 2 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-prototypes.h

diff --git a/arch/s390/include/asm/asm-prototypes.h b/arch/s390/include/asm/asm-prototypes.h
new file mode 100644
index 0000000..2c3413b
--- /dev/null
+++ b/arch/s390/include/asm/asm-prototypes.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_S390_PROTOTYPES_H
+
+#include <linux/kvm_host.h>
+#include <linux/ftrace.h>
+#include <asm/fpu/api.h>
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_S390_PROTOTYPES_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 6b246aa..1b5c5ee 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -94,7 +94,7 @@ static void update_mt_scaling(void)
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
+static int do_account_vtime(struct task_struct *tsk)
 {
 	u64 timer, clock, user, system, steal;
 	u64 user_scaled, system_scaled;
@@ -138,7 +138,7 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 	}
 	account_user_time(tsk, user);
 	tsk->utimescaled += user_scaled;
-	account_system_time(tsk, hardirq_offset, system);
+	account_system_time(tsk, 0, system);
 	tsk->stimescaled += system_scaled;
 
 	steal = S390_lowcore.steal_timer;
@@ -152,7 +152,7 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 
 void vtime_task_switch(struct task_struct *prev)
 {
-	do_account_vtime(prev, 0);
+	do_account_vtime(prev);
 	prev->thread.user_timer = S390_lowcore.user_timer;
 	prev->thread.system_timer = S390_lowcore.system_timer;
 	S390_lowcore.user_timer = current->thread.user_timer;
@@ -166,7 +166,7 @@ void vtime_task_switch(struct task_struct *prev)
  */
 void vtime_account_user(struct task_struct *tsk)
 {
-	if (do_account_vtime(tsk, HARDIRQ_OFFSET))
+	if (do_account_vtime(tsk))
 		virt_timer_expire();
 }
 
