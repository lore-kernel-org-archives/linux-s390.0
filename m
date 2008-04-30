Return-Path: <linux-kernel-owner+w=401wt.eu-S1759978AbYD3JP1@vger.kernel.org>
Subject: [patch] s390: Remove self ptrace IEEE_IP hack.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Wed, 30 Apr 2008 11:14:56 +0200
Message-Id: <1209546896.10954.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The self referential PT_IEEE_IP ptrace peek & poke calls have been
broken for that last 6 years. For peek the code always returns 0
instead of the last ieee fault and for poke the code does nothing.
Since nobody noticed the code seems to be superfluous. So lets
remove it.

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ptrace.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2008-04-30 11:10:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2008-04-30 11:11:02.000000000 +0200
@@ -607,8 +607,6 @@ do_ptrace_emu31(struct task_struct *chil
 }
 #endif
 
-#define PT32_IEEE_IP 0x13c
-
 static int
 do_ptrace(struct task_struct *child, long request, long addr, long data)
 {
@@ -617,24 +615,6 @@ do_ptrace(struct task_struct *child, lon
 	if (request == PTRACE_ATTACH)
 		return ptrace_attach(child);
 
-	/*
-	 * Special cases to get/store the ieee instructions pointer.
-	 */
-	if (child == current) {
-		if (request == PTRACE_PEEKUSR && addr == PT_IEEE_IP)
-			return peek_user(child, addr, data);
-		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
-			return poke_user(child, addr, data);
-#ifdef CONFIG_COMPAT
-		if (request == PTRACE_PEEKUSR &&
-		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
-			return peek_user_emu31(child, addr, data);
-		if (request == PTRACE_POKEUSR &&
-		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
-			return poke_user_emu31(child, addr, data);
-#endif
-	}
-
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		return ret;
