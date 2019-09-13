Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390166AbfIMV1O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 17:27:14 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v6 09/10] s390: vfio-ap: added versioning to vfio_ap module
Date: Fri, 13 Sep 2019 17:26:57 -0400
Message-Id: <1568410018-10833-10-git-send-email-akrowiak@linux.ibm.com>
In-Reply-To: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Added versioning to vfio_ap module. The introduction of hot plug/unplug
and over-provisioning of AP resources require a different set of
regression tests to be run. Version checking provides a means for the
regression test software to determine the appropriate set of tests to run.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 2 ++
 drivers/s390/crypto/vfio_ap_private.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 477218e39289..d9051cf7fd5c 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -21,6 +21,8 @@
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(VFIO_AP_MODULE_VERSION);
+
 
 static struct ap_driver vfio_ap_drv;
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 21546bb90240..8d2099d222fa 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -22,6 +22,7 @@
 #include "ap_bus.h"
 
 #define VFIO_AP_MODULE_NAME "vfio_ap"
+#define VFIO_AP_MODULE_VERSION "1.2.0"
 #define VFIO_AP_DRV_NAME "vfio_ap"
 
 /**
-- 
2.7.4
