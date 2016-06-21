From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 44/51] KVM: s390: vsie: support IBS interpretation
Date: Tue, 21 Jun 2016 15:13:22 +0200
Message-ID: <1466514809-146638-45-git-send-email-borntraeger@de.ibm.com>
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

We can easily enable ibs for guest 2, so he can use it for guest 3.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 7630dd7..c128567 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -105,6 +105,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_GSLS	5
 #define KVM_S390_VM_CPU_FEAT_IB		6
 #define KVM_S390_VM_CPU_FEAT_CEI	7
+#define KVM_S390_VM_CPU_FEAT_IBS	8
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1c1188b..8ba7a98 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -277,6 +277,8 @@ static void kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IB);
 	if (sclp.has_cei)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_CEI);
+	if (sclp.has_ibs)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
 }
 
 int kvm_arch_init(void *opaque)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index f3a4a0b..3ececbb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -111,6 +111,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		newflags |= cpuflags & CPUSTAT_P;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_GSLS))
 		newflags |= cpuflags & CPUSTAT_SM;
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IBS))
+		newflags |= cpuflags & CPUSTAT_IBS;
 
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
-- 
2.5.5
