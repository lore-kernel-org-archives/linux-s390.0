From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: set the prefix initially properly
Date: Fri, 12 Aug 2016 10:06:35 +0200
Message-ID: <1470989196-95234-2-git-send-email-borntraeger@de.ibm.com>
References: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Julius Niedworok <jniedwor@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julius Niedworok <jniedwor@linux.vnet.ibm.com>

When KVM_RUN is triggered on a VCPU without an initial reset, a
validity intercept occurs.
Setting the prefix will set the KVM_REQ_MMU_RELOAD bit initially,
thus preventing the bug.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Julius Niedworok <jniedwor@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f3ae48..e63f6ed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1672,6 +1672,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+	kvm_s390_set_prefix(vcpu, 0);
 	if (test_kvm_facility(vcpu->kvm, 64))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
 	/* fprs can be synchronized via vrs, even if the guest has no vx. With
-- 
2.5.5
