From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: s390: clear floating interrupt bitmap and parameters
Date: Mon, 22 Jun 2015 13:20:12 +0200
Message-ID: <1434972012-68554-2-git-send-email-borntraeger@de.ibm.com>
References: <1434972012-68554-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1434972012-68554-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, 4.1@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

commit 6d3da24141 ("KVM: s390: deliver floating interrupts in order
of priority") introduced a regression for the reset handling.

We don't clear the bitmap of pending floating interrupts
and interrupt parameters. This could result in stale interrupts
even after a reset. Let's fix this by clearing the pending bitmap
and the parameters for service and machine check interrupts.

Cc: stable@vger.kernel.org # 4.1
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 322ef9c..480b975 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1621,6 +1621,9 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	int i;
 
 	spin_lock(&fi->lock);
+	fi->pending_irqs = 0;
+	memset(&fi->srv_signal, 0, sizeof(fi->srv_signal));
+	memset(&fi->mchk, 0, sizeof(fi->mchk));
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		clear_irq_list(&fi->lists[i]);
 	for (i = 0; i < FIRQ_MAX_COUNT; i++)
-- 
2.3.0
