Return-Path: <linux-arch-owner@vger.kernel.org>
From: Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v7 15/15] locking/rwsem: Wake up all readers in wait queue
Date: Wed, 18 Oct 2017 14:30:31 -0400
Message-ID: <1508351431-22375-16-git-send-email-longman@redhat.com>
In-Reply-To: <1508351431-22375-1-git-send-email-longman@redhat.com>
References: <1508351431-22375-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20171018183031.qNe2eL2S7qxH-AC0T0DIVzqtFF2gPbWuwdqJrWPGu_U@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

When the front of the wait queue is a reader, other readers
immediately following the first reader will also be woken up at the
same time.

Assuming that the lock hold times of the other readers still in the
queue will be about the same as the readers that are being woken up,
there is really not much additional cost other than the additional
latency due to the wakeup of additional tasks by the waker. Therefore
all the readers in the queue are woken up to improve reader throughput.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 42129fa..e8da0a9 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -177,16 +177,16 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Grant an infinite number of read locks to the readers at the front
-	 * of the queue. We know that woken will be at least 1 as we accounted
-	 * for above. Note we increment the 'active part' of the count by the
+	 * Grant an infinite number of read locks to all the readers in the
+	 * queue. We know that woken will be at least 1 as we accounted for
+	 * above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
 	 */
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		struct task_struct *tsk;
 
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
-			break;
+			continue;
 
 		woken++;
 		tsk = waiter->task;
-- 
1.8.3.1
