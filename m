Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:35880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgDRHxN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Apr 2020 03:53:13 -0400
From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] KVM: s390: remove unneeded semicolon in gisa_vcpu_kicker()
Date: Sat, 18 Apr 2020 16:19:26 +0800
Message-ID: <20200418081926.41666-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, Ulrich.Weigand@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>

Fix the following coccicheck warning:

arch/s390/kvm/interrupt.c:3085:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8191106bf7b9..559177123d0f 100644
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
2.21.1
