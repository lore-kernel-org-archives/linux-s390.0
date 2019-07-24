Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfGXVcI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jul 2019 17:32:08 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH 1/1] MAINTAINERS: vfio-ccw: Remove myself as the maintainer
Date: Wed, 24 Jul 2019 17:32:03 -0400
Message-Id: <19aee1ab0e5bcc01053b515117a66426a9332086.1564003585.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1564003585.git.alifm@linux.ibm.com>
References: <cover.1564003585.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

I will not be able to continue with my maintainership responsibilities
going forward, so remove myself as the maintainer.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e90487..dd07a23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13696,7 +13696,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
 
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
-M:	Farhan Ali <alifm@linux.ibm.com>
 M:	Eric Farman <farman@linux.ibm.com>
 R:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
-- 
2.7.4
