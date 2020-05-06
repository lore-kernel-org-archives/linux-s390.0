Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727994AbgEFL7y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 07:59:54 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction
Date: Wed,  6 May 2020 13:59:45 +0200
Message-Id: <20200506115945.13132-2-borntraeger@de.ibm.com>
In-Reply-To: <20200506115945.13132-1-borntraeger@de.ibm.com>
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Qian Cai <cailca@icloud.com>

In LPAR we will only get an intercept for FC==3 for the PQAP
instruction. Running nested under z/VM can result in other intercepts as
well as ECA_APIE is an effective bit: If one hypervisor layer has
turned this bit off, the end result will be that we will get intercepts for
all function codes. Usually the first one will be a query like PQAP(QCI).
So the WARN_ON_ONCE is not right. Let us simply remove it.

Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: stable@vger.kernel.org # v5.3+
Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
Link: https://lore.kernel.org/kvm/20200505083515.2720-1-borntraeger@de.ibm.com
Reported-by: Qian Cai <cailca@icloud.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 69a824f9ef0b..893893642415 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -626,10 +626,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * available for the guest are AQIC and TAPQ with the t bit set
 	 * since we do not set IC.3 (FIII) we currently will only intercept
 	 * the AQIC function code.
+	 * Note: running nested under z/VM can result in intercepts for other
+	 * function codes, e.g. PQAP(QCI). We do not support this and bail out.
 	 */
 	reg0 = vcpu->run->s.regs.gprs[0];
 	fc = (reg0 >> 24) & 0xff;
-	if (WARN_ON_ONCE(fc != 0x03))
+	if (fc != 0x03)
 		return -EOPNOTSUPP;
 
 	/* PQAP instruction is allowed for guest kernel only */
-- 
2.25.4
