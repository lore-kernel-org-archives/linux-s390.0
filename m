From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Thu, 14 Jan 2016 14:56:30 -0500
Message-ID: <20160114195630.GA3520@mtj.duckdns.org>
References: <56978452.6010606@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56978452.6010606@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello,

Thanks a lot for the report and detailed analysis.  Can you please
test whether the following patch fixes the issue?

Thanks.

---
 include/linux/cpuset.h |    6 ++++++
 kernel/cgroup.c        |    2 ++
 kernel/cpuset.c        |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 5 deletions(-)

--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -137,6 +137,8 @@ static inline void set_mems_allowed(node
 	task_unlock(current);
 }
 
+extern void cpuset_post_attach_flush(void);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -243,6 +245,10 @@ static inline bool read_mems_allowed_ret
 	return false;
 }
 
+static inline void cpuset_post_attach_flush(void)
+{
+}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -57,6 +57,7 @@
 #include <linux/vmalloc.h> /* TODO: replace with more sophisticated array */
 #include <linux/kthread.h>
 #include <linux/delay.h>
+#include <linux/cpuset.h>
 
 #include <linux/atomic.h>
 
@@ -2739,6 +2740,7 @@ out_unlock_rcu:
 out_unlock_threadgroup:
 	percpu_up_write(&cgroup_threadgroup_rwsem);
 	cgroup_kn_unlock(of->kn);
+	cpuset_post_attach_flush();
 	return ret ?: nbytes;
 }
 
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -287,6 +287,8 @@ static struct cpuset top_cpuset = {
 static DEFINE_MUTEX(cpuset_mutex);
 static DEFINE_SPINLOCK(callback_lock);
 
+static struct workqueue_struct *cpuset_migrate_mm_wq;
+
 /*
  * CPU / memory hotplug is handled asynchronously.
  */
@@ -971,6 +973,23 @@ static int update_cpumask(struct cpuset
 	return 0;
 }
 
+struct cpuset_migrate_mm_work {
+	struct work_struct	work;
+	struct mm_struct	*mm;
+	nodemask_t		from;
+	nodemask_t		to;
+};
+
+static void cpuset_migrate_mm_workfn(struct work_struct *work)
+{
+	struct cpuset_migrate_mm_work *mwork =
+		container_of(work, struct cpuset_migrate_mm_work, work);
+
+	do_migrate_pages(mwork->mm, &mwork->from, &mwork->to, MPOL_MF_MOVE_ALL);
+	mmput(mwork->mm);
+	kfree(mwork);
+}
+
 /*
  * cpuset_migrate_mm
  *
@@ -989,16 +1008,31 @@ static void cpuset_migrate_mm(struct mm_
 							const nodemask_t *to)
 {
 	struct task_struct *tsk = current;
+	struct cpuset_migrate_mm_work *mwork;
 
 	tsk->mems_allowed = *to;
 
-	do_migrate_pages(mm, from, to, MPOL_MF_MOVE_ALL);
+	mwork = kzalloc(sizeof(*mwork), GFP_KERNEL);
+	if (mwork) {
+		mwork->mm = mm;
+		mwork->from = *from;
+		mwork->to = *to;
+		INIT_WORK(&mwork->work, cpuset_migrate_mm_workfn);
+		queue_work(cpuset_migrate_mm_wq, &mwork->work);
+	} else {
+		mmput(mm);
+	}
 
 	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &tsk->mems_allowed);
 	rcu_read_unlock();
 }
 
+void cpuset_post_attach_flush(void)
+{
+	flush_workqueue(cpuset_migrate_mm_wq);
+}
+
 /*
  * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
  * @tsk: the task to change
@@ -1097,7 +1131,8 @@ static void update_tasks_nodemask(struct
 		mpol_rebind_mm(mm, &cs->mems_allowed);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
-		mmput(mm);
+		else
+			mmput(mm);
 	}
 	css_task_iter_end(&it);
 
@@ -1545,11 +1580,11 @@ static void cpuset_attach(struct cgroup_
 			 * @old_mems_allowed is the right nodesets that we
 			 * migrate mm from.
 			 */
-			if (is_memory_migrate(cs)) {
+			if (is_memory_migrate(cs))
 				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
 						  &cpuset_attach_nodemask_to);
-			}
-			mmput(mm);
+			else
+				mmput(mm);
 		}
 	}
 
@@ -2359,6 +2394,9 @@ void __init cpuset_init_smp(void)
 	top_cpuset.effective_mems = node_states[N_MEMORY];
 
 	register_hotmemory_notifier(&cpuset_track_online_nodes_nb);
+
+	cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
+	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
 /**
