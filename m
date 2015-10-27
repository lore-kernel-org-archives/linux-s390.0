From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] s390/virtio: use noop dma ops
Date: Tue, 27 Oct 2015 23:48:51 +0100
Message-ID: <1445986131-239566-5-git-send-email-borntraeger@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

With all infrastructure in place, lets provide dma_ops for virtio
devices on s390.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/virtio/kvm_virtio.c | 2 ++
 drivers/s390/virtio/virtio_ccw.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
index 53fb975..05adaa9 100644
--- a/drivers/s390/virtio/kvm_virtio.c
+++ b/drivers/s390/virtio/kvm_virtio.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
@@ -318,6 +319,7 @@ static void add_kvm_device(struct kvm_device_desc *d, unsigned int offset)
 		return;
 	}
 
+	kdev->vdev.dev.archdata.dma_ops = &dma_noop_ops;
 	kdev->vdev.dev.parent = kvm_root;
 	kdev->vdev.id.device = d->type;
 	kdev->vdev.config = &kvm_vq_configspace_ops;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1cda784..8fb7a6b 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
@@ -1093,6 +1094,7 @@ static void virtio_ccw_auto_online(void *data, async_cookie_t cookie)
 	struct ccw_device *cdev = data;
 	int ret;
 
+	cdev->dev.archdata.dma_ops = &dma_noop_ops;
 	ret = ccw_device_set_online(cdev);
 	if (ret)
 		dev_warn(&cdev->dev, "Failed to set online: %d\n", ret);
-- 
2.4.3
