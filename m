From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 3/9] KVM: s390: Fix access to CR6 in TPI handler
Date: Thu, 28 Nov 2013 15:06:52 +0100
Message-ID: <1385647618-15541-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The TPI handler currently uses vcpu->run->s.regs.crs[6] to get the current
value of CR6. I think this is wrong, because vcpu->run->s.regs.crs is
only updated when kvm_arch_vcpu_ioctl_run() drops back to userspace.
So let's change the TPI handler to use vcpu->arch.sie_block->gcr[6] instead.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 2440602..b18fe52 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -197,7 +197,7 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	if (addr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	cc = 0;
-	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->run->s.regs.crs[6], 0);
+	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->arch.sie_block->gcr[6], 0);
 	if (!inti)
 		goto no_interrupt;
 	cc = 1;
-- 
1.7.9.5
