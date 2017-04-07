From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/9] KVM: s390: log runtime instrumentation enablement
Date: Fri,  7 Apr 2017 12:47:54 +0200
Message-ID: <1491562082-6392-2-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

We handle runtime instrumentation enablement either lazy or via
sync_regs on migration. Make sure to add a debug log entry for that
per CPU on the first occurrence.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 14 ++++++++------
 arch/s390/kvm/priv.c     |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fd6cd05b..5fda468 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2719,6 +2719,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 
 static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
+	struct runtime_instr_cb *riccb;
+
+	riccb = (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
 	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
 	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
@@ -2747,12 +2750,11 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	 * we should enable RI here instead of doing the lazy enablement.
 	 */
 	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_RICCB) &&
-	    test_kvm_facility(vcpu->kvm, 64)) {
-		struct runtime_instr_cb *riccb =
-			(struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
-
-		if (riccb->valid)
-			vcpu->arch.sie_block->ecb3 |= 0x01;
+	    test_kvm_facility(vcpu->kvm, 64) &&
+	    riccb->valid &&
+	    !(vcpu->arch.sie_block->ecb3 & 0x01)) {
+		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (sync_regs)");
+		vcpu->arch.sie_block->ecb3 |= 0x01;
 	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 64b6a30..93d6cde 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -37,6 +37,7 @@
 static int handle_ri(struct kvm_vcpu *vcpu)
 {
 	if (test_kvm_facility(vcpu->kvm, 64)) {
+		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (lazy)");
 		vcpu->arch.sie_block->ecb3 |= 0x01;
 		kvm_s390_retry_instr(vcpu);
 		return 0;
-- 
2.7.4
