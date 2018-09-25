From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 25/26] KVM: s390: CPU model support for AP virtualization
Date: Tue, 25 Sep 2018 19:16:40 -0400
Message-ID: <20180925231641.4954-26-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new CPU model facilities to support
AP virtualization for KVM guests:

1. AP Query Configuration Information (QCI) facility is installed.

   This is indicated by setting facilities bit 12 for
   the guest. The kernel will not enable this facility
   for the guest if it is not set on the host.

   If this facility is not set for the KVM guest, then only
   APQNs with an APQI less than 16 will be used by a Linux
   guest regardless of the matrix configuration for the virtual
   machine. This is a limitation of the Linux AP bus.

2. AP Facilities Test facility (APFT) is installed.

   This is indicated by setting facilities bit 15 for
   the guest. The kernel will not enable this facility for
   the guest if it is not set on the host.

   If this facility is not set for the KVM guest, then no
   AP devices will be available to the guest regardless of
   the guest's matrix configuration for the virtual
   machine. This is a limitation of the Linux AP bus.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c         | 1 +
 arch/s390/tools/gen_facilities.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 81fd82f7626d..444965e78010 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -371,6 +371,7 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+
 	/*
 	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 0c85aedcf9b3..fd788e0f2e5b 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -106,6 +106,8 @@ static struct facility_def facility_defs[] = {
 
 		.name = "FACILITIES_KVM_CPUMODEL",
 		.bits = (int[]){
+			12, /* AP Query Configuration Information */
+			15, /* AP Facilities Test */
 			156, /* etoken facility */
 			-1  /* END */
 		}
-- 
2.19.0.221.g150f307
