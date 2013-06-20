From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/7] KVM: s390: Renamed PGM_PRIVILEGED_OPERATION
Date: Thu, 20 Jun 2013 17:21:59 +0200
Message-ID: <1371741725-53624-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Renamed the PGM_PRIVILEGED_OPERATION define to PGM_PRIVILEGED_OP since this
define was way longer than the other PGM_* defines and caused the code often
to exceed the 80 columns limit when not split to multiple lines.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/priv.c             | 16 +++++++---------
 arch/s390/kvm/sigp.c             |  3 +--
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 4339069..3238d40 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -175,7 +175,7 @@ struct kvm_s390_ext_info {
 };
 
 #define PGM_OPERATION            0x01
-#define PGM_PRIVILEGED_OPERATION 0x02
+#define PGM_PRIVILEGED_OP	 0x02
 #define PGM_EXECUTE              0x03
 #define PGM_PROTECTION           0x04
 #define PGM_ADDRESSING           0x05
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a0c63d7..a21e014 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -259,8 +259,8 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	u64 addr;
 
 	if (gpsw->mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -446,7 +446,7 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 	if (handler) {
 		if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 			return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+							   PGM_PRIVILEGED_OP);
 		else
 			return handler(vcpu);
 	}
@@ -493,7 +493,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OPERATION);
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	if (vcpu->run->s.regs.gprs[reg1] & PFMF_RESERVED)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -564,7 +564,7 @@ int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
 		if ((handler != handle_epsw) &&
 		    (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE))
 			return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+							   PGM_PRIVILEGED_OP);
 		else
 			return handler(vcpu);
 	}
@@ -581,8 +581,7 @@ int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu)
 
 	/* All eb instructions that end up here are privileged. */
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
 	if (handler)
 		return handler(vcpu);
@@ -642,8 +641,7 @@ static int handle_sckpf(struct kvm_vcpu *vcpu)
 	u32 value;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	if (vcpu->run->s.regs.gprs[0] & 0x00000000ffff0000)
 		return kvm_s390_inject_program_int(vcpu,
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 033c864..bec398c 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -333,8 +333,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 
 	/* sigp in userspace can exit */
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu,
-						   PGM_PRIVILEGED_OPERATION);
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	order_code = kvm_s390_get_base_disp_rs(vcpu);
 
-- 
1.8.2.2
