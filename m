Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33526 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409247AbfJXLm3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb6TL103687
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vt3kjvhd1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:24 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 21/37] KVM: S390: protvirt: Instruction emulation
Date: Thu, 24 Oct 2019 07:40:43 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-22-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

We have two new SIE exit codes 104 for a secure instruction
interception, on which the SIE needs hypervisor action to complete the
instruction.

And 108 which is merely a notification and provides data for tracking
and management, like for the lowcore we set notification bits for the
lowcore pages.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/intercept.c        | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2a8a1e21e1c3..a42dfe98128b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -212,6 +212,8 @@ struct kvm_s390_sie_block {
 #define ICPT_KSS	0x5c
 #define ICPT_PV_MCHKR	0x60
 #define ICPT_PV_INT_EN	0x64
+#define ICPT_PV_INSTR	0x68
+#define ICPT_PV_NOT	0x6c
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index b013a9c88d43..a1df8a43c88b 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -451,6 +451,23 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
 
+static int handle_pv_spx(struct kvm_vcpu *vcpu)
+{
+	u32 pref = *(u32 *)vcpu->arch.sie_block->sidad;
+
+	kvm_s390_set_prefix(vcpu, pref);
+	trace_kvm_s390_handle_prefix(vcpu, 1, pref);
+	return 0;
+}
+
+static int handle_pv_not(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sie_block->ipa == 0xb210)
+		return handle_pv_spx(vcpu);
+
+	return handle_instruction(vcpu);
+}
+
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 {
 	int rc, per_rc = 0;
@@ -505,6 +522,12 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 		 */
 		rc = 0;
 	break;
+	case ICPT_PV_INSTR:
+		rc = handle_instruction(vcpu);
+		break;
+	case ICPT_PV_NOT:
+		rc = handle_pv_not(vcpu);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1
