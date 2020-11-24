Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v12 02/17] s390/vfio-ap: decrement reference count to KVM
Date: Tue, 24 Nov 2020 16:40:01 -0500
Message-Id: <20201124214016.3013-3-akrowiak@linux.ibm.com>
In-Reply-To: <20201124214016.3013-1-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@stny.rr.com>

Decrement the reference count to KVM when notified that KVM pointer is
invalidated via the vfio group notifier.

Signed-off-by: Tony Krowiak <akrowiak@stny.rr.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 66fd9784a156..31e39c1f6e56 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1095,7 +1095,11 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
 
 	if (!data) {
+		if (matrix_mdev->kvm)
+			kvm_put_kvm(matrix_mdev->kvm);
+
 		matrix_mdev->kvm = NULL;
+
 		return NOTIFY_OK;
 	}
 
-- 
2.21.1
