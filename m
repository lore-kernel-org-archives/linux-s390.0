From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 50/51] KVM: s390: vsie: add indication for future features
Date: Tue, 21 Jun 2016 15:13:28 +0200
Message-ID: <1466514809-146638-51-git-send-email-borntraeger@de.ibm.com>
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

We have certain SIE features that we cannot support for now.
Let's add these features, so user space can directly prepare to enable
them, so we don't have to update yet another component.

In addition, add a comment block, telling why it is for now not possible to
forward/enable these features.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  4 ++++
 arch/s390/kvm/kvm-s390.c         | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index c128567..a2ffec4 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -106,6 +106,10 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_IB		6
 #define KVM_S390_VM_CPU_FEAT_CEI	7
 #define KVM_S390_VM_CPU_FEAT_IBS	8
+#define KVM_S390_VM_CPU_FEAT_SKEY	9
+#define KVM_S390_VM_CPU_FEAT_CMMA	10
+#define KVM_S390_VM_CPU_FEAT_PFMFI	11
+#define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6fdf1f7..31cf22f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -281,6 +281,24 @@ static void kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_CEI);
 	if (sclp.has_ibs)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
+	/*
+	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
+	 * all skey handling functions read/set the skey from the PGSTE
+	 * instead of the real storage key.
+	 *
+	 * KVM_S390_VM_CPU_FEAT_CMMA: Wrong shadow of PTE.I bits will make
+	 * pages being detected as preserved although they are resident.
+	 *
+	 * KVM_S390_VM_CPU_FEAT_PFMFI: Wrong shadow of PTE.I bits will
+	 * have the same effect as for KVM_S390_VM_CPU_FEAT_SKEY.
+	 *
+	 * For KVM_S390_VM_CPU_FEAT_SKEY, KVM_S390_VM_CPU_FEAT_CMMA and
+	 * KVM_S390_VM_CPU_FEAT_PFMFI, all PTE.I and PGSTE bits have to be
+	 * correctly shadowed. We can do that for the PGSTE but not for PTE.I.
+	 *
+	 * KVM_S390_VM_CPU_FEAT_SIGPIF: Wrong SCB addresses in the SCA. We
+	 * cannot easily shadow the SCA because of the ipte lock.
+	 */
 }
 
 int kvm_arch_init(void *opaque)
-- 
2.5.5
