From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: use WARN_ON_ONCE only for checking
Date: Fri,  1 Sep 2017 09:46:47 +0200
Message-ID: <1504252008-102471-3-git-send-email-borntraeger@de.ibm.com>
References: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Move the real logic that always has to be executed out of the
WARN_ON_ONCE.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170830160603.5452-3-david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a619dda..a832ad0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2479,6 +2479,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
+	int rc;
 
 	mci.val = mcck_info->mcic;
 	if (mci.sr)
@@ -2496,12 +2497,13 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 	if (mci.ck) {
 		/* Inject the floating machine check */
 		inti.type = KVM_S390_MCHK;
-		WARN_ON_ONCE(__inject_vm(vcpu->kvm, &inti));
+		rc = __inject_vm(vcpu->kvm, &inti);
 	} else {
 		/* Inject the machine check to specified vcpu */
 		irq.type = KVM_S390_MCHK;
-		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
+		rc = kvm_s390_inject_vcpu(vcpu, &irq);
 	}
+	WARN_ON_ONCE(rc);
 }
 
 int kvm_set_routing_entry(struct kvm *kvm,
-- 
2.7.4
