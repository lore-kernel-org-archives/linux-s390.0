Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgBTKkb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:31 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 22/37] KVM: s390: protvirt: Write sthyi data to instruction data area
Date: Thu, 20 Feb 2020 05:40:05 -0500
Message-Id: <20200220104020.5343-23-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

STHYI data has to go through the bounce buffer.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 850045034016..a5de0e1975bb 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -392,7 +392,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	if (addr & ~PAGE_MASK)
+	if (!kvm_s390_pv_cpu_is_protected(vcpu) && (addr & ~PAGE_MASK))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	sctns = (void *)get_zeroed_page(GFP_KERNEL);
@@ -403,10 +403,15 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 
 out:
 	if (!cc) {
-		r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
-		if (r) {
-			free_page((unsigned long)sctns);
-			return kvm_s390_inject_prog_cond(vcpu, r);
+		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
+			memcpy((void *)(sida_origin(vcpu->arch.sie_block)),
+			       sctns, PAGE_SIZE);
+		} else {
+			r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
+			if (r) {
+				free_page((unsigned long)sctns);
+				return kvm_s390_inject_prog_cond(vcpu, r);
+			}
 		}
 	}
 
-- 
2.25.0
