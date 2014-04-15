From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 17/47] KVM: s390: convert handle_stfl()
Date: Tue, 15 Apr 2014 14:00:20 +0200
Message-ID: <1397563250-3089-18-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert handle_stfl() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4792f1d..7066fc5 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -318,10 +318,10 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	rc = copy_to_guest(vcpu, offsetof(struct _lowcore, stfl_fac_list),
-			   vfacilities, 4);
+	rc = write_guest_lc(vcpu, offsetof(struct _lowcore, stfl_fac_list),
+			    vfacilities, 4);
 	if (rc)
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		return rc;
 	VCPU_EVENT(vcpu, 5, "store facility list value %x",
 		   *(unsigned int *) vfacilities);
 	trace_kvm_s390_handle_stfl(vcpu, *(unsigned int *) vfacilities);
-- 
1.8.4.2
