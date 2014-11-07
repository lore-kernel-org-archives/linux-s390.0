From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/4] KVM: fix vm device attribute documentation
Date: Fri,  7 Nov 2014 12:45:16 +0100
Message-ID: <1415360716-9670-5-git-send-email-borntraeger@de.ibm.com>
References: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Documentation uses incorrect attribute names for some vm device
attributes: fix this.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 0d16f96..d426fc8 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -12,14 +12,14 @@ specific.
 1. GROUP: KVM_S390_VM_MEM_CTRL
 Architectures: s390
 
-1.1. ATTRIBUTE: KVM_S390_VM_MEM_CTRL
+1.1. ATTRIBUTE: KVM_S390_VM_MEM_ENABLE_CMMA
 Parameters: none
-Returns: -EBUSY if already a vcpus is defined, otherwise 0
+Returns: -EBUSY if a vcpu is already defined, otherwise 0
 
-Enables CMMA for the virtual machine
+Enables Collaborative Memory Management Assist (CMMA) for the virtual machine.
 
-1.2. ATTRIBUTE: KVM_S390_VM_CLR_CMMA
-Parameteres: none
+1.2. ATTRIBUTE: KVM_S390_VM_MEM_CLR_CMMA
+Parameters: none
 Returns: 0
 
 Clear the CMMA status for all guest pages, so any pages the guest marked
-- 
1.9.3
