From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/9] KVM: s390: enable STFLE interpretation only if enabled for the guest
Date: Thu, 10 Mar 2016 16:36:58 +0100
Message-ID: <1457624219-110920-9-git-send-email-borntraeger@de.ibm.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Not setting the facility list designation disables STFLE interpretation,
this is what we want if the guest was told to not have it.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b54daed..b6a0654 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1639,7 +1639,8 @@ static void kvm_s390_vcpu_setup_model(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.cpu_id = model->cpu_id;
 	vcpu->arch.sie_block->ibc = model->ibc;
-	vcpu->arch.sie_block->fac = (int) (long) model->fac->list;
+	if (test_kvm_facility(vcpu->kvm, 7))
+		vcpu->arch.sie_block->fac = (int) (long) model->fac->list;
 }
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
-- 
2.5.0
