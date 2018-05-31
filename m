From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 31 May 2018 21:08:00 +0000
Subject: [GIT PULL 7/7] KVM: s390: vsie: simplify < 8k address checks
Message-Id: <20180531210800.137347-8-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

This makes it certainly more readable.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 969882b54266..84c89cb9636f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -557,7 +557,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
 		gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
 	if (gpa) {
-		if (!(gpa & ~0x1fffUL))
+		if (gpa < 2 * PAGE_SIZE)
 			rc = set_validity_icpt(scb_s, 0x0038U);
 		else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
 			rc = set_validity_icpt(scb_s, 0x0011U);
@@ -578,7 +578,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
 	if (gpa && (scb_s->ecb & ECB_TE)) {
-		if (!(gpa & ~0x1fffUL)) {
+		if (gpa < 2 * PAGE_SIZE) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
@@ -594,7 +594,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = READ_ONCE(scb_o->gvrd) & ~0x1ffUL;
 	if (gpa && (scb_s->eca & ECA_VX) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
-		if (!(gpa & ~0x1fffUL)) {
+		if (gpa < 2 * PAGE_SIZE) {
 			rc = set_validity_icpt(scb_s, 0x1310U);
 			goto unpin;
 		}
@@ -613,7 +613,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = READ_ONCE(scb_o->riccbd) & ~0x3fUL;
 	if (gpa && (scb_s->ecb3 & ECB3_RI)) {
-		if (!(gpa & ~0x1fffUL)) {
+		if (gpa < 2 * PAGE_SIZE) {
 			rc = set_validity_icpt(scb_s, 0x0043U);
 			goto unpin;
 		}
@@ -632,7 +632,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 		gpa = READ_ONCE(scb_o->sdnxo) & ~0xfUL;
 		sdnxc = READ_ONCE(scb_o->sdnxo) & 0xfUL;
-		if (!gpa || !(gpa & ~0x1fffUL)) {
+		if (!gpa || gpa < 2 * PAGE_SIZE) {
 			rc = set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
 		}
-- 
2.14.2
