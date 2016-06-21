From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 38/51] KVM: s390: vsie: support 64-bit-SCAO
Date: Tue, 21 Jun 2016 15:13:16 +0200
Message-ID: <1466514809-146638-39-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's provide the 64-bit-SCAO facility to guest 2, so he can set up a SCA
for guest 3 that has a 64 bit address. Please note that we already require
the 64 bit SCAO for our vsie implementation, in order to forward the SCA
directly (by pinning the page).

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 62423b1..c5e4537 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -99,6 +99,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_NR_BITS	1024
 #define KVM_S390_VM_CPU_FEAT_ESOP	0
 #define KVM_S390_VM_CPU_FEAT_SIEF2	1
+#define KVM_S390_VM_CPU_FEAT_64BSCAO	2
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3fb1242..e0c5a57 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -265,6 +265,8 @@ static void kvm_s390_cpu_feat_init(void)
 	    !test_facility(3))
 		return;
 	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
+	if (sclp.has_64bscao)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
 }
 
 int kvm_arch_init(void *opaque)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ebc988f..44e66c3 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -449,6 +449,8 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
 	if (hpa) {
 		gpa = scb_o->scaol & ~0xfUL;
+		if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
+			gpa |= (u64) scb_o->scaoh << 32;
 		unpin_guest_page(vcpu->kvm, gpa, hpa);
 		scb_s->scaol = 0;
 		scb_s->scaoh = 0;
@@ -499,6 +501,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	int rc = 0;
 
 	gpa = scb_o->scaol & ~0xfUL;
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
+		gpa |= (u64) scb_o->scaoh << 32;
 	if (gpa) {
 		if (!(gpa & ~0x1fffUL))
 			rc = set_validity_icpt(scb_s, 0x0038U);
-- 
2.5.5
