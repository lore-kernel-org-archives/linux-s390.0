From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/23] KVM: Use common function for VCPU lookup by id
Date: Wed,  2 Dec 2015 12:06:02 +0100
Message-ID: <1449054384-76374-2-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's reuse the new common function for VPCU lookup by id.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split out the new function into a separate patch]
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++--------
 arch/s390/kvm/diag.c         | 11 +++--------
 virt/kvm/kvm_main.c          | 12 +++++-------
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 54b45b7..a29da44 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -308,16 +308,10 @@ static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
 
 static struct kvm_vcpu *kvmppc_find_vcpu(struct kvm *kvm, int id)
 {
-	int r;
-	struct kvm_vcpu *v, *ret = NULL;
+	struct kvm_vcpu *ret;
 
 	mutex_lock(&kvm->lock);
-	kvm_for_each_vcpu(r, v, kvm) {
-		if (v->vcpu_id == id) {
-			ret = v;
-			break;
-		}
-	}
+	ret = kvm_get_vcpu_by_id(kvm, id);
 	mutex_unlock(&kvm->lock);
 	return ret;
 }
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 5fbfb88..05f7de9 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -155,10 +155,8 @@ static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
 
 static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tcpu;
 	int tid;
-	int i;
 
 	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
 	vcpu->stat.diagnose_9c++;
@@ -167,12 +165,9 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 	if (tid == vcpu->vcpu_id)
 		return 0;
 
-	kvm_for_each_vcpu(i, tcpu, kvm)
-		if (tcpu->vcpu_id == tid) {
-			kvm_vcpu_yield_to(tcpu);
-			break;
-		}
-
+	tcpu = kvm_get_vcpu_by_id(vcpu->kvm, tid);
+	if (tcpu)
+		kvm_vcpu_yield_to(tcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 73cbb41..9649a42 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2257,7 +2257,7 @@ static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 {
 	int r;
-	struct kvm_vcpu *vcpu, *v;
+	struct kvm_vcpu *vcpu;
 
 	if (id >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -2281,12 +2281,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 		r = -EINVAL;
 		goto unlock_vcpu_destroy;
 	}
-
-	kvm_for_each_vcpu(r, v, kvm)
-		if (v->vcpu_id == id) {
-			r = -EEXIST;
-			goto unlock_vcpu_destroy;
-		}
+	if (kvm_get_vcpu_by_id(kvm, id)) {
+		r = -EEXIST;
+		goto unlock_vcpu_destroy;
+	}
 
 	BUG_ON(kvm->vcpus[atomic_read(&kvm->online_vcpus)]);
 
-- 
2.3.0
