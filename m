Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbgCIPBP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 11:01:15 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] KVM: s390: Also reset registers in sync regs for initial cpu reset
Date: Mon,  9 Mar 2020 11:00:25 -0400
Message-Id: <20200309150026.4329-4-borntraeger@de.ibm.com>
In-Reply-To: <20200309150026.4329-1-borntraeger@de.ibm.com>
References: <20200309150026.4329-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org

When we do the initial CPU reset we must not only clear the registers
in the internal data structures but also in kvm_run sync_regs. For
modern userspace sync_regs is the only place that it looks at.

Cc: stable@vger.kernel.org
Fixes: 7de3f1423ff943 ("KVM: s390: Add new reset vcpu API")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6b1842a9feed..81f54ddedb3d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3529,7 +3529,10 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	/* Initial reset is a superset of the normal reset */
 	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
 
-	/* this equals initial cpu reset in pop, but we don't switch to ESA */
+	/*
+	 * This equals initial cpu reset in pop, but we don't switch to ESA.
+	 * We do not even reset the internal data, but also ...
+	 */
 	vcpu->arch.sie_block->gpsw.mask = 0;
 	vcpu->arch.sie_block->gpsw.addr = 0;
 	kvm_s390_set_prefix(vcpu, 0);
@@ -3538,6 +3541,19 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
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
 	/*
 	 * Do not reset these registers in the protected case, as some of
-- 
2.25.0
