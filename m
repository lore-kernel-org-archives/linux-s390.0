From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 2/3] MAINTAINERS: add Halil as additional vfio-ccw maintainer
Date: Wed, 31 Jan 2018 10:24:11 +0100
Message-ID: <20180131092412.9997-3-cohuck@redhat.com>
References: <20180131092412.9997-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180131092412.9997-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, david@redhat.com, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7a416c516b..990ac01c319d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11863,6 +11863,7 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
 M:	Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+M:	Halil Pasic <pasic@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
-- 
2.13.6
