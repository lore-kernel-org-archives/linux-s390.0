From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
	vcpu preempted check
Date: Tue, 15 Nov 2016 16:47:06 +0100
Message-ID: <20161115154706.GF11311@worktop.programming.kicks-ass.net>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, dave@stgolabs.net, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, konrad.wilk@oracle.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 02, 2016 at 05:08:33AM -0400, Pan Xinhui wrote:
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 0f400c0..38c3bb7 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -310,6 +310,8 @@ struct pv_lock_ops {
>  
>  	void (*wait)(u8 *ptr, u8 val);
>  	void (*kick)(int cpu);
> +
> +	bool (*vcpu_is_preempted)(int cpu);
>  };

So that ends up with a full function call in the native case. I did
something like the below on top, completely untested, not been near a
compiler etc..

It doesn't get rid of the branch, but at least it avoids the function
call, and hardware should have no trouble predicting a constant
condition.

Also, it looks like you end up not setting vcpu_is_preempted when KVM
doesn't support steal clock, which would end up in an instant NULL
deref. Fixed that too.

---
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -673,6 +673,11 @@ static __always_inline void pv_kick(int
 	PVOP_VCALL1(pv_lock_ops.kick, cpu);
 }
 
+static __always_inline void pv_vcpu_is_prempted(int cpu)
+{
+	PVOP_VCALLEE1(pv_lock_ops.vcpu_is_preempted, cpu);
+}
+
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -309,7 +309,7 @@ struct pv_lock_ops {
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
 
-	bool (*vcpu_is_preempted)(int cpu);
+	struct paravirt_callee_save vcpu_is_preempted;
 };
 
 /* This contains all the paravirt structures: we get a convenient
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -32,6 +32,12 @@ static inline void queued_spin_unlock(st
 {
 	pv_queued_spin_unlock(lock);
 }
+
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return pv_vcpu_is_preempted(cpu);
+}
 #else
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -26,14 +26,6 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(int cpu)
-{
-	return pv_lock_ops.vcpu_is_preempted(cpu);
-}
-#endif
-
 #include <asm/qspinlock.h>
 
 /*
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -415,15 +415,6 @@ void kvm_disable_steal_time(void)
 	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
 }
 
-static bool kvm_vcpu_is_preempted(int cpu)
-{
-	struct kvm_steal_time *src;
-
-	src = &per_cpu(steal_time, cpu);
-
-	return !!src->preempted;
-}
-
 #ifdef CONFIG_SMP
 static void __init kvm_smp_prepare_boot_cpu(void)
 {
@@ -480,9 +471,6 @@ void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
 		pv_time_ops.steal_clock = kvm_steal_clock;
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-		pv_lock_ops.vcpu_is_preempted = kvm_vcpu_is_preempted;
-#endif
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -604,6 +592,14 @@ static void kvm_wait(u8 *ptr, u8 val)
 	local_irq_restore(flags);
 }
 
+static bool __kvm_vcpu_is_preempted(int cpu)
+{
+	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
+
+	return !!src->preempted;
+}
+PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
@@ -620,6 +616,12 @@ void __init kvm_spinlock_init(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = kvm_wait;
 	pv_lock_ops.kick = kvm_kick_cpu;
+	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted);
+
+	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
+		pv_lock_ops.vcpu_is_preempted =
+			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
+	}
 }
 
 static __init int kvm_spinlock_init_jump(void)
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -12,7 +12,6 @@ __visible void __native_queued_spin_unlo
 {
 	native_queued_spin_unlock(lock);
 }
-
 PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
 bool pv_is_native_spin_unlock(void)
@@ -21,9 +20,16 @@ bool pv_is_native_spin_unlock(void)
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
-static bool native_vcpu_is_preempted(int cpu)
+__visible bool __native_vcpu_is_preempted(int cpu)
 {
-	return 0;
+	return false;
+}
+PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
+
+bool pv_is_native_vcpu_is_preempted(void)
+{
+	return pv_lock_ops.queued_spin_unlock.func ==
+		__raw_callee_save__native_vcpu_is_preempted;
 }
 
 struct pv_lock_ops pv_lock_ops = {
@@ -32,7 +38,7 @@ struct pv_lock_ops pv_lock_ops = {
 	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait = paravirt_nop,
 	.kick = paravirt_nop,
-	.vcpu_is_preempted = native_vcpu_is_preempted,
+	.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted),
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -11,6 +11,7 @@ DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %c
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
+DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "movl $0, %eax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -26,6 +27,7 @@ unsigned paravirt_patch_ident_64(void *i
 }
 
 extern bool pv_is_native_spin_unlock(void);
+extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
@@ -54,6 +56,12 @@ unsigned native_patch(u8 type, u16 clobb
 				end   = end_pv_lock_ops_queued_spin_unlock;
 				goto patch_site;
 			}
+		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
+			if (pv_is_native_vcpu_is_preempted()) {
+				start = start_pv_lock_ops_vcpu_is_preempted;
+				end   = end_pv_lock_ops_vcpu_is_preempted;
+				goto patch_site;
+			}
 #endif
 
 	default:
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -20,6 +20,7 @@ DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
+DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "movl $0, rax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -35,6 +36,7 @@ unsigned paravirt_patch_ident_64(void *i
 }
 
 extern bool pv_is_native_spin_unlock(void);
+extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
@@ -66,6 +68,12 @@ unsigned native_patch(u8 type, u16 clobb
 				end   = end_pv_lock_ops_queued_spin_unlock;
 				goto patch_site;
 			}
+		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
+			if (pv_is_native_vcpu_is_preempted()) {
+				start = start_pv_lock_ops_vcpu_is_preempted;
+				end   = end_pv_lock_ops_vcpu_is_preempted;
+				goto patch_site;
+			}
 #endif
 
 	default:
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -114,6 +114,8 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
+PV_CALLEE_SAVE_REGS_THUNK(xen_vcpu_stolen);
+
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -136,8 +138,7 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = xen_qlock_wait;
 	pv_lock_ops.kick = xen_qlock_kick;
-
-	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
+	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
 
 /*
