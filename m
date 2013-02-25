From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 4/5] KVM: ioeventfd for virtio-ccw devices.
Date: Mon, 25 Feb 2013 16:27:49 +0100
Message-ID: <1361806070-62465-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

Enhance KVM_IOEVENTFD with a new flag that allows to attach to virtio-ccw
devices on s390 via the KVM_VIRTIO_CCW_NOTIFY_BUS.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  8 ++++++++
 include/uapi/linux/kvm.h          |  3 +++
 virt/kvm/eventfd.c                | 14 ++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c2534c3..86232d6 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1468,15 +1468,23 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+For the special case of virtio-ccw devices on s390, the ioevent is matched
+to a subchannel/virtqueue tuple instead.
+
 The following flags are defined:
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY \
+	(1 << kvm_ioeventfd_flag_nr_virtio_ccw_notify)
 
 If datamatch flag is set, the event will be signaled only if the written value
 to the registered address is equal to datamatch in struct kvm_ioeventfd.
 
+For virtio-ccw devices, addr contains the subchannel id and datamatch the
+virtqueue index.
+
 
 4.60 KVM_DIRTY_TLB
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9a2db57..8f3e5ae 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -448,12 +448,15 @@ enum {
 	kvm_ioeventfd_flag_nr_datamatch,
 	kvm_ioeventfd_flag_nr_pio,
 	kvm_ioeventfd_flag_nr_deassign,
+	kvm_ioeventfd_flag_nr_virtio_ccw_notify,
 	kvm_ioeventfd_flag_nr_max,
 };
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY \
+	(1 << kvm_ioeventfd_flag_nr_virtio_ccw_notify)
 
 #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
 
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index f0ced1a..8de3cd7 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -679,11 +679,16 @@ static int
 kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
 	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
-	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
+	int                       ccw;
+	enum kvm_bus              bus_idx;
 	struct _ioeventfd        *p;
 	struct eventfd_ctx       *eventfd;
 	int                       ret;
 
+	ccw = args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY;
+	bus_idx = pio ? KVM_PIO_BUS :
+		ccw ? KVM_VIRTIO_CCW_NOTIFY_BUS :
+		KVM_MMIO_BUS;
 	/* must be natural-word sized */
 	switch (args->len) {
 	case 1:
@@ -759,11 +764,16 @@ static int
 kvm_deassign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
 	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
-	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
+	int                       ccw;
+	enum kvm_bus              bus_idx;
 	struct _ioeventfd        *p, *tmp;
 	struct eventfd_ctx       *eventfd;
 	int                       ret = -ENOENT;
 
+	ccw = args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY;
+	bus_idx = pio ? KVM_PIO_BUS :
+		ccw ? KVM_VIRTIO_CCW_NOTIFY_BUS :
+		KVM_MMIO_BUS;
 	eventfd = eventfd_ctx_fdget(args->fd);
 	if (IS_ERR(eventfd))
 		return PTR_ERR(eventfd);
-- 
1.7.12.4
