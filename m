From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 19/47] KVM: s390: convert handle_prog()
Date: Tue, 15 Apr 2014 14:00:22 +0200
Message-ID: <1397563250-3089-20-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_prog() to new guest access functions.
Also make the code a bit more readable and look at the return code
of write_guest_lc() which was missing before.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index eeb1ac7..a8d8da8 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -111,18 +111,22 @@ static int handle_instruction(struct kvm_vcpu *vcpu)
 
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_itdb *itdb;
+	int rc;
+
 	vcpu->stat.exit_program_interruption++;
 
 	/* Restore ITDB to Program-Interruption TDB in guest memory */
-	if (IS_TE_ENABLED(vcpu) &&
-	    !(current->thread.per_flags & PER_FLAG_NO_TE) &&
-	    IS_ITDB_VALID(vcpu)) {
-		copy_to_guest(vcpu, TDB_ADDR, vcpu->arch.sie_block->itdba,
-			      sizeof(struct kvm_s390_itdb));
-		memset((void *) vcpu->arch.sie_block->itdba, 0,
-		       sizeof(struct kvm_s390_itdb));
-	}
-
+	if (!IS_TE_ENABLED(vcpu) || !IS_ITDB_VALID(vcpu))
+		goto skip_itdb;
+	if (current->thread.per_flags & PER_FLAG_NO_TE)
+		goto skip_itdb;
+	itdb = (struct kvm_s390_itdb *)vcpu->arch.sie_block->itdba;
+	rc = write_guest_lc(vcpu, TDB_ADDR, itdb, sizeof(*itdb));
+	if (rc)
+		return rc;
+	memset(itdb, 0, sizeof(*itdb));
+skip_itdb:
 	trace_kvm_s390_intercept_prog(vcpu, vcpu->arch.sie_block->iprcc);
 	return kvm_s390_inject_program_int(vcpu, vcpu->arch.sie_block->iprcc);
 }
-- 
1.8.4.2
