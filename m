From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 5/7] KVM: s390: Check for access exceptions during TPI
Date: Thu, 20 Jun 2013 17:22:03 +0200
Message-ID: <1371741725-53624-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When a guest calls the TPI instruction, the second operand address could
point to an invalid location. In this case the problem should be signaled
to the guest by throwing an access exception.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 0b19e22..4b8fb6c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -146,9 +146,10 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 		 * Store the two-word I/O interruption code into the
 		 * provided area.
 		 */
-		put_guest(vcpu, inti->io.subchannel_id, (u16 __user *) addr);
-		put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *) (addr + 2));
-		put_guest(vcpu, inti->io.io_int_parm, (u32 __user *) (addr + 4));
+		if (put_guest(vcpu, inti->io.subchannel_id, (u16 __user *)addr)
+		    || put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *)(addr + 2))
+		    || put_guest(vcpu, inti->io.io_int_parm, (u32 __user *)(addr + 4)))
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	} else {
 		/*
 		 * Store the three-word I/O interruption code into
-- 
1.8.2.2
