Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439159AbfJXLmk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBbUEa011379
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vu9avvrfd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:37 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 28/37] KVM: s390: protvirt: Add program exception injection
Date: Thu, 24 Oct 2019 07:40:50 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-29-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Only two program exceptions can be injected for a protected guest:
specification and operand

Both have a code in offset 248 of the state description, as the lowcore
is not accessible by KVM for such guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1f87c7d3fa3e..2a711bae69a7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -826,6 +826,21 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
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
@@ -846,6 +861,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 					 pgm_info.code, 0);
 
+	if (kvm_s390_pv_is_protected(vcpu->kvm))
+		return __deliver_prog_pv(vcpu, pgm_info.code & ~PGM_PER);
+
 	switch (pgm_info.code & ~PGM_PER) {
 	case PGM_AFX_TRANSLATION:
 	case PGM_ASX_TRANSLATION:
-- 
2.20.1
