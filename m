From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/16] KVM: s390: add kvm stat counter for all diagnoses
Date: Wed, 29 Jul 2015 11:05:55 +0200
Message-ID: <1438160766-108179-6-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Sometimes kvm stat counters are the only performance metric to check
after something went wrong. Let's add additional counters for some
diagnoses.

In addition do the count for diag 10 all the time, even if we inject
a program interrupt.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 3 +++
 arch/s390/kvm/diag.c             | 5 ++++-
 arch/s390/kvm/kvm-s390.c         | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3024acb..764f91e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -258,6 +258,9 @@ struct kvm_vcpu_stat {
 	u32 diagnose_10;
 	u32 diagnose_44;
 	u32 diagnose_9c;
+	u32 diagnose_258;
+	u32 diagnose_308;
+	u32 diagnose_500;
 };
 
 #define PGM_OPERATION			0x01
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index fc7ec95..9806616 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -27,13 +27,13 @@ static int diag_release_pages(struct kvm_vcpu *vcpu)
 
 	start = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
 	end = vcpu->run->s.regs.gprs[vcpu->arch.sie_block->ipa & 0xf] + 4096;
+	vcpu->stat.diagnose_10++;
 
 	if (start & ~PAGE_MASK || end & ~PAGE_MASK || start >= end
 	    || start < 2 * PAGE_SIZE)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	VCPU_EVENT(vcpu, 5, "diag release pages %lX %lX", start, end);
-	vcpu->stat.diagnose_10++;
 
 	/*
 	 * We checked for start >= end above, so lets check for the
@@ -75,6 +75,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	u16 rx = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
 	u16 ry = (vcpu->arch.sie_block->ipa & 0x0f);
 
+	vcpu->stat.diagnose_258++;
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], rx, &parm, sizeof(parm));
@@ -175,6 +176,7 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 	unsigned long subcode = vcpu->run->s.regs.gprs[reg] & 0xffff;
 
 	VCPU_EVENT(vcpu, 5, "diag ipl functions, subcode %lx", subcode);
+	vcpu->stat.diagnose_308++;
 	switch (subcode) {
 	case 3:
 		vcpu->run->s390_reset_flags = KVM_S390_RESET_CLEAR;
@@ -202,6 +204,7 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 {
 	int ret;
 
+	vcpu->stat.diagnose_500++;
 	/* No virtio-ccw notification? Get out quickly. */
 	if (!vcpu->kvm->arch.css_support ||
 	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3772947..b623267 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -108,6 +108,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "diagnose_10", VCPU_STAT(diagnose_10) },
 	{ "diagnose_44", VCPU_STAT(diagnose_44) },
 	{ "diagnose_9c", VCPU_STAT(diagnose_9c) },
+	{ "diagnose_258", VCPU_STAT(diagnose_258) },
+	{ "diagnose_308", VCPU_STAT(diagnose_308) },
+	{ "diagnose_500", VCPU_STAT(diagnose_500) },
 	{ NULL }
 };
 
-- 
2.3.0
