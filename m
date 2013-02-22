From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 2/4] KVM: Introduce KVM_CSS_BUS.
Date: Fri, 22 Feb 2013 13:09:47 +0100
Message-ID: <1361534989-38884-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Add a new bus type for s390 css kvm io devices.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b768ef..59be516 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -148,6 +148,7 @@ struct kvm_io_bus {
 enum kvm_bus {
 	KVM_MMIO_BUS,
 	KVM_PIO_BUS,
+	KVM_CSS_BUS,
 	KVM_NR_BUSES
 };
 
-- 
1.7.12.4
