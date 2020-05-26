Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728568AbgEZJdV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 05:33:21 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: vsie: Move conditional reschedule
Date: Tue, 26 May 2020 11:33:11 +0200
Message-Id: <20200526093313.77976-2-borntraeger@de.ibm.com>
In-Reply-To: <20200526093313.77976-1-borntraeger@de.ibm.com>
References: <20200526093313.77976-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

From: David Hildenbrand <david@redhat.com>

Let's move it to the outer loop, in case we ever run again into long
loops, trying to map the prefix. While at it, convert it to cond_resched().

Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200403153050.20569-5-david@redhat.com
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f6c22d72072..ef05b4e167fb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1000,8 +1000,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	handle_last_fault(vcpu, vsie_page);
 
-	if (need_resched())
-		schedule();
 	if (test_cpu_flag(CIF_MCCK_PENDING))
 		s390_handle_mcck();
 
@@ -1185,6 +1183,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu))
 			break;
+		cond_resched();
 	}
 
 	if (rc == -EFAULT) {
-- 
2.25.4
