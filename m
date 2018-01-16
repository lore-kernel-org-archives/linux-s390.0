From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/6] KVM: s390: use created_vcpus in more places
Date: Tue, 16 Jan 2018 16:03:10 +0100
Message-ID: <20180116150314.201352-3-borntraeger@de.ibm.com>
References: <20180116150314.201352-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116150314.201352-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus") introduced
kvm->created_vcpus to avoid races with the existing kvm->online_vcpus
scheme. One place was "forgotten" and one new place was "added".
Let's fix those.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
Fixes: a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus")
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40f0ae5a883f..00ef6f47e466 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -573,7 +573,7 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 	case KVM_CAP_S390_GS:
 		r = -EINVAL;
 		mutex_lock(&kvm->lock);
-		if (atomic_read(&kvm->online_vcpus)) {
+		if (kvm->created_vcpus) {
 			r = -EBUSY;
 		} else if (test_facility(133)) {
 			set_kvm_facility(kvm->arch.model.fac_mask, 133);
@@ -1094,7 +1094,7 @@ static int kvm_s390_set_processor_feat(struct kvm *kvm,
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
-	if (!atomic_read(&kvm->online_vcpus)) {
+	if (!kvm->created_vcpus) {
 		bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
 			    KVM_S390_VM_CPU_FEAT_NR_BITS);
 		ret = 0;
-- 
2.13.4
