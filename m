From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/8] KVM: s390: Fix sparse warnings in priv.c
Date: Fri, 26 Jul 2013 15:04:05 +0200
Message-ID: <1374843847-5046-7-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

sparse complained about the missing UL postfix for long constants.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 2883026..bb69df0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -491,12 +491,12 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
 	/* This basically extracts the mask half of the psw. */
-	vcpu->run->s.regs.gprs[reg1] &= 0xffffffff00000000;
+	vcpu->run->s.regs.gprs[reg1] &= 0xffffffff00000000UL;
 	vcpu->run->s.regs.gprs[reg1] |= vcpu->arch.sie_block->gpsw.mask >> 32;
 	if (reg2) {
-		vcpu->run->s.regs.gprs[reg2] &= 0xffffffff00000000;
+		vcpu->run->s.regs.gprs[reg2] &= 0xffffffff00000000UL;
 		vcpu->run->s.regs.gprs[reg2] |=
-			vcpu->arch.sie_block->gpsw.mask & 0x00000000ffffffff;
+			vcpu->arch.sie_block->gpsw.mask & 0x00000000ffffffffUL;
 	}
 	return 0;
 }
-- 
1.8.3.1
