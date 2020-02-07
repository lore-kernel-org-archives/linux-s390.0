Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 26/35] KVM: s390: protvirt: Add program exception injection
Date: Fri,  7 Feb 2020 06:39:49 -0500
Message-Id: <20200207113958.7320-27-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Only two program exceptions can be injected for a protected guest:
specification and operand.

For both, a code needs to be specified in the interrupt injection
control of the state description, as the guest prefix page is not
accessible to KVM for such guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c28fa09cb557..2df6459ab98b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -837,6 +837,21 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
 	return rc ? -EFAULT : 0;
 }
 
+static int __deliver_prog_pv(struct kvm_vcpu *vcpu, u16 code)
+{
+	switch (code) {
+	case PGM_SPECIFICATION:
+		vcpu->arch.sie_block->iictl = IICTL_CODE_SPECIFICATION;
+		break;
+	case PGM_OPERAND:
+		vcpu->arch.sie_block->iictl = IICTL_CODE_OPERAND;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
@@ -857,6 +872,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 					 pgm_info.code, 0);
 
+	if (kvm_s390_pv_is_protected(vcpu->kvm))
+		return __deliver_prog_pv(vcpu, pgm_info.code & ~PGM_PER);
+
 	switch (pgm_info.code & ~PGM_PER) {
 	case PGM_AFX_TRANSLATION:
 	case PGM_ASX_TRANSLATION:
-- 
2.24.0
