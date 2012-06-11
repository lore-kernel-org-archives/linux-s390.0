From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/3] s390/kvm: Set CPU in stopped state on initial cpu reset
Date: Mon, 11 Jun 2012 16:06:57 +0200
Message-ID: <1339423619-42299-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The initial cpu reset sets the cpu in the stopped state.
Several places check for the cpu state (e.g. sigp set prefix) and
not setting the STOPPED state triggered errors with newer guest
kernels after reboot.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 664766d..ace9360 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -347,6 +347,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_fpregs.fpc = 0;
 	asm volatile("lfpc %0" : : "Q" (vcpu->arch.guest_fpregs.fpc));
 	vcpu->arch.sie_block->gbea = 1;
+	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 }
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
-- 
1.7.10.4
