From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v5 03/13] KVM: s390: CPU model support for AP virtualization
Date: Mon,  7 May 2018 11:11:42 -0400
Message-ID: <1525705912-12815-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduces a new CPU model feature and two CPU model
facilities to support AP virtualization for KVM guests.

CPU model feature:

The KVM_S390_VM_CPU_FEAT_AP feature indicates that
AP instructions are available on the guest. This
feature will be enabled by the kernel only if the AP
instructions are installed on the linux host. This feature
must be specifically turned on for the KVM guest from
userspace to use the VFIO AP device driver for guest
access to AP devices.

By default, AP instructions will be interpreted if this
feature is turned on for the KVM guest. This guarantees
that AP instructions executed on the guest will not be
met with an operation exception due to the fact that there
are no handlers to process intercepted AP instructions.

CPU model facilities:

1. AP Query Configuration Information (QCI) facility is installed.

   This is indicated by setting facilities bit 12 for
   the guest. The kernel will not enable this facility
   for the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

   If this facility is not set for the KVM guest, then only
   APQNs with an APQI less than 16 will be available to the
   guest regardless of the guest's matrix configuration. This
   is a limitation of the AP bus running on the guest.

2. AP Facilities Test facility (APFT) is installed.

   This is indicated by setting facilities bit 15 for
   the guest. The kernel will not enable this facility for
   the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

   If this facility is not set for the KVM guest, then no
   AP devices will be available to the guest regardless of
   the guest's matrix configuration. This is a limitation
   of the AP bus running under the guest.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    2 ++
 arch/s390/include/uapi/asm/kvm.h |    1 +
 arch/s390/kvm/kvm-s390.c         |   12 ++++++++++++
 arch/s390/tools/gen_facilities.c |    3 +++
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 5393c4d..ef4b237 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -186,6 +186,7 @@ struct kvm_s390_sie_block {
 #define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
@@ -714,6 +715,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55..a580dec 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_AP		14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 99779a6..81fbb0d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -367,6 +367,11 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+
+	/* Check if AP instructions installed on host */
+	if (kvm_ap_instructions_available())
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
+
 	/*
 	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
@@ -1928,6 +1933,8 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
 	kvm_s390_format_crycb(kvm);
+	/* Default setting indicating SIE shall interpret AP instructions */
+	kvm->arch.crypto.apie = 1;
 }
 
 static void sca_dispose(struct kvm *kvm)
@@ -2458,6 +2465,11 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
+	if (vcpu->kvm->arch.crypto.apie &&
+	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
 	/* If MSAX3 is installed, set up protected key support */
 	if (test_kvm_facility(vcpu->kvm, 76)) {
 		vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 90a8c9e..e0e2c19 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -106,6 +106,9 @@ struct facility_def {
 
 		.name = "FACILITIES_KVM_CPUMODEL",
 		.bits = (int[]){
+			12, /* AP Query Configuration Information */
+			15, /* AP Facilities Test */
+			156, /* Execution Token facility */
 			-1  /* END */
 		}
 	},
-- 
1.7.1
