Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409273AbfJXLmg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb9RV088853
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:34 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vuapnhfuy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:32 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 25/37] KVM: s390: protvirt: STSI handling
Date: Thu, 24 Oct 2019 07:40:47 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-26-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Save response to sidad and disable address checking for protected
guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ed52ffa8d5d4..06c7e7a10825 100644
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
+	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+		memcpy((void *)vcpu->arch.sie_block->sidad, (void *)mem,
+		       PAGE_SIZE);
+		rc = 0;
+	} else
+		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
 
-	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
 	if (rc) {
 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
 		goto out;
-- 
2.20.1
