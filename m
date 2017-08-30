From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/12] KVM: s390: sthyi: remove invalid guest write access
Date: Wed, 30 Aug 2017 09:54:08 +0200
Message-ID: <1504079650-82735-4-git-send-email-borntraeger@de.ibm.com>
References: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

handle_sthyi() always writes to guest memory if the sthyi function
code is zero in order to fault in the page that later is written to.

However a function code of zero does not necessarily mean that a write
to guest memory happens: if the KVM host is running as a second level
guest under z/VM 6.2 the sthyi instruction is indicated to be
available to the KVM host, however if the instruction is executed it
will always return with a return code that indicates "unsupported
function code".

In such a case handle_sthyi() must not write to guest memory. This
means that the prior write access to fault in the guest page may
result in invalid guest exceptions, and/or invalid data modification.

In order to be architecture compliant simply remove the write_guest()
call.

Given that the guest assumed a write access anyway, this fix does not
qualify for -stable. This just makes sure the sthyi handler is
architecture compliant.

Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sthyi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index a2e5c24..395926b 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -436,14 +436,6 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	if (addr & ~PAGE_MASK)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	/*
-	 * If the page has not yet been faulted in, we want to do that
-	 * now and not after all the expensive calculations.
-	 */
-	r = write_guest(vcpu, addr, reg2, &cc, 1);
-	if (r)
-		return kvm_s390_inject_prog_cond(vcpu, r);
-
 	sctns = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!sctns)
 		return -ENOMEM;
-- 
2.7.4
