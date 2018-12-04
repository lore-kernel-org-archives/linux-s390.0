From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Date: Tue, 04 Dec 2018 22:05:38 +0000
Subject: [tip:core/rcu] s390/mm: Convert tlb_table_flush() to use call_rcu()
Message-Id: <tip-0d4e68e2f3979c67a3596c61c118e0c73a2bdfe0@git.kernel.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit-ID:  0d4e68e2f3979c67a3596c61c118e0c73a2bdfe0
Gitweb:     https://git.kernel.org/tip/0d4e68e2f3979c67a3596c61c118e0c73a2bdfe0
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Tue, 30 Oct 2018 16:30:07 -0700
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Thu, 8 Nov 2018 21:43:20 -0800

s390/mm: Convert tlb_table_flush() to use call_rcu()

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
