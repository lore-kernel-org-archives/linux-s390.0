From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH linux-next] fix s390 compile error due to smp_call_function
Date: Tue, 8 Jul 2008 16:25:50 +0200
Message-ID: <200807081625.50437.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello Jens,

the following patch in linux-next (v2.6.26-rc9-7220-g5e36ed1)

commit 8691e5a8f691cc2a4fda0651e8d307aaba0e7d68
Author: Jens Axboe <jens.axboe@oracle.com>
Date:   Fri Jun 6 11:18:06 2008 +0200
smp_call_function: get rid of the unused nonatomic/retry argument

causes a build error on s390.
  CC      arch/s390/kernel/time.o
arch/s390/kernel/time.c: In function 'stp_work_fn':
arch/s390/kernel/time.c:1448: error: too many arguments to 
function 'smp_call_function'
arch/s390/kernel/time.c:1481: error: too many arguments to 
function 'smp_call_function'

The fix is simple and obvious, remove the unneeded argument.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 arch/s390/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-next/arch/s390/kernel/time.c
===================================================================
--- linux-next.orig/arch/s390/kernel/time.c
+++ linux-next/arch/s390/kernel/time.c
@@ -1445,7 +1445,7 @@ static void stp_work_fn(struct work_stru
 	 */
 	memset(&stp_sync, 0, sizeof(stp_sync));
 	preempt_disable();
-	smp_call_function(clock_sync_cpu_start, &stp_sync, 0, 0);
+	smp_call_function(clock_sync_cpu_start, &stp_sync, 0);
 	local_irq_disable();
 	enable_sync_clock();
 
@@ -1478,7 +1478,7 @@ static void stp_work_fn(struct work_stru
 		stp_sync.in_sync = 1;
 
 	local_irq_enable();
-	smp_call_function(clock_sync_cpu_end, NULL, 0, 0);
+	smp_call_function(clock_sync_cpu_end, NULL, 0);
 	preempt_enable();
 }
 
