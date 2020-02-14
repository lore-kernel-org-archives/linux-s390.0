Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728081AbgBNW1e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:34 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 29/42] KVM: s390: protvirt: Add diag 308 subcode 8 - 10 handling
Date: Fri, 14 Feb 2020 17:26:45 -0500
Message-Id: <20200214222658.12946-30-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

If the host initialized the Ultravisor, we can set stfle bit 161
(protected virtual IPL enhancements facility), which indicates that
the IPL subcodes 8, 9, and 10 are valid. These subcodes are used by a
normal guest to set/retrieve an IPL information block of type 5 (for
protected virtual machines) and transition into protected mode.

Once in protected mode, the Ultravisor will conceal the facility bit.
Therefore each boot into protected mode has to go through
non-protected mode. There is no secure re-ipl with subcode 10 without
a previous subcode 3.

In protected mode, there is no subcode 4 available, as the VM has no
more access to its memory from non-protected mode. I.e., only a IPL
clear is possible.

The error cases will all be handled in userspace.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4a97d3b7840e..f96c1f530cc2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2621,6 +2621,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (css_general_characteristics.aiv && test_facility(65))
 		set_kvm_facility(kvm->arch.model.fac_mask, 65);
 
+	if (is_prot_virt_host()) {
+		set_kvm_facility(kvm->arch.model.fac_mask, 161);
+		set_kvm_facility(kvm->arch.model.fac_list, 161);
+	}
+
 	kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
 	kvm->arch.model.ibc = sclp.ibc & 0x0fff;
 
-- 
2.25.0
