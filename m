Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64840 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgCIIv4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298pE0H005596
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7aadwty-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:54 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:40 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 22/36] KVM: s390: protvirt: STSI handling
Date: Mon,  9 Mar 2020 09:51:12 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-23-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Save response to sidad and disable address checking for protected
guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ed52ffa8d5d4..69a824f9ef0b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -2,7 +2,7 @@
 /*
  * handling privileged instructions
  *
- * Copyright IBM Corp. 2008, 2018
+ * Copyright IBM Corp. 2008, 2020
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 
 	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
-	if (operand2 & 0xfff)
+	if (!kvm_s390_pv_cpu_is_protected(vcpu) && (operand2 & 0xfff))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	switch (fc) {
@@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		handle_stsi_3_2_2(vcpu, (void *) mem);
 		break;
 	}
-
-	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
+	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
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
2.24.1
