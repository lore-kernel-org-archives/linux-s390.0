From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/16] KVM: s390: only reset CMMA state if it was enabled before
Date: Wed, 29 Jul 2015 11:05:54 +0200
Message-ID: <1438160766-108179-5-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

There is no point in resetting the CMMA state if it was never enabled.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 641639b..3772947 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -344,6 +344,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_S390_VM_MEM_CLR_CMMA:
+		ret = -EINVAL;
+		if (!kvm->arch.use_cmma)
+			break;
+
 		mutex_lock(&kvm->lock);
 		idx = srcu_read_lock(&kvm->srcu);
 		s390_reset_cmma(kvm->arch.gmap->mm);
-- 
2.3.0
