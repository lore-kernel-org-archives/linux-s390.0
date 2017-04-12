From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v5 13/13] MAINTAINERS: Add vfio-ccw maintainer
Date: Wed, 12 Apr 2017 07:21:15 +0200
Message-ID: <20170412052115.101657-14-bjsdjshi@linux.vnet.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Add Cornelia Huck as the vfio-ccw maintainer.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c60235e..5bac5f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -999,6 +999,11 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 
+vfio-ccw
+M: Cornelia Huck <cornelia.huck@de.ibm.com>
+S: Supported
+F: hw/vfio/ccw.c
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-- 
2.10.2
