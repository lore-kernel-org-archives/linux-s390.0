From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Tue, 24 Aug 2010 15:48:51 +0200
Message-ID: <1282657732-20902-2-git-send-email-agraf@suse.de>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282657732-20902-1-git-send-email-agraf@suse.de>
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

The one big missing feature in s390-virtio was hotplugging. This is no more.
This patch implements hotplug add support, so you can on the fly add new devices
in the guest.

Keep in mind that this needs a patch for qemu to actually leverage the
functionality.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - move dev_add to kvm_virtio.h
---
 arch/s390/include/asm/kvm_virtio.h |    1 +
 drivers/s390/kvm/kvm_virtio.c      |   47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_virtio.h b/arch/s390/include/asm/kvm_virtio.h
index 3f5d100..72f6141 100644
--- a/arch/s390/include/asm/kvm_virtio.h
+++ b/arch/s390/include/asm/kvm_virtio.h
@@ -59,5 +59,6 @@ struct kvm_vqconfig {
 #define VIRTIO_PARAM_MASK		0xff
 #define VIRTIO_PARAM_VRING_INTERRUPT	0x0
 #define VIRTIO_PARAM_CONFIG_CHANGED	0x1
+#define VIRTIO_PARAM_DEV_ADD		0x2
 
 #endif
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 68cef4d..5a46b8c 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -32,6 +32,7 @@
  * The pointer to our (page) of device descriptions.
  */
 static void *kvm_devices;
+struct work_struct hotplug_work;
 
 struct kvm_device {
 	struct virtio_device vdev;
@@ -328,6 +329,47 @@ static void scan_devices(void)
 }
 
 /*
+ * match for a kvm device with a specific desc pointer
+ */
+static int match_desc(struct device *dev, void *data)
+{
+	if ((ulong)to_kvmdev(dev_to_virtio(dev))->desc == (ulong)data)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * hotplug_device tries to find changes in the device page.
+ */
+static void hotplug_devices(struct work_struct *dummy)
+{
+	unsigned int i;
+	struct kvm_device_desc *d;
+	struct device *dev;
+
+	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {
+		d = kvm_devices + i;
+
+		/* end of list */
+		if (d->type == 0)
+			break;
+
+		/* device already exists */
+		dev = device_find_child(kvm_root, d, match_desc);
+		if (dev) {
+			/* XXX check for hotplug remove */
+			put_device(dev);
+			continue;
+		}
+
+		/* new device */
+		printk(KERN_INFO "Adding new virtio device %p\n", d);
+		add_kvm_device(d, i);
+	}
+}
+
+/*
  * we emulate the request_irq behaviour on top of s390 extints
  */
 static void kvm_extint_handler(u16 code)
@@ -357,6 +399,9 @@ static void kvm_extint_handler(u16 code)
 
 		break;
 	}
+	case VIRTIO_PARAM_DEV_ADD:
+		schedule_work(&hotplug_work);
+		break;
 	case VIRTIO_PARAM_VRING_INTERRUPT:
 	default:
 		vring_interrupt(0, vq);
@@ -390,6 +435,8 @@ static int __init kvm_devices_init(void)
 
 	kvm_devices = (void *) real_memory_size;
 
+	INIT_WORK(&hotplug_work, hotplug_devices);
+
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, kvm_extint_handler);
 
-- 
1.6.0.2
