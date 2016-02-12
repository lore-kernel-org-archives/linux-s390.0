From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/18] KVM: s390: usage hint for adapter mappings
Date: Fri, 12 Feb 2016 14:22:59 +0100
Message-ID: <1455283382-62999-16-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The interface for adapter mappings was designed with code in mind
that maps each address only once; let's document this.

Otherwise, duplicate mappings are added to the list, which makes
the code ineffective and uses up the limited amount of mapping
needlessly.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index d1ad9d5..e3e314c 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -88,6 +88,8 @@ struct kvm_s390_io_adapter_req {
       perform a gmap translation for the guest address provided in addr,
       pin a userspace page for the translated address and add it to the
       list of mappings
+      Note: A new mapping will be created unconditionally; therefore,
+            the calling code should avoid making duplicate mappings.
 
     KVM_S390_IO_ADAPTER_UNMAP
       release a userspace page for the translated address specified in addr
-- 
2.3.0
