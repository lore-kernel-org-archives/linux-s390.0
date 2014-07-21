From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/9] KVM: s390: document KVM_CAP_S390_IRQCHIP
Date: Mon, 21 Jul 2014 21:14:23 +0200
Message-ID: <1405970065-3740-8-git-send-email-borntraeger@de.ibm.com>
References: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Let's document that this is a capability that may be enabled per-vm.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 7ab41e9..f1979c7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3023,3 +3023,12 @@ Parameters: args[0] is the XICS device fd
             args[1] is the XICS CPU number (server ID) for this vcpu
 
 This capability connects the vcpu to an in-kernel XICS device.
+
+6.8 KVM_CAP_S390_IRQCHIP
+
+Architectures: s390
+Target: vm
+Parameters: none
+
+This capability enables the in-kernel irqchip for s390. Please refer to
+"4.24 KVM_CREATE_IRQCHIP" for details.
-- 
1.8.4.2
