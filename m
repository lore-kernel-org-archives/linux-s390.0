From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/12] KVM: s390: Introduce helper function for faulting-in a guest page
Date: Fri, 16 May 2014 16:09:40 +0200
Message-ID: <1400249388-3969-5-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Rework the function kvm_arch_fault_in_sync() to become a proper helper
function for faulting-in a guest page. Now it takes the guest address as
a parameter and does not ignore the possible error code from gmap_fault()
anymore (which could cause undetected error conditions before).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 32 +++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.h |  1 +
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0a01744..d91feb2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1045,15 +1045,30 @@ retry:
 	return 0;
 }
 
-static long kvm_arch_fault_in_sync(struct kvm_vcpu *vcpu)
+/**
+ * kvm_arch_fault_in_page - fault-in guest page if necessary
+ * @vcpu: The corresponding virtual cpu
+ * @gpa: Guest physical address
+ * @writable: Whether the page should be writable or not
+ *
+ * Make sure that a guest page has been faulted-in on the host.
+ *
+ * Return: Zero on success, negative error code otherwise.
+ */
+long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
 {
-	long rc;
-	hva_t fault = gmap_fault(current->thread.gmap_addr, vcpu->arch.gmap);
 	struct mm_struct *mm = current->mm;
+	hva_t hva;
+	long rc;
+
+	hva = gmap_fault(gpa, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(hva))
+		return (long)hva;
 	down_read(&mm->mmap_sem);
-	rc = get_user_pages(current, mm, fault, 1, 1, 0, NULL, NULL);
+	rc = get_user_pages(current, mm, hva, 1, writable, 0, NULL, NULL);
 	up_read(&mm->mmap_sem);
-	return rc;
+
+	return rc < 0 ? rc : 0;
 }
 
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
@@ -1191,9 +1206,12 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	} else if (current->thread.gmap_pfault) {
 		trace_kvm_s390_major_guest_pfault(vcpu);
 		current->thread.gmap_pfault = 0;
-		if (kvm_arch_setup_async_pf(vcpu) ||
-		    (kvm_arch_fault_in_sync(vcpu) >= 0))
+		if (kvm_arch_setup_async_pf(vcpu)) {
 			rc = 0;
+		} else {
+			gpa_t gpa = current->thread.gmap_addr;
+			rc = kvm_arch_fault_in_page(vcpu, gpa, 1);
+		}
 	}
 
 	if (rc == -1) {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 38b589d..e489945 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -156,6 +156,7 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
+long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
-- 
1.8.4.2
