Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgINIWX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 04:22:23 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
Date: Mon, 14 Sep 2020 10:22:15 +0200
Message-Id: <20200914082215.6143-2-borntraeger@de.ibm.com>
In-Reply-To: <20200914082215.6143-1-borntraeger@de.ibm.com>
References: <20200914082215.6143-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>

From: Collin Walling <walling@linux.ibm.com>

Documentation for the s390 DIAGNOSE 0x318 instruction handling.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/kvm/20200625150724.10021-2-walling@linux.ibm.com/
Message-Id: <20200625150724.10021-2-walling@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d2b733dc7892..51191b56e61c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6173,3 +6173,23 @@ specific interfaces must be consistent, i.e. if one says the feature
 is supported, than the other should as well and vice versa.  For arm64
 see Documentation/virt/kvm/devices/vcpu.rst "KVM_ARM_VCPU_PVTIME_CTRL".
 For x86 see Documentation/virt/kvm/msr.rst "MSR_KVM_STEAL_TIME".
+
+8.25 KVM_CAP_S390_DIAG318
+-------------------------
+
+:Architectures: s390
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
2.25.4
