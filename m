Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28187 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbgCIIvn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298pVjO084575
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ym5e1rh1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:40 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 24/36] KVM: s390: protvirt: Do only reset registers that are accessible
Date: Mon,  9 Mar 2020 09:51:14 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-25-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

For protected VMs the hypervisor can not access guest breaking event
address, program parameter, bpbc and todpr. Do not reset those fields
as the control block does not provide access to these fields.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 797b4031ed4d..1c7bbc2497a2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3502,14 +3502,21 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
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
+	/*
+	 * Do not reset these registers in the protected case, as some of
+	 * them are overlayed and they are not accessible in this case
+	 * anyway.
+	 */
+	if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
+		vcpu->arch.sie_block->gbea = 1;
+		vcpu->arch.sie_block->pp = 0;
+		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+		vcpu->arch.sie_block->todpr = 0;
+	}
 }
 
 static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
-- 
2.24.1
