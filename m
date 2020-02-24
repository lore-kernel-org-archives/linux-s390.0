Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727438AbgBXLlQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 06:41:16 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v4 24/36] KVM: s390: protvirt: Do only reset registers that are accessible
Date: Mon, 24 Feb 2020 06:40:55 -0500
Message-Id: <20200224114107.4646-25-borntraeger@de.ibm.com>
In-Reply-To: <20200224114107.4646-1-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

For protected VMs the hypervisor can not access guest breaking event
address, program parameter, bpbc and todpr. Do not reset those fields
as the control block does not provide access to these fields.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6ab4c88f2e1d..c734e89235f9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3499,14 +3499,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	kvm_s390_set_prefix(vcpu, 0);
 	kvm_s390_set_cpu_timer(vcpu, 0);
 	vcpu->arch.sie_block->ckc = 0;
-	vcpu->arch.sie_block->todpr = 0;
 	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
 	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
 	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
 	vcpu->run->s.regs.fpc = 0;
-	vcpu->arch.sie_block->gbea = 1;
-	vcpu->arch.sie_block->pp = 0;
-	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+	if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
+		vcpu->arch.sie_block->gbea = 1;
+		vcpu->arch.sie_block->pp = 0;
+		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+		vcpu->arch.sie_block->todpr = 0;
+	}
 }
 
 static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
-- 
2.25.0
