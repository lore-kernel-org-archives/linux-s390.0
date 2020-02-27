Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728640AbgB0IrX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 03:47:23 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v4.1 36/36] KVM: s390: protvirt: Add KVM api documentation
Date: Thu, 27 Feb 2020 03:47:17 -0500
Message-Id: <20200227084717.13449-1-borntraeger@de.ibm.com>
In-Reply-To: <a392d135-c0aa-3513-b633-70aa6c7e88bd@de.ibm.com>
References: <a392d135-c0aa-3513-b633-70aa6c7e88bd@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: borntraeger@de.ibm.com, cohuck@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, david@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

From: Janosch Frank <frankja@linux.ibm.com>

Add documentation for KVM_CAP_S390_PROTECTED capability and the
KVM_S390_PV_COMMAND ioctl.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7505d7a6c0d8..bae90f3cd11d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4648,6 +4648,54 @@ the clear cpu reset definition in the POP. However, the cpu is not put
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
+  donating memory to the Ultravisor that will become inaccessible to
+  KVM. All existing CPUs are converted to protected ones. After this
+  command has succeeded, any CPU added via hotplug will become
+  protected during its creation as well.
+
+KVM_PV_DISABLE
+
+  Deregister the VM from the Ultravisor and reclaim the memory that
+  had been donated to the Ultravisor, making it usable by the kernel
+  again.  All registered VCPUs are converted back to non-protected
+  ones.
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
 
@@ -6026,3 +6074,14 @@ Architectures: s390
 
 This capability indicates that the KVM_S390_NORMAL_RESET and
 KVM_S390_CLEAR_RESET ioctls are available.
+
+8.23 KVM_CAP_S390_PROTECTED
+
+Architecture: s390
+
+
+This capability indicates that the Ultravisor has been initialized and
+KVM can therefore start protected VMs.
+This capability governs the KVM_S390_PV_COMMAND ioctl and the
+KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
+guests when the state change is invalid.
-- 
2.25.0
