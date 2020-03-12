Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbgCLO2a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 10:28:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CELTVx136704
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 10:28:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqn704buq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 10:28:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Mar 2020 14:27:55 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: Also reset registers in sync regs for initial cpu reset
Date: Thu, 12 Mar 2020 15:27:50 +0100
In-Reply-To: <20200312142750.3603-1-borntraeger@de.ibm.com>
References: <20200312142750.3603-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200312142750.3603-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

When we do the initial CPU reset we must not only clear the registers
in the internal data structures but also in kvm_run sync_regs. For
modern userspace sync_regs is the only place that it looks at.

Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d7ff30e45589..c2e6d4ba4e23 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3268,7 +3268,10 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	/* Initial reset is a superset of the normal reset */
 	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
 
-	/* this equals initial cpu reset in pop, but we don't switch to ESA */
+	/*
+	 * This equals initial cpu reset in pop, but we don't switch to ESA.
+	 * We do not only reset the internal data, but also ...
+	 */
 	vcpu->arch.sie_block->gpsw.mask = 0;
 	vcpu->arch.sie_block->gpsw.addr = 0;
 	kvm_s390_set_prefix(vcpu, 0);
@@ -3278,6 +3281,19 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
 	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
 	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
+
+	/* ... the data in sync regs */
+	memset(vcpu->run->s.regs.crs, 0, sizeof(vcpu->run->s.regs.crs));
+	vcpu->run->s.regs.ckc = 0;
+	vcpu->run->s.regs.crs[0] = CR0_INITIAL_MASK;
+	vcpu->run->s.regs.crs[14] = CR14_INITIAL_MASK;
+	vcpu->run->psw_addr = 0;
+	vcpu->run->psw_mask = 0;
+	vcpu->run->s.regs.todpr = 0;
+	vcpu->run->s.regs.cputm = 0;
+	vcpu->run->s.regs.ckc = 0;
+	vcpu->run->s.regs.pp = 0;
+	vcpu->run->s.regs.gbea = 1;
 	vcpu->run->s.regs.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
 	vcpu->arch.sie_block->pp = 0;
-- 
2.24.1
