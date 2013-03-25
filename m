From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 05/11] KVM: s390: make if statements in lpsw/lpswe handlers readable
Date: Mon, 25 Mar 2013 17:22:52 +0100
Message-ID: <1364228578-20528-6-git-send-email-cornelia.huck@de.ibm.com>
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

Being unable to parse the 5- and 8-line if statements I had to split them
to be able to make any sense of them and verify that they match the
architecture.
So change the code since I guess that other people will also have a hard
time parsing such long conditional statements with line breaks.

Introduce a common is_valid_psw() function which does all the checks needed.
In case of lpsw (64 bit psw -> 128 bit psw conversion) it will do some not
needed additional checks, since a couple of bits can't be set anyway, but
that doesn't hurt.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9d32c56..05d186c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -258,68 +258,58 @@ static void handle_new_psw(struct kvm_vcpu *vcpu)
 #define PSW_ADDR_24 0x0000000000ffffffUL
 #define PSW_ADDR_31 0x000000007fffffffUL
 
+static int is_valid_psw(psw_t *psw) {
+	if (psw->mask & PSW_MASK_UNASSIGNED)
+		return 0;
+	if ((psw->mask & PSW_MASK_ADDR_MODE) == PSW_MASK_BA) {
+		if (psw->addr & ~PSW_ADDR_31)
+			return 0;
+	}
+	if (!(psw->mask & PSW_MASK_ADDR_MODE) && (psw->addr & ~PSW_ADDR_24))
+		return 0;
+	if ((psw->mask & PSW_MASK_ADDR_MODE) ==  PSW_MASK_EA)
+		return 0;
+	return 1;
+}
+
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
-	u64 addr;
+	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
 	psw_compat_t new_psw;
+	u64 addr;
 
-	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu,
 						   PGM_PRIVILEGED_OPERATION);
-
 	addr = kvm_s390_get_base_disp_s(vcpu);
-
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
 	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-
 	if (!(new_psw.mask & PSW32_MASK_BASE))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	vcpu->arch.sie_block->gpsw.mask =
-		(new_psw.mask & ~PSW32_MASK_BASE) << 32;
-	vcpu->arch.sie_block->gpsw.mask |= new_psw.addr & PSW32_ADDR_AMODE;
-	vcpu->arch.sie_block->gpsw.addr = new_psw.addr & ~PSW32_ADDR_AMODE;
-
-	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_UNASSIGNED) ||
-	    (!(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) &&
-	     (vcpu->arch.sie_block->gpsw.addr & ~PSW_ADDR_24)) ||
-	    ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) ==
-	     PSW_MASK_EA))
+	gpsw->mask = (new_psw.mask & ~PSW32_MASK_BASE) << 32;
+	gpsw->mask |= new_psw.addr & PSW32_ADDR_AMODE;
+	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
+	if (!is_valid_psw(gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
 	handle_new_psw(vcpu);
 	return 0;
 }
 
 static int handle_lpswe(struct kvm_vcpu *vcpu)
 {
-	u64 addr;
 	psw_t new_psw;
+	u64 addr;
 
 	addr = kvm_s390_get_base_disp_s(vcpu);
-
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
 	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-
-	vcpu->arch.sie_block->gpsw.mask = new_psw.mask;
-	vcpu->arch.sie_block->gpsw.addr = new_psw.addr;
-
-	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_UNASSIGNED) ||
-	    (((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) ==
-	      PSW_MASK_BA) &&
-	     (vcpu->arch.sie_block->gpsw.addr & ~PSW_ADDR_31)) ||
-	    (!(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) &&
-	     (vcpu->arch.sie_block->gpsw.addr & ~PSW_ADDR_24)) ||
-	    ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) ==
-	     PSW_MASK_EA))
+	vcpu->arch.sie_block->gpsw = new_psw;
+	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
 	handle_new_psw(vcpu);
 	return 0;
 }
-- 
1.7.12.4
