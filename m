From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH] s390: vfio-ap: trace the update of APCB masks
Date: Fri,  5 Oct 2018 09:33:01 +0200
Message-ID: <1538724781-31852-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Define a tracing function to trace in the KVM trace buffer
and trace the changes of the APCB masks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 22 ++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a8a9984..00e632a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -753,6 +753,28 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
 	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
 	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
 	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
+
+	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: apm %016lx %016lx %016lx %016lx",
+			    apm[0], apm[1], apm[2], apm[3]);
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
+			    aqm[0], aqm[1], aqm[2], aqm[3]);
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: adm %016lx %016lx %016lx %016lx",
+			    adm[0], adm[1], adm[2], adm[3]);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Both CRYCB format uses APCB format 0 */
+	default: /* Can not happen */
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: apm %016lx aqm %04x adm %04x", apm[0],
+			    *((unsigned short *)aqm), *((unsigned short *)adm));
+		break;
+	}
+
 }
 
 /**
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5675492..4cd779d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -19,6 +19,10 @@
 
 #include "ap_bus.h"
 
+#define VM_AP_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
+	debug_sprintf_event(d_kvm->arch.dbf, d_loglevel, d_string "\n", \
+			    d_args)
+
 #define VFIO_AP_MODULE_NAME "vfio_ap"
 #define VFIO_AP_DRV_NAME "vfio_ap"
 
-- 
2.7.4
