From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 26/47] KVM: s390: convert handle_tpi()
Date: Tue, 15 Apr 2014 14:00:29 +0200
Message-ID: <1397563250-3089-27-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert handle_tpi() to new guest access functions.

The code now sets up a structure which is copied with a single call to
guest space instead of issuing several separate guest access calls.
This is necessary since the to be copied data may cross a page boundary.
If a protection exception happens while accessing any of the pages, the
instruction is suppressed and may not have modified any memory contents.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5abfd53..4f6bc16 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -224,9 +224,12 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 static int handle_tpi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_interrupt_info *inti;
+	unsigned long len;
+	u32 tpi_data[3];
+	int cc, rc;
 	u64 addr;
-	int cc;
 
+	rc = 0;
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -235,30 +238,33 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	if (!inti)
 		goto no_interrupt;
 	cc = 1;
+	tpi_data[0] = inti->io.subchannel_id << 16 | inti->io.subchannel_nr;
+	tpi_data[1] = inti->io.io_int_parm;
+	tpi_data[2] = inti->io.io_int_word;
 	if (addr) {
 		/*
 		 * Store the two-word I/O interruption code into the
 		 * provided area.
 		 */
-		if (put_guest(vcpu, inti->io.subchannel_id, (u16 __user *)addr)
-		    || put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *)(addr + 2))
-		    || put_guest(vcpu, inti->io.io_int_parm, (u32 __user *)(addr + 4)))
-			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		len = sizeof(tpi_data) - 4;
+		rc = write_guest(vcpu, addr, &tpi_data, len);
+		if (rc)
+			return kvm_s390_inject_prog_cond(vcpu, rc);
 	} else {
 		/*
 		 * Store the three-word I/O interruption code into
 		 * the appropriate lowcore area.
 		 */
-		put_guest(vcpu, inti->io.subchannel_id, (u16 __user *) __LC_SUBCHANNEL_ID);
-		put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *) __LC_SUBCHANNEL_NR);
-		put_guest(vcpu, inti->io.io_int_parm, (u32 __user *) __LC_IO_INT_PARM);
-		put_guest(vcpu, inti->io.io_int_word, (u32 __user *) __LC_IO_INT_WORD);
+		len = sizeof(tpi_data);
+		if (write_guest_lc(vcpu, __LC_SUBCHANNEL_ID, &tpi_data, len))
+			rc = -EFAULT;
 	}
 	kfree(inti);
 no_interrupt:
 	/* Set condition code and we're done. */
-	kvm_s390_set_psw_cc(vcpu, cc);
-	return 0;
+	if (!rc)
+		kvm_s390_set_psw_cc(vcpu, cc);
+	return rc ? -EFAULT : 0;
 }
 
 static int handle_tsch(struct kvm_vcpu *vcpu)
-- 
1.8.4.2
