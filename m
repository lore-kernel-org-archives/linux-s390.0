Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391392AbgFXUWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 16:22:39 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH 1/2] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
Date: Wed, 24 Jun 2020 16:21:59 -0400
Message-Id: <20200624202200.28209-2-walling@linux.ibm.com>
In-Reply-To: <20200624202200.28209-1-walling@linux.ibm.com>
References: <20200624202200.28209-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Documentation for the s390 DIAGNOSE 0x318 instruction handling.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 426f94582b7a..056608e8f243 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6150,3 +6150,22 @@ KVM can therefore start protected VMs.
 This capability governs the KVM_S390_PV_COMMAND ioctl and the
 KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
 guests when the state change is invalid.
+
+8.24 KVM_CAP_S390_DIAG318
+-------------------------
+
+:Architecture: s390
+
+This capability allows for information regarding the control program that may
+be observed via system/firmware service events. The availability of this
+capability indicates that KVM handling of the register synchronization, reset,
+and VSIE shadowing of the DIAGNOSE 0x318 related information is present.
+
+The information associated with the instruction is an 8-byte value consisting
+of a one-byte Control Program Name Code (CPNC), and a 7-byte Control Program
+Version Code (CPVC). The CPNC determines what environment the control program
+is running in (e.g. Linux, z/VM...), and the CPVC is used for extraneous
+information specific to OS (e.g. Linux version, Linux distribution...)
+
+If this capability is available, then the CPNC and CPVC can be synchronized
+between KVM and userspace via the sync regs mechanism (KVM_SYNC_DIAG318).
-- 
2.26.2
