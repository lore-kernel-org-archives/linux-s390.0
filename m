From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/23] KVM: s390: fast path for sca_ext_call_pending
Date: Wed,  2 Dec 2015 12:06:14 +0100
Message-ID: <1449054384-76374-14-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If CPUSTAT_ECALL_PEND isn't set, we can't have an external call pending,
so we can directly avoid taking the lock.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 831c9ac..62ec925 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -39,6 +39,9 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
 	int c, scn;
 
+	if (!(atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND))
+		return 0;
+
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -60,8 +63,7 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 	if (src_id)
 		*src_id = scn;
 
-	return c && atomic_read(&vcpu->arch.sie_block->cpuflags) &
-			CPUSTAT_ECALL_PEND;
+	return c;
 }
 
 static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
-- 
2.3.0
