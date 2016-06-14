From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/52] KVM: s390: gaccess: store guest address on ALC prot exceptions
Date: Tue, 14 Jun 2016 20:56:48 +0200
Message-ID: <1465930649-181383-12-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's pass the effective guest address to get_vcpu_asce(), so we
can properly set the guest address in case we inject an ALC protection
exception.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 66938d2..c0da9e9 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -477,7 +477,7 @@ enum {
 };
 
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
-			 ar_t ar, enum gacc_mode mode)
+			 unsigned long ga, ar_t ar, enum gacc_mode mode)
 {
 	int rc;
 	struct psw_bits psw = psw_bits(vcpu->arch.sie_block->gpsw);
@@ -519,6 +519,7 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 			vcpu->arch.pgm.exc_access_id = ar;
 			break;
 		case PGM_PROTECTION:
+			tec_bits->addr = ga >> PAGE_SHIFT;
 			tec_bits->b60 = 1;
 			tec_bits->b61 = 1;
 			break;
@@ -783,7 +784,8 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 
 	if (!len)
 		return 0;
-	rc = get_vcpu_asce(vcpu, &asce, ar, mode);
+	ga = kvm_s390_logical_to_effective(vcpu, ga);
+	rc = get_vcpu_asce(vcpu, &asce, ga, ar, mode);
 	if (rc)
 		return rc;
 	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
@@ -854,7 +856,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 
 	gva = kvm_s390_logical_to_effective(vcpu, gva);
 	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	rc = get_vcpu_asce(vcpu, &asce, ar, mode);
+	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
 	tec->addr = gva >> PAGE_SHIFT;
 	if (rc)
 		return rc;
-- 
2.5.5
