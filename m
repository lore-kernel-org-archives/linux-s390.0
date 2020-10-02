Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgJBUBA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 16:01:00 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Add entry for s390 vfio-pci
Date: Fri,  2 Oct 2020 16:00:44 -0400
Message-Id: <1601668844-5798-6-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Add myself to cover s390-specific items related to vfio-pci.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa..389c4ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15162,6 +15162,14 @@ F:	Documentation/s390/vfio-ccw.rst
 F:	drivers/s390/cio/vfio_ccw*
 F:	include/uapi/linux/vfio_ccw.h
 
+S390 VFIO-PCI DRIVER
+M:	Matthew Rosato <mjrosato@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
+S:	Supported
+F:	drivers/vfio/pci/vfio_pci_zdev.c
+F:	include/uapi/linux/vfio_zdev.h
+
 S390 ZCRYPT DRIVER
 M:	Harald Freudenberger <freude@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
-- 
1.8.3.1
