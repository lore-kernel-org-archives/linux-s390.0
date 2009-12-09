Return-Path: <linux-kernel-owner+w=401wt.eu-S1757473AbZLITw4@vger.kernel.org>
Date: Wed, 9 Dec 2009 20:46:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] s390: ptrace: don't abuse PT_PTRACED
Message-ID: <20091209194651.GA24919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Untested, but hopefully trivial enough and should't change the
compiled code.

Nobody except ptrace itself should use task->ptrace or PT_PTRACED
directly, change arch/s390/kernel/traps.c to use the helper.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
---

 arch/s390/kernel/traps.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- V1/arch/s390/kernel/traps.c~S390_DONT_ABUSE_PT_PTRACED	2009-04-06 00:03:36.000000000 +0200
+++ V1/arch/s390/kernel/traps.c	2009-12-09 20:31:49.000000000 +0100
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/ptrace.h>
+#include <linux/tracehook.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -382,7 +382,7 @@ void __kprobes do_single_step(struct pt_
 					SIGTRAP) == NOTIFY_STOP){
 		return;
 	}
-	if ((current->ptrace & PT_PTRACED) != 0)
+	if (tracehook_consider_fatal_signal(current, SIGTRAP))
 		force_sig(SIGTRAP, current);
 }
 
@@ -483,7 +483,7 @@ static void illegal_op(struct pt_regs * 
 		if (get_user(*((__u16 *) opcode), (__u16 __user *) location))
 			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
-			if (current->ptrace & PT_PTRACED)
+			if (tracehook_consider_fatal_signal(current, SIGTRAP))
 				force_sig(SIGTRAP, current);
 			else
 				signal = SIGILL;
