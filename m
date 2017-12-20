From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/5] kvm_config: add CONFIG_S390_GUEST
Date: Wed, 20 Dec 2017 16:53:00 +0100
Message-ID: <20171220155300.102321-6-borntraeger@de.ibm.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

make kvmconfig currently does not select CONFIG_S390_GUEST. Since
the virtio-ccw transport depends on CONFIG_S390_GUEST, we want
to add CONFIG_S390_GUEST to kvmconfig.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 kernel/configs/kvm_guest.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
index 8d9643767142..108fecc20fc1 100644
--- a/kernel/configs/kvm_guest.config
+++ b/kernel/configs/kvm_guest.config
@@ -18,6 +18,7 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
+CONFIG_S390_GUEST=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BLK=y
-- 
2.13.4
