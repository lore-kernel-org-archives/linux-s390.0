From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] KVM: s390: Spelling s/intance/instance/
Date: Mon,  9 Mar 2015 21:27:12 +0100
Message-ID: <1425932832-6244-1-git-send-email-geert+renesas@glider.be>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/s390/kvm/kvm-s390.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index fda3f3146eb636d3..83f32a147d72c0f3 100644
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
1.9.1
