From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 03/14] KVM: s390: CPU model support for AP virtualization
Date: Wed, 14 Mar 2018 14:25:43 -0400
Message-ID: <1521051954-25715-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
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

CPU model facilities:

1. AP Query Configuration Information (QCI) facility is installed.

   This is indicated by setting facilities bit 12 for
   the guest. The kernel will not enable this facility
   for the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

2. AP Facilities Test facility (APFT) is installed.

   This is indicated by setting facilities bit 15 for
   the guest. The kernel will not enable this facility for
   the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/include/uapi/asm/kvm.h |    1 +
 arch/s390/kvm/kvm-s390.c         |    4 ++++
 arch/s390/tools/gen_facilities.c |    2 ++
 4 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 65a944e..98957c2 100644
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
index c47731d..a60c45b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -350,6 +350,10 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+
+	if (ap_instructions_installed()) /* AP instructions installed on host */
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
+
 	/*
 	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 83ffefc..a8ae59a 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -107,6 +107,8 @@ struct facility_def {
 
 		.name = "FACILITIES_KVM_CPUMODEL",
 		.bits = (int[]){
+			12, /* AP Query Configuration Information */
+			15, /* AP Facilities Test */
 			-1  /* END */
 		}
 	},
-- 
1.7.1
