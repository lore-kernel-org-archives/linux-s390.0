From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/18] KVM: s390: add documentation of KVM_S390_VM_TOD
Date: Fri, 12 Feb 2016 14:22:57 +0100
Message-ID: <1455283382-62999-14-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's properly document KVM_S390_VM_TOD and its attributes.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index f083a16..27c1a3b 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -84,3 +84,22 @@ Returns:    -EBUSY in case 1 or more vcpus are already activated (only in write
 	    -EFAULT if the given address is not accessible from kernel space
 	    -ENOMEM if not enough memory is available to process the ioctl
 	    0 in case of success
+
+3. GROUP: KVM_S390_VM_TOD
+Architectures: s390
+
+3.1. ATTRIBUTE: KVM_S390_VM_TOD_HIGH
+
+Allows user space to set/get the TOD clock extension (u8).
+
+Parameters: address of a buffer in user space to store the data (u8) to
+Returns:    -EFAULT if the given address is not accessible from kernel space
+	    -EINVAL if setting the TOD clock extension to != 0 is not supported
+
+3.2. ATTRIBUTE: KVM_S390_VM_TOD_LOW
+
+Allows user space to set/get bits 0-63 of the TOD clock register as defined in
+the POP (u64).
+
+Parameters: address of a buffer in user space to store the data (u64) to
+Returns:    -EFAULT if the given address is not accessible from kernel space
-- 
2.3.0
