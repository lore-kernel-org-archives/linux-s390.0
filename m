From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 03/11] kernel/locking: Drop the overload of {mutex,
	rwsem}_spin_on_owner
Date: Fri, 28 Oct 2016 04:11:19 -0400
Message-ID: <1477642287-24104-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: kernellwp@gmail.com, jgross@suse.com, David.Laight@ACULAB.COM, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
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
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Juergen Gross <jgross@suse.com>
---
 kernel/locking/mutex.c      | 15 +++++++++++++--
 kernel/locking/rwsem-xadd.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a70b90d..82108f5 100644
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
+	 * As lock holder preemption issue, we both skip spinning if task is not
+	 * on cpu or its cpu is preempted
+	 */
 	if (owner)
-		retval = owner->on_cpu;
+		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 	rcu_read_unlock();
 	/*
 	 * if lock->owner is not set, the mutex owner may have just acquired
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 2337b4b..0897179 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -336,7 +336,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		goto done;
 	}
 
-	ret = owner->on_cpu;
+	/*
+	 * As lock holder preemption issue, we both skip spinning if task is not
+	 * on cpu or its cpu is preempted
+	 */
+	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 done:
 	rcu_read_unlock();
 	return ret;
@@ -362,8 +366,14 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
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
