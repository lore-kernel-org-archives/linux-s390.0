From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 25/52] KVM: s390: provide CMMA attributes only if available
Date: Tue, 14 Jun 2016 20:57:02 +0200
Message-ID: <1465930649-181383-26-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's not provide the device attribute for cmma enabling and clearing
if the hardware doesn't support it.

This also helps getting rid of the undocumented return value "-EINVAL"
in case CMMA is not available when trying to enable it.

Also properly document the meaning of -EINVAL for CMMA clearing.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt        | 2 ++
 Documentation/virtual/kvm/devices/vm.txt | 3 ++-
 arch/s390/kvm/kvm-s390.c                 | 7 ++++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a4482cc..4aac3e5 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2520,6 +2520,7 @@ Parameters: struct kvm_device_attr
 Returns: 0 on success, -1 on error
 Errors:
   ENXIO:  The group or attribute is unknown/unsupported for this device
+          or hardware support is missing.
   EPERM:  The attribute cannot (currently) be accessed this way
           (e.g. read-only attribute, or attribute that only makes
           sense when the device is in a different state)
@@ -2547,6 +2548,7 @@ Parameters: struct kvm_device_attr
 Returns: 0 on success, -1 on error
 Errors:
   ENXIO:  The group or attribute is unknown/unsupported for this device
+          or hardware support is missing.
 
 Tests whether a device supports a particular attribute.  A successful
 return indicates the attribute is implemented.  It does not necessarily
diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 8a458f4..b6cda49 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -20,7 +20,8 @@ Enables Collaborative Memory Management Assist (CMMA) for the virtual machine.
 
 1.2. ATTRIBUTE: KVM_S390_VM_MEM_CLR_CMMA
 Parameters: none
-Returns: 0
+Returns: -EINVAL if CMMA was not enabled
+         0 otherwise
 
 Clear the CMMA status for all guest pages, so any pages the guest marked
 as unused are again used any may not be reclaimed by the host.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 005e664..f695c6e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -485,7 +485,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	unsigned int idx;
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_ENABLE_CMMA:
-		ret = -EINVAL;
+		ret = -ENXIO;
 		if (!sclp.has_cmma)
 			break;
 
@@ -499,6 +499,9 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_S390_VM_MEM_CLR_CMMA:
+		ret = -ENXIO;
+		if (!sclp.has_cmma)
+			break;
 		ret = -EINVAL;
 		if (!kvm->arch.use_cmma)
 			break;
@@ -964,6 +967,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		switch (attr->attr) {
 		case KVM_S390_VM_MEM_ENABLE_CMMA:
 		case KVM_S390_VM_MEM_CLR_CMMA:
+			ret = sclp.has_cmma ? 0 : -ENXIO;
+			break;
 		case KVM_S390_VM_MEM_LIMIT_SIZE:
 			ret = 0;
 			break;
-- 
2.5.5
