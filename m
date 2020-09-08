Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgIHPYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:24:02 -0400
Date: Tue, 8 Sep 2020 15:30:31 +0200
From: peterz@infradead.org
Subject: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com, svens@linux.ibm.com


After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
lock tracepoints are visible to lockdep and RCU-lockdep is finding a
bunch more RCU violations that were previously hidden.

Switch the idle->seqcount over to using raw_write_*() to avoid the
lockdep annotation and thus the lock tracepoints.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/kernel/idle.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -39,14 +39,13 @@ void enabled_wait(void)
 	local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	/* XXX seqcount has tracepoints that require RCU */
-	write_seqcount_begin(&idle->seqcount);
+	raw_write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
 	idle->idle_time += idle_time;
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
-	write_seqcount_end(&idle->seqcount);
+	raw_write_seqcount_end(&idle->seqcount);
 }
 NOKPROBE_SYMBOL(enabled_wait);
 
