From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 40/51] KVM: s390: vsie: support guest-PER-enhancement
Date: Tue, 21 Jun 2016 15:13:18 +0200
Message-ID: <1466514809-146638-41-git-send-email-borntraeger@de.ibm.com>
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

We can easily forward the guest-PER-enhancement facility to guest 2 if
available.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 1d2e820..98526ac 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -101,6 +101,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_SIEF2	1
 #define KVM_S390_VM_CPU_FEAT_64BSCAO	2
 #define KVM_S390_VM_CPU_FEAT_SIIF	3
+#define KVM_S390_VM_CPU_FEAT_GPERE	4
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d735612..1757528 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -269,6 +269,8 @@ static void kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
 	if (sclp.has_siif)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIIF);
+	if (sclp.has_gpere)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_GPERE);
 }
 
 int kvm_arch_init(void *opaque)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 1615ed3..b8792ef 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -107,6 +107,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			return set_validity_icpt(scb_s, 0x0001U);
 		newflags |= CPUSTAT_GED2;
 	}
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_GPERE))
+		newflags |= cpuflags & CPUSTAT_P;
 
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
-- 
2.5.5
