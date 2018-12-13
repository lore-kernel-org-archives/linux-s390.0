From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 13 Dec 2018 08:55:27 +0000
Subject: [PULL 2/2] MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil Reviewer
Message-Id: <20181213085527.26540-3-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Eric and Farhan will help with maintaining vfio-ccw.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20181212145929.136522-1-borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d17f568a3b9..2e9d876d65d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13021,7 +13021,9 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
 
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
-M:	Halil Pasic <pasic@linux.ibm.com>
+M:	Farhan Ali <alifm@linux.ibm.com>
+M:	Eric Farman <farman@linux.ibm.com>
+R:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
-- 
2.17.2
