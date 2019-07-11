Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbfGKOaC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 10:30:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BETjTb120326
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 10:30:01 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp4r1xksn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 10:29:49 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Thu, 11 Jul 2019 15:28:59 +0100
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v3 5/5] vfio-ccw: Update documentation for csch/hsch
Date: Thu, 11 Jul 2019 10:28:55 -0400
In-Reply-To: <cover.1562854091.git.alifm@linux.ibm.com>
References: <cover.1562854091.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1562854091.git.alifm@linux.ibm.com>
References: <cover.1562854091.git.alifm@linux.ibm.com>
Message-Id: <7d977612c3f3152ffb950d77ae11b4b25c1e20c4.1562854091.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

We now support CLEAR SUBCHANNEL and HALT SUBCHANNEL
via ccw_cmd_region.

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index 1f6d0b5..be2af10 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -180,6 +180,13 @@ The process of how these work together.
    add it to an iommu_group and a vfio_group. Then we could pass through
    the mdev to a guest.
 
+
+VFIO-CCW Regions
+----------------
+
+The vfio-ccw driver exposes MMIO regions to accept requests from and return
+results to userspace.
+
 vfio-ccw I/O region
 -------------------
 
@@ -205,6 +212,25 @@ irb_area stores the I/O result.
 
 ret_code stores a return code for each access of the region.
 
+This region is always available.
+
+vfio-ccw cmd region
+-------------------
+
+The vfio-ccw cmd region is used to accept asynchronous instructions
+from userspace.
+
+#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+struct ccw_cmd_region {
+       __u32 command;
+       __u32 ret_code;
+} __packed;
+
+This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
+
+Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
+
 vfio-ccw operation details
 --------------------------
 
@@ -306,9 +332,8 @@ Together with the corresponding work in QEMU, we can bring the passed
 through DASD/ECKD device online in a guest now and use it as a block
 device.
 
-While the current code allows the guest to start channel programs via
-START SUBCHANNEL, support for HALT SUBCHANNEL or CLEAR SUBCHANNEL is
-not yet implemented.
+The current code allows the guest to start channel programs via
+START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
 
 vfio-ccw supports classic (command mode) channel I/O only. Transport
 mode (HPF) is not supported.
-- 
2.7.4
