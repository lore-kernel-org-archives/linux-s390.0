From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 24/47] KVM: s390: convert handle_store_cpu_address()
Date: Tue, 15 Apr 2014 14:00:27 +0200
Message-ID: <1397563250-3089-25-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_store_cpu_address() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 306caa2..36c34cf 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -134,23 +134,26 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 
 static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 {
-	u64 useraddr;
+	u16 vcpu_id = vcpu->vcpu_id;
+	u64 ga;
+	int rc;
 
 	vcpu->stat.instruction_stap++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	useraddr = kvm_s390_get_base_disp_s(vcpu);
+	ga = kvm_s390_get_base_disp_s(vcpu);
 
-	if (useraddr & 1)
+	if (ga & 1)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (put_guest(vcpu, vcpu->vcpu_id, (u16 __user *)useraddr))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = write_guest(vcpu, ga, &vcpu_id, sizeof(vcpu_id));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", useraddr);
-	trace_kvm_s390_handle_stap(vcpu, useraddr);
+	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", ga);
+	trace_kvm_s390_handle_stap(vcpu, ga);
 	return 0;
 }
 
-- 
1.8.4.2
