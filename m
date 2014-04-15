From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 47/47] KVM: s390: Factor out handle_itdb to handle TX aborts
Date: Tue, 15 Apr 2014 14:00:50 +0200
Message-ID: <1397563250-3089-48-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Factor out the new function handle_itdb(), which copies the ITDB into
guest lowcore to fully handle a TX abort.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index f391604..94194e9 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -171,12 +171,34 @@ static void __extract_prog_irq(struct kvm_vcpu *vcpu,
 	}
 }
 
+/*
+ * restore ITDB to program-interruption TDB in guest lowcore
+ * and set TX abort indication if required
+*/
+static int handle_itdb(struct kvm_vcpu *vcpu,
+		       struct kvm_s390_pgm_info *pgm_info)
+{
+	struct kvm_s390_itdb *itdb;
+	int rc;
+
+	if (!IS_TE_ENABLED(vcpu) || !IS_ITDB_VALID(vcpu))
+		return 0;
+	if (current->thread.per_flags & PER_FLAG_NO_TE)
+		return 0;
+	itdb = (struct kvm_s390_itdb *)vcpu->arch.sie_block->itdba;
+	rc = write_guest_lc(vcpu, __LC_PGM_TDB, itdb, sizeof(*itdb));
+	if (rc)
+		return rc;
+	memset(itdb, 0, sizeof(*itdb));
+
+	return 0;
+}
+
 #define per_event(vcpu) (vcpu->arch.sie_block->iprcc & PGM_PER)
 
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_pgm_info pgm_info;
-	struct kvm_s390_itdb *itdb;
 	int rc;
 
 	vcpu->stat.exit_program_interruption++;
@@ -188,20 +210,13 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 			return 0;
 	}
 
-	/* Restore ITDB to Program-Interruption TDB in guest memory */
-	if (!IS_TE_ENABLED(vcpu) || !IS_ITDB_VALID(vcpu))
-		goto skip_itdb;
-	if (current->thread.per_flags & PER_FLAG_NO_TE)
-		goto skip_itdb;
-	itdb = (struct kvm_s390_itdb *)vcpu->arch.sie_block->itdba;
-	rc = write_guest_lc(vcpu, __LC_PGM_TDB, itdb, sizeof(*itdb));
-	if (rc)
-		return rc;
-	memset(itdb, 0, sizeof(*itdb));
-skip_itdb:
 	trace_kvm_s390_intercept_prog(vcpu, vcpu->arch.sie_block->iprcc);
 	__extract_prog_irq(vcpu, &pgm_info);
 
+	rc = handle_itdb(vcpu, &pgm_info);
+	if (rc)
+		return rc;
+
 	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 }
 
-- 
1.8.4.2
