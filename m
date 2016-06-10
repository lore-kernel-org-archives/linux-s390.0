From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: ignore IBC if zero
Date: Fri, 10 Jun 2016 12:04:35 +0200
Message-ID: <1465553076-155323-2-git-send-email-borntraeger@de.ibm.com>
References: <1465553076-155323-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465553076-155323-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Looks like we forgot about the special IBC value of 0 meaning "no IBC".
Let's fix that, otherwise it gets rounded up and suddenly an IBC is active
with the lowest possible machine.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Fixes: commit 053dd2308d81 ("KVM: s390: force ibc into valid range")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6d8ec3a..c9ae539 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -657,7 +657,7 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 		kvm->arch.model.cpuid = proc->cpuid;
 		lowest_ibc = sclp.ibc >> 16 & 0xfff;
 		unblocked_ibc = sclp.ibc & 0xfff;
-		if (lowest_ibc) {
+		if (lowest_ibc && proc->ibc) {
 			if (proc->ibc > unblocked_ibc)
 				kvm->arch.model.ibc = unblocked_ibc;
 			else if (proc->ibc < lowest_ibc)
-- 
2.5.5
