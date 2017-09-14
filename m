Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] samples/kprobes: Add s390 case in kprobe example module
Date: Thu, 14 Sep 2017 14:11:15 +0200
Message-Id: <20170914121115.13748-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Add info prints in sample kprobe handlers for S/390

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 samples/kprobes/kprobe_example.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 88b3e2d227ae..67de3b774bc9 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -47,6 +47,10 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 			" pstate = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
 #endif
+#ifdef CONFIG_S390
+	pr_info("<%s> pre_handler: p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
+		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
+#endif
 
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
@@ -76,6 +80,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
 	pr_info("<%s> post_handler: p->addr = 0x%p, pstate = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->pstate);
 #endif
+#ifdef CONFIG_S390
+	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
+		p->symbol_name, p->addr, regs->flags);
+#endif
 }
 
 /*
-- 
2.13.5
