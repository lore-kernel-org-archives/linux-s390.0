From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/18] KVM: s390: instruction-fetching exceptions on SIE faults
Date: Fri, 12 Feb 2016 14:22:55 +0100
Message-ID: <1455283382-62999-12-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

On instruction-fetch exceptions, we have to forward the PSW by any
valid ilc and correctly use that ilc when injecting the irq. Injection
will already take care of rewinding the PSW if we injected a nullifying
program irq, so we don't need special handling prior to injection.

Until now, autodetection would have guessed an ilc of 0.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 12cec63ed..d0dcf73 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2181,9 +2181,17 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	 * to be able to forward the PSW.
 	 */
 	rc = read_guest_instr(vcpu, &opcode, 1);
-	if (rc)
-		return kvm_s390_inject_prog_cond(vcpu, rc);
 	ilen = insn_length(opcode);
+	if (rc < 0) {
+		return rc;
+	} else if (rc) {
+		/* Instruction-Fetching Exceptions - we can't detect the ilen.
+		 * Forward by arbitrary ilc, injection will take care of
+		 * nullification if necessary.
+		 */
+		pgm_info = vcpu->arch.pgm;
+		ilen = 4;
+	}
 	pgm_info.flags = ilen | KVM_S390_PGM_FLAGS_ILC_VALID;
 	kvm_s390_forward_psw(vcpu, ilen);
 	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
-- 
2.3.0
