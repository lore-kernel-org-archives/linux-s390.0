Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3948 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgHUT4c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Aug 2020 15:56:32 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Date: Fri, 21 Aug 2020 15:56:01 -0400
Message-Id: <20200821195616.13554-2-akrowiak@linux.ibm.com>
In-Reply-To: <20200821195616.13554-1-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Let's set a version for the vfio_ap module so that automated regression
tests can determine whether dynamic configuration tests can be run or
not.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index be2520cc010b..f4ceb380dd61 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -17,10 +17,12 @@
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
 #define VFIO_AP_DEV_NAME "matrix"
+#define VFIO_AP_MODULE_VERSION "1.2.0"
 
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(VFIO_AP_MODULE_VERSION);
 
 static struct ap_driver vfio_ap_drv;
 
-- 
2.21.1
