From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 10/11] x86, xen: support vcpu preempted check
Date: Fri, 28 Oct 2016 04:11:26 -0400
Message-ID: <1477642287-24104-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Juergen Gross <jgross@suse.com>

Support the vcpu_is_preempted() functionality under Xen. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

A quick test (4 vcpus on 1 physical cpu doing a parallel build job
with "make -j 8") reduced system time by about 5% with this patch.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/xen/spinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3d6e006..74756bb 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
-
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = xen_qlock_wait;
 	pv_lock_ops.kick = xen_qlock_kick;
+
+	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
 }
 
 /*
-- 
2.4.11
