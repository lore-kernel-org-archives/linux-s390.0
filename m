From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 02/11] locking/osq: Drop the overload of osq_lock()
Date: Wed,  2 Nov 2016 05:08:29 -0400
Message-ID: <1478077718-37424-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: kernellwp@gmail.com, jgross@suse.com, dave@stgolabs.net, David.Laight@ACULAB.COM, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, konrad.wilk@oracle.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

An over-committed guest with more vCPUs than pCPUs has a heavy overload
in osq_lock().

This is because vCPU A hold the osq lock and yield out, vCPU B wait
per_cpu node->locked to be set. IOW, vCPU B wait vCPU A to run and
unlock the osq lock.

Kernel has an interface bool vcpu_is_preempted(int cpu) to detect if a
vCPU is currently running or not. So break the spin loops on true
condition.

test case:
perf record -a perf bench sched messaging -g 400 -p && perf report

before patch:
18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
 3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
 2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call

after patch:
20.68%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner
 8.45%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 4.12%  sched-messaging  [kernel.vmlinux]  [k] system_call
 3.01%  sched-messaging  [kernel.vmlinux]  [k] system_call_common
 2.83%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 2.64%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 2.00%  sched-messaging  [kernel.vmlinux]  [k] osq_lock

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Juergen Gross <jgross@suse.com>
---
 kernel/locking/osq_lock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..091f97f 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -21,6 +21,11 @@ static inline int encode_cpu(int cpu_nr)
 	return cpu_nr + 1;
 }
 
+static inline int node_cpu(struct optimistic_spin_node *node)
+{
+	return node->cpu - 1;
+}
+
 static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
 {
 	int cpu_nr = encoded_cpu_val - 1;
@@ -118,8 +123,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	while (!READ_ONCE(node->locked)) {
 		/*
 		 * If we need to reschedule bail... so we can block.
+		 * Use vcpu_is_preempted to detect lock holder preemption issue.
 		 */
-		if (need_resched())
+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
 			goto unqueue;
 
 		cpu_relax_lowlatency();
-- 
2.4.11
