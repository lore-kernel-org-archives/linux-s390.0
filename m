From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 3/4] KVM: s390: document FLIC behavior on unsupported
Date: Wed, 20 Apr 2016 14:54:55 +0200
Message-ID: <1461156896-27006-4-git-send-email-cornelia.huck@de.ibm.com>
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

FLIC behavior deviates from the API documentation in reporting EINVAL
instead of ENXIO for KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR when the group
or attribute is unknown/unsupported. Unfortunately this can not be fixed
for historical reasons. Let us at least have it documented.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index e3e314c..646f474 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -94,3 +94,9 @@ struct kvm_s390_io_adapter_req {
     KVM_S390_IO_ADAPTER_UNMAP
       release a userspace page for the translated address specified in addr
       from the list of mappings
+
+Note: The KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR device ioctls executed on
+FLIC with an unknown group or attribute gives the error code EINVAL (instead of
+ENXIO, as specified in the API documentation). It is not possible to conclude
+that a FLIC operation is unavailable based on the error code resulting from a
+usage attempt.
-- 
2.8.1
