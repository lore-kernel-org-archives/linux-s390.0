From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups during poll
Date: Mon,  2 May 2016 12:42:33 +0200
Message-ID: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Radim, Paolo,

can you have a look at this patch? If you are ok with it, I want to
submit this patch with my next s390 pull request. It touches KVM common
code, but I tried to make it a nop for everything but s390.

Christian

----snip----


Some wakeups should not be considered a sucessful poll. For example on
s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
would be considered runnable - letting all vCPUs poll all the time for
transactional like workload, even if one vCPU would be enough.
This can result in huge CPU usage for large guests.
This patch lets architectures provide a way to qualify wakeups if they
should be considered a good/bad wakeups in regard to polls.

For s390 the implementation will fence of halt polling for anything but
known good, single vCPU events. The s390 implementation for floating
interrupts does a wakeup for one vCPU, but the interrupt will be delivered
by whatever CPU comes first. To limit the halt polling we only mark the
woken up CPU as a valid poll. This code will also cover several other
wakeup reasons like IPI or expired timers. This will of course also mark
some events as not sucessful. As  KVM on z runs always as a 2nd level
hypervisor, we prefer to not poll, unless we are really sure, though.

So we start with a minimal set and will provide additional patches in
the future that mark additional code paths as valid wakeups, if that
turns out to be necessary.

This patch successfully limits the CPU usage for cases like uperf 1byte
transactional ping pong workload or wakeup heavy workload like OLTP
while still providing a proper speedup.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/Kconfig     |  1 +
 arch/s390/kvm/interrupt.c |  8 ++++++++
 include/linux/kvm_host.h  | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/Kconfig          |  4 ++++
 virt/kvm/kvm_main.c       |  9 ++++++---
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 5ea5af3..ccfe6f6 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -28,6 +28,7 @@ config KVM
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
+	select HAVE_KVM_INVALID_POLLS
 	select SRCU
 	select KVM_VFIO
 	---help---
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2130299..fade1b4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -976,6 +976,14 @@ no_timer:
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * This is outside of the if because we want to mark the wakeup
+	 * as valid for vCPUs that
+	 * a: do polling right now
+	 * b: do sleep right now
+	 * otherwise we would never grow the poll interval properly
+	 */
+	vcpu_set_valid_wakeup(vcpu);
 	if (waitqueue_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 861f690..550beec 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -224,6 +224,7 @@ struct kvm_vcpu {
 	sigset_t sigset;
 	struct kvm_vcpu_stat stat;
 	unsigned int halt_poll_ns;
+	bool valid_wakeup;
 
 #ifdef CONFIG_HAS_IOMEM
 	int mmio_needed;
@@ -1178,4 +1179,37 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 				  uint32_t guest_irq, bool set);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
+#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
+/* If we wakeup during the poll time, was it a sucessful poll? */
+static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+	return vcpu->valid_wakeup;
+}
+
+/* Mark the next wakeup as a non-sucessful poll */
+static inline void vcpu_reset_wakeup(struct kvm_vcpu *vcpu)
+{
+	vcpu->valid_wakeup = false;
+}
+
+/* Mark the next wakeup as a sucessful poll */
+static inline void vcpu_set_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+	vcpu->valid_wakeup = true;
+}
+#else
+static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
+static inline void vcpu_reset_wakeup(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline void vcpu_set_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+}
+#endif /* CONFIG_HAVE_KVM_INVALID_POLLS */
+
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 7a79b68..b9edb51 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -41,6 +41,10 @@ config KVM_VFIO
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
        bool
 
+config HAVE_KVM_INVALID_POLLS
+       bool
+
+
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9102ae1..d63ea60 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2008,7 +2008,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 			 * arrives.
 			 */
 			if (kvm_vcpu_check_block(vcpu) < 0) {
-				++vcpu->stat.halt_successful_poll;
+				if (vcpu_valid_wakeup(vcpu))
+					++vcpu->stat.halt_successful_poll;
 				goto out;
 			}
 			cur = ktime_get();
@@ -2038,14 +2039,16 @@ out:
 		if (block_ns <= vcpu->halt_poll_ns)
 			;
 		/* we had a long block, shrink polling */
-		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
+		else if (!vcpu_valid_wakeup(vcpu) ||
+			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
 			shrink_halt_poll_ns(vcpu);
 		/* we had a short halt and our poll time is too small */
 		else if (vcpu->halt_poll_ns < halt_poll_ns &&
-			block_ns < halt_poll_ns)
+			block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
 			grow_halt_poll_ns(vcpu);
 	} else
 		vcpu->halt_poll_ns = 0;
+	vcpu_reset_wakeup(vcpu);
 
 	trace_kvm_vcpu_wakeup(block_ns, waited);
 }
-- 
2.3.0
