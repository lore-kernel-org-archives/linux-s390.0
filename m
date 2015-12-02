From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/23] KVM: s390: we always have a SCA
Date: Wed,  2 Dec 2015 12:06:15 +0100
Message-ID: <1449054384-76374-15-git-send-email-borntraeger@de.ibm.com>
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

Having no sca can never happen, even when something goes wrong when
switching to ESCA. Otherwise we would have a serious bug.
Let's remove this superfluous check.

Acked-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 16c19fb..5c58127 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1608,13 +1608,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.sie_block->itdba = (unsigned long) &sie_page->itdb;
 
 	vcpu->arch.sie_block->icpua = id;
-	if (!kvm_is_ucontrol(kvm)) {
-		if (!kvm->arch.sca) {
-			WARN_ON_ONCE(1);
-			goto out_free_cpu;
-		}
+	if (!kvm_is_ucontrol(kvm))
 		sca_add_vcpu(vcpu, kvm, id);
-	}
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
-- 
2.3.0
