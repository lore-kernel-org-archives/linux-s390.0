Return-Path: <linux-kernel-owner+w=401wt.eu-S1760997AbZBYPME@vger.kernel.org>
Message-Id: <20090225150830.315661748@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 12/46] cputime: initialize per thread timer values on fork
Content-Disposition: inline; filename=111-cputime-thread.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Initialize per thread timer values instead of just copying them from
the parent. That way it is easily possible to tell how much time a
thread spent in user/system context.
Doesn't fix a bug, this is just for debugging purposes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -163,6 +163,7 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
+	struct thread_info *ti;
 	struct fake_frame
 	{
 		struct stack_frame sf;
@@ -214,6 +215,10 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.mm_segment = get_fs();
 	/* Don't copy debug registers */
 	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
+	/* Initialize per thread user and system timer values */
+	ti = task_thread_info(p);
+	ti->user_timer = 0;
+	ti->system_timer = 0;
 	return 0;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
