From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 6/6] KVM: s390: Fix epsw instruction decoding
Date: Wed, 12 Jun 2013 13:54:57 +0200
Message-ID: <1371038097-28577-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The handle_epsw() function calculated the first register in the wrong way,
so that it always used r0 by mistake. Now the code uses the common helper
function for decoding the registers of rre functions instead to avoid such
mistakes.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bda9c9b..a0c63d7 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -457,8 +457,7 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 {
 	int reg1, reg2;
 
-	reg1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 24;
-	reg2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
 	/* This basically extracts the mask half of the psw. */
 	vcpu->run->s.regs.gprs[reg1] &= 0xffffffff00000000;
-- 
1.8.1.6
