From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:52 +0000
Subject: [GIT PULL 25/28] KVM: s390: CPU model support for AP virtualization
Message-Id: <20181002070655.224110-26-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
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
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20180925231641.4954-26-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/tools/gen_facilities.c | 2 ++
 1 file changed, 2 insertions(+)

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
2.17.0
