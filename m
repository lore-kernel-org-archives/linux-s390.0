From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/11] KVM: s390: Fix rewinding of the PSW pointing to an EXECUTE instruction
Date: Fri, 28 Nov 2014 14:25:30 +0100
Message-ID: <1417181139-25623-3-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

A couple of our interception handlers rewind the PSW to the beginning
of the instruction to run the intercepted instruction again during the
next SIE entry. This normally works fine, but there is also the
possibility that the instruction did not get run directly but via an
EXECUTE instruction.
In this case, the PSW does not point to the instruction that caused the
interception, but to the EXECUTE instruction! So we've got to rewind the
PSW to the beginning of the EXECUTE instruction instead.
This is now accomplished with a new helper function kvm_s390_rewind_psw().

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/intercept.c        | 16 ++++++++++++++--
 arch/s390/kvm/kvm-s390.h         |  6 ++++--
 arch/s390/kvm/priv.c             | 12 ++++--------
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 7e02d77..ac7b074 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -123,7 +123,7 @@ struct kvm_s390_sie_block {
 #define ICPT_PARTEXEC	0x38
 #define ICPT_IOINST	0x40
 	__u8	icptcode;		/* 0x0050 */
-	__u8	reserved51;		/* 0x0051 */
+	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
 	__u8	reserved54[2];		/* 0x0054 */
 	__u16	ipa;			/* 0x0056 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index eaf4629..1d244df 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -38,6 +38,19 @@ static const intercept_handler_t instruction_handlers[256] = {
 	[0xeb] = kvm_s390_handle_eb,
 };
 
+void kvm_s390_rewind_psw(struct kvm_vcpu *vcpu, int ilc)
+{
+	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
+
+	/* Use the length of the EXECUTE instruction if necessary */
+	if (sie_block->icptstatus & 1) {
+		ilc = (sie_block->icptstatus >> 4) & 0x6;
+		if (!ilc)
+			ilc = 4;
+	}
+	sie_block->gpsw.addr = __rewind_psw(sie_block->gpsw, ilc);
+}
+
 static int handle_noop(struct kvm_vcpu *vcpu)
 {
 	switch (vcpu->arch.sie_block->icptcode) {
@@ -288,7 +301,6 @@ static int handle_external_interrupt(struct kvm_vcpu *vcpu)
  */
 static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 {
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	unsigned long srcaddr, dstaddr;
 	int reg1, reg2, rc;
 
@@ -310,7 +322,7 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 	if (rc != 0)
 		return rc;
 
-	psw->addr = __rewind_psw(*psw, 4);
+	kvm_s390_rewind_psw(vcpu, 4);
 
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 244d023..ff8d977 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -24,8 +24,6 @@ typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 /* declare vfacilities extern */
 extern unsigned long *vfacilities;
 
-int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
-
 /* Transactional Memory Execution related macros */
 #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & 0x10))
 #define TDB_FORMAT1		1
@@ -152,6 +150,10 @@ void kvm_s390_reinject_io_int(struct kvm *kvm,
 			      struct kvm_s390_interrupt_info *inti);
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
 
+/* implemented in intercept.c */
+void kvm_s390_rewind_psw(struct kvm_vcpu *vcpu, int ilc);
+int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
+
 /* implemented in priv.c */
 int is_valid_psw(psw_t *psw);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 04f70fd..b37db1a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -176,21 +176,18 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	vcpu->arch.sie_block->gpsw.addr =
-		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
+	kvm_s390_rewind_psw(vcpu, 4);
 	VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
 	return 0;
 }
 
 static int handle_ipte_interlock(struct kvm_vcpu *vcpu)
 {
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-
 	vcpu->stat.instruction_ipte_interlock++;
-	if (psw_bits(*psw).p)
+	if (psw_bits(vcpu->arch.sie_block->gpsw).p)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 	wait_event(vcpu->kvm->arch.ipte_wq, !ipte_lock_held(vcpu));
-	psw->addr = __rewind_psw(*psw, 4);
+	kvm_s390_rewind_psw(vcpu, 4);
 	VCPU_EVENT(vcpu, 4, "%s", "retrying ipte interlock operation");
 	return 0;
 }
@@ -721,8 +718,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* Rewind PSW to repeat the ESSA instruction */
-	vcpu->arch.sie_block->gpsw.addr =
-		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
+	kvm_s390_rewind_psw(vcpu, 4);
 	vcpu->arch.sie_block->cbrlo &= PAGE_MASK;	/* reset nceo */
 	cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo);
 	down_read(&gmap->mm->mmap_sem);
-- 
1.9.3
