From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 7/9] KVM: s390: fix diagnose code extraction
Date: Thu, 28 Nov 2013 15:06:56 +0100
Message-ID: <1385647618-15541-8-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, stable@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The diagnose code to be used is the contents of the base register (if not
zero), plus the displacement. The current code ignores the base register
contents. So let's fix that...

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 78d967f..5ff29be 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -137,7 +137,7 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
-	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
+	int code = kvm_s390_get_base_disp_rs(vcpu) & 0xffff;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
-- 
1.7.9.5
