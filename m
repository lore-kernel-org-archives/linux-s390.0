Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgCIIvj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298pVuN084580
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ym5e1rgy1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:36 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/36] KVM: s390: protvirt: Instruction emulation
Date: Mon,  9 Mar 2020 09:51:03 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-14-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

We have two new SIE exit codes dealing with instructions.
104 (0x68) for a secure instruction interception, on which the SIE needs
hypervisor action to complete the instruction. We can piggy-back on the
existing instruction handlers.

108 which is merely a notification and provides data for tracking and
management. For example this is used to tell the host about a new value
for the prefix register. As there will be several special case handlers
in later patches, we handle this in a separate function.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/intercept.c        | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index fdc6ceff6397..c6694f47b73b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -217,6 +217,8 @@ struct kvm_s390_sie_block {
 #define ICPT_KSS	0x5c
 #define ICPT_MCHKREQ	0x60
 #define ICPT_INT_ENABLE	0x64
+#define ICPT_PV_INSTR	0x68
+#define ICPT_PV_NOTIFY	0x6c
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 9090f29ae822..9966c43c6035 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -444,6 +444,11 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
 
+static int handle_pv_notification(struct kvm_vcpu *vcpu)
+{
+	return handle_instruction(vcpu);
+}
+
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 {
 	int rc, per_rc = 0;
@@ -489,6 +494,12 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 		 */
 		rc = 0;
 		break;
+	case ICPT_PV_INSTR:
+		rc = handle_instruction(vcpu);
+		break;
+	case ICPT_PV_NOTIFY:
+		rc = handle_pv_notification(vcpu);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.24.1
