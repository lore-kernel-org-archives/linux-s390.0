From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: rework broken SIGP STOP interrupt handling
Date: Thu, 31 Jul 2014 09:59:02 +0200
Message-ID: <1406793542-3043-3-git-send-email-borntraeger@de.ibm.com>
References: <1406793542-3043-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1406793542-3043-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Gleb Natapov <gleb@kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

A VCPU might never stop if it intercepts (for whatever reason) between
"fake interrupt delivery" and execution of the stop function.

Heart of the problem is that SIGP STOP is an interrupt that has to be
processed on every SIE entry until the VCPU finally executes the stop
function.

This problem was made apparent by commit 7dfc63cf977447e09b1072911c2
(KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time).
With the old code, the guest could (incorrectly) inject SIGP STOPs
multiple times. The bug of losing a sigp stop exists in KVM before
7dfc63cf97, but it was hidden by Linux guests doing a sigp stop loop.
The new code (rightfully) returns CC=2 and does not queue a new
interrupt.

This patch is a simple fix of the problem. Longterm we are going to
rework that code - e.g. get rid of the action bits and so on.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[some additional patch description]
---
 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1be3d8d..92528a0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -158,6 +158,9 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 					       LCTL_CR10 | LCTL_CR11);
 		vcpu->arch.sie_block->ictl |= (ICTL_STCTL | ICTL_PINT);
 	}
+
+	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP)
+		atomic_set_mask(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
 }
 
 static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
-- 
1.8.4.2
