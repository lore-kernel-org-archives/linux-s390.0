Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH] s390: Remove obsolete bust_spinlock() implementation
Date: Thu, 22 Nov 2018 15:15:29 +0100
Message-Id: <20181122141529.14933-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
List-ID: <linux-s390.vger.kernel.org>

The commit cefc8be82403cf ("Consolidate bust_spinlocks()") kept
the s390-specific implementation because of the absence of CONFIG_VT.
In fact, the only difference was calling console_unblank() instead of
unblank_screen().

The common implementation in lib/bust_spinlocks.c started to call
unblank_screen() explicitly since the commit b61312d353da187
("oops handling: ensure that any oops is flushed to the mtdoops
console").

As a result, the custom implementation is not longer necessary.
And we could get all the other improvements of the common
implementation for free.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/s390/mm/fault.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..11613362c4e7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -81,30 +81,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 	return ret;
 }
 
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out.
- */
-void bust_spinlocks(int yes)
-{
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /*
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
-- 
2.13.7
