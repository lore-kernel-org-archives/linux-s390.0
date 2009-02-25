Return-Path: <linux-kernel-owner+w=401wt.eu-S1757174AbZBYPJ3@vger.kernel.org>
Message-Id: <20090225150827.036167101@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 01/46] fix dump_stack vs. %p and (null)
Content-Disposition: inline; filename=100-dump-stack.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The s390 implemenation of dump_stack uses %p to display stack content.
Since d97106ab53f812910a62d18afb9dbe882819c1ba (Make %p print '(null)'
for NULL pointers) this causes a strange output for dump_stack:

[...]
Process basename (pid: 8822, task: 00000000b2ece038, ksp: 00000000b24d7b38)
04000000b5685c00 00000000b24d7760 0000000000000002 (null)
00000000b24d7800 00000000b24d7778 00000000b24d7778 00000000001052fe
(null) 00000000b24d7b38 (null) 000000000000000a
000000000000000d (null) 00000000b24d7760 00000000b24d77d8
000000000051a7e8 00000000001052fe 00000000b24d7760 00000000b24d77b0
Call Trace:
[...]

This patch changes our dump_stack to use the appropriate %x format.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -61,9 +61,11 @@ extern pgm_check_handler_t do_asce_excep
 #define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
 
 #ifndef CONFIG_64BIT
+#define LONG "%08lx "
 #define FOURLONG "%08lx %08lx %08lx %08lx\n"
 static int kstack_depth_to_print = 12;
 #else /* CONFIG_64BIT */
+#define LONG "%016lx "
 #define FOURLONG "%016lx %016lx %016lx %016lx\n"
 static int kstack_depth_to_print = 20;
 #endif /* CONFIG_64BIT */
@@ -155,7 +157,7 @@ void show_stack(struct task_struct *task
 			break;
 		if (i && ((i * sizeof (long) % 32) == 0))
 			printk("\n       ");
-		printk("%p ", (void *)*stack++);
+		printk(LONG, *stack++);
 	}
 	printk("\n");
 	show_trace(task, sp);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
