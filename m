From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/8] s390/kvm: cleanup/fix handle_tpi()
Date: Tue,  5 Mar 2013 13:14:46 +0100
Message-ID: <1362485687-2799-8-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

- add missing specification exception check
- remove one level of indentation
- use defines instead of magic numbers

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 54 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cb07147..d64382c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -14,6 +14,7 @@
 #include <linux/kvm.h>
 #include <linux/gfp.h>
 #include <linux/errno.h>
+#include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
@@ -129,39 +130,44 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 
 static int handle_tpi(struct kvm_vcpu *vcpu)
 {
-	u64 addr;
 	struct kvm_s390_interrupt_info *inti;
+	u64 addr;
 	int cc;
 
 	addr = kvm_s390_get_base_disp_s(vcpu);
-
+	if (addr & 3) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+	cc = 0;
 	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->run->s.regs.crs[6], 0);
-	if (inti) {
-		if (addr) {
-			/*
-			 * Store the two-word I/O interruption code into the
-			 * provided area.
-			 */
-			put_guest(vcpu, inti->io.subchannel_id, (u16 *) addr);
-			put_guest(vcpu, inti->io.subchannel_nr, (u16 *) (addr + 2));
-			put_guest(vcpu, inti->io.io_int_parm, (u32 *) (addr + 4));
-		} else {
-			/*
-			 * Store the three-word I/O interruption code into
-			 * the appropriate lowcore area.
-			 */
-			put_guest(vcpu, inti->io.subchannel_id, (u16 *) 184);
-			put_guest(vcpu, inti->io.subchannel_nr, (u16 *) 186);
-			put_guest(vcpu, inti->io.io_int_parm, (u32 *) 188);
-			put_guest(vcpu, inti->io.io_int_word, (u32 *) 192);
-		}
-		cc = 1;
-	} else
-		cc = 0;
+	if (!inti)
+		goto no_interrupt;
+	cc = 1;
+	if (addr) {
+		/*
+		 * Store the two-word I/O interruption code into the
+		 * provided area.
+		 */
+		put_guest(vcpu, inti->io.subchannel_id, (u16 *) addr);
+		put_guest(vcpu, inti->io.subchannel_nr, (u16 *) (addr + 2));
+		put_guest(vcpu, inti->io.io_int_parm, (u32 *) (addr + 4));
+	} else {
+		/*
+		 * Store the three-word I/O interruption code into
+		 * the appropriate lowcore area.
+		 */
+		put_guest(vcpu, inti->io.subchannel_id, (u16 *) __LC_SUBCHANNEL_ID);
+		put_guest(vcpu, inti->io.subchannel_nr, (u16 *) __LC_SUBCHANNEL_NR);
+		put_guest(vcpu, inti->io.io_int_parm, (u32 *) __LC_IO_INT_PARM);
+		put_guest(vcpu, inti->io.io_int_word, (u32 *) __LC_IO_INT_WORD);
+	}
 	kfree(inti);
+no_interrupt:
 	/* Set condition code and we're done. */
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	vcpu->arch.sie_block->gpsw.mask |= (cc & 3ul) << 44;
+out:
 	return 0;
 }
 
-- 
1.8.0.1
