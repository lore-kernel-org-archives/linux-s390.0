From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/10] KVM: s390: support NQ only if the facility is enabled for the guest
Date: Mon,  9 May 2016 11:20:13 +0200
Message-ID: <1462785621-12600-3-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

While we can not fully fence of the Nonquiescing Key-Setting facility,
we should as try our best to hide it.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 3561119..3137479 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -670,8 +670,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	if (vcpu->run->s.regs.gprs[reg1] & PFMF_RESERVED)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	/* Only provide non-quiescing support if the host supports it */
-	if (vcpu->run->s.regs.gprs[reg1] & PFMF_NQ && !test_facility(14))
+	/* Only provide non-quiescing support if enabled for the guest */
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_NQ &&
+	    !test_kvm_facility(vcpu->kvm, 14))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* No support for conditional-SSKE */
-- 
2.5.5
