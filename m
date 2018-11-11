Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/41] s390/mm: Convert tlb_table_flush() to use call_rcu()
Date: Sun, 11 Nov 2018 11:43:36 -0800
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
Message-Id: <20181111194410.6368-7-paulmck@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now that call_rcu()'s callback is not invoked until after all
preempt-disable regions of code have completed (in addition to explicitly
marked RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_sched().  This commit therefore makes that change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: <linux-s390@vger.kernel.org>
---
 arch/s390/mm/pgalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 76d89ee8b428..da64e4b9324e 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -350,7 +350,7 @@ void tlb_table_flush(struct mmu_gather *tlb)
 	struct mmu_table_batch **batch = &tlb->batch;
 
 	if (*batch) {
-		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
+		call_rcu(&(*batch)->rcu, tlb_remove_table_rcu);
 		*batch = NULL;
 	}
 }
-- 
2.17.1
