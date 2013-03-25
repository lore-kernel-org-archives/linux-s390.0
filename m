From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 04/11] KVM: s390: fix return code handling in lpsw/lpswe handlers
Date: Mon, 25 Mar 2013 17:22:51 +0100
Message-ID: <1364228578-20528-5-git-send-email-cornelia.huck@de.ibm.com>
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

kvm_s390_inject_program_int() may return with a non-zero return value, in
case of an error (out of memory). Report that to the calling functions
instead of ignoring the error case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 844a2b9..9d32c56 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -269,20 +269,14 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 
 	addr = kvm_s390_get_base_disp_s(vcpu);
 
-	if (addr & 7) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (addr & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw))) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
-	if (!(new_psw.mask & PSW32_MASK_BASE)) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (!(new_psw.mask & PSW32_MASK_BASE))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	vcpu->arch.sie_block->gpsw.mask =
 		(new_psw.mask & ~PSW32_MASK_BASE) << 32;
@@ -293,13 +287,10 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	    (!(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) &&
 	     (vcpu->arch.sie_block->gpsw.addr & ~PSW_ADDR_24)) ||
 	    ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) ==
-	     PSW_MASK_EA)) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	     PSW_MASK_EA))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	handle_new_psw(vcpu);
-out:
 	return 0;
 }
 
@@ -310,15 +301,11 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 
 	addr = kvm_s390_get_base_disp_s(vcpu);
 
-	if (addr & 7) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (addr & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw))) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	vcpu->arch.sie_block->gpsw.mask = new_psw.mask;
 	vcpu->arch.sie_block->gpsw.addr = new_psw.addr;
@@ -330,13 +317,10 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	    (!(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) &&
 	     (vcpu->arch.sie_block->gpsw.addr & ~PSW_ADDR_24)) ||
 	    ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_ADDR_MODE) ==
-	     PSW_MASK_EA)) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	     PSW_MASK_EA))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	handle_new_psw(vcpu);
-out:
 	return 0;
 }
 
-- 
1.7.12.4
