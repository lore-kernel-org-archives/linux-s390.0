From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/6] KVM: s390: Add low-address protection to TEST BLOCK
Date: Tue, 29 Apr 2014 15:36:46 +0200
Message-ID: <1398778608-3887-5-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

TEST BLOCK is also subject to the low-address protection, so we need
to check the destination address in our handler.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a47157b..07d0c10 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -206,6 +206,9 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 
 	kvm_s390_get_regs_rre(vcpu, NULL, &reg2);
 	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	addr = kvm_s390_logical_to_effective(vcpu, addr);
+	if (kvm_s390_check_low_addr_protection(vcpu, addr))
+		return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 	addr = kvm_s390_real_to_abs(vcpu, addr);
 
 	if (kvm_is_error_gpa(vcpu->kvm, addr))
-- 
1.8.4.2
