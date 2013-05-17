From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/8] s390/kvm: Kick guests out of sie if prefix page host pte is touched
Date: Fri, 17 May 2013 14:41:36 +0200
Message-ID: <1368794498-2051-7-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The guest prefix pages must be mapped writeable all the time
while SIE is running, otherwise the guest might see random
behaviour. (pinned at the pte level) Turns out that mlocking is
not enough, the page table entry (not the page) might change or
become r/o. This patch uses the gmap notifiers to kick guest
cpus out of SIE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/kvm/intercept.c       | 39 ++------------------------------
 arch/s390/kvm/kvm-s390.c        | 49 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h        |  1 +
 4 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1fc68d9..1d0ad7d 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -739,6 +739,7 @@ struct gmap {
 	struct mm_struct *mm;
 	unsigned long *table;
 	unsigned long asce;
+	void *private;
 	struct list_head crst_list;
 };
 
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index b7d1b2e..f0b8be0 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -174,47 +174,12 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 
 static int handle_validity(struct kvm_vcpu *vcpu)
 {
-	unsigned long vmaddr;
 	int viwhy = vcpu->arch.sie_block->ipb >> 16;
-	int rc;
 
 	vcpu->stat.exit_validity++;
 	trace_kvm_s390_intercept_validity(vcpu, viwhy);
-	if (viwhy == 0x37) {
-		vmaddr = gmap_fault(vcpu->arch.sie_block->prefix,
-				    vcpu->arch.gmap);
-		if (IS_ERR_VALUE(vmaddr)) {
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-		rc = fault_in_pages_writeable((char __user *) vmaddr,
-			 PAGE_SIZE);
-		if (rc) {
-			/* user will receive sigsegv, exit to user */
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-		vmaddr = gmap_fault(vcpu->arch.sie_block->prefix + PAGE_SIZE,
-				    vcpu->arch.gmap);
-		if (IS_ERR_VALUE(vmaddr)) {
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-		rc = fault_in_pages_writeable((char __user *) vmaddr,
-			 PAGE_SIZE);
-		if (rc) {
-			/* user will receive sigsegv, exit to user */
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-	} else
-		rc = -EOPNOTSUPP;
-
-out:
-	if (rc)
-		VCPU_EVENT(vcpu, 2, "unhandled validity intercept code %d",
-			   viwhy);
-	return rc;
+	WARN_ONCE(true, "kvm: unhandled validity intercept 0x%x\n", viwhy);
+	return -EOPNOTSUPP;
 }
 
 static int handle_instruction(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ef4ef21..08227c1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -84,6 +84,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 };
 
 static unsigned long long *facilities;
+static struct gmap_notifier gmap_notifier;
 
 /* Section: not file related */
 int kvm_arch_hardware_enable(void *garbage)
@@ -96,13 +97,18 @@ void kvm_arch_hardware_disable(void *garbage)
 {
 }
 
+static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address);
+
 int kvm_arch_hardware_setup(void)
 {
+	gmap_notifier.notifier_call = kvm_gmap_notifier;
+	gmap_register_ipte_notifier(&gmap_notifier);
 	return 0;
 }
 
 void kvm_arch_hardware_unsetup(void)
 {
+	gmap_unregister_ipte_notifier(&gmap_notifier);
 }
 
 void kvm_arch_check_processor_compat(void *rtn)
@@ -239,6 +245,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm->arch.gmap = gmap_alloc(current->mm);
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
+		kvm->arch.gmap->private = kvm;
 	}
 
 	kvm->arch.css_support = 0;
@@ -309,6 +316,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 		vcpu->arch.gmap = gmap_alloc(current->mm);
 		if (!vcpu->arch.gmap)
 			return -ENOMEM;
+		vcpu->arch.gmap->private = vcpu->kvm;
 		return 0;
 	}
 
@@ -482,6 +490,22 @@ void exit_sie_sync(struct kvm_vcpu *vcpu)
 	exit_sie(vcpu);
 }
 
+static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address)
+{
+	int i;
+	struct kvm *kvm = gmap->private;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		/* match against both prefix pages */
+		if (vcpu->arch.sie_block->prefix == (address & ~0x1000UL)) {
+			VCPU_EVENT(vcpu, 2, "gmap notifier for %lx", address);
+			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+			exit_sie_sync(vcpu);
+		}
+	}
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	/* kvm common code refers to this, but never calls it */
@@ -634,6 +658,27 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL; /* not implemented yet */
 }
 
+static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
+	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
+	 * This ensures that the ipte instruction for this request has
+	 * already finished. We might race against a second unmapper that
+	 * wants to set the blocking bit. Lets just retry the request loop.
+	 */
+	while (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
+		int rc;
+		rc = gmap_ipte_notify(vcpu->arch.gmap,
+				      vcpu->arch.sie_block->prefix,
+				      PAGE_SIZE * 2);
+		if (rc)
+			return rc;
+		s390_vcpu_unblock(vcpu);
+	}
+	return 0;
+}
+
 static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc;
@@ -649,6 +694,10 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		kvm_s390_deliver_pending_interrupts(vcpu);
 
+	rc = kvm_s390_handle_requests(vcpu);
+	if (rc)
+		return rc;
+
 	vcpu->arch.sie_block->icptcode = 0;
 	preempt_disable();
 	kvm_guest_enter();
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 7a8abfd..269b523 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -63,6 +63,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 {
 	vcpu->arch.sie_block->prefix = prefix & 0x7fffe000u;
 	vcpu->arch.sie_block->ihcpu  = 0xffff;
+	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 }
 
 static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu)
-- 
1.8.1.4
