From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 5/9] x86,
	paravirt: Add interface to support kvm/xen vcpu preempted check
Date: Thu, 20 Oct 2016 17:27:50 -0400
Message-ID: <1476998874-2089-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: kernellwp@gmail.com, jgross@suse.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

This is to fix some lock holder preemption issues. Some other locks
implementation do a spin loop before acquiring the lock itself.
Currently kernel has an interface of bool vcpu_is_preempted(int cpu). It
takes the cpu as parameter and return true if the cpu is preempted.
Then kernel can break the spin loops upon on the retval of
vcpu_is_preempted.

As kernel has used this interface, So lets support it.

To deal with kernel and kvm/xen, add vcpu_is_preempted into struct
pv_lock_ops.

Then kvm or xen could provide their own implementation to support
vcpu_is_preempted.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/include/asm/paravirt_types.h | 2 ++
 arch/x86/include/asm/spinlock.h       | 8 ++++++++
 arch/x86/kernel/paravirt-spinlocks.c  | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0f400c0..38c3bb7 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -310,6 +310,8 @@ struct pv_lock_ops {
 
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
+
+	bool (*vcpu_is_preempted)(int cpu);
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 921bea7..0526f59 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -26,6 +26,14 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return pv_lock_ops.vcpu_is_preempted(cpu);
+}
+#endif
+
 #include <asm/qspinlock.h>
 
 /*
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 2c55a00..2f204dd 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -21,12 +21,18 @@ bool pv_is_native_spin_unlock(void)
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
+static bool native_vcpu_is_preempted(int cpu)
+{
+	return 0;
+}
+
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.queued_spin_lock_slowpath = native_queued_spin_lock_slowpath,
 	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait = paravirt_nop,
 	.kick = paravirt_nop,
+	.vcpu_is_preempted = native_vcpu_is_preempted,
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
-- 
2.4.11
