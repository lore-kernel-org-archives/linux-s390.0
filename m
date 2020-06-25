Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405765AbgFYPHx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 11:07:53 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 1/2] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
Date: Thu, 25 Jun 2020 11:07:23 -0400
Message-Id: <20200625150724.10021-2-walling@linux.ibm.com>
In-Reply-To: <20200625150724.10021-1-walling@linux.ibm.com>
References: <20200625150724.10021-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Documentation for the s390 DIAGNOSE 0x318 instruction handling.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 426f94582b7a..e0b4f2088c46 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6150,3 +6150,23 @@ KVM can therefore start protected VMs.
 This capability governs the KVM_S390_PV_COMMAND ioctl and the
 KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
 guests when the state change is invalid.
+
+8.24 KVM_CAP_S390_DIAG318
+-------------------------
+
+:Architecture: s390
+
+This capability enables a guest to set information about its control program
+(i.e. guest kernel type and version). The information is helpful during
+system/firmware service events, providing additional data about the guest
+environments running on the machine.
+
+The information is associated with the DIAGNOSE 0x318 instruction, which sets
+an 8-byte value consisting of a one-byte Control Program Name Code (CPNC) and
+a 7-byte Control Program Version Code (CPVC). The CPNC determines what
+environment the control program is running in (e.g. Linux, z/VM...), and the
+CPVC is used for information specific to OS (e.g. Linux version, Linux
+distribution...)
+
+If this capability is available, then the CPNC and CPVC can be synchronized
+between KVM and userspace via the sync regs mechanism (KVM_SYNC_DIAG318).
-- 
2.26.2
