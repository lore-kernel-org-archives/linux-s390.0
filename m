From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/3] S390: take a full byte as ext_param indicator
Date: Tue, 24 Aug 2010 15:48:50 +0200
Message-ID: <1282657732-20902-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: virtualization@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, borntraeger@de.ibm.com, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Currenty the ext_param field only distinguishes between "config change" and
"vring interrupt". We can do a lot more with it though, so let's enable a
full byte of possible values and constants to #defines while at it.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - move defines to virtio_s390.h
---
 arch/s390/include/asm/kvm_virtio.h |    6 ++++++
 drivers/s390/kvm/kvm_virtio.c      |   19 +++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_virtio.h b/arch/s390/include/asm/kvm_virtio.h
index acdfdff..3f5d100 100644
--- a/arch/s390/include/asm/kvm_virtio.h
+++ b/arch/s390/include/asm/kvm_virtio.h
@@ -54,4 +54,10 @@ struct kvm_vqconfig {
  * This is pagesize for historical reasons. */
 #define KVM_S390_VIRTIO_RING_ALIGN	4096
 
+
+/* These values are supposed to be in ext_params on an interrupt */
+#define VIRTIO_PARAM_MASK		0xff
+#define VIRTIO_PARAM_VRING_INTERRUPT	0x0
+#define VIRTIO_PARAM_CONFIG_CHANGED	0x1
+
 #endif
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 4e298bc..68cef4d 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -334,7 +334,7 @@ static void kvm_extint_handler(u16 code)
 {
 	struct virtqueue *vq;
 	u16 subcode;
-	int config_changed;
+	u32 param;
 
 	subcode = S390_lowcore.cpu_addr;
 	if ((subcode & 0xff00) != VIRTIO_SUBCODE_64)
@@ -343,18 +343,25 @@ static void kvm_extint_handler(u16 code)
 	/* The LSB might be overloaded, we have to mask it */
 	vq = (struct virtqueue *)(S390_lowcore.ext_params2 & ~1UL);
 
-	/* We use the LSB of extparam, to decide, if this interrupt is a config
-	 * change or a "standard" interrupt */
-	config_changed = S390_lowcore.ext_params & 1;
+	/* We use ext_params to decide what this interrupt means */
+	param = S390_lowcore.ext_params & VIRTIO_PARAM_MASK;
 
-	if (config_changed) {
+	switch (param) {
+	case VIRTIO_PARAM_CONFIG_CHANGED:
+	{
 		struct virtio_driver *drv;
 		drv = container_of(vq->vdev->dev.driver,
 				   struct virtio_driver, driver);
 		if (drv->config_changed)
 			drv->config_changed(vq->vdev);
-	} else
+
+		break;
+	}
+	case VIRTIO_PARAM_VRING_INTERRUPT:
+	default:
 		vring_interrupt(0, vq);
+		break;
+	}
 }
 
 /*
-- 
1.6.0.2
