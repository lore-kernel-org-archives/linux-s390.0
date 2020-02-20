Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727922AbgBTKka (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:30 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 10/37] KVM: s390: protvirt: Add KVM api documentation
Date: Thu, 20 Feb 2020 05:39:53 -0500
Message-Id: <20200220104020.5343-11-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Add documentation for KVM_CAP_S390_PROTECTED capability and the
KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 97a72a53fa4b..77e1edfe5d4c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4646,6 +4646,51 @@ the clear cpu reset definition in the POP. However, the cpu is not put
 into ESA mode. This reset is a superset of the initial reset.
 
 
+4.125 KVM_S390_PV_COMMAND
+-------------------------
+
+:Capability: KVM_CAP_S390_PROTECTED
+:Architectures: s390
+:Type: vm ioctl
+:Parameters: struct kvm_pv_cmd
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_pv_cmd {
+	__u32 cmd;	/* Command to be executed */
+	__u16 rc;	/* Ultravisor return code */
+	__u16 rrc;	/* Ultravisor return reason code */
+	__u64 data;	/* Data or address */
+	__u32 flags;    /* flags for future extensions. Must be 0 for now */
+	__u32 reserved[3];
+  };
+
+cmd values:
+
+KVM_PV_ENABLE
+  Allocate memory and register the VM with the Ultravisor, thereby
+  donating memory to the Ultravisor making it inaccessible to KVM.
+  Also converts all existing CPUs to protected ones. Future hotplug
+  CPUs will become protected during creation.
+
+KVM_PV_DISABLE
+  Deregisters the VM from the Ultravisor and frees memory that was
+  donated, so the kernel can use it again. All registered VCPUs are
+  converted back to non-protected ones.
+
+KVM_PV_VM_SET_SEC_PARMS
+  Pass the image header from VM memory to the Ultravisor in
+  preparation of image unpacking and verification.
+
+KVM_PV_VM_UNPACK
+  Unpack (protect and decrypt) a page of the encrypted boot image.
+
+KVM_PV_VM_VERIFY
+  Verify the integrity of the unpacked image. Only if this succeeds,
+  KVM is allowed to start protected VCPUs.
+
+
 5. The kvm_run structure
 ========================
 
@@ -6024,3 +6069,10 @@ Architectures: s390
 
 This capability indicates that the KVM_S390_NORMAL_RESET and
 KVM_S390_CLEAR_RESET ioctls are available.
+
+8.23 KVM_CAP_S390_PROTECTED
+
+Architecture: s390
+
+This capability indicates that KVM can start protected VMs and the
+Ultravisor has therefore been initialized.
-- 
2.25.0
