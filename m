From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/8] KVM: s390: Add helper function for setting condition code
Date: Fri, 26 Jul 2013 15:04:06 +0200
Message-ID: <1374843847-5046-8-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Introduced a helper function for setting the CC in the
guest PSW to improve the readability of the code.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h |  7 +++++++
 arch/s390/kvm/priv.c     | 15 ++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index faa4df6..dc99f1c 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -115,6 +115,13 @@ static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu)
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
 
+/* Set the condition code in the guest program status word */
+static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
+{
+	vcpu->arch.sie_block->gpsw.mask &= ~(3UL << 44);
+	vcpu->arch.sie_block->gpsw.mask |= cc << 44;
+}
+
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bb69df0..59200ee 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -164,8 +164,7 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	kfree(inti);
 no_interrupt:
 	/* Set condition code and we're done. */
-	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-	vcpu->arch.sie_block->gpsw.mask |= (cc & 3ul) << 44;
+	kvm_s390_set_psw_cc(vcpu, cc);
 	return 0;
 }
 
@@ -220,8 +219,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 		 * Set condition code 3 to stop the guest from issueing channel
 		 * I/O instructions.
 		 */
-		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-		vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
+		kvm_s390_set_psw_cc(vcpu, 3);
 		return 0;
 	}
 }
@@ -384,7 +382,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	if (fc > 3) {
-		vcpu->arch.sie_block->gpsw.mask |= 3ul << 44;	  /* cc 3 */
+		kvm_s390_set_psw_cc(vcpu, 3);
 		return 0;
 	}
 
@@ -394,7 +392,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 
 	if (fc == 0) {
 		vcpu->run->s.regs.gprs[0] = 3 << 28;
-		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);  /* cc 0 */
+		kvm_s390_set_psw_cc(vcpu, 0);
 		return 0;
 	}
 
@@ -428,12 +426,11 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
 	free_page(mem);
-	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
+	kvm_s390_set_psw_cc(vcpu, 0);
 	vcpu->run->s.regs.gprs[0] = 0;
 	return 0;
 out_no_data:
-	/* condition code 3 */
-	vcpu->arch.sie_block->gpsw.mask |= 3ul << 44;
+	kvm_s390_set_psw_cc(vcpu, 3);
 out_exception:
 	free_page(mem);
 	return rc;
-- 
1.8.3.1
