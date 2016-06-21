From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 41/51] KVM: s390: vsie: support guest-storage-limit-suppression
Date: Tue, 21 Jun 2016 15:13:19 +0200
Message-ID: <1466514809-146638-42-git-send-email-borntraeger@de.ibm.com>
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

We can easily forward guest-storage-limit-suppression if available.

One thing to care about is keeping the prefix properly mapped when
gsls in toggled on/off or the mso changes in between. Therefore we better
remap the prefix on any mso changes just like we already do with the
prefix.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 7 +++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 98526ac..9ed0747 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -102,6 +102,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_64BSCAO	2
 #define KVM_S390_VM_CPU_FEAT_SIIF	3
 #define KVM_S390_VM_CPU_FEAT_GPERE	4
+#define KVM_S390_VM_CPU_FEAT_GSLS	5
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1757528..ce9813a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -271,6 +271,8 @@ static void kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIIF);
 	if (sclp.has_gpere)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_GPERE);
+	if (sclp.has_gsls)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_GSLS);
 }
 
 int kvm_arch_init(void *opaque)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index b8792ef..ea65bf2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -109,6 +109,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_GPERE))
 		newflags |= cpuflags & CPUSTAT_P;
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_GSLS))
+		newflags |= cpuflags & CPUSTAT_SM;
 
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
@@ -242,7 +244,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	bool had_tx = scb_s->ecb & 0x10U;
-	unsigned long new_mso;
+	unsigned long new_mso = 0;
 	int rc;
 
 	/* make sure we don't have any leftovers when reusing the scb */
@@ -284,7 +286,8 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 	scb_s->icpua = scb_o->icpua;
 
-	new_mso = scb_o->mso & 0xfffffffffff00000UL;
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
+		new_mso = scb_o->mso & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
 	if (scb_s->mso != new_mso || scb_s->prefix != scb_o->prefix)
 		prefix_unmapped(vsie_page);
-- 
2.5.5
