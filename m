From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 03/11] KVM: s390: fix psw conversion in lpsw handler
Date: Mon, 25 Mar 2013 17:22:50 +0100
Message-ID: <1364228578-20528-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When converting a 64 bit psw to a 128 bit psw the addressing mode bit of
the "addr" part of the 64 bit psw must be moved to the basic addressing
mode bit of the "mask" part of the 128 bit psw.
In addition the addressing mode bit must be cleared when moved to the "addr"
part of the 128 bit psw.
Otherwise an invalid psw would be generated if the orginal psw was in the
31 bit addressing mode.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 7b397b3..844a2b9 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -286,7 +286,8 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sie_block->gpsw.mask =
 		(new_psw.mask & ~PSW32_MASK_BASE) << 32;
-	vcpu->arch.sie_block->gpsw.addr = new_psw.addr;
+	vcpu->arch.sie_block->gpsw.mask |= new_psw.addr & PSW32_ADDR_AMODE;
+	vcpu->arch.sie_block->gpsw.addr = new_psw.addr & ~PSW32_ADDR_AMODE;
 
 	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_UNASSIGNED) ||
 	    (!(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) &&
-- 
1.7.12.4
