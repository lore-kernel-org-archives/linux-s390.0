From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 06 Mar 2018 15:00:27 +0000
Subject: [GIT PULL 2/2] KVM: s390: fix memory overwrites when not using SCA entries
Message-Id: <20180306150027.175145-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Even if we don't have extended SCA support, we can have more than 64 CPUs
if we don't enable any HW features that might use the SCA entries.

Now, this works just fine, but we missed a return, which is why we
would actually store the SCA entries. If we have more than 64 CPUs, this
means writing outside of the basic SCA - bad.

Let's fix this. This allows > 64 CPUs when running nested (under vSIE)
without random crashes.

Fixes: a6940674c384 ("KVM: s390: allow 255 VCPUs when sca entries aren't used")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180306132758.21034-1-david@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index df19f158347e..339ac0964590 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2147,6 +2147,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 		/* we still need the basic sca for the ipte control */
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+		return;
 	}
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
-- 
2.14.3
