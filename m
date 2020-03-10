Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731558AbgCJNMa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 09:12:30 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] KVM: s390: Also reset registers in sync regs for initial cpu reset
Date: Tue, 10 Mar 2020 09:12:23 -0400
Message-Id: <20200310131223.10287-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, stable@vger.kernel.org

When we do the initial CPU reset we must not only clear the registers
in the internal data structures but also in kvm_run sync_regs. For
modern userspace sync_regs is the only place that it looks at.

Cc: stable@vger.kernel.org
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
2.25.0
