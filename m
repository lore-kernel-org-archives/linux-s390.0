Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727046AbgBTKk3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:29 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 14/37] KVM: s390: protvirt: Instruction emulation
Date: Thu, 20 Feb 2020 05:39:57 -0500
Message-Id: <20200220104020.5343-15-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

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
index 6aeb4b36042c..6fdbac696f65 100644
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
2.25.0
