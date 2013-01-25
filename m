From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/3] s390/kvm: Fix instruction decoding
Date: Fri, 25 Jan 2013 15:34:17 +0100
Message-ID: <1359124457-51126-4-git-send-email-borntraeger@de.ibm.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Instructions with long displacement have a signed displacement.
Currently the sign bit is interpreted as 2^20: Lets fix it by doing the
sign extension from 20bit to 32bit and then use it as a signed variable
in the addition (see kvm_s390_get_base_disp_rsy).

Furthermore, there are lots of "int" in that code. This is problematic,
because shifting on a signed integer is undefined/implementation defined
if the bit value happens to be negative.
Fortunately the promotion rules will make the right hand side unsigned
anyway, so there is no real problem right now.
Let's convert them anyway to unsigned where appropriate to avoid
problems if the code is changed or copy/pasted later on.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 3e05def..4d89d64 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -67,8 +67,8 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 
 static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
+	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
@@ -76,10 +76,10 @@ static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu)
 static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 					      u64 *address1, u64 *address2)
 {
-	int base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
-	int disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
-	int base2 = (vcpu->arch.sie_block->ipb & 0xf000) >> 12;
-	int disp2 = vcpu->arch.sie_block->ipb & 0x0fff;
+	u32 base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
+	u32 disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
+	u32 base2 = (vcpu->arch.sie_block->ipb & 0xf000) >> 12;
+	u32 disp2 = vcpu->arch.sie_block->ipb & 0x0fff;
 
 	*address1 = (base1 ? vcpu->run->s.regs.gprs[base1] : 0) + disp1;
 	*address2 = (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
@@ -87,17 +87,20 @@ static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 
 static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
+	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
+	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
 			((vcpu->arch.sie_block->ipb & 0xff00) << 4);
+	/* The displacement is a 20bit _SIGNED_ value */
+	if (disp2 & 0x80000)
+		disp2+=0xfff00000;
 
-	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + (long)(int)disp2;
 }
 
 static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
+	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
-- 
1.7.12.4
