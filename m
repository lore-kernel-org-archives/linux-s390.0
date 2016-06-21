From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 39/51] KVM: s390: vsie: support shared IPTE-interlock facility
Date: Tue, 21 Jun 2016 15:13:17 +0200
Message-ID: <1466514809-146638-40-git-send-email-borntraeger@de.ibm.com>
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

As we forward the whole SCA provided by guest 2, we can directly forward
SIIF if available.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index c5e4537..1d2e820 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -100,6 +100,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_ESOP	0
 #define KVM_S390_VM_CPU_FEAT_SIEF2	1
 #define KVM_S390_VM_CPU_FEAT_64BSCAO	2
+#define KVM_S390_VM_CPU_FEAT_SIIF	3
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e0c5a57..d735612 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -267,6 +267,8 @@ static void kvm_s390_cpu_feat_init(void)
 	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
 	if (sclp.has_64bscao)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
+	if (sclp.has_siif)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIIF);
 }
 
 int kvm_arch_init(void *opaque)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 44e66c3..1615ed3 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -315,6 +315,8 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* Run-time-Instrumentation */
 	if (test_kvm_facility(vcpu->kvm, 64))
 		scb_s->ecb3 |= scb_o->ecb3 & 0x01U;
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIIF))
+		scb_s->eca |= scb_o->eca & 0x00000001U;
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
-- 
2.5.5
