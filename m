Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEHfd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 03:35:33 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction
Date: Tue,  5 May 2020 09:35:25 +0200
Message-Id: <20200505073525.2287-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

In LPAR we will only get an intercept for FC==3 for the PQAP
instruction. Running nested under z/VM can result in other intercepts as
well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
us simply remove it.

Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Reported-by: Qian Cai <cailca@icloud.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 69a824f9ef0b..bbe46c6aedbf 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -626,10 +626,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * available for the guest are AQIC and TAPQ with the t bit set
 	 * since we do not set IC.3 (FIII) we currently will only intercept
 	 * the AQIC function code.
+	 * Note: running nested under z/VM can result in intercepts, e.g.
+	 * for PQAP(QCI). We do not support this and bail out.
 	 */
 	reg0 = vcpu->run->s.regs.gprs[0];
 	fc = (reg0 >> 24) & 0xff;
-	if (WARN_ON_ONCE(fc != 0x03))
+	if (fc != 0x03)
 		return -EOPNOTSUPP;
 
 	/* PQAP instruction is allowed for guest kernel only */
-- 
2.25.4
