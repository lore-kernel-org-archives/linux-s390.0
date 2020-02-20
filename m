Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727909AbgBTKka (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:30 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 31/37] KVM: s390: protvirt: Mask PSW interrupt bits for interception 104 and 112
Date: Thu, 20 Feb 2020 05:40:14 -0500
Message-Id: <20200220104020.5343-32-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

We're not allowed to inject interrupts on intercepts that leave the
guest state in an "in-between" state where the next SIE entry will do a
continuation, namely secure instruction interception (104) and secure
prefix interception (112).
As our PSW is just a copy of the real one that will be replaced on the
next exit, we can mask out the interrupt bits in the PSW to make sure
that we do not inject anything.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f0b6609b65b6..4503f153efd7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4064,6 +4064,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	return vcpu_post_run_fault_in_sie(vcpu);
 }
 
+#define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
 static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc, exit_reason;
@@ -4100,6 +4101,16 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 			memcpy(vcpu->run->s.regs.gprs,
 			       sie_page->pv_grregs,
 			       sizeof(sie_page->pv_grregs));
+			/*
+			 * We're not allowed to inject interrupts on intercepts
+			 * that leave the guest state in an "in-between" state
+			 * where the next SIE entry will do a continuation.
+			 * Fence interrupts in our "internal" PSW.
+			 */
+			if (vcpu->arch.sie_block->icptcode == ICPT_PV_INSTR ||
+			    vcpu->arch.sie_block->icptcode == ICPT_PV_PREF) {
+				vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;
+			}
 		}
 		local_irq_disable();
 		__enable_cpu_timer_accounting(vcpu);
-- 
2.25.0
