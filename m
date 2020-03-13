Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgCMMks (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Mar 2020 08:40:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DCc22u126772
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2020 08:40:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqyuwe8ch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2020 08:40:46 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Fri, 13 Mar 2020 12:40:44 -0000
From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH] KVM: s390: pending interrupts are unlikely
Date: Fri, 13 Mar 2020 13:40:30 +0100
Message-Id: <20200313124030.99834-1-mimu@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, Michael Mueller <mimu@linux.ibm.com>

A statistical analysis shows that in most cases when deliverable_irqs()
is called, no interrupts are pending. (see: early exit ratio)

The data was sampled during an iperf3 run over virtio_net
between one guest and the host.

deliverable_irqs()
        called = 3145123
           by kvm_s390_vcpu_has_irq() = 3005581 (95.56%)
              by kvm_arch_vcpu_runnable() = 3005578 (95.56%)
                 by kvm_s390_handle_wait() = 1219331 (38.76%)
                 by kvm_vcpu_check_block() = 2943565 (93.59%)
                    by kvm_cpu_block(1) = 2826431 (89.86%)
                    by kvm_cpu_block(2) = 117136 (3.72%)
                 by kvm_arch_dy_runnable() = 0 (0%)
              by kvm_arch_setup_async_pf() = 0 (0%)
              by handle_stop() = 0 (0%)
           by kvm_s390_deliver_pending_interrupt() = 139542 (4.43%)
              irqs_delivered = (0:15917 1:61810 2:1 3:0 4:0 x:0)
              irqs_pending = (0:15917 1:61722 2:86 3:1 4:0 x:0)
    early exit = 3021787 (96.07%)
  pending irqs = 123237 (3.91%)

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 028167d6eacd..c34d62b4209e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -369,7 +369,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 	unsigned long active_mask;
 
 	active_mask = pending_irqs(vcpu);
-	if (!active_mask)
+	if (likely(!active_mask))
 		return 0;
 
 	if (psw_extint_disabled(vcpu))
-- 
2.17.0
