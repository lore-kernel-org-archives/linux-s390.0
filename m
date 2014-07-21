From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/9] KVM: document target of capability enablement
Date: Mon, 21 Jul 2014 21:14:22 +0200
Message-ID: <1405970065-3740-7-git-send-email-borntraeger@de.ibm.com>
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

Capabilities can be enabled on a vcpu or (since recently) on a vm. Document
this and note for the existing capabilites whether they are per-vcpu or
per-vm.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a41465b..7ab41e9 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2875,15 +2875,18 @@ The fields in each entry are defined as follows:
 6. Capabilities that can be enabled
 -----------------------------------
 
-There are certain capabilities that change the behavior of the virtual CPU when
-enabled. To enable them, please see section 4.37. Below you can find a list of
-capabilities and what their effect on the vCPU is when enabling them.
+There are certain capabilities that change the behavior of the virtual CPU or
+the virtual machine when enabled. To enable them, please see section 4.37.
+Below you can find a list of capabilities and what their effect on the vCPU or
+the virtual machine is when enabling them.
 
 The following information is provided along with the description:
 
   Architectures: which instruction set architectures provide this ioctl.
       x86 includes both i386 and x86_64.
 
+  Target: whether this is a per-vcpu or per-vm capability.
+
   Parameters: what parameters are accepted by the capability.
 
   Returns: the return value.  General error numbers (EBADF, ENOMEM, EINVAL)
@@ -2893,6 +2896,7 @@ The following information is provided along with the description:
 6.1 KVM_CAP_PPC_OSI
 
 Architectures: ppc
+Target: vcpu
 Parameters: none
 Returns: 0 on success; -1 on error
 
@@ -2907,6 +2911,7 @@ When this capability is enabled, KVM_EXIT_OSI can occur.
 6.2 KVM_CAP_PPC_PAPR
 
 Architectures: ppc
+Target: vcpu
 Parameters: none
 Returns: 0 on success; -1 on error
 
@@ -2926,6 +2931,7 @@ When this capability is enabled, KVM_EXIT_PAPR_HCALL can occur.
 6.3 KVM_CAP_SW_TLB
 
 Architectures: ppc
+Target: vcpu
 Parameters: args[0] is the address of a struct kvm_config_tlb
 Returns: 0 on success; -1 on error
 
@@ -2968,6 +2974,7 @@ For mmu types KVM_MMU_FSL_BOOKE_NOHV and KVM_MMU_FSL_BOOKE_HV:
 6.4 KVM_CAP_S390_CSS_SUPPORT
 
 Architectures: s390
+Target: vcpu
 Parameters: none
 Returns: 0 on success; -1 on error
 
@@ -2979,9 +2986,13 @@ handled in-kernel, while the other I/O instructions are passed to userspace.
 When this capability is enabled, KVM_EXIT_S390_TSCH will occur on TEST
 SUBCHANNEL intercepts.
 
+Note that even though this capability is enabled per-vcpu, the complete
+virtual machine is affected.
+
 6.5 KVM_CAP_PPC_EPR
 
 Architectures: ppc
+Target: vcpu
 Parameters: args[0] defines whether the proxy facility is active
 Returns: 0 on success; -1 on error
 
@@ -3007,6 +3018,7 @@ This capability connects the vcpu to an in-kernel MPIC device.
 6.7 KVM_CAP_IRQ_XICS
 
 Architectures: ppc
+Target: vcpu
 Parameters: args[0] is the XICS device fd
             args[1] is the XICS CPU number (server ID) for this vcpu
 
-- 
1.8.4.2
