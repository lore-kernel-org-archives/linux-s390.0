From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/18] KVM: s390: add documentation of KVM_S390_VM_CRYPTO
Date: Fri, 12 Feb 2016 14:22:58 +0100
Message-ID: <1455283382-62999-15-git-send-email-borntraeger@de.ibm.com>
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

Let's properly document KVM_S390_VM_CRYPTO and its attributes.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 27c1a3b..a9ea877 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -103,3 +103,36 @@ the POP (u64).
 
 Parameters: address of a buffer in user space to store the data (u64) to
 Returns:    -EFAULT if the given address is not accessible from kernel space
+
+4. GROUP: KVM_S390_VM_CRYPTO
+Architectures: s390
+
+4.1. ATTRIBUTE: KVM_S390_VM_CRYPTO_ENABLE_AES_KW (w/o)
+
+Allows user space to enable aes key wrapping, including generating a new
+wrapping key.
+
+Parameters: none
+Returns:    0
+
+4.2. ATTRIBUTE: KVM_S390_VM_CRYPTO_ENABLE_DEA_KW (w/o)
+
+Allows user space to enable dea key wrapping, including generating a new
+wrapping key.
+
+Parameters: none
+Returns:    0
+
+4.3. ATTRIBUTE: KVM_S390_VM_CRYPTO_DISABLE_AES_KW (w/o)
+
+Allows user space to disable aes key wrapping, clearing the wrapping key.
+
+Parameters: none
+Returns:    0
+
+4.4. ATTRIBUTE: KVM_S390_VM_CRYPTO_DISABLE_DEA_KW (w/o)
+
+Allows user space to disable dea key wrapping, clearing the wrapping key.
+
+Parameters: none
+Returns:    0
-- 
2.3.0
