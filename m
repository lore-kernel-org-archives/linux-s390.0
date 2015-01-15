From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 03/21] KVM: s390: move vcpu specific initalization to a later point
Date: Thu, 15 Jan 2015 14:43:16 +0100
Message-ID: <1421329414-76826-4-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

As we will allow in a later patch to recreate gmaps with new limits,
we need to make sure that vcpus get their reference for that gmap
after they increased the online_vcpu counter, so there is no possible race.

While we are doing this, we also can simplify the vcpu_init function, by
moving ucontrol specifics to an own function.
That way we also start now setting the kvm_valid_regs for the ucontrol path.

Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ec004f8..529f7905 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -546,25 +546,30 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 }
 
 /* Section: vcpu related */
+static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.gmap = gmap_alloc(current->mm, -1UL);
+	if (!vcpu->arch.gmap)
+		return -ENOMEM;
+	vcpu->arch.gmap->private = vcpu->kvm;
+
+	return 0;
+}
+
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
-	if (kvm_is_ucontrol(vcpu->kvm)) {
-		vcpu->arch.gmap = gmap_alloc(current->mm, -1UL);
-		if (!vcpu->arch.gmap)
-			return -ENOMEM;
-		vcpu->arch.gmap->private = vcpu->kvm;
-		return 0;
-	}
-
-	vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 	vcpu->run->kvm_valid_regs = KVM_SYNC_PREFIX |
 				    KVM_SYNC_GPRS |
 				    KVM_SYNC_ACRS |
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return __kvm_ucontrol_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -617,6 +622,8 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_is_ucontrol(vcpu->kvm))
+		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 }
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
-- 
1.9.3
