Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2527 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgBTKka (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:30 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 32/37] KVM: s390: protvirt: do not inject interrupts after start
Date: Thu, 20 Feb 2020 05:40:15 -0500
Message-Id: <20200220104020.5343-33-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

As PSW restart is handled by the ultravisor (and we only get a start
notification) we must re-check the PSW after a start before injecting
interrupts.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4503f153efd7..76ab9e4c8f55 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4479,6 +4479,13 @@ int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	if (kvm_s390_pv_cpu_is_protected(vcpu))
 		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
+	/*
+	 * The real PSW might have changed due to a RESTART interpreted by the
+	 * ultravisor. We block all interrupts and let the next sie exit
+	 * refresh our view.
+	 */
+	if (kvm_s390_pv_cpu_is_protected(vcpu))
+		vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;
 	/*
 	 * Another VCPU might have used IBS while we were offline.
 	 * Let's play safe and flush the VCPU at startup.
-- 
2.25.0
