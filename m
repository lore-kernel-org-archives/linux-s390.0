From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/11] KVM: s390: Spelling s/intance/instance/
Date: Wed, 18 Mar 2015 12:43:59 +0100
Message-ID: <1426679049-37696-2-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-Id: <1425932832-6244-1-git-send-email-geert+renesas@glider.be>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index fda3f31..83f32a1 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -125,7 +125,7 @@ static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 	vcpu->arch.sie_block->gpsw.mask |= cc << 44;
 }
 
-/* test availability of facility in a kvm intance */
+/* test availability of facility in a kvm instance */
 static inline int test_kvm_facility(struct kvm *kvm, unsigned long nr)
 {
 	return __test_facility(nr, kvm->arch.model.fac->mask) &&
-- 
2.3.0
