From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 2/5] KVM: s390: Export virtio-ccw api.
Date: Mon, 25 Feb 2013 16:27:47 +0100
Message-ID: <1361806070-62465-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

Export the virtio-ccw api in a header for usage by other code.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/uapi/asm/Kbuild       |  1 +
 arch/s390/include/uapi/asm/virtio-ccw.h | 21 +++++++++++++++++++++
 drivers/s390/kvm/virtio_ccw.c           |  5 +----
 3 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/virtio-ccw.h

diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 7bf68ff..9ccd190 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -44,5 +44,6 @@ header-y += termios.h
 header-y += types.h
 header-y += ucontext.h
 header-y += unistd.h
+header-y += virtio-ccw.h
 header-y += vtoc.h
 header-y += zcrypt.h
diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
new file mode 100644
index 0000000..a9a4ebf
--- /dev/null
+++ b/arch/s390/include/uapi/asm/virtio-ccw.h
@@ -0,0 +1,21 @@
+/*
+ * Definitions for virtio-ccw devices.
+ *
+ * Copyright IBM Corp. 2013
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *  Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ */
+#ifndef __KVM_VIRTIO_CCW_H
+#define __KVM_VIRTIO_CCW_H
+
+/* Alignment of vring buffers. */
+#define KVM_VIRTIO_CCW_RING_ALIGN 4096
+
+/* Subcode for diagnose 500 (virtio hypercall). */
+#define KVM_S390_VIRTIO_CCW_NOTIFY 3
+
+#endif
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 3217dfe..c5532b3 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -31,6 +31,7 @@
 #include <asm/irq.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
+#include <asm/virtio-ccw.h>
 
 /*
  * virtio related functions
@@ -79,10 +80,6 @@ struct virtio_ccw_vq_info {
 	struct list_head node;
 };
 
-#define KVM_VIRTIO_CCW_RING_ALIGN 4096
-
-#define KVM_S390_VIRTIO_CCW_NOTIFY 3
-
 #define CCW_CMD_SET_VQ 0x13
 #define CCW_CMD_VDEV_RESET 0x33
 #define CCW_CMD_SET_IND 0x43
-- 
1.7.12.4
