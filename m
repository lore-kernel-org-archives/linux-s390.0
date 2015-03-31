From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/8] KVM: s390: store the breaking-event address on pgm interrupts
Date: Tue, 31 Mar 2015 15:01:56 +0200
Message-ID: <1427806923-21910-2-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If the PER-3 facility is installed, the breaking-event address is to be
stored in the low core.

There is no facility bit for PER-3 in stfl(e) and Linux always uses the
value at address 272 no matter if PER-3 is available or not.
We can't hide its existence from the guest. All program interrupts
injected via the SIE automatically store this information if the PER-3
facility is available in the hypervisor. Also the itdb contains the
address automatically.

As there is no switch to turn this mechanism off, let's simply make it
consistent and also store the breaking event address in case of manual
program interrupt injection.

Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2afec60..2361b8e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -585,6 +585,8 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 		kvm_s390_rewind_psw(vcpu, ilc);
 
 	rc |= put_guest_lc(vcpu, ilc, (u16 *) __LC_PGM_ILC);
+	rc |= put_guest_lc(vcpu, vcpu->arch.sie_block->gbea,
+				 (u64 *) __LC_LAST_BREAK);
 	rc |= put_guest_lc(vcpu, pgm_info.code,
 			   (u16 *)__LC_PGM_INT_CODE);
 	rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
-- 
2.3.0
