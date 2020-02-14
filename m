Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbgBNW1a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:30 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 24/42] KVM: s390: protvirt: STSI handling
Date: Fri, 14 Feb 2020 17:26:40 -0500
Message-Id: <20200214222658.12946-25-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Save response to sidad and disable address checking for protected
guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ed52ffa8d5d4..b2de7dc5f58d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 
 	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
-	if (operand2 & 0xfff)
+	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (operand2 & 0xfff))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	switch (fc) {
@@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		handle_stsi_3_2_2(vcpu, (void *) mem);
 		break;
 	}
-
-	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
+	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
+		       PAGE_SIZE);
+		rc = 0;
+	} else {
+		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
+	}
 	if (rc) {
 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
 		goto out;
-- 
2.25.0
