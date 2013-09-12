From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/8] KVM: s390: Allow NULL parameter for kvm_s390_get_regs_rre
Date: Thu, 12 Sep 2013 10:33:46 +0200
Message-ID: <1378974829-46578-6-git-send-email-borntraeger@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

We're not always interested in both registers that are specified
for an RRE instruction. So allow NULL as parameter, too, to indicate
that we do not need the corresponding value.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index a307a85..b44912a 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -90,8 +90,10 @@ static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 
 static inline void kvm_s390_get_regs_rre(struct kvm_vcpu *vcpu, int *r1, int *r2)
 {
-	*r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
-	*r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	if (r1)
+		*r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
+	if (r2)
+		*r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
 }
 
 static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
-- 
1.8.3.1
