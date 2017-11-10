From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] MAINTAINERS: add virtio-ccw.h to virtio/s390 section
Date: Fri, 10 Nov 2017 15:56:11 +0100
Message-ID: <20171110145611.15306-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The file arch/s390/include/uapi/asm/virtio-ccw.h belongs to the
s390 virtio drivers as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Martin, Heiko: It's probably best to take this through your tree.

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f375f7fc..48c6f1179b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14312,6 +14312,7 @@ L:	virtualization@lists.linux-foundation.org
 L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/s390/virtio/
+F:	arch/s390/include/uapi/asm/virtio-ccw.h
 
 VIRTIO GPU DRIVER
 M:	David Airlie <airlied@linux.ie>
-- 
2.13.6
