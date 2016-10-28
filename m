From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 01/11] kernel/sched: introduce vcpu preempted check interface
Date: Fri, 28 Oct 2016 04:11:17 -0400
Message-ID: <1477642287-24104-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch support to fix lock holder preemption issue.

For kernel users, we could use bool vcpu_is_preempted(int cpu) to detech if
one vcpu is preempted or not.

The default implementation is a macro defined by false. So compiler can
wrap it out if arch dose not support such vcpu pteempted check.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Juergen Gross <jgross@suse.com>
---
 include/linux/sched.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 348f51b..44c1ce7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3506,6 +3506,18 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+/*
+ * In order to deal with a various lock holder preemption issues provide an
+ * interface to see if a vCPU is currently running or not.
+ *
+ * This allows us to terminate optimistic spin loops and block, analogous to
+ * the native optimistic spin heuristic of testing if the lock owner task is
+ * running or not.
+ */
+#ifndef vcpu_is_preempted
+#define vcpu_is_preempted(cpu)	false
+#endif
+
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-- 
2.4.11
