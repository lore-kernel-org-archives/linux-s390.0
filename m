Return-Path: <linux-kernel-owner+w=401wt.eu-S1756224AbZHYVd7@vger.kernel.org>
Date: Tue, 25 Aug 2009 14:35:41 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] timer.c: fix S/390 comments
Message-Id: <20090825143541.43fc2ed8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: lkml <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: akpm <akpm@linux-foundation.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix typos and add omitted words.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc:	Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:	Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:	linux390@de.ibm.com
Cc:	linux-s390@vger.kernel.org
---
 kernel/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-2631-rc7.orig/kernel/timer.c
+++ lnx-2631-rc7/kernel/timer.c
@@ -1007,8 +1007,8 @@ static inline void __run_timers(struct t
 #ifdef CONFIG_NO_HZ
 /*
  * Find out when the next timer event is due to happen. This
- * is used on S/390 to stop all activity when a cpus is idle.
- * This functions needs to be called disabled.
+ * is used on S/390 to stop all activity when a CPU is idle.
+ * This function needs to be called with interrupts disabled.
  */
 static unsigned long __next_timer_interrupt(struct tvec_base *base)
 {



---
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
