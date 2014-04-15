From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 29/47] KVM: s390: convert handle_stidp()
Date: Tue, 15 Apr 2014 14:00:32 +0200
Message-ID: <1397563250-3089-30-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_stidp() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 2de7454..bc96972 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -428,7 +428,9 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 
 static int handle_stidp(struct kvm_vcpu *vcpu)
 {
+	u64 stidp_data = vcpu->arch.stidp_data;
 	u64 operand2;
+	int rc;
 
 	vcpu->stat.instruction_stidp++;
 
@@ -440,8 +442,9 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 	if (operand2 & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (put_guest(vcpu, vcpu->arch.stidp_data, (u64 __user *)operand2))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = write_guest(vcpu, operand2, &stidp_data, sizeof(stidp_data));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 
 	VCPU_EVENT(vcpu, 5, "%s", "store cpu id");
 	return 0;
-- 
1.8.4.2
