Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731703AbgEZJd1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 05:33:27 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/3] KVM: s390: remove unneeded semicolon in gisa_vcpu_kicker()
Date: Tue, 26 May 2020 11:33:13 +0200
Message-Id: <20200526093313.77976-4-borntraeger@de.ibm.com>
In-Reply-To: <20200526093313.77976-1-borntraeger@de.ibm.com>
References: <20200526093313.77976-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>

From: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

arch/s390/kvm/interrupt.c:3085:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200418081926.41666-1-yanaijie@huawei.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bfb481134994..a4d4ca2769bd 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3082,7 +3082,7 @@ static enum hrtimer_restart gisa_vcpu_kicker(struct hrtimer *timer)
 		__airqs_kick_single_vcpu(kvm, pending_mask);
 		hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
 		return HRTIMER_RESTART;
-	};
+	}
 
 	return HRTIMER_NORESTART;
 }
-- 
2.25.4
