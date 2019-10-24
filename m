Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409243AbfJXLmT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBbB6a020894
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuabhj5mk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:16 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 16/37] KVM: s390: protvirt: Implement machine-check interruption injection
Date: Thu, 24 Oct 2019 07:40:38 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-17-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

From: Michael Mueller <mimu@linux.ibm.com>

Similar to external interrupts, the hypervisor can inject machine
checks by providing the right data in the interrupt injection controls.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c919dfe4dfd3..1f87c7d3fa3e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -568,6 +568,14 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	union mci mci;
 	int rc;
 
+	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+		vcpu->arch.sie_block->iictl = IICTL_CODE_MCHK;
+		vcpu->arch.sie_block->mcic = mchk->mcic;
+		vcpu->arch.sie_block->faddr = mchk->failing_storage_address;
+		vcpu->arch.sie_block->edc = mchk->ext_damage_code;
+		return 0;
+	}
+
 	mci.val = mchk->mcic;
 	/* take care of lazy register loading */
 	save_fpu_regs();
-- 
2.20.1
