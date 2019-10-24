Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439192AbfJXLmp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb7MP002453
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vub6ggaqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:41 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 31/37] KVM: s390: protvirt: Add diag 308 subcode 8 - 10 handling
Date: Thu, 24 Oct 2019 07:40:53 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-32-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

If the host initialized the Ultravisor, we can set stfle bit 161
(protected virtual IPL enhancements facility), which indicates, that
the IPL subcodes 8, 9 and are valid. These subcodes are used by a
normal guest to set/retrieve a IPIB of type 5 and transition into
protected mode.

Once in protected mode, the VM will loose the facility bit, as each
boot into protected mode has to go through non-protected. There is no
secure re-ipl with subcode 10 without a previous subcode 3.

In protected mode, there is no subcode 4 available, as the VM has no
more access to its memory from non-protected mode. I.e. each IPL
clears.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/diag.c     | 6 ++++++
 arch/s390/kvm/kvm-s390.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3fb54ec2cf3e..b951dbdcb6a0 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -197,6 +197,12 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 	case 4:
 		vcpu->run->s390_reset_flags = 0;
 		break;
+	case 8:
+	case 9:
+	case 10:
+		if (!test_kvm_facility(vcpu->kvm, 161))
+			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		/* fall through */
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 500972a1f742..8947f1812b12 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2590,6 +2590,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
2.20.1
