Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727034AbgBTKk3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:29 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 17/37] KVM: s390: protvirt: Handle spec exception loops
Date: Thu, 20 Feb 2020 05:40:00 -0500
Message-Id: <20200220104020.5343-18-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

SIE intercept code 8 is used only on exception loops for protected
guests. That means we need to stop the guest when we see it. This is
done by userspace.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index d50a0214eba1..cf4c0da4e956 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -231,6 +231,13 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.exit_program_interruption++;
 
+	/*
+	 * Intercept 8 indicates a loop of specification exceptions
+	 * for protected guests.
+	 */
+	if (kvm_s390_pv_cpu_is_protected(vcpu))
+		return -EOPNOTSUPP;
+
 	if (guestdbg_enabled(vcpu) && per_event(vcpu)) {
 		rc = kvm_s390_handle_per_event(vcpu);
 		if (rc)
-- 
2.25.0
