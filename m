From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 4/8] KVM: s390: Add FAULT_FLAG_RETRY_NOWAIT for guest fault
Date: Thu, 30 Jan 2014 13:53:45 +0100
Message-ID: <1391086429-43935-5-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

In the case of a fault, we will retry to exit sie64 but with gmap fault
indication for this thread set. This makes it possible to handle async
page faults.

Based on a patch from Martin Schwidefsky.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h   |  2 ++
 arch/s390/include/asm/processor.h |  1 +
 arch/s390/kvm/kvm-s390.c          | 23 +++++++++++++++++++++--
 arch/s390/mm/fault.c              | 26 ++++++++++++++++++++++----
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2204400..66101f6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -767,6 +767,7 @@ static inline void pgste_set_pte(pte_t *ptep, pte_t entry)
  * @table: pointer to the page directory
  * @asce: address space control element for gmap page table
  * @crst_list: list of all crst tables used in the guest address space
+ * @pfault_enabled: defines if pfaults are applicable for the guest
  */
 struct gmap {
 	struct list_head list;
@@ -775,6 +776,7 @@ struct gmap {
 	unsigned long asce;
 	void *private;
 	struct list_head crst_list;
+	bool pfault_enabled;
 };
 
 /**
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 0a876bc..dc5fc4f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -79,6 +79,7 @@ struct thread_struct {
         unsigned long ksp;              /* kernel stack pointer             */
 	mm_segment_t mm_segment;
 	unsigned long gmap_addr;	/* address of last gmap fault. */
+	unsigned int gmap_pfault;	/* signal of a pending guest pfault */
 	struct per_regs per_user;	/* User specified PER registers */
 	struct per_event per_event;	/* Cause of the last PER trap */
 	unsigned long per_flags;	/* Flags to control debug behavior */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 782420f..9eec794 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -255,6 +255,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
 		kvm->arch.gmap->private = kvm;
+		kvm->arch.gmap->pfault_enabled = 0;
 	}
 
 	kvm->arch.css_support = 0;
@@ -701,6 +702,17 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static long kvm_arch_fault_in_sync(struct kvm_vcpu *vcpu)
+{
+	long rc;
+	hva_t fault = gmap_fault(current->thread.gmap_addr, vcpu->arch.gmap);
+	struct mm_struct *mm = current->mm;
+	down_read(&mm->mmap_sem);
+	rc = get_user_pages(current, mm, fault, 1, 1, 0, NULL, NULL);
+	up_read(&mm->mmap_sem);
+	return rc;
+}
+
 static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	int rc, cpuflags;
@@ -730,7 +742,7 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 {
-	int rc;
+	int rc = -1;
 
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
@@ -744,7 +756,14 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 						current->thread.gmap_addr;
 		vcpu->run->s390_ucontrol.pgm_code = 0x10;
 		rc = -EREMOTE;
-	} else {
+
+	} else if (current->thread.gmap_pfault) {
+		current->thread.gmap_pfault = 0;
+		if (kvm_arch_fault_in_sync(vcpu) >= 0)
+			rc = 0;
+	}
+
+	if (rc == -1) {
 		VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
 		trace_kvm_s390_sie_fault(vcpu);
 		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d95265b2..88cef50 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -50,6 +50,7 @@
 #define VM_FAULT_BADMAP		0x020000
 #define VM_FAULT_BADACCESS	0x040000
 #define VM_FAULT_SIGNAL		0x080000
+#define VM_FAULT_PFAULT		0x100000
 
 static unsigned long store_indication __read_mostly;
 
@@ -227,6 +228,7 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
 			return;
 		}
 	case VM_FAULT_BADCONTEXT:
+	case VM_FAULT_PFAULT:
 		do_no_context(regs);
 		break;
 	case VM_FAULT_SIGNAL:
@@ -264,6 +266,9 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
  */
 static inline int do_exception(struct pt_regs *regs, int access)
 {
+#ifdef CONFIG_PGSTE
+	struct gmap *gmap;
+#endif
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
@@ -304,9 +309,10 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	down_read(&mm->mmap_sem);
 
 #ifdef CONFIG_PGSTE
-	if ((current->flags & PF_VCPU) && S390_lowcore.gmap) {
-		address = __gmap_fault(address,
-				     (struct gmap *) S390_lowcore.gmap);
+	gmap = (struct gmap *)
+		((current->flags & PF_VCPU) ? S390_lowcore.gmap : 0);
+	if (gmap) {
+		address = __gmap_fault(address, gmap);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
 			goto out_up;
@@ -315,6 +321,8 @@ static inline int do_exception(struct pt_regs *regs, int access)
 			fault = VM_FAULT_OOM;
 			goto out_up;
 		}
+		if (gmap->pfault_enabled)
+			flags |= FAULT_FLAG_RETRY_NOWAIT;
 	}
 #endif
 
@@ -371,9 +379,19 @@ retry:
 				      regs, address);
 		}
 		if (fault & VM_FAULT_RETRY) {
+#ifdef CONFIG_PGSTE
+			if (gmap && (flags & FAULT_FLAG_RETRY_NOWAIT)) {
+				/* FAULT_FLAG_RETRY_NOWAIT has been set,
+				 * mmap_sem has not been released */
+				current->thread.gmap_pfault = 1;
+				fault = VM_FAULT_PFAULT;
+				goto out_up;
+			}
+#endif
 			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
 			 * of starvation. */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			flags &= ~(FAULT_FLAG_ALLOW_RETRY |
+				   FAULT_FLAG_RETRY_NOWAIT);
 			flags |= FAULT_FLAG_TRIED;
 			down_read(&mm->mmap_sem);
 			goto retry;
-- 
1.8.4.2
