From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 2/4] KVM: s390: implement has_attr for FLIC
Date: Wed, 20 Apr 2016 14:54:54 +0200
Message-ID: <1461156896-27006-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, jfrei@linux.vnet.ibm.com, agraf@suse.de, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

HAS_ATTR is useful for determining the supported attributes; let's
implement it.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 84efc2b..4c2cdb2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2074,6 +2074,22 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return r;
 }
 
+static int flic_has_attr(struct kvm_device *dev,
+			     struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_FLIC_GET_ALL_IRQS:
+	case KVM_DEV_FLIC_ENQUEUE:
+	case KVM_DEV_FLIC_CLEAR_IRQS:
+	case KVM_DEV_FLIC_APF_ENABLE:
+	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
+	case KVM_DEV_FLIC_ADAPTER_REGISTER:
+	case KVM_DEV_FLIC_ADAPTER_MODIFY:
+		return 0;
+	}
+	return -ENXIO;
+}
+
 static int flic_create(struct kvm_device *dev, u32 type)
 {
 	if (!dev)
@@ -2095,6 +2111,7 @@ struct kvm_device_ops kvm_flic_ops = {
 	.name = "kvm-flic",
 	.get_attr = flic_get_attr,
 	.set_attr = flic_set_attr,
+	.has_attr = flic_has_attr,
 	.create = flic_create,
 	.destroy = flic_destroy,
 };
-- 
2.8.1
