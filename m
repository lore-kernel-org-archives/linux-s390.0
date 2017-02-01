From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/12] KVM: s390: instruction-execution-protection support
Date: Wed,  1 Feb 2017 12:38:05 +0100
Message-ID: <1485949094-138708-4-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

The new Instruction Execution Protection needs to be enabled before
the guest can use it. Therefore we pass the IEP facility bit to the
guest and enable IEP interpretation.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 3 +++
 arch/s390/tools/gen_facilities.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bec71e9..e513081 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1938,6 +1938,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	if (test_kvm_facility(vcpu->kvm, 8) && sclp.has_pfmfi)
 		vcpu->arch.sie_block->ecb2 |= 0x08;
+	if (test_kvm_facility(vcpu->kvm, 130))
+		vcpu->arch.sie_block->ecb2 |= 0x20;
 	vcpu->arch.sie_block->eca = 0x1002000U;
 	if (sclp.has_cei)
 		vcpu->arch.sie_block->eca |= 0x80000000U;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d8673e2..ed62c6d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -324,6 +324,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* Run-time-Instrumentation */
 	if (test_kvm_facility(vcpu->kvm, 64))
 		scb_s->ecb3 |= scb_o->ecb3 & 0x01U;
+	/* Instruction Execution Prevention */
+	if (test_kvm_facility(vcpu->kvm, 130))
+		scb_s->ecb2 |= scb_o->ecb2 & 0x20U;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIIF))
 		scb_s->eca |= scb_o->eca & 0x00000001U;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IB))
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index b6ac8df..0cf802d 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -80,6 +80,7 @@ static struct facility_def facility_defs[] = {
 			76, /* msa extension 3 */
 			77, /* msa extension 4 */
 			78, /* enhanced-DAT 2 */
+			130, /* instruction-execution-protection */
 			131, /* enhanced-SOP 2 and side-effect */
 			-1  /* END */
 		}
-- 
2.7.4
