Return-Path: <linux-kernel-owner+w=401wt.eu-S1759138AbYBEPo3@vger.kernel.org>
Message-Id: <20080205153915.575520030@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/18] sclp_tty/sclp_vt220: Fix scheduling while atomic
Content-Disposition: inline; filename=016-vt220-full.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Under load the following bug message appeared while using sysrq-t:

BUG: scheduling while atomic: bash/3662/0x00000004
0000000000105b74 000000003ba17740 0000000000000002 0000000000000000
       000000003ba177e0 000000003ba17758 000000003ba17758 0000000000105bfe
       0000000000817ba8 000000003f2a5350 0000000000000000 0000000000000000
       000000003ba17740 000000000000000c 000000003ba17740 000000003ba177b0
       0000000000568630 0000000000105bfe 000000003ba17740 000000003ba17790
Call Trace:
([<0000000000105b74>] show_trace+0x13c/0x158)
 [<0000000000105c58>] show_stack+0xc8/0xfc
 [<0000000000105cbc>] dump_stack+0x30/0x40
 [<000000000012a0c8>] __schedule_bug+0x84/0x94
 [<000000000056234e>] schedule+0x5ea/0x970
 [<0000000000477cd2>] __sclp_vt220_write+0x1f6/0x3ec
 [<0000000000477f00>] sclp_vt220_con_write+0x38/0x48
 [<0000000000130b4a>] __call_console_drivers+0xbe/0xd8
 [<0000000000130bf0>] _call_console_drivers+0x8c/0xd0
 [<0000000000130eea>] release_console_sem+0x1a6/0x2fc
 [<0000000000131786>] vprintk+0x262/0x480
 [<00000000001319fa>] printk+0x56/0x68
 [<0000000000125aaa>] print_cfs_rq+0x45e/0x4a4
 [<000000000012614e>] sched_debug_show+0x65e/0xee8
 [<000000000012a8fc>] show_state_filter+0x1cc/0x1f0
 [<000000000044d39c>] sysrq_handle_showstate+0x2c/0x3c
 [<000000000044d1fe>] __handle_sysrq+0xae/0x18c
 [<00000000002001f2>] write_sysrq_trigger+0x8a/0x90
 [<00000000001f7862>] proc_reg_write+0x9a/0xc4
 [<00000000001a83d4>] vfs_write+0xb8/0x174
 [<00000000001a8b88>] sys_write+0x58/0x8c
 [<0000000000112e7c>] sysc_noemu+0x10/0x16
 [<0000020000116f68>] 0x20000116f68

The problem seems to be, that with a full console buffer, release_console_sem
disables interrupts with spin_lock_irqsave and then calls the console function
without enabling interrupts. __sclp_vt220_write checks for in_interrupt, to
decide if it can schedule. It should check for in_atomic instead.

The same is true for sclp_tty.c.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_tty.c   |    2 +-
 drivers/s390/char/sclp_vt220.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_tty.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_tty.c
+++ quilt-2.6/drivers/s390/char/sclp_tty.c
@@ -332,7 +332,7 @@ sclp_tty_write_string(const unsigned cha
 		if (sclp_ttybuf == NULL) {
 			while (list_empty(&sclp_tty_pages)) {
 				spin_unlock_irqrestore(&sclp_tty_lock, flags);
-				if (in_interrupt())
+				if (in_atomic())
 					sclp_sync_wait();
 				else
 					wait_event(sclp_tty_waitq,
Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -400,7 +400,7 @@ __sclp_vt220_write(const unsigned char *
 			while (list_empty(&sclp_vt220_empty)) {
 				spin_unlock_irqrestore(&sclp_vt220_lock,
 						       flags);
-				if (in_interrupt())
+				if (in_atomic())
 					sclp_sync_wait();
 				else
 					wait_event(sclp_vt220_waitq,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
