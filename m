From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/4] KVM: s390: fix stale machine check data for guarded storage
Date: Fri, 21 Apr 2017 12:09:43 +0200
Message-ID: <1492769385-237420-3-git-send-email-borntraeger@de.ibm.com>
References: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

When delivering a machine check the CPU state is "loaded", which
means that some registers are already in the host registers.
Before writing the register content into the machine check
save area, we must make sure that we save the content of the
registers into the data structures that are used for delivering
the machine check.
We already do the right thing for access, vector/floating point
registers, let's do the same for guarded storage.

Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 482673e..caf15c8a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -419,6 +419,8 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	/* take care of lazy register loading */
 	save_fpu_regs();
 	save_access_regs(vcpu->run->s.regs.acrs);
+	if (MACHINE_HAS_GS && vcpu->arch.gs_enabled)
+		save_gs_cb(current->thread.gs_cb);
 
 	/* Extended save area */
 	rc = read_guest_lc(vcpu, __LC_MCESAD, &ext_sa_addr,
-- 
2.7.4
