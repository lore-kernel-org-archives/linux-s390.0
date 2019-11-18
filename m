Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbfKRIgK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8WKuM073620
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wayaw422v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 18 Nov 2019 08:36:07 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/5] KVM: s390: Remove unused parameter from __inject_sigp_restart()
Date: Mon, 18 Nov 2019 09:35:58 +0100
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
Message-Id: <20191118083602.15835-2-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

It's not required, so drop it to make it clear that this interrupt
does not have any extra parameters.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/kvm/20190912070250.15131-1-thuth@redhat.com
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d1ccc168c071..165dea4c7f19 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1477,8 +1477,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
-				 struct kvm_s390_irq *irq)
+static int __inject_sigp_restart(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
@@ -2007,7 +2006,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		rc = __inject_sigp_stop(vcpu, irq);
 		break;
 	case KVM_S390_RESTART:
-		rc = __inject_sigp_restart(vcpu, irq);
+		rc = __inject_sigp_restart(vcpu);
 		break;
 	case KVM_S390_INT_CLOCK_COMP:
 		rc = __inject_ckc(vcpu);
-- 
2.21.0
