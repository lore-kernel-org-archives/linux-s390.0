From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v5 4/6] KVM: Introduce KVM_VIRTIO_CCW_NOTIFY_BUS.
Date: Thu, 28 Feb 2013 12:33:19 +0100
Message-ID: <1362051201-56541-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

Add a new bus type for virtio-ccw devices on s390.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b768ef..206247f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -148,6 +148,7 @@ struct kvm_io_bus {
 enum kvm_bus {
 	KVM_MMIO_BUS,
 	KVM_PIO_BUS,
+	KVM_VIRTIO_CCW_NOTIFY_BUS,
 	KVM_NR_BUSES
 };
 
-- 
1.7.12.4
