Return-Path: <xinhui.pan@linux.vnet.ibm.com>
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 4/4] kernel/locking: Drop the overload of {mutex,
 rwsem}_spin_on_owner
Date: Tue, 28 Jun 2016 10:43:11 -0400
In-Reply-To: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1467124991-13164-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com, dave@stgolabs.net, schwidefsky@de.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

An over-committed guest with more vCPUs than pCPUs has a heavy overload in
the two spin_on_owner. This blames on the lock holder preemption issue.

Kernel has an interface bool vcpu_is_preempted(int cpu) to see if a vCPU is
currently running or not. So break the spin loops on true condition.

test-case:
perf record -a perf bench sched messaging -g 400 -p && perf report

before patch:
20.68%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner
 8.45%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 4.12%  sched-messaging  [kernel.vmlinux]  [k] system_call
 3.01%  sched-messaging  [kernel.vmlinux]  [k] system_call_common
 2.83%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 2.64%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 2.00%  sched-messaging  [kernel.vmlinux]  [k] osq_lock

after patch:
 9.99%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 5.28%  sched-messaging  [unknown]         [H] 0xc0000000000768e0
 4.27%  sched-messaging  [kernel.vmlinux]  [k] __copy_tofrom_user_power7
 3.77%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 3.24%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.02%  sched-messaging  [kernel.vmlinux]  [k] system_call
 2.69%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 kernel/locking/mutex.c      | 15 +++++++++++++--
 kernel/locking/rwsem-xadd.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 79d2d76..ef0451b2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -236,7 +236,13 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 		 */
 		barrier();
 
-		if (!owner->on_cpu || need_resched()) {
+		/*
+		 * Use vcpu_is_preempted to detech lock holder preemption issue
+		 * and break. vcpu_is_preempted is a macro defined by false if
+		 * arch does not support vcpu preempted check,
+		 */
+		if (!owner->on_cpu || need_resched() ||
+				vcpu_is_preempted(task_cpu(owner))) {
 			ret = false;
 			break;
 		}
@@ -261,8 +267,13 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 
 	rcu_read_lock();
 	owner = READ_ONCE(lock->owner);
+
+	/*
+	 * As lock holder preemption issue, we both skip spinning if task not
+	 * on cpu or its cpu is preempted
+	 */
 	if (owner)
-		retval = owner->on_cpu;
+		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 	rcu_read_unlock();
 	/*
 	 * if lock->owner is not set, the mutex owner may have just acquired
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 09e30c6..828ca7c 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -319,7 +319,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		goto done;
 	}
 
-	ret = owner->on_cpu;
+	/*
+	 * As lock holder preemption issue, we both skip spinning if task not
+	 * on cpu or its cpu is preempted
+	 */
+	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 done:
 	rcu_read_unlock();
 	return ret;
@@ -340,8 +344,14 @@ bool rwsem_spin_on_owner(struct rw_semaphore *sem, struct task_struct *owner)
 		 */
 		barrier();
 
-		/* abort spinning when need_resched or owner is not running */
-		if (!owner->on_cpu || need_resched()) {
+		/*
+		 * abort spinning when need_resched or owner is not running or
+		 * owner's cpu is preempted. vcpu_is_preempted is a macro
+		 * defined by false if arch does not support vcpu preempted
+		 * check
+		 */
+		if (!owner->on_cpu || need_resched() ||
+				vcpu_is_preempted(task_cpu(owner))) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
2.4.11
