Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54676 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727031AbgBGLkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:09 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 18/35] KVM: s390: protvirt: Add new gprs location handling
Date: Fri,  7 Feb 2020 06:39:41 -0500
Message-Id: <20200207113958.7320-19-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Guest registers for protected guests are stored at offset 0x380.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  4 +++-
 arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index bd1ddbfef436..9d7b248dcadc 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -343,7 +343,9 @@ struct kvm_s390_itdb {
 struct sie_page {
 	struct kvm_s390_sie_block sie_block;
 	struct mcck_volatile_info mcck_info;	/* 0x0200 */
-	__u8 reserved218[1000];		/* 0x0218 */
+	__u8 reserved218[360];		/* 0x0218 */
+	__u64 pv_grregs[16];		/* 0x0380 */
+	__u8 reserved400[512];		/* 0x0400 */
 	struct kvm_s390_itdb itdb;	/* 0x0600 */
 	__u8 reserved700[2304];		/* 0x0700 */
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e1dd851aca65..6f90d16cad92 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3999,6 +3999,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc, exit_reason;
+	struct sie_page *sie_page = (struct sie_page *)vcpu->arch.sie_block;
 
 	/*
 	 * We try to hold kvm->srcu during most of vcpu_run (except when run-
@@ -4020,8 +4021,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		guest_enter_irqoff();
 		__disable_cpu_timer_accounting(vcpu);
 		local_irq_enable();
+		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+			memcpy(sie_page->pv_grregs,
+			       vcpu->run->s.regs.gprs,
+			       sizeof(sie_page->pv_grregs));
+		}
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
+		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+			memcpy(vcpu->run->s.regs.gprs,
+			       sie_page->pv_grregs,
+			       sizeof(sie_page->pv_grregs));
+		}
 		local_irq_disable();
 		__enable_cpu_timer_accounting(vcpu);
 		guest_exit_irqoff();
-- 
2.24.0
